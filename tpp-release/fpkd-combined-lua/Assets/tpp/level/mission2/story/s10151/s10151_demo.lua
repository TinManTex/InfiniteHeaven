local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_SahelanAppearance 		= "p31_050026_000_final",	
	Demo_BreakSahelan 			= "p31_050040_000_final",	
	Demo_DeadSkullFace 			= "p31_050050_000_final",	
	
	Demo_MillerStandIdle		= "p31_050050_002",			
	
	Demo_AfterDeadSkullFace 	= "p31_050050_001_final",	

	Demo_Ending1				= "p31_050060_000_final",
	Demo_Ending2				= "p31_050070_000_final",
	Demo_Ending3				= "p31_050080",
	
	Demo_Movie					= "dummy_movie",			
	
	Demo_SkullShot1				="p31_050050_003",
	Demo_SkullShot2				="p31_050050_004",
	Demo_SkullShot3				="p31_050050_005",
}


this.demoBlockList = {
	Demo_SahelanAppearance 		= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d01.fpk" },	
	Demo_BreakSahelan 			= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d02.fpk" },	
	Demo_DeadSkullFace 			= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },	
	Demo_MillerStandIdle		= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },	
	Demo_AfterDeadSkullFace 	= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },	
	
	
	Demo_Ending1				= { "/Assets/tpp/pack/mission2/free/f30050/f30050_Buddy.fpk","/Assets/tpp/pack/mission2/story/s10151/s10151_d04.fpk" },	
	Demo_Ending2				= { "/Assets/tpp/pack/mission2/story/s10151/s10151_endroll.fpk","/Assets/tpp/pack/mission2/story/s10151/s10151_d05.fpk" },	
	Demo_Ending3				= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d06.fpk" },	
	
	Demo_Movie					= { "/Assets/tpp/pack/mission2/story/s10151/s10151_movie.fpk" },	
	
	Demo_SkullShot1				= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },
	Demo_SkullShot2				= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },
	Demo_SkullShot3				= { "/Assets/tpp/pack/mission2/story/s10151/s10151_d03.fpk" },
}











function this.Messages()
	return
	StrCode32Table {
	
		Demo = {

			{	
				msg = "p31_050026_cabl_off01",	
				func = function()
					Fox.Log( "s10151_demo.Messages(): Demo: p31_050026_cabl_off01" )
					this.SetVisibleSteelTower()
				end,
				option = {
					isExecDemoPlaying = true,
				
				},
			},
			nil
		},
	}
end






this.SahelanAppearance = function(func)

	TppDemo.ReserveInTheBackGround{ demoName = "Demo_SahelanAppearance" }

	TppDemo.Play("Demo_SahelanAppearance",{
					onStart = function()
						this.SetVisiblePowerPlantSahelan()
					end,
	
					onEnd = function()
						TppScriptBlock.LoadDemoBlock( "Demo_BreakSahelan" )
						func()
					end,
			},{
				useDemoBlock = true,
				startNoFadeIn = true,
				
		}
	)
end

this.SetVisiblePowerPlantSahelan = function()
	TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "rock_break_before", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "rock_break_after", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "afgh_sttw002_0000", false, false)
	TppDataUtility.SetVisibleDataFromIdentifier( "DemoModelIdentifier", "afgh_ctwk002_vrtn003_0000", false, false)
	
	
	s10151_sequence.s10151_baseOnActiveTable.afgh_powerPlant()
end


this.BreakSahelan = function(func)
	TppDemo.ReserveInTheBackGround{ demoName = "Demo_BreakSahelan" }
	TppDemo.Play("Demo_BreakSahelan",{
					onEnd = function()
						TppScriptBlock.LoadDemoBlock( "Demo_DeadSkullFace" )
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				startNoFadeIn = true,
				finishFadeOut = true,
		}
	)
end


