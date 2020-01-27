local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table








this.loadedAvatarData = false 
this.needToResetAfterAvatarEdit = false 
this.sequenceFrameCount = 0 
this.startedLoadingAvatarEditUI = false 

this.needToSaveAvatarData = false

this.isFemaleAvatar = false

this.preAvatarPlayerType = 0
this.preAvatarPlayerCamoType = 0
this.preAvatarPlayerPartsType = 0
this.preAvatarGearState =  {}






local LOAD_TIME_OUT_FRAME_COUNT = 1800
local PARTS_WAIT_FRAME_COUNT = 10
local FADE_WAIT_FRAME_COUNT = 300

local GEAR_TYPE_COUNT = 5	
local GEAR_STATE_SIZE = 3	
local GEAR_STATE_ARRAY_SIZE = GEAR_TYPE_COUNT * GEAR_STATE_SIZE

local AVATAR_SCRIPT_BLOCK_NAME = "AvatarScriptBlockData"


local AVATAR_DATA_LIST_MALE = {		
		
		"/Assets/tpp/pack/mission2/common/mis_com_avatar_edit.fpk",
		
		
		"/Assets/tpp/pack/ui/ui_avatar_edit_men.fpk",
		"/Assets/tpp/pack/player/avatar/deform/avm_dfrm_men_mtar.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type1_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type2_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type3_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type4_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type5_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type6_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avm0_type7_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type1_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type2_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type3_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type4_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type5_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type6_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avm0_type7_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avm_hair_a0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avm_hair_b0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avm_hair_c0_v00.fpk",
		"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c00.fpk",
		"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c01.fpk",
		"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c02.fpk",
		"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c03.fpk",
		"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c04.fpk",
	}
local AVATAR_DATA_LIST_FEMALE = {
		
		"/Assets/tpp/pack/mission2/common/mis_com_avatar_edit.fpk",
		
		
		"/Assets/mgo/pack/ui/ui_avatar_edit_women.fpk",
		"/Assets/mgo/pack/player/avatar/deform/avm_dfrm_women_mtar.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type1_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type2_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type3_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type4_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type5_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type6_v00.fpk",
		"/Assets/mgo/pack/player/avatar/face/plfova_avf0_type7_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type1_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type2_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type3_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type4_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type5_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type6_v00.fpk",
		"/Assets/mgo/pack/player/avatar/deform/pldfrm_avf0_type7_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avf_hair_a0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avf_hair_b0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avf_hair_c0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/hair/plfova_avf_hair_d0_v00.fpk",
		"/Assets/mgo/pack/player/avatar/body/plfova_avf0_main0_skin0_c00.fpk",
		"/Assets/mgo/pack/player/avatar/body/plfova_avf0_main0_skin0_c01.fpk",
		"/Assets/mgo/pack/player/avatar/body/plfova_avf0_main0_skin0_c02.fpk",
		"/Assets/mgo/pack/player/avatar/body/plfova_avf0_main0_skin0_c03.fpk",
		"/Assets/mgo/pack/player/avatar/body/plfova_avf0_main0_skin0_c04.fpk",
	}

function this.IsMgoFemalePlayerType()
	local isFemale = vars.playerType == PlayerType.MGO_FEMALE
	Fox.Log( "isFemale:" .. tostring(isFemale) .. " // playerType:" .. vars.playerType .. " // MGO_FEMALE:" .. PlayerType.MGO_FEMALE )
	return isFemale
end

function this.GetAvatarScriptBlockId()
	return ScriptBlock.GetScriptBlockId(AVATAR_SCRIPT_BLOCK_NAME)
end


function this.CheckScriptBlockExists()
	local blockId = this.GetAvatarScriptBlockId()
	if blockId == ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
		Fox.Error("Avatar ScriptBlock could not be found! Name : " .. AVATAR_SCRIPT_BLOCK_NAME )
		return false
	end
	
	return true
end

function this.LoadAvatarData(loadFemaleData)

	local blockId = this.GetAvatarScriptBlockId()
	
	Fox.Log("LoadAvatarData. blockId: " .. blockId .. " , loadFemaleData: " .. tostring(loadFemaleData))

	
	local dataList = AVATAR_DATA_LIST_MALE
	if loadFemaleData then
		dataList = AVATAR_DATA_LIST_FEMALE
	end

	
	ScriptBlock.Load(blockId, dataList)	
	ScriptBlock.Activate(blockId)
	
	this.loadedAvatarData = true
