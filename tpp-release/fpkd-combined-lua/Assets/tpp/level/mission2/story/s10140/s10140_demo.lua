local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoBlockList = {
	Demo_Opening				=	"/Assets/tpp/pack/mission2/story/s10140/s10140_d01.fpk",
	Demo_CodeTalker_Evacuate	= 	"/Assets/tpp/pack/mission2/story/s10140/s10140_d01.fpk",
	Demo_Inside_Heli			=	"/Assets/tpp/pack/mission2/story/s10140/s10140_d02.fpk",
	Demo_TorturedHueyAtMB		=	"/Assets/tpp/pack/mission2/story/s10140/s10140_d03.fpk",
	Demo_GoToLastMission		=	"/Assets/tpp/pack/mission2/story/s10140/s10140_d03.fpk",
	Demo_PandemicConverge		=	"/Assets/tpp/pack/mission2/story/s10140/s10140_d03.fpk",
}

this.demoList = {
	Demo_Opening				=	"p41_060210",
	Demo_CodeTalker_Evacuate	=	"p41_060220",
	Demo_Inside_Heli			=	"p41_060250_000_final",
	Demo_TorturedHueyAtMB		=	"p41_060260_000_final",
	Demo_GoToLastMission		=	"p41_060270_000_final",
	Demo_PandemicConverge		=	"p41_060255",
}	





this.PlayDemo_Opening = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_Opening ####")
	
	
	this.SetDemoToIdelEnabled_Heli(true)

	TppDemo.Play("Demo_Opening",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
			finishFadeOut		= true,	
		}
	)
end


this.PlayDemo_CodeTalker_Evacuate = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_CodeTalker_Evacuate ####")

	
	this.SetStateAfterDemo_Parasite()
	
	TppDemo.Play("Demo_CodeTalker_Evacuate",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
		}
	)
end


this.PlayDemo_Inside_Heli = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_Inside_Heli ####")
	
	
	this.SetDemoToIdelEnabled_Heli(true)

	TppDemo.Play("Demo_Inside_Heli",{
		onEnd 	= function()
			func()
			TppDemo.ReserveInTheBackGround{ demoName = "Demo_PandemicConverge" }
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
			isExecMissionClear	= true,	
			finishFadeOut		= true,	
			waitBlockLoadEndOnDemoSkip	= false,	
		}
	)
end


this.PlayDemo_PandemicConverge = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_PandemicConverge ####")
	
	local trans, rotQuat = MotherBaseStage.GetDemoCenter( 7, 0 )
	local demoId = "p41_060255"
	DemoDaemon.SetDemoTransform( demoId, rotQuat, trans )

	TppDemo.Play("Demo_PandemicConverge",{
		onStart 	= function()
			TppDataUtility.SetVisibleDataFromIdentifier( "uq_0020_demo_hide_AssetIdentifier", "p41_060255_off", false, false)
			this.UnsetEmergencyAsset()
		end,
		onEnd 	= function()
			func()
			MotherBaseStage.UnlockCluster()
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
			isExecMissionClear	= true,	
			finishFadeOut		= true,	
		}
	)
end


this.PlayDemo_TorturedHueyAtMB = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_TorturedHueyAtMB ####")
	local trans, rotQuat = MotherBaseStage.GetDemoCenter( TppDefine.CLUSTER_DEFINE.Command, 0 )
	local demoId = "p41_060260"
	DemoDaemon.SetDemoTransform( demoId, rotQuat, trans )

	TppDemo.Play("Demo_TorturedHueyAtMB",{
		onEnd 	= function()
			func()
		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
			isExecMissionClear	= true,	
			finishFadeOut		= true,	
			waitTextureLoadOnDemoPlay = true,
		}
	)
end


