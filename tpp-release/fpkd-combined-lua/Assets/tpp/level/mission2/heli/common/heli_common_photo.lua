local heli_common_photo = {}

local MIN_PHOTO_INDEX = 1
local MAX_PHOTO_INDEX = 37

local MIN_MESH_INDEX = 38
local MAX_MESH_INDEX = 42





heli_common_photo.MESH_LIST = {
	[38]	= "MESH_38",
	[39]	= "MESH_39",
	[40]	= "MESH_40",
	[41]	= "MESH_41",
}

heli_common_photo.GROUP_ID_LIST = {
	[1]		= 0,
	[2]		= 0,
	[3]		= 0,
	[4]		= 0,
	[5]		= 0,
	[6]		= 0,
	[7]		= 0,
	[8]		= 1,
	[9]		= 1,
	[10]	= 1,
	[11]	= 1,
	[12]	= 1,
	[13]	= 1,
	[14]	= 1,
	[15]	= 1,
	[16]	= 1,
	[17]	= 1,
	[18]	= 1,
	[19]	= 1,
	[20]	= 1,
	[21]	= 1,
	[22]	= 1,
	[23]	= 2,
	[24]	= 2,
	[25]	= 2,
	[26]	= 2,
	[27]	= 2,
	[28]	= 2,
	[29]	= 2,
	[30]	= 2,
	[31]	= 2,
	[32]	= 2,
	[33]	= 2,
	[34]	= 2,
	[35]	= 2,
	[36]	= 2,
	[37]	= 2,
}

heli_common_photo.UNIT_LIST = {
	[1] 	=	{ 0 },
	[2] 	=	{ 1 },
	[3] 	=	{ 0, 2 },
	[4] 	=	{ 0, 2, 3 },
	[5] 	=	{ 0, 2, 3, 4},
	[6] 	=	{ 1, 5, },
	[7] 	=	{ 1, 5, 6 },
	[8] 	=	{ 0 },
	[9] 	=	{ 1 },
	[10]	=	{ 2 },
	[11]	=	{ 3 },
	[12]	=	{ 4 },
	[13]	=	{ 5 },
	[14]	=	{ 6 },
	[15]	=	{ 7 },
	[16]	=	{ 8, 9 },
	[17]	=	{ 10 },
	[18]	=	{ 11, 12 },
	[19]	=	{ 13, 14 },
	[20]	=	{ 15 },
	[21]	=	{ 16 },
	[22]	=	{ 17 },
	[23]	=	{ 0 },
	[24]	=	{ 1, 2 },
	[25]	=	{ 3 },
	[26]	=	{ 4 },
	[27]	=	{ 5 },
	[28]	=	{ 6 },
	[29]	=	{ 7 },
	[30]	=	{ 8, 9 },
	[31]	=	{ 10 },
	[32]	=	{ 11 },
	[33]	=	{ 12 },
	[34]	=	{ 12, 13 },
	[35]	=	{ 12, 14 },
	[36]	=	{ 12, 15 },
	[37]	=	{ 12, 16 },
}