end

function this.IsFinishedLoadingAvatarData()

	local blockId = this.GetAvatarScriptBlockId()
	if ScriptBlock.IsProcessing(blockId) then
		return false
	end	
	
	return true
end

function this.UnloadAvatarData()

	if this.loadedAvatarData == false then
		return
	end

	Fox.Log("UnloadAvatarData")
	
	this.loadedAvatarData = false
	
	local blockId = this.GetAvatarScriptBlockId()
	ScriptBlock.Load(blockId, "")	
end

function this.SetupPlayerForAvatarUI()
	Fox.Log("SetupPlayerForAvatarUI")
	
	Player.SetPadMask {
		settingName = "AvatarPadMask",
		except = true,
		sticks = PlayerPad.STICK_R,
	}	

	
	TppUiStatusManager.SetStatus( "EquipHud", "INVALID" )
	Player.SetAroundCameraManualMode( true )
	Player.SetAroundCameraManualModeParams {
		target = Vector3(0,1001,0),
		offset = Vector3(0,0,0),
	}
	Player.UpdateAroundCameraManualModeParams()

	
	local gameObjectId = { type="TppPlayer2", index=0 }
	local command = { id = "Warp", pos={0,1001,0}, rotY=4.7 }
	GameObject.SendCommand( gameObjectId, command )
	
	this.preAvatarPlayerType = vars.playerType
	this.preAvatarPlayerCamoType = vars.playerCamoType
	this.preAvatarPlayerPartsType = vars.playerPartsType
	
	if this.isFemaleAvatar then
		vars.playerCamoType = PlayerCamoType.AVATAR_EDIT_WOMAN
		vars.playerPartsType = PlayerPartsType.AVATAR_EDIT_WOMAN
	else
		vars.playerCamoType = PlayerCamoType.AVATAR_EDIT_MAN
		vars.playerPartsType = PlayerPartsType.AVATAR_EDIT_MAN
	end
	
	vars.playerType = PlayerType.AVATAR

	
	for i = 0, GEAR_STATE_ARRAY_SIZE-1 do
		
		this.preAvatarGearState[i] = vars.gearState[i]
		vars.gearState[i] = 0
	end
		
end

function this.RevertPlayerAfterAvatarUI()
	Fox.Log("RevertPlayerAfterAvatarUI")
	
	
	
	
	

	vars.playerType = this.preAvatarPlayerType
	vars.playerCamoType = this.preAvatarPlayerCamoType
	vars.playerPartsType = this.preAvatarPlayerPartsType

	
	for i = 0, GEAR_STATE_ARRAY_SIZE-1 do
		vars.gearState[i] = this.preAvatarGearState[i]
	end
end


function this.SetNextSequence(nextSequence)
	Fox.Log("SetNextSequence: " .. nextSequence)
	TppSequence.SetNextSequence( nextSequence, { isExecMissionClear = true, isExecGameOver = true, isExecDemoPlaying = true } )	
end





local sequences = {}

function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		
		"Seq_Ruleset_Init",
		"Seq_Ruleset_Main", 					
		"Seq_Ruleset_LoadAvatarCommonData",		
		"Seq_Ruleset_LoadAvatarUI",				
		"Seq_Ruleset_StartAvatarEdit",			
		"Seq_Ruleset_FinishAvatarEdit",			
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
	
	
	mvars.mis_missionName = "mgo_mission"
	Fox.Log("Set mission name for mgo : " .. mvars.mis_missionName)
end








function this.MissionPrepare()
	Fox.Log("*** init MissionPrepare ***")
	if vars.rulesetId ~= 4 then 
		TppMission.AlwaysMissionCanStart()
	else
		TppEquip.CreateEquipPreviewSystem{
				equipListUpCount		= 5,			
				partsListUpCount		= 5,			
		}
	end
end





sequences.Seq_Ruleset_Init = {

	OnEnter = function()
		Fox.Log("Seq_Ruleset_Init:OnEnter")
		
		
		
		
		Fox.Log( "Seq_Ruleset_Init:Enabling the announce log")
		TppUiStatusManager.ClearStatus( "AnnounceLog" )








		
	end,
	
	OnUpdate = function()
		
		this.SetNextSequence( "Seq_Ruleset_Main" )
	end,
	
}

