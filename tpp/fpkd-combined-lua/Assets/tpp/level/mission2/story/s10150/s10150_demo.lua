local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_OpOKBZero 				= "p31_050005",				
	Demo_dummy_NPC01			= "npc01",			
	Demo_SkullFaceAppearance 	= "p31_050010_000_final",	
	Demo_SahelanAppearance 		= "p31_050025_000_final",	
}


this.demoBlockList = {
	Demo_OpOKBZero				= { 
		TppDefine.MISSION_COMMON_PACK.HUEY,
		TppDefine.MISSION_COMMON_PACK.LIQUID,
		TppDefine.MISSION_COMMON_PACK.MILLER,
		TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT,
		"/Assets/tpp/pack/mission2/story/s10150/s10150_d01.fpk" 
	},	
	Demo_dummy_NPC01			= { 
		TppDefine.MISSION_COMMON_PACK.ENEMY_HELI,
		TppDefine.MISSION_COMMON_PACK.WALKERGEAR,
		"/Assets/tpp/pack/mission2/story/s10150/s10150_npc01.fpk"
	},
	Demo_SkullFaceAppearance 	= { "/Assets/tpp/pack/mission2/story/s10150/s10150_d02.fpk" },	
	Demo_SahelanAppearance 		= { "/Assets/tpp/pack/mission2/story/s10150/s10150_d03.fpk" },	
}





this.OpOKBZero = function(func)
	
	
	TppDemo.Play("Demo_OpOKBZero",{
					onEnd = function()
						TppScriptBlock.LoadDemoBlock( "Demo_dummy_NPC01" )
						func()
					end,
			},{
				useDemoBlock = true,
				startNoFadeIn = true,
				
		}
	)
	
end


this.SkullFaceAppearance = function(func)
	
	TppDemo.Play("Demo_SkullFaceAppearance",{
					onEnd = function()
					
						func()
					end,
			},{
				useDemoBlock = true,
				startNoFadeIn = true,
				
		}
	)
end

this.visibleOffPowerPlantAsset = function()
	TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "afgh_sttw002_0000", false, false)
	TppDataUtility.SetVisibleDataFromIdentifier( "DemoModelIdentifier", "afgh_ctwk002_vrtn003_0000", false, false)
end


this.SahelanAppearance = function(func)
	
	TppDemo.Play("Demo_SahelanAppearance",{
					onInit = function()
						TppDemo.ReserveInTheBackGround{ demoName = "Demo_SahelanAppearance" }
					end,
					
					onStart = function()
						this.visibleOffPowerPlantAsset()
					end,

					onEnd = function()
						func()
					end,
			},{
				isExecMissionClear = true,
				useDemoBlock = true,
				finishFadeOut = true,
				waitBlockLoadEndOnDemoSkip = false,
		}
	)
end





return this