heli_common_photo.OPEN_CONDITION_LIST = {
	[1] = function()
		return true	
	end,
	[2]	= function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
			return true
		else
			return false
		end
	end,
	[3] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		local isClearedMissionList = {10033,10036,10043}
		if ( TppStory.GetClearedMissionCount(isClearedMissionList) >= 1 ) and ( gvars.str_storySequence >= TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE ) then
			return true
		else
			return false
		end
	end,
	[4] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
			return true
		else
			return false
		end
	end,
	[5] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
			return true
		else
			return false
		end
	end,
	[6] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY then
			return true
		else
			return false
		end
	end,
	[7] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
			return true
		else
			return false
		end
	end,
	[8] = function()
		return true	
	end,
	[9]	 = function()
		return true	
	end,
	[10] = function()
		return true	
	end,
	[11] = function()
		return true	
	end,
	[12] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.HORSE) >= 50 then
			return true
		else
			return false
		end
	end,
	[13] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.DidObtainBuddyType(BuddyType.DOG) then
			return true
		else
			return false
		end
	end,
	[14] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.CanSortieBuddyType(BuddyType.DOG) then
			return true
		else
			return false
		end
	end,
	[15] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG) >= 50 then
			return true
		else
			return false
		end
	end,
	[16] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.CanSortieBuddyType(BuddyType.QUIET) then
			return true
		else
			return false
		end
	end,
	[17] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET) >= 80 then
			return true
		else
			return false
		end
	end,
	[18] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.CanSortieBuddyType(BuddyType.WALKER_GEAR) then
			return true
		else
			return false
		end
	end,
	[19] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.CanSortieBuddyType(BuddyType.BATTLE_GEAR) then
			return true
		else
			return false
		end
	end,
	[20] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.CanArrivalHueyInMB() then
			return true
		else
			return false
		end
	end,
	[21] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end

		if TppDemo.IsPlayedMBEventDemo("ArrivedMotherBaseLiquid") then
			return true
		else
			return false
		end
	end,
	[22] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
			return true
		else
			return false
		end
	end,
	[23] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredSoldierCount() >= 10 then
			return true
		else
			return false
		end
	end,
	[24] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredSoldierCount() >= 30 then
			return true
		else
			return false
		end
	end,
	[25] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredSoldierCount() >= 150 then
			return true
		else
			return false
		end
	end,
	[26] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredSoldierCount() >= 400 then
			return true
		else
			return false
		end
	end,
	[27] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredHostageCount() >= 1 then
			return true
		else
			return false
		end
	end,
	[28] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.GetRecoveredHostageCount() >= 5 then
			return true
		else
			return false
		end
	end,
	[29] = function()
		if TppTerminal.GetRecoveredHostageCount() >= 10 then
			return true
		else
			return false
		end
	end,
	[30] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		if TppQuest.IsCleard("field_q30010") then
			return true
		else
			return false
		end
	end,
	[31] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		local count = TppTerminal.GetRecoveredAfghGoatCount() + TppTerminal.GetRecoveredDonkeyCount()
		if count >= 10 then
			return true
		else
			return false
		end
	end,
	[32] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		local count = TppTerminal.GetRecoveredMafrGoatCount() + TppTerminal.GetRecoveredZebraCount() + TppTerminal.GetRecoveredOkapiCount()
		if count >= 10 then
			return true
		else
			return false
		end
	end,
	[33] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppTerminal.IsRecoveredCompleatedGoat() and TppTerminal.GetAnimalTypeCountFromRecoveredHistory(TppMotherBaseManagementConst.ANIMAL_TYPE_GOAT) >= 30 then
			return true
		else
			return false
		end
	end,
	[34] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		if TppTerminal.IsRecoveredCompleatedHorse() and TppTerminal.GetAnimalTypeCountFromRecoveredHistory(TppMotherBaseManagementConst.ANIMAL_TYPE_HORSE) >= 30 then
			return true
		else
			return false
		end
	end,
	[35] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		if TppTerminal.IsRecoveredCompleatedDog() and TppTerminal.GetAnimalTypeCountFromRecoveredHistory(TppMotherBaseManagementConst.ANIMAL_TYPE_DOG) >= 30 then
			return true
		else
			return false
		end
	end,
	[36] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		
		if TppTerminal.IsRecoveredCompleatedBear() and TppTerminal.GetAnimalTypeCountFromRecoveredHistory(TppMotherBaseManagementConst.ANIMAL_TYPE_BEAR) >= 30 then
			return true
		else
			return false
		end
	end,
	[37] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end

		if TppMotherBaseManagement.IsCompletedAnimal() then
			return true
		else
			return false
		end
	end,

	
	
	[38] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		return false		
	end,
	
	[39] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		return false	
	end,

	
	[40] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		return false	
	end,

	
	[41] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		return false	
	end,

	
	[42] = function( index )
		if DEBUG then
			if heli_common_photo.DEBUG_IsForceShow( index ) then
				return true
			end
		end
		
		if TppBuddyService.CanSortieBuddyType(BuddyType.QUIET) then
			if vars.buddyType == BuddyType.QUIET then
				return true
			end
		end
		return false
	end,
}