sequences.Seq_Ruleset_Main = {

	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "RequestAvatarEdit",
					func = function()
						Fox.Log( "sequences.Seq_Ruleset_Main.Messages(): UI: RequestAvatarEdit" )

						
						if not this.CheckScriptBlockExists() then
							return
						end

						vars.isAvatarEditMode = 1
						this.sequenceFrameCount = 0

						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "RequestAvatarEdit", nil, { forceNotMute = true } )
					end,
				},
			},
			UI = {
				{
					msg = "EndFadeOut", sender = "RequestAvatarEdit",
					func = function()
						
						this.SetNextSequence( "Seq_Ruleset_LoadAvatarCommonData" )
					end,
				},
				{
					msg = "PauseMenuOpenStore",
					func = function()
						Fox.Log( "sequences.Seq_Ruleset_Main.Messages(): UI: PauseMenuOpenStore" )
						
						if ( Fox.GetPlatformName() ~= "PS3" ) then
							Fox.Log("sequences.Seq_Ruleset_Main.Messages() : Mission reload for store is only work PS3")
							return
						end
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOpenStore" )
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOpenStore",
					func = function()
						Fox.Log( "sequences.Seq_Ruleset_Main.Messages(): UI: EndFadeOut" )
						
						TppMission.ResetIsStartFromHelispace()
						TppMission.ResetIsStartFromFreePlay()
						TppMission.VarResetOnNewMission()
						local currentMissionCode = vars.missionCode
						
						vars.locationCode = 200
						vars.missionCode = 7
						local showLoadingTips = false
						TppMission.Load( vars.missionCode, currentMissionCode, { showLoadingTips = showLoadingTips } )	
					end,
				},
			},
			nil,
		}
	end,
	
	OnEnter = function()
		Fox.Log("Seq_Ruleset_Main:OnEnter")
		
		this.sequenceFrameCount = 0

		
		this.UnloadAvatarData()

		vars.isAvatarEditMode = 0
		
		if this.needToResetAfterAvatarEdit then
			this.needToResetAfterAvatarEdit = false
			
			
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeInMainAfterAvatarEdit" )
			
			
			Player.ResetPadMask{
				settingName = "AvatarPadMask",
			}
		end
	end,

	OnUpdate = function()
		if vars.isAvatarEditMode == 1 then
			this.sequenceFrameCount = this.sequenceFrameCount + 1
			if this.sequenceFrameCount > FADE_WAIT_FRAME_COUNT then
				
				Fox.Log("Seq_Ruleset_Main: Fadeout failed. Cancel entering avatar edit mode.")
				vars.isAvatarEditMode = 0
			end
		end
	end,
	
}

sequences.Seq_Ruleset_LoadAvatarCommonData = {

	OnEnter = function()
		Fox.Log("Seq_Ruleset_LoadAvatarCommonData:OnEnter")
		
		this.sequenceFrameCount = 0
		this.needToResetAfterAvatarEdit = true
		
		
		if not this.CheckScriptBlockExists() then
			this.SetNextSequence( "Seq_Ruleset_Main" )
			return
		end

		
		MgoCharacterData.UpdateAvatarDataBeforeAvatarEdit()

		this.isFemaleAvatar = this.IsMgoFemalePlayerType()
		
		local loadFemaleData = this.isFemaleAvatar
		this.LoadAvatarData( loadFemaleData )
	end,

	OnUpdate = function()
		
		if this.IsFinishedLoadingAvatarData() then
			this.SetNextSequence( "Seq_Ruleset_LoadAvatarUI" )
			return
		end
		
		
		this.sequenceFrameCount = this.sequenceFrameCount + 1
		if this.sequenceFrameCount > LOAD_TIME_OUT_FRAME_COUNT then
			Fox.Error( "Seq_Ruleset_LoadAvatarCommonData LOAD TIMEOUT" )
			this.SetNextSequence( "Seq_Ruleset_Main" )
			return
		end
	end,
	
}