this.PlayDemo_GoToLastMission = function(func)
	Fox.Log("#### s10140_demo.PlayDemo_GoToLastMission ####")
	local trans, rotQuat = MotherBaseStage.GetDemoCenter( TppDefine.CLUSTER_DEFINE.Command, 0 )
	local demoId = "p41_060270"
	DemoDaemon.SetDemoTransform( demoId, rotQuat, trans )

	TppDemo.Play("Demo_GoToLastMission",{
		onInit	= function()
			
			TppClock.SetTime( "16:00:00" )
			
			TppWeather.RequestWeather( TppDefine.WEATHER.RAINY, 0 )
		end,	
		onEnd 	= function()
			func()
			
			TppWeather.CancelRequestWeather()
 		end,
		},
		{
			useDemoBlock		= true,
			startNoFadeIn		= true,
			isExecMissionClear	= true,	
			finishFadeOut		= true,	
			waitBlockLoadEndOnDemoSkip	= false,	
		}
	)
end





this.SetDemoToIdelEnabled_Heli = function(flag)
	Fox.Log("#### s10140_demo.SetDemoToIdelEnabled_Heli #### enable = " ..tostring(flag))
	
	local targetHeli = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
	GameObject.SendCommand( targetHeli, { id ="SetDemoToIdleEnabled", enabled = flag })	
end



this.SetStateAfterDemo_Parasite = function()
	Fox.Log("#### s10140_demo.SetStateAfterDemo_Parasite ####")
	GameObject.SendCommand( { type="TppParasite2", index=0 }, { id="SetStateAfterDemo", realize=true, harden=true } ) 
	GameObject.SendCommand( { type="TppParasite2", index=1 }, { id="SetStateAfterDemo", realize=true, harden=true } ) 
	GameObject.SendCommand( { type="TppParasite2", index=2 }, { id="SetStateAfterDemo", realize=true, harden=true } ) 
	GameObject.SendCommand( { type="TppParasite2", index=3 }, { id="SetStateAfterDemo", realize=true, harden=true } ) 
end



this.UnsetEmergencyAsset = function()
	local assetFlag = false
	local gimmickFlag = true
	local IDEN_ASSET_ID = "uq_0020_demo_hide_AssetIdentifier"
	local IDEN_ASSET_KEY = {"emergency_obj"}

	
	TppDataUtility.SetVisibleDataFromIdentifier( IDEN_ASSET_ID, "emergency_obj" , assetFlag )
	TppDataUtility.SetVisibleDataFromIdentifier( IDEN_ASSET_ID, "close_door" , not assetFlag )

	
	TppDataUtility.VisibleMeshFromIdentifier(IDEN_ASSET_ID,"floor","MESH_usually_IV")
	TppDataUtility.InvisibleMeshFromIdentifier(IDEN_ASSET_ID,"floor","MESH_emergency")

	
	
	TppDataUtility.SetVisibleDataFromIdentifier( "uq07_item_Identifier", "off0000", assetFlag, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "uq07_item_Identifier", "off0001", assetFlag, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "uq07_item_Identifier", "off0002", assetFlag, true)
	
	
	local type = -1
	local layout = MotherBaseStage.GetCurrentLayout()
	local GIMMICK_PATH = string.format("/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl07/mtbs_ly%03d_cl07_item.fox2", layout, layout)
	local GIMMICK_NAME_TABLE = {
		"ly003_cl07_item0000|cl07pl0_uq_0070_gimmick2|mtbs_tent001_gim_n0001|srt_mtbs_tent001",
		"ly003_cl07_item0000|cl07pl0_uq_0070_gimmick2|mafr_tent002_vrtn003_gim_n0001|srt_mafr_tent002_vrtn003",
		"ly003_cl07_item0000|cl07pl0_uq_0070_light2|afgh_lght007_vrtn002_gim_n0001|srt_afgh_lght007_vrtn002",
		"ly003_cl07_item0000|cl07pl0_uq_0070_light2|mtbs_lght007_emit001_gim_n0001|srt_mtbs_lght007_emit001",
		"ly003_cl07_item0000|cl07pl0_uq_0070_light2|mtbs_lght007_emit001_gim_n0002|srt_mtbs_lght007_emit001",
	}
	for i, keyName in pairs(GIMMICK_NAME_TABLE)do
		Gimmick.InvisibleGimmick( type, keyName, GIMMICK_PATH, gimmickFlag)
	end

end



return this