this.DeadSkullFace = function(func)
	
	TppPlayer.Warp{ pos = {-663.7727,578.7035,-1570.55}, rotY = -0.096239}
	Player.RequestToSetCameraRotation{rotX =-0.273829 , rotY = -180.096239 }

	TppDemo.ReserveInTheBackGround{ demoName = "Demo_DeadSkullFace" }
	local exceptGameStatus = {}
	for key, value in pairs( TppDefine.UI_STATUS_TYPE_ALL ) do
		exceptGameStatus[key] = false
	end
	exceptGameStatus["PauseMenu"] = nil
	TppDemo.Play("Demo_DeadSkullFace",{
					onStart = function()
						this.SetVisibleSteelTower()
						this.SetVisibleCable()
					end,
					onEnd = function()
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				startNoFadeIn = true,
				exceptGameStatus = exceptGameStatus,
		}
	)
end

local SteelTowerList = {

	"cypr_cabl002_vrtn005_gim_n0005|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0006|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0007|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0008|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0009|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0010|srt_cypr_cabl002_vrtn005",
	"cypr_cabl002_vrtn005_gim_n0011|srt_cypr_cabl002_vrtn005",	
	"cypr_cabl002_vrtn005_gim_n0012|srt_cypr_cabl002_vrtn005",
}

this.SetVisibleSteelTower = function()
	Fox.Log("_______s10151_demo.SetVisibleSteelTower()")
	local path = "/Assets/tpp/level/location/afgh/block_large/powerPlant/afgh_powerPlant_asset.fox2"
	
	for i,gimName in ipairs (SteelTowerList) do
		Gimmick.InvisibleGimmick  ( -1, gimName, path, true )
	end
	
	
end

this.SetVisibleCable = function()
	Fox.Log("_______s10151_demo.SetVisibleCable()")
	TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_rubble_DataIdentifier", "cableSet", true, true)
end


this.MillerStandIdle = function(func)

	TppDemo.Play("Demo_MillerStandIdle",{
					onEnd = function()
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,		
				isInGame = true,
		}
	)
end

this.ShotSkullChangeCamera = function(func)
	Fox.Log("_______s10151_demo.ShotSkullChangeCamera ____  mvars.shotCount:" .. tostring(mvars.shotCount))

	local DemoShotList = {
		"Demo_SkullShot1",
		"Demo_SkullShot2",
		"Demo_SkullShot3",
	}

	TppDemo.Play(DemoShotList[mvars.shotCount],
		{
			onInit = function()
				TppDemo.SpecifyIgnoreNpcDisable{"SkullFace"}
			end,
			onEnd = function()
				
				
				if mvars.shotCount == s10151_sequence.MAX_SHOT_COUNT then
					
					GkEventTimerManager.Start( "FlashBackTimer", s10151_sequence.FLASHBACK_TIME)
				else
					
					GkEventTimerManager.Start( "ShotSkullTimer", s10151_sequence.SHOT_SKULL_TIME)
					GkEventTimerManager.Start( "ShotBreathTimer", 1.5)
					
					TppMain.EnablePlayerPad()
				end
				
				
				local param = {
					id="SetSpecialAttackMode",
					enabled = true,
					type = "KillSkullFace",
					sequence = mvars.shotCount%3,	
					sequenceWaitTime = 0.0,	
					cockingWaitTime = 0.5,	
				}
				GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, param )
				
				Player.ChangeEquip{
					equipId = TppEquip.EQP_WP_SkullFace_hg_010, 	
					stock = 0,		
					stockSub = 0,	
					ammo = 3,		
					ammoSub = 0,	
					suppressorLife = 0, 	
					isSuppressorOn = false, 
					isLightOn = false,		
					dropPrevEquip = false,	
					temporaryChange = true,
				}
				
				if func then
					func()
				end
			end,
		},{
			isExecMissionClear = true,
			useDemoBlock = true,
		
			isExecDemoPlaying = true,
		
			fadeSpeed = 0.05,
			startNoFadeIn = true,
		}
	)
end