sequences.Seq_Ruleset_LoadAvatarUI = {

	OnEnter = function()
		Fox.Log("Seq_Ruleset_LoadAvatarUI:OnEnter")
		
		this.sequenceFrameCount = 0
		this.startedLoadingAvatarEditUI = false
		
		
		this.SetupPlayerForAvatarUI()		
	end,

	OnUpdate = function()
	
		this.sequenceFrameCount = this.sequenceFrameCount + 1
		
		local playerFinishedChangingParts = (this.sequenceFrameCount > PARTS_WAIT_FRAME_COUNT) and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE }
		if playerFinishedChangingParts then
			if this.startedLoadingAvatarEditUI == false then
				
				Fox.Log("Seq_Ruleset_LoadAvatarUI: start loading avatar edit ui")
				this.startedLoadingAvatarEditUI = true				
				if this.isFemaleAvatar then
					TppUiCommand.LoadAvatarEdit( { type=AvatarEdit.AVATAR_IN_HELI, presets=avatar_presets_women.presets } )
				else
					TppUiCommand.LoadAvatarEdit( { type=AvatarEdit.AVATAR_IN_HELI, presets=avatar_presets.presets } )
				end
			end
			
			if TppUiCommand.IsAvatarEditReady() then
				this.SetNextSequence( "Seq_Ruleset_StartAvatarEdit" )
				return
			end			
		end		
		
		
		if this.sequenceFrameCount > LOAD_TIME_OUT_FRAME_COUNT then
			Fox.Error( "Seq_Ruleset_LoadAvatarCommonData LOAD TIMEOUT" )
			this.SetNextSequence( "Seq_Ruleset_Main" )
			return
		end
	end,
	
}

sequences.Seq_Ruleset_StartAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "AvatarEditEnd",
					func = function( needSave )

						if needSave and ( needSave == 1 ) then
							this.needToSaveAvatarData = true
						else
							this.needToSaveAvatarData = false
						end
						
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "FadeOutAvatarEditEnd", nil, { forceNotMute = true } )
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutAvatarEditEnd",
					func = function()
						
						this.SetNextSequence( "Seq_Ruleset_FinishAvatarEdit" )
					end,
				},
			},
			nil,
		}
	end,
	
	OnEnter = function()
		Fox.Log("Seq_Ruleset_StartAvatarEdit:OnEnter")
		
		TppUI.FadeIn( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeInStartAvatarEdit" )
		TppUiCommand.StartAvatarEdit()

		this.needToSaveAvatarData = false
	end,	
}

sequences.Seq_Ruleset_FinishAvatarEdit = {
	
	OnEnter = function()
		Fox.Log("Seq_Ruleset_FinishAvatarEdit:OnEnter")
		
		this.sequenceFrameCount = 0
		
		TppUiCommand.EndAvatarEdit()	

		if this.needToSaveAvatarData then
			Fox.Log("Seq_Ruleset_FinishAvatarEdit: Save avatar data")
			
			
			
			
			MgoCharacterData.UpdateCharacterDataAfterAvatarEdit()
			
			TppSave.SaveAvatarData()
		else
			Fox.Log("Seq_Ruleset_FinishAvatarEdit: Don't need to save avatar data")
		end

		
		this.RevertPlayerAfterAvatarUI()
		
		
		Player.SetPadMask {
			settingName = "AvatarEndPadMask",
			except = true,
		}	
	end,

	OnUpdate = function()

		this.sequenceFrameCount = this.sequenceFrameCount + 1
		if this.sequenceFrameCount > LOAD_TIME_OUT_FRAME_COUNT then
			Fox.Error( "Seq_Ruleset_FinishAvatarEdit AVATAR LOADING TIMEOUT" )
			this.SetNextSequence( "Seq_Ruleset_Main" )			
			Player.ResetPadMask{ settingName = "AvatarEndPadMask", }			
			return
		end
		
		local playerFinishedChangingParts = (this.sequenceFrameCount > PARTS_WAIT_FRAME_COUNT) and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE }		
		if playerFinishedChangingParts then
			this.UnloadAvatarData()
			vars.isAvatarEditMode = 0
		end
		
		local playerFinishedChangingAvatar = not Player.IsLocalPlayerAvatarLoading()

		if (playerFinishedChangingParts and playerFinishedChangingAvatar) then
			this.SetNextSequence( "Seq_Ruleset_Main" )			
			Player.ResetPadMask{ settingName = "AvatarEndPadMask", }
			return
		end

	end,
	
}




return this