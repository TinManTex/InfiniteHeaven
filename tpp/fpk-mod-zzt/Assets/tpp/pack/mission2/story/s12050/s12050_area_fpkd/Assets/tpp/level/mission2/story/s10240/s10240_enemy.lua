--DEBUGNOW
return InfCore.PCall(function()

local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
	
	mbqf_mtbs_cp = {
		"sol_mtbs_0000",
		"sol_mtbs_0001",
		"sol_mtbs_0002",
		"sol_mtbs_0003",
		"sol_mtbs_0004",
		"sol_mtbs_0005",
		nil
	},
	nil
}

this.routeSets = {
	--DEBUGNOW
	mbqf_mtbs_cp = {
		priority = {
			"groupA",
			nil
		},
		sneak_day = {
			groupA = {
			--[[
				"rts_10240_d_0001",
				"rts_10240_d_0002",
				"rts_10240_d_0003",
				"rts_10240_d_0004",
				"rts_10240_d_0005",
				"rts_10240_d_0006",
				--]]
											"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0002",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0003",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0004",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0005",
			},
		},
		sneak_night= {
			groupA = {
			--[[
				"rts_10240_d_0001",
				"rts_10240_d_0002",
				"rts_10240_d_0003",
				"rts_10240_d_0004",
				"rts_10240_d_0005",
				"rts_10240_d_0006",
				--]]
											"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0001",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0002",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0003",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0004",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0005",
			},
		},
	},
	--]]
}





this.combatSetting = {
	nil
}




this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	local gameObjectId
	local seed = {	84, 64 }
	local seedNum = 1

	if TppSequence.GetSequenceIndex( TppSequence.GetMissionStartSequenceName() ) == TppSequence.GetSequenceIndex("Seq_Demo_Funeral") then
		
		Fox.Log("fova set : demo")
		local faceSeed = { 54, 67, 75, 96, 132, 294 }
		for i, enemyId in pairs(this.soldierDefine.mbqf_mtbs_cp)do
			gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyId )
			GameObject.SendCommand( gameObjectId, { id = "SetFriendly"} )
			GameObject.SendCommand( gameObjectId, { id = "ChangeFova", balaclavaFaceId=TppEnemyFaceId.dds_balaclava2,seed=faceSeed[i] } )
		end

	else
		Fox.Log("fova set : game")
		
		for i, enemyId in pairs(this.soldierDefine.mbqf_mtbs_cp)do
			gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyId )
			--DEBUGNOW GameObject.SendCommand( gameObjectId, { id = "SetFriendly"} )
				--DEBUGNOW GameObject.SendCommand( gameObjectId, { id = "SetSoundSwitchCyprusMask", enabled=true } )			
			GameObject.SendCommand( gameObjectId, { id = "ChangeFova",  balaclavaFaceId=TppEnemyFaceId.dds_balaclava6, seed = seed[seedNum] } )
			
			if seedNum == 1 then
				seedNum = 2
			else
				seedNum = 1
			end
		end

	end

	
	local gameObjectId = { type="TppCommandPost2", index=0 }
	local command = { id = "SetFriendlyCp" }
		--DEBUGNOW GameObject.SendCommand( gameObjectId, command )
	
	

end


this.OnLoad = function ()
	Fox.Log("*** enemu.lua s10240 onload ***")
end




return this

end)--DEBUGNOW