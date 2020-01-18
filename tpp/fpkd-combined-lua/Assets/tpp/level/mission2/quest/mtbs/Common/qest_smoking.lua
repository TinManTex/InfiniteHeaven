local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID








this.RouteSets = {
	Command = {
		plnt0 = {
			day = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0000_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0000_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0010_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0010_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0020_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0020_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0030_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0030_0000",
				"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_qest_n_0031_0000",
			},			
		},
	},
	Combat = {
		plnt0 = {
			day = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0000_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0000_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0010_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0010_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0020_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0020_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0030_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0030_0000",
				"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_qest_n_0031_0000",
			},			
		},
	},
	Develop = {
		plnt0 = {
			day = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0000_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0000_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0010_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0010_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0020_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0020_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0030_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0030_0000",
				"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_qest_n_0031_0000",
			},			
		},
	},
	Support = {
		plnt0 = {
			day = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0000_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0000_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0010_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0010_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0020_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0020_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0030_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0030_0000",
				"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_qest_n_0031_0000",
			},			
		},
	},

	Medical = {
		plnt0 = {
			day = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0000_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0000_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 = {
			day = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0010_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0010_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 = {
			day = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0020_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0020_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0021_0000",
			},
		},

		plnt3 = {
			day = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0030_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0030_0000",
				"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_qest_n_0031_0000",
			},
		},
	},
	Spy = {
		plnt0 = {
			day = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0000_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0000_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0010_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0010_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0020_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0020_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0030_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0030_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_qest_n_0031_0000",
			},			
		},
	},
	BaseDev = {
		plnt0 = {
			day = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0000_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0001_0000",
			},
			night = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0000_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0001_0000",
			},
		},
		plnt1 ={
			day = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0010_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0011_0000",
			},
			night = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0010_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0011_0000",
			},
		},
		plnt2 ={
			day = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0020_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0021_0000",
			},
			night = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0020_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0021_0000",
			},
		},
		plnt3 ={
			day = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0030_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_d_0031_0000",
			},
			night = {
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0030_0000",
				"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_qest_n_0031_0000",
			},			
		},
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = function()
			Fox.Log("quest_smoking OnDeactivate")
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest_smoking OnOutOfAcitveArea")

			



			
		end,
		OnTerminate = function()
			Fox.Log("quest_smoking OnTerminate")
		end,
	}
end




function this.Messages()
	return
	StrCode32Table {
		Block = {
			{
				msg = "StageBlockCurrentSmallBlockIndexUpdated",
				func = function() end,
			},
		},
	}
end







function this.OnActivate()
	Fox.Log("quest_smoking activate")
	mvars.qst_smok_soldierList = {}
	local clusterId = mtbs_cluster.GetCurrentClusterId()
	local clusterName = mtbs_cluster.GetClusterName(clusterId)
	local day = TppClock.GetTimeOfDay()
	local routeList = this.RouteSets[clusterName]
	for _, plntName in ipairs( mtbs_enemy.plntNameDefine ) do
		local routeSets = routeList[plntName][day]
		local soldierList = mtbs_enemy.GetSoldierForQuest( clusterName, plntName, #routeSets )
		
		for i, soldierName in ipairs( soldierList ) do
			local routeName = routeSets[i]
			local gameObjectId = GetGameObjectId("TppSoldier2", soldierName)
			
			TppEnemy.SetDisable( gameObjectId )
			TppEnemy.SetSneakRoute( gameObjectId, routeName )

			table.insert(mvars.qst_smok_soldierList, gameObjectId )	
			
		end
	end
	mvars.qst_smok_waitSoldierDisableFrame = 5
end




function this.OnInitialize()	
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	
	if mvars.qst_smok_waitSoldierDisableFrame and mvars.qst_smok_waitSoldierDisableFrame > 0 then
		mvars.qst_smok_waitSoldierDisableFrame = mvars.qst_smok_waitSoldierDisableFrame - 1
		if mvars.qst_smok_waitSoldierDisableFrame == 0 then
			this._EnableSoldiers()
		end
	end
	TppQuest.QuestBlockOnUpdate( this )
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
end







quest_step.QStep_Start = {

	Messages = function( self )
		return
		StrCode32Table {
			Trap = {
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		TppQuest.ClearWithSaveMtbsDDQuest()
	end,
	
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
		this._ResetSoldiers()	
	end,
}


this._EnableSoldiers = function()
	for _, gameObjectId in ipairs( mvars.qst_smok_soldierList ) do
		TppEnemy.SetEnable( gameObjectId )
	end
end


this._ResetSoldiers = function()
	if mvars.qst_smok_soldierList then	
		for _, gameObjectId in ipairs( mvars.qst_smok_soldierList ) do
			TppEnemy.UnsetSneakRoute(gameObjectId)
		end
	end
end

return this