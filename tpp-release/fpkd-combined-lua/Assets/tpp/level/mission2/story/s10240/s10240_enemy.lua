local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}


local BIRD_OBJECT_ID01 = "CritterBirdGameObjectLocator"
local BIRD_OBJECT_ID02 = "CritterBirdGameObjectLocator0000"



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
	
	mbqf_mtbs_cp = {
		priority = {
			"groupA",
			nil
		},
		sneak_day = {
			groupA = {
				"rts_10240_d_0001",
				"rts_10240_d_0002",
				"rts_10240_d_0003",
				"rts_10240_d_0004",
				"rts_10240_d_0005",
				"rts_10240_d_0006",
			},
		},
		sneak_night= {
			groupA = {
				"rts_10240_d_0001",
				"rts_10240_d_0002",
				"rts_10240_d_0003",
				"rts_10240_d_0004",
				"rts_10240_d_0005",
				"rts_10240_d_0006",
			},
		},
	},
}





this.combatSetting = {
	nil
}




this.EnableBird = function()
	Fox.Log("bird ON!")
	this._ChangeEnableBird()

end

this.DisableBird = function()
	Fox.Log("bird OFF!!")
	this._ChangeEnableBird(false)
end

this.WarpBird = function()
	Fox.Log("warp birds to perch")
	local typeName = "TppCritterBird"
	local gameObjectId = {type = typeName, index = 0}
	for i=0,7 do
		local command = {
		        id = "WarpOnPerch",
		        name = BIRD_OBJECT_ID01,
		        birdIndex = i,	   perchIndex = i,
		        degreeRotationY = 200.0,
		}
		GameObject.SendCommand(gameObjectId, command)
	end
end

this.FlyingBird = function()
	Fox.Log("Flying bird !!")
	local typeName = "TppCritterBird"
	local gameObjectId = {type = typeName, index = 0}
	local command = {
	        id = "ForceFlying",
	        name = BIRD_OBJECT_ID01,
	}
	GameObject.SendCommand(gameObjectId, command)

end

this.DisableEnemyForDemo = function()
	for i, enemyId in pairs(this.soldierDefine.mbqf_mtbs_cp)do
		TppEnemy.SetDisable( enemyId )
	end
end

this.ChangeRouteEnemy = function()
	local beforeRoute	= "rts_10240_d_0006"
	local afterRoute	= "rts_10240_d_0007"
	local routePointNum	= 2

	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=beforeRoute }
	local soldiers = GameObject.SendCommand( gameObjectId, command )
	Fox.Log( "soldier num "..#soldiers )
	if #soldiers > 0 then
		for i, soldier in ipairs(soldiers) do
			GameObject.SendCommand( soldier, { id="SetSneakRoute", route=afterRoute, point=routePointNum,isRelaxed=true } )
			Fox.Log( "soldierID : "..soldier..". change route. "..beforeRoute.." > "..afterRoute )
		end
	else
		Fox.Log("return. no soldier")
		return
	end
end





this._ChangeEnableBird = function(enabled)
	Fox.Log("_change bird enable")
	local change = true
	if enabled == false then
		change = false
	end

	local typeName = "TppCritterBird"
	local gameObjectId = {type = typeName, index = 0}
	local command = {
	        id = "SetEnabled",
	        enabled = change,
	        name = BIRD_OBJECT_ID01,
	}
	GameObject.SendCommand(gameObjectId, command)

	command = {
	        id = "SetEnabled",
	        enabled = change,
	        name = BIRD_OBJECT_ID02,
	}
	GameObject.SendCommand(gameObjectId, command)
end






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
			GameObject.SendCommand( gameObjectId, { id = "SetFriendly"} )
			GameObject.SendCommand( gameObjectId, { id = "SetSoundSwitchCyprusMask", enabled=true } )			
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
	GameObject.SendCommand( gameObjectId, command )
	
	
	local speed01 = 20
	local gameObjectId = {type =  "TppCritterBird", index = 0}
	local command = {
			id = "SetParameter",
	        name = BIRD_OBJECT_ID01,
        	maxSpeed = 30,
        	minSpeed = 15
	}
	GameObject.SendCommand(gameObjectId, command)

	
	mtbs_enemy.SetupEmblem()
end


this.OnLoad = function ()
	Fox.Log("*** enemu.lua s10240 onload ***")
end




return this
