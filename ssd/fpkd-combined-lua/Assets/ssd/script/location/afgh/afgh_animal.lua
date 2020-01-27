local afgh_animal = {}
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString



afgh_animal.animalInstancePackList = {


	
 	Rat = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_rat.fpk",
	
 	HeadgeHog1 = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_hgh1.fpk",
	
 	HeadgeHog2 = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_hgh2.fpk",
	
	Rabbit = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_apk.fpk",


	
 	Raven = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_rvn.fpk",
	
 	Bycanistes = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_hnb0.fpk",


	
	Nigra = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_stk1.fpk",
	
 	Boyciana = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_stk.fpk",
	
 	Jefty = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_stk2.fpk",


	
	Griffon = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_vlt1.fpk",
	
	Lappet = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_vlt2.fpk",
	
	Martial = "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mte.fpk",


	
	Zebra = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zbr.fpk", "Zebra" },
	
	Donkey = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_dnk.fpk", "Donkey" },
	
	Okapi = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_okp.fpk", "Okapi" },


	
	Goat = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_csm.fpk", "Goat" },
	
	Sheep = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_kkl.fpk", "Sheep" },
	
	Nubian = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_nbn.fpk", "Nubian" },
	
	Bor = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_bor.fpk", "Boer" },


	
	Cashmere = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ber2.fpk", "KashmirBear" },


	
	Wolf = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_wlf.fpk", "Wolf" },
	
	Jackal = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_jcl.fpk", "Jackal" },
	
	Lycaon = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_lyc.fpk", "Lycaon" },
	
	Anubis = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_anb.fpk", "Anubis" },

}


afgh_animal.animalTypeSetting = {
	afgh_01_ground = {
		Rat = { groupNumber = 11 },
	},
	afgh_01_water = {
		Rat = { groupNumber = 11 },
	},
	afgh_04 = {
		Rat = { groupNumber = 6 },
	},
	afgh_05 = {
		Rat = { groupNumber = 3 },
	},
	afgh_06 = {
		Rat = { groupNumber = 6 },
	},
}


afgh_animal.animalAreaSetting = {
	{
		areaName = "afgh_01",
		blockName = "herbivore_block",
		loadArea = {126, 145, 136, 155},
		activeArea = {127, 146, 135, 154},
		defines = {
			{
				keyName = "afgh_01_ground",
				animal = {
					"Rat",
					"Sheep",
					"Wolf",
					"Griffon",
					"Raven",
				},
				conditionFunc = function()
					local isSequence = TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.BEFORE_k40090
					return isSequence
				end,
				locatorPack = {
					"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00.fpk",
					"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00_asset_ground.fpk",
				},
			},
			{
				keyName = "afgh_01_water",
				animal = {
					"Rat",
					"Sheep",
					"Wolf",
					"Griffon",
					"Raven",
				},
				conditionFunc = function()
					local isSequence = TppStory.GetCurrentStorySequence() < TppDefine.STORY_SEQUENCE.BEFORE_k40090
					return isSequence
				end,
				locatorPack = {
					"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00.fpk",
					"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_01.fpk",			
					"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00_asset_water.fpk",
				}
			},
		},
	},
	{
		areaName = "afgh_04",
		blockName = "herbivore_block",
		loadArea = {138, 143, 145, 150},
		activeArea = {139, 144, 144, 149},
		defines = {
			{
				keyName = "afgh_04",
				animal = {
					"Rat",
					"Boyciana",
					"Sheep",
					"Wolf",
				 },
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_04_00.fpk",
			},
		},
	},
	{
		areaName = "afgh_05",
		blockName = "herbivore_block",
		loadArea = {140, 137, 144, 141},
		activeArea = {141, 138, 143, 140},
		defines = {
			{
				keyName = "afgh_05",
				animal = {
					"Rabbit",
					"Goat",
				},
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_05_00.fpk",
			},
		},
	},
	{
		areaName = "afgh_06",
		blockName = "herbivore_block",
		loadArea = {132, 137, 139, 141},
		activeArea = {133, 138, 138, 140},
		defines = {
			{
				keyName = "afgh_06",
				animal = {
					"HeadgeHog1",
					"Raven",
					"Wolf",
					"Goat",
				},
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_06_00.fpk",
			},
		},
	},
}


afgh_animal.captureCageAnimalAreaSetting = {
}


afgh_animal.captureAnimalList = {
}


afgh_animal.animalRareLevel = {
}


afgh_animal.animalMaterial = {
}


afgh_animal.animalInfoList = {
}




function afgh_animal.OnAllocate()
	
	local instanceList = afgh_animal.animalInstancePackList
	local packList = {}
	for _, name in ipairs( TppAnimalBlock.ANIMAL_BLOCK_GROUP_NAMES ) do
		packList[name] = {}
	end

	if not next( afgh_animal.animalAreaSetting ) then
		return
	end

	for _, setting in ipairs( afgh_animal.animalAreaSetting ) do
		local blockName = setting.blockName
		local currentPack = packList[blockName]
		for _, def in ipairs( setting.defines ) do
			local packLabel = def.keyName
			currentPack[packLabel] = {}
			for _, type in ipairs( def.animal ) do
				TppAnimal.GetPackFileListFromInstanceInfo( currentPack[packLabel], instanceList[type] )
			end
			if IsTypeTable( def.locatorPack ) then
				for j, pack in ipairs( def.locatorPack ) do
					table.insert( currentPack[packLabel], pack )
				end
			else
				table.insert( currentPack[packLabel], def.locatorPack )
			end
		end
	end

	if DEBUG then
		Tpp.DEBUG_DumpTable( packList )
	end

	for _, name in ipairs( TppAnimalBlock.ANIMAL_BLOCK_GROUP_NAMES ) do
		TppScriptBlock.RegisterCommonBlockPackList( name, packList[name] )
	end
end

function afgh_animal.OnMissionCanStart()
	
	local noAnimalBlock = true
	for _, name in ipairs( TppAnimalBlock.ANIMAL_BLOCK_GROUP_NAMES ) do
		local blockId = ScriptBlock.GetScriptBlockId( name )
		if blockId ~= ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
			noAnimalBlock = false
			break
		end
	end

	if noAnimalBlock then
		Fox.Log("animal block is not registered.")
		return
	end

	afgh_animal.Messages = function()
		return
		Tpp.StrCode32Table{
			Block = {
				{
					msg = "StageBlockCurrentSmallBlockIndexUpdated",
					func = function( x, y )
						TppAnimalBlock.UpdateLoadAnimalBlock( x, y )
					end,
					option = { isExecFastTravel = true, },
				},
			},
		}
	end

	afgh_animal.messageExecTable = Tpp.MakeMessageExecTable( afgh_animal.Messages() )

	afgh_animal.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( afgh_animal.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end

	afgh_animal.MAX_AREA_NUM = #afgh_animal.animalAreaSetting

	
	local x, y = Tpp.GetCurrentStageSmallBlockIndex()
	TppAnimalBlock.UpdateLoadAnimalBlock( x, y )
end


return afgh_animal