function heli_common_photo.OnBuddyBlockLoad()
	Fox.Log("heli_common_photo.OnBuddyBlockLoad")
	TppHeliPhotoFova.ClearGroupSetting()

	for photoIndex = 7, MIN_PHOTO_INDEX, -1 do
		local groupIndex = heli_common_photo.GROUP_ID_LIST[photoIndex]
		Fox.Log("heli_common_photo.OnBuddyBlockLoad(): groupIndex:" .. tostring( groupIndex ) )
		if groupIndex == 0 and heli_common_photo.OPEN_CONDITION_LIST[ photoIndex ]( photoIndex ) then
			Fox.Log( "heli_common_photo.OnBuddyBlockLoad(): break" )
			heli_common_photo.Show( photoIndex )
			break
		end
	end

	for photoIndex = 8, MAX_PHOTO_INDEX do
		local groupIndex = heli_common_photo.GROUP_ID_LIST[photoIndex]
		if heli_common_photo.OPEN_CONDITION_LIST[photoIndex]( photoIndex ) then
			heli_common_photo.Show( photoIndex )
		end
	end

end

function heli_common_photo.OnRestoreSVars()
	Fox.Log("heli_common_photo.OnRestoreSVars")
	
	for meshIndex = MIN_MESH_INDEX, MAX_MESH_INDEX do
		if heli_common_photo.OPEN_CONDITION_LIST[meshIndex]( meshIndex ) then
			heli_common_photo.ShowMESH( meshIndex )
		else
			heli_common_photo.HideMESH( meshIndex )
		end
	end
end

function heli_common_photo.Show( photoIndex )
	local groupIndex = heli_common_photo.GROUP_ID_LIST[photoIndex]
	local unitTable = heli_common_photo.UNIT_LIST[photoIndex]

	TppDataUtility.SetVisibleDataFromIdentifier( "HeliPhotoIdentifier", "uth0_pho00_def_0000", true, false )

	for i, unitIndex in pairs( unitTable ) do
		Fox.Log("heli_common_photo.Show : photoIndex = " .. tostring(photoIndex) .. ", groupIndex = " .. tostring(groupIndex) .. ", unitIndex = " .. tostring(unitIndex) )
		TppHeliPhotoFova.SetGroupUnit( groupIndex, unitIndex )
	end
end

function heli_common_photo.ShowMESH( meshIndex )
	local MESH = heli_common_photo.MESH_LIST[meshIndex]
	
	
end

function heli_common_photo.HideMESH( meshIndex )
	local MESH = heli_common_photo.MESH_LIST[meshIndex]
	
	
end

function heli_common_photo.DEBUG_ForceShow( photoIndex )
	Fox.Log("heli_common_photo.DEBUG_ForceShow : photoIndex = " .. tostring(photoIndex) )
	heli_common_photo.DEBUG_ForceShowIndex = heli_common_photo.DEBUG_ForceShowIndex or {}
	heli_common_photo.DEBUG_ForceShowIndex[photoIndex] = true
end

function heli_common_photo.DEBUG_ClearForceShow()
	for photoIndex = MIN_PHOTO_INDEX, MAX_MESH_INDEX do
		heli_common_photo.DEBUG_ForceShowIndex[photoIndex] = nil
	end
end

function heli_common_photo.DEBUG_IsForceShow( photoIndex )
	if heli_common_photo.DEBUG_ForceShowIndex then
		return heli_common_photo.DEBUG_ForceShowIndex[photoIndex]
	end
end

function heli_common_photo.DEBUG_DumpConditionResult()
	Fox.Log("********** heli_common_photo.DEBUG_DumpConditionResult **************** ")
	for photoIndex = MIN_PHOTO_INDEX, MAX_PHOTO_INDEX do
		local result = heli_common_photo.OPEN_CONDITION_LIST[photoIndex]()
		Fox.Log("photoIndex = " .. tostring(photoIndex) .. ", result = " .. tostring(result) )
	end
	
	for meshIndex = MIN_MESH_INDEX, MAX_MESH_INDEX do
		local result = heli_common_photo.OPEN_CONDITION_LIST[meshIndex]()
		Fox.Log("meshIndex = " .. tostring(meshIndex) .. ", result = " .. tostring(result) )
	end
	Fox.Log("********** heli_common_photo.DEBUG_DumpConditionResult **************** ")
end

return heli_common_photo