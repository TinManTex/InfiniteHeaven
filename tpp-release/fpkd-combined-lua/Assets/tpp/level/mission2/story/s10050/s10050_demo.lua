local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoBlockList = {
	Demo_ConnectKillQuietGame	=	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d01.fpk" },
	Demo_NotKillQuiet			=	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d01.fpk" },
	Demo_QuietDied				=	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d01.fpk" },
	Demo_RideHeliWithQuiet		= 	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d01.fpk" },
	Demo_GoToMotherBase			=	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk" },
	Demo_ArrivedMotherBase		=	{ "/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk" },
}

this.demoList = {
	Demo_ConnectKillQuietGame	=	"p31_030110_000_final",	
	Demo_NotKillQuiet			=	"p31_030130_final_000",	
	Demo_QuietDied				=	"p31_030140",			
	Demo_RideHeliWithQuiet		=	"p31_030200_000_final",	
	Demo_GoToMotherBase			=	"p31_030210",			
	Demo_ArrivedMotherBase		=	"p31_030220_000_final",	
}





this.PlayDemo_ConnectKillQuietGame = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_ConnectKillQuietGame ####")
	TppDemo.Play("Demo_ConnectKillQuietGame",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock = true,
			
		}
	)
end


this.PlayDemo_NotKillQuiet = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_RideHeliWithQuiet ####")
	TppDemo.Play("Demo_NotKillQuiet",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,
			
		}
	)
end


this.PlayDemo_QuietDied = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_QuietDied ####")
	TppDemo.Play("Demo_QuietDied",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,

		}
	)
end


this.PlayDemo_RideHeliWithQuiet = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_RideHeliWithQuiet ####")
	
	
	this.SetDemoToIdelEnabled_Heli(true)
	
	TppDemo.Play("Demo_RideHeliWithQuiet",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,

			finishFadeOut		= true,	
			isExecMissionClear	= true,	
			waitBlockLoadEndOnDemoSkip	= false,	
		}
	)
end


this.PlayDemo_GoToMotherBase = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_GoToMotherBase ####")

	
	DemoDaemon.SetDemoTransform( this.demoList.Demo_GoToMotherBase, Quat(0,0,0,1), Vector3(5000,0,5000) )

	
	MotherBaseStage.LockCluster()

	
	TppDemo.Play("Demo_GoToMotherBase",{
		onEnd 	= function()
			
			MotherBaseStage.UnlockCluster()

			func()
		end,
		},
		{
			useDemoBlock		= true,
			finishFadeOut		= true,	
			isExecMissionClear	= true,	
		}
	)
end


this.PlayDemo_ArrivedMotherBase = function(func)
	Fox.Log("#### s10050_demo.PlayDemo_ArrivedMotherBase ####")

	
	MotherBaseStage.LockCluster()

	TppDemo.Play("Demo_ArrivedMotherBase",{
		onEnd 	= function()
			
			MotherBaseStage.UnlockCluster()

			func()
		end,
		},
		{
			useDemoBlock		= true,
			finishFadeOut		= true,	
			isExecMissionClear	= true,	
		}
	)
end



this.SetDemoToIdelEnabled_Heli = function(flag)
	Fox.Log("#### s10140_demo.SetDemoToIdelEnabled_Heli #### enable = " ..tostring(flag))
	
	local targetHeli = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
	GameObject.SendCommand( targetHeli, { id ="SetDemoToIdleEnabled", enabled = flag })	
end



return this