this.AfterDeadSkullFace = function(func)
	
	TppDemo.Play( "Demo_AfterDeadSkullFace",
		{
			onEnd = function()
				TppScriptBlock.Unload( "demo_block" )
				func()
			end,
		},
		{
			isExecMissionClear = true,
			isExecDemoPlaying = true,
			waitBlockLoadEndOnDemoSkip = false,
			useDemoBlock = true,
			finishFadeOut = true,
		}
	)

end




this.Ending01 = function(func)
	local cluster = TppDefine.CLUSTER_DEFINE.Develop
	MotherBaseStage.LockCluster( cluster )
	local translation, rotQuat = MotherBaseStage.GetDemoCenter( cluster )
	DemoDaemon.SetDemoTransform( "p31_050060_000_final", rotQuat, translation )

	TppDemo.Play("Demo_Ending1",{
					onInit = function() 
						WeatherManager.RequestTag("Default", 0 )
						
						TppClock.SetTime( "10:00:00" )
						
						TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
						
						
						if not TppStory.CanArrivalQuietInMB() then
							TppDemoUtility.SetInvisibleUniqueCharacter{invisible = {"Quiet"}}
						end
					end,
					onStart = function()
						TppDataUtility.SetVisibleDataFromIdentifier( "uq_0020_demo_hide_AssetIdentifier", "demo_hide", false, true)
					end,
					onEnd = function()
						TppDataUtility.SetVisibleDataFromIdentifier( "uq_0020_demo_hide_AssetIdentifier", "demo_hide", true, true)
						TppScriptBlock.LoadDemoBlock( "Demo_Ending2")
						
						
						
						TppWeather.CancelRequestWeather()
						
						
						vars.buddyType = mvars.buddyTypeTmp 
						
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				startNoFadeIn = true,
				finishFadeOut = true
		}
	)
	
end


this.Ending02 = function(func)
	local cluster = TppDefine.CLUSTER_DEFINE.Develop
	MotherBaseStage.LockCluster( cluster )	
	local translation, rotQuat = MotherBaseStage.GetDemoCenter( cluster )
	DemoDaemon.SetDemoTransform( "p31_050070_000_final", rotQuat, translation )

	TppDemo.Play("Demo_Ending2",{
					onInit = function() 
						
						TppClock.SetTime( "11:00:00" )
						
						TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
					end,
					onStart = function()
						
						TppDataUtility.SetVisibleDataFromIdentifier( "uq_0020_demo_hide_AssetIdentifier", "demo_hide_2", false, true)
					end,
	
					onEnd = function()
						
						TppDataUtility.SetVisibleDataFromIdentifier( "uq_0020_demo_hide_AssetIdentifier", "demo_hide_2", true, true)

						if svars.isCleardS10151 then
							TppScriptBlock.LoadDemoBlock( "Demo_Ending3" )
						else
							TppScriptBlock.LoadDemoBlock( "Demo_Movie" )
						end
						
						MotherBaseStage.UnlockCluster()
						
						
						TppWeather.CancelRequestWeather()
						
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				startNoFadeIn = true,
				finishFadeOut = true
		}
	)
end


this.Ending03 = function(func)
	
	local cluster = TppDefine.CLUSTER_DEFINE.Command
	MotherBaseStage.LockCluster( cluster )
	
	local translation, rotQuat = MotherBaseStage.GetDemoCenter( cluster )
	DemoDaemon.SetDemoTransform( "p31_050080", rotQuat, translation )
	
	TppDemo.Play("Demo_Ending3",{
					onInit = function() 
						
						TppClock.SetTime( "17:45:00" )
						
						TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
						
						
						if not TppStory.CanArrivalQuietInMB() then
							TppDemoUtility.SetInvisibleUniqueCharacter{invisible = {"Quiet"}}
						end
					end,
					onEnd = function()
						
					
						
						MotherBaseStage.UnlockCluster()
						
						
						TppWeather.CancelRequestWeather()
						
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				startNoFadeIn = true,
				finishFadeOut = true,
		}
	)
end




return this
