local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local TimerStart = GkEventTimerManager.Start

local IS_QA_RELEASE
if ( Fox.GetDebugLevel() == Fox.DEBUG_LEVEL_QA_RELEASE ) then
	IS_QA_RELEASE = true
end

local sequences = {}

local function DebugPrintState(state)
	if DebugText then
		DebugText.Print(DebugText.NewContext(), tostring(state))
	end
end

local function ClosePopupAndWait()
	if TppUiCommand.IsShowPopup() then
		TppUiCommand.ErasePopup()
		while TppUiCommand.IsShowPopup() do
			DebugPrintState("waiting popup closed...")
			coroutine.yield()
		end
	end
end








function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		"Seq_In_Store",
	}
	TppSequence.RegisterSequenceTable(sequences)
end








function this.MissionPrepare()
	Fox.Log("*** init MissionPrepare ***")
	
	MgoMatchMakingManager.SetInvitationBlockStoreOpen(true)
	TppMission.AlwaysMissionCanStart()
	Shop.AllocatePSStoreMemory()
end

function this.OnTerminate()
	Fox.Log("*** term OnTerminate ***")
	
	MgoMatchMakingManager.SetInvitationBlockStoreOpen(false)
	Shop.FreePSStoreMemory()
end








sequences.Seq_In_Store = {
	Messages = function( self ) 
		return StrCode32Table{
			UI = {
				{
					msg = "EndOnlineStore",
					func = function()
						Fox.Log("*** receive EndOnlineStore ***")
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeOutOpenStore" )
						

						TppPlayer.SetStartStatus( TppDefine.INITIAL_PLAYER_STATE.ON_FOOT )
						vars.initialPlayerAction = PlayerInitialAction.STAND
						TppPlayer.ResetDisableAction()
						TppPlayer.ResetInitialPosition()
						TppPlayer.ResetMissionStartPosition()
						TppMission.ResetIsStartFromHelispace()
						TppMission.ResetIsStartFromFreePlay()
						TppMission.VarResetOnNewMission()

						
						local currentMissionCode = vars.missionCode
						
						vars.locationCode = 101
						vars.missionCode = 6
						local showLoadingTips = false
						TppMission.Load( vars.missionCode, currentMissionCode, { showLoadingTips = showLoadingTips } )	
					end,
				},
			},
		}
	end,
	OnEnter = function( self )
		Fox.Log("sequences.Seq_In_Store.OnEnter()")
		
		TppSoundDaemon.SetMute( "Loading" )
		TppUiCommand.StartOnlineStore()
	end,
}




return this