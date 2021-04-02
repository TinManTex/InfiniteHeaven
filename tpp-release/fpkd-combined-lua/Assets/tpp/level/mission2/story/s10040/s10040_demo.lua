local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_AttackHostage1 = "p31_020020_000", 

	Demo_FindHoneyBee1	= "p31_020025_002", 
	Demo_FindHoneyBee2	= "p31_020025_003", 

	Demo_RescueHostage 	= "p31_020010", 

	
	Demo_FondHoneyBee02 	= "p31_020050",
	
	Demo_EnemyHeli 		= "p31_020027",	
	Demo_Clear			= "p31_020040",		

	Demo_FogStart		= "p31_020029",
	Demo_SkullFace		= "p31_020030_000_final",
	Demo_SkullFace2		= "p31_020035_000_final",
	Demo_Parasite		= "parasite"
}

this.demoBlockList = {
	Demo_AttackHostage1 	= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d01.fpk" },
	Demo_RescueHostage	 	= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d01.fpk" },
	
	Demo_FondHoneyBee02 	= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d02.fpk" },
	Demo_FindHoneyBee1 		= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d02.fpk" },
	Demo_EnemyHeli 			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d03.fpk" },
	Demo_Clear	 			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d04.fpk" },
	Demo_Parasite 			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d05.fpk" },
	Demo_FogStart			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d06.fpk" },
	Demo_SkullFace			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d06.fpk" },
	Demo_SkullFace2			= { "/Assets/tpp/pack/mission2/story/s10040/s10040_d07.fpk" },
}





this.PlayAttackHostage = function(func)
	Fox.Log("Play demo. attack to hostage 000")
	TppDemo.Play(
		"Demo_AttackHostage1",
		{
			onEnd = function() func() end,
		},
		{
			useDemoBlock = true,
			isInGame = true,
		}
	 )
end


this.PlayFindHoneyBee1 = function(func)
	Fox.Log("Play demo. find honey bee1")
	TppDemo.Play("Demo_FindHoneyBee1",
		{
			onEnd = function() func() end,
		}, 
		{
			useDemoBlock = true,
			isInGame = true,
			isSnakeOnly = false,
		}
	)
end


this.PlayFindHoneyBee2 = function(func)
	Fox.Log("Play demo. find honey bee2")

	TppDemo.Play("Demo_FindHoneyBee2",
		{
			onEnd = function() func() end,
		},
		{
			useDemoBlock = true,
			isInGame = true, 
			isSnakeOnly = false,
		}
	)
end



this.PlayRescueHostage = function(func, iden, key, startFunc )
	
	if svars.isDemoArea then
	elseif svars.isDemoArea2 then
		TppDemo.SetDemoTransform(
			"Demo_RescueHostage",
			{
				
				identifier	= iden,
				locatorName	= key
			}
		)

	else
		Fox.Error("not in demo area")
		return
	end

	TppDemo.Play(
		"Demo_RescueHostage",
		{
			onEnd = function() func() end,
			onStart = function() startFunc() end,
		},
		{
			useDemoBlock = true
		} 
	)

end

this.PlayYuruConCamera = function()
	Fox.Log("Play demo. Yuru Con Camera 1")

	TppDemo.Play("Demo_FondHoneyBee01",
		{
			onEnd = function()
				Fox.Log("end yuru con 1")
			end,
		},
		{
			useDemoBlock = true,
			
		}
	)
end

this.PlayYuruConCamera2 = function(func)
	Fox.Log("Play demo. Yuru Con Camera 2")

	TppDemo.Play("Demo_FondHoneyBee02",
		{
			onEnd = function()
				Fox.Log("end yuru con 2")
				func()
			end,
		},
		{
			useDemoBlock = true,
			isSnakeOnly = false,
		}
	)
end

this.CheckIsPlayHostageAttack = function()
	Fox.Log("check play demo")
	
	if DemoDaemon.IsPlayingDemoId( this.demoList.Demo_FindHoneyBee1 ) == true then
		Fox.Log("true")
		return true
	else
		return false
	end

end



this.PlayFogStart = function(func)
	Fox.Log("Play demo. start fog")

	TppDemo.Play("Demo_FogStart",
		{
			onEnd = function() func() end
		},
		{
			useDemoBlock = true,
			finishFadeOut = false,
		}
	)

end

this.PlaySkullFace = function(func)
	Fox.Log("Play demo. skull face")
	
	local type = -1
	local GIMMICK_PATH = "/Assets/tpp/level/location/afgh/block_large/fort/afgn_fort_light.fox2"
	local name = "afgh_lght007_vrtn002_gim_n0003|srt_afgh_lght007_vrtn002"
	Fox.Log("invisible light gimmick")
	Gimmick.InvisibleGimmick( type, name, GIMMICK_PATH, true)


	TppDemo.Play("Demo_SkullFace",
		{
			onStart = function() 
				TppEffectWeatherParameterMediator.ReleaseAdditionalFogNearDistanceEnvelope( 2.0 )
			end,
			onEnd = function() 
				func() 
				TppUI.ShowAccessIcon()
			end,
		},
		{
			useDemoBlock = true,
			finishFadeOut = true,
		}
	)
end

this.PlaySkullFace2 = function(func)
	Fox.Log("Play demo. skull face2")

	TppDemo.Play("Demo_SkullFace2",
		{
			onStart = function()
				TppUI.HideAccessIcon()
			end,
			onEnd = function() func() end,
		},
		{
			useDemoBlock = true,
			startNoFadeIn = true,
			waitBlockLoadEndOnDemoSkip = false,
		}
	)
end





this.PlayMissionCear = function(iden,key,func)	
	Fox.Log("Play clear demo")
	
	if key == false then
		Fox.Log("not set pos")
	else
		Fox.Log("set pos : "..iden..","..key )
		TppDemo.SetDemoTransform(
			"Demo_Clear",
			{
				
				identifier	= iden,
				locatorName	= key
			}
		)
	end
	
	TppDemo.Play(
		"Demo_Clear",
		{
			onEnd = function() func() end,
		}, 
		{
			useDemoBlock = true,
			finishFadeOut = true,
			isExecMissionClear=true,
			waitBlockLoadEndOnDemoSki = true,
		}
	)
end



this.PlayEnemyHeli = function(func)
	Fox.Log("Play Game Over Demo")
	TppDemo.Play( 
		"Demo_EnemyHeli",
		{
			onEnd = function()
				TppMission.ShowGameOverMenu{}
			end
		},
		{
			useDemoBlock = true,
			finishFadeOut = true,
			isExecGameOver = true ,
			
			isSnakeOnly = false,
		}
	)
end




return this
