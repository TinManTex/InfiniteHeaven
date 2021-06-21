local this={}
local StrCode32=InfCore.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand

this.requires={}

--tex requires the proper vox_ene_common_ soundbank to be loaded, see InfSoundInfo for pack paths
this.cpTypes=CpType.TYPE_AFRIKAANS--tex apply to all cps
--tex or per cp cpType
--this.cpTypes={
--	briefing_ob=CpType.TYPE_AFRIKAANS,
--	village_cp=CpType.TYPE_AMERICA,
--}--cpTypes

--REF TppEnemy._AnnouncePhaseChange, cpSubTypeToLangId
--this.cpAnounceLangIds="cmmn_ene_pf"--tex apply to all cps
--tex or per cp
--this.cpAnounceLangIds={
--	briefing_ob="cmmn_ene_pf",
--	village_cp="cmmn_ene_zrs",
--}--cpAnounceLangIds

--this.cpSubTypes="PF_C"--tex apply to all cps
--tex or per cp subtype
this.cpSubTypes={
	briefing_ob="PF_B",
	village_cp="PF_C",
}--cpSubTypes

this.soldierDefine={
	briefing_ob = {--17
		"sol_afc0_0000",
		"sol_afc0_0001",
		"sol_afc0_0002",
		"sol_afc0_0003",
		"sol_afc0_0004",
		"sol_afc0_0005",
		"sol_afc0_0006",
		"sol_afc0_0007",
		"sol_afc0_0008",
		"sol_afc0_0009",
		"sol_afc0_0010",
		"sol_afc0_0011",
		"sol_afc0_0012",
		"sol_afc0_0013",
		"sol_afc0_0014",
		"sol_afc0_0015",
		"sol_afc0_0016",
	},--briefing_ob
	village_cp = {--21
		"sol_afc0_0017",
		"sol_afc0_0018",
		"sol_afc0_0019",
		"sol_afc0_0020",
		"sol_afc0_0021",
		"sol_afc0_0022",
		"sol_afc0_0023",
		"sol_afc0_0024",
		"sol_afc0_0025",
		"sol_afc0_0026",
		"sol_afc0_0027",
		"sol_afc0_0028",
		"sol_afc0_0029",
		"sol_afc0_0030",
		"sol_afc0_0031",
		"sol_afc0_0032",
		"sol_afc0_0033",
		"sol_afc0_0034",
		"sol_afc0_0035",
		"sol_afc0_0036",
		"sol_afc0_0037",
	},--village_cp	
	quest_cp={
		"sol_quest_0000",
		"sol_quest_0001",
		"sol_quest_0002",
		"sol_quest_0003",
		"sol_quest_0004",
		"sol_quest_0005",
		"sol_quest_0006",
		"sol_quest_0007",
	},
}--soldierDefine

this.soldierTypes={
	PF={--REF EnemyType["TYPE_"..soldierType]
		this.soldierDefine.briefing_ob,
		this.soldierDefine.village_cp,
	},
}--soldierTypes

this.soldierSubTypes=true--tex true = use cpSubTypes to define soldier subtypes for
--tex or per soldier sub type
--this.soldierSubTypes={	
--	PF_C={
--		"sol_afc0_0019",
--		this.soldierDefine.briefing_ob,	
--	},
--	PF_B={
--		this.soldierDefine.village_cp,
--	},
--}--soldierSubTypes

this.routeSets={
	briefing_ob={
		priority={
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day={
			groupA={
				"rt_afc0_d_0000",
				"rt_afc0_d_0001",
				"rt_afc0_d_0002",
				"rt_afc0_d_0003",
				"rt_afc0_d_0004",
			},
			groupB={
				"rt_afc0_d_0005",
				"rt_afc0_d_0006",
				"rt_afc0_d_0007",
				"rt_afc0_d_0008",
				"rt_afc0_d_0009",
				"rt_afc0_d_0010",
			},
			groupC={
				"rt_afc0_d_0032",
				"rt_afc0_d_0033",
				"rt_afc0_d_0034",
				"rt_afc0_d_0035",
				"rt_afc0_d_0036",			
			},
		},--sneak_day
		sneak_night= {
			groupA={
				"rt_afc0_d_0000",
				"rt_afc0_d_0001",
				"rt_afc0_d_0002",
				"rt_afc0_d_0003",
				"rt_afc0_d_0004",
			},
			groupB={
				"rt_afc0_d_0005",
				"rt_afc0_d_0006",
				"rt_afc0_d_0007",
				"rt_afc0_d_0008",
				"rt_afc0_d_0009",
				"rt_afc0_d_0010",
			},
			groupC={
				"rt_afc0_d_0032",
				"rt_afc0_d_0033",
				"rt_afc0_d_0034",
				"rt_afc0_d_0035",
				"rt_afc0_d_0036",			
			},
		},--sneak_night
	},--briefing_ob
	village_cp={
		priority={
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day={
			groupA={
				"rt_afc0_d_0011",
				"rt_afc0_d_0012",
				"rt_afc0_d_0013",
				"rt_afc0_d_0014",
				"rt_afc0_d_0015",
			},
			groupB={			
				"rt_afc0_d_0016",
				"rt_afc0_d_0017",
				"rt_afc0_d_0018",
				"rt_afc0_d_0019",
				"rt_afc0_d_0020",
				"rt_afc0_d_0021",
			},
			groupC={
				"rt_afc0_d_0022",
				"rt_afc0_d_0023",
				"rt_afc0_d_0024",
				"rt_afc0_d_0025",
				"rt_afc0_d_0026",
			},
			groupD={
				"rt_afc0_d_0027",
				"rt_afc0_d_0028",
				"rt_afc0_d_0029",
				"rt_afc0_d_0030",
				"rt_afc0_d_0031",
			},
		},--sneak_day
		sneak_night= {
			groupA={
				"rt_afc0_d_0011",
				"rt_afc0_d_0012",
				"rt_afc0_d_0013",
				"rt_afc0_d_0014",
				"rt_afc0_d_0015",
			},
			groupB={			
				"rt_afc0_d_0016",
				"rt_afc0_d_0017",
				"rt_afc0_d_0018",
				"rt_afc0_d_0019",
				"rt_afc0_d_0020",
				"rt_afc0_d_0021",
			},
			groupC={
				"rt_afc0_d_0022",
				"rt_afc0_d_0023",
				"rt_afc0_d_0024",
				"rt_afc0_d_0025",
				"rt_afc0_d_0026",
			},
			groupD={
				"rt_afc0_d_0027",
				"rt_afc0_d_0028",
				"rt_afc0_d_0029",
				"rt_afc0_d_0030",
				"rt_afc0_d_0031",
			},
		},--sneak_night
	},--village_cp
	quest_cp--DEBUGNOW  = { USE_COMMON_ROUTE_SETS = true, },
	--TODO common routesets, see /Assets/tpp/script/location/afgh/afgh_routeSets.lua
	--refrerenced through location script .requires, see /Assets/tpp/script/location/afgh/afgh.lua .requires
		 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		sneak_night = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		caution = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
			},
		},
		travel = {
			lrrpHold = {
			},
		},
		nil
	},--quest_cp
}--routeSets

this.combatSetting={
	nil
}--combatSetting

this.InitEnemy=function()
end

this.SetUpEnemy=function()
	TppEnemy.SetupQuestEnemy()
end--SetUpEnemy

this.OnLoad=function()
end

return this
