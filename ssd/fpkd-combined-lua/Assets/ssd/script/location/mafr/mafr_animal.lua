local mafr_animal = {}


mafr_animal.animalInstancePackList = {

	
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


	
	Brwon = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ber1.fpk", "Bear" },
	
	Cashmere = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ber2.fpk", "KashmirBear" },


	
	Wolf = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_wlf.fpk", "Wolf" },
	
	Jackal = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_jcl.fpk", "Jackal" },
	
	Lycaon = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_lyc.fpk", "Lycaon" },
	
	Anubis = { "/Assets/ssd/pack/npc/gameobject/npc_gameobject_anb.fpk", "Anubis" },


}


mafr_animal.animalTypeSetting = {
	mafr_01 = {
		Rat 	= { groupNumber = 6 },
	},
	mafr_04 = {
		Rat 	= { groupNumber = 6 },
	},
}


mafr_animal.animalAreaSetting = {
	{
		areaName = "mafr_01",
		blockName = "herbivore_block",
		loadArea = {153, 124, 157, 127},
		activeArea = {154, 125, 156, 126},
		defines = {
			{
				keyName = "mafr_01",
				animal = { "HeadgeHog2", "Zebra", "Nigra", },
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/mafr/pack_mission/animal/anml_mafr_01_00.fpk",
			},
		},
	},
	{
		areaName = "mafr_02",
		blockName = "herbivore_block",
		loadArea = {149, 124, 152, 128},
		activeArea = {150, 125, 151, 127},
		defines = {
			{
				keyName = "mafr_02",
				animal = { "Bycanistes","Donkey", "Bor", "Lycaon", },
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/mafr/pack_mission/animal/anml_mafr_02_00.fpk",
			},
		},
	},
	{
		areaName = "mafr_03",
		blockName = "herbivore_block",
		loadArea = {152, 116, 156, 120},
		activeArea = {153, 117, 155, 119},
		defines = {
			{
				keyName = "mafr_03",
				animal = { "Martial", "Okapi", "Nubian", },
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/mafr/pack_mission/animal/anml_mafr_03_00.fpk",
			},
		},
	},
	{
		areaName = "mafr_04",
		blockName = "herbivore_block",
		loadArea = {143, 122, 147, 126},
		activeArea = {144, 123, 146, 125},
		defines = {
			{
				keyName = "mafr_04",
				animal = { "HeadgeHog2","Lappet", "Jackal" },
				conditionFunc = nil,
				locatorPack = "/Assets/ssd/pack/location/mafr/pack_mission/animal/anml_mafr_04_00.fpk",
			},
		},
	},
}


mafr_animal.captureCageAnimalAreaSetting = {
}


mafr_animal.captureAnimalList = {
}


mafr_animal.animalRareLevel = {
}


mafr_animal.animalMaterial = {
}


mafr_animal.animalInfoList = {
}




function mafr_animal.OnAllocate()
	
	local instanceList = mafr_animal.animalInstancePackList
	local packList = {}
	for _, name in ipairs( TppAnimalBlock.ANIMAL_BLOCK_GROUP_NAMES ) do
		packList[name] = {}
	end

	if not next( mafr_animal.animalAreaSetting ) then
		return
	end

	for _, setting in ipairs( mafr_animal.animalAreaSetting ) do
		local blockName = setting.blockName
		local currentPack = packList[blockName]
		for _, def in ipairs( setting.defines ) do
			local packLabel = def.keyName
			currentPack[packLabel] = {}
			for _, type in ipairs( def.animal ) do
				TppAnimal.GetPackFileListFromInstanceInfo( currentPack[packLabel], instanceList[type] )
			end
			table.insert( currentPack[packLabel], def.locatorPack )
		end
	end

	if DEBUG then
		Tpp.DEBUG_DumpTable( packList )
	end

	for _, name in ipairs( TppAnimalBlock.ANIMAL_BLOCK_GROUP_NAMES ) do
		TppScriptBlock.RegisterCommonBlockPackList( name, packList[name] )
	end
end

function mafr_animal.OnMissionCanStart()
	
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

	mafr_animal.Messages = function()
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

	mafr_animal.messageExecTable = Tpp.MakeMessageExecTable( mafr_animal.Messages() )

	mafr_animal.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( mafr_animal.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end

	mafr_animal.MAX_AREA_NUM = #mafr_animal.animalAreaSetting

	
	local x, y = Tpp.GetCurrentStageSmallBlockIndex()
	TppAnimalBlock.UpdateLoadAnimalBlock( x, y )
end


return mafr_animal
