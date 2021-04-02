local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}






this.soldierDefine = {
	s10140_zombies_cp = {
		"zmb_s10140_0000",
		"zmb_s10140_0001",
		"zmb_s10140_0002",
		"zmb_s10140_0003",
		"zmb_s10140_0004",
		"zmb_s10140_0005",
		"zmb_s10140_0006",
		"zmb_s10140_0007",
		"zmb_s10140_0008",
		"zmb_s10140_0009",
		"zmb_s10140_0010",
		"zmb_s10140_0011",
		nil
	},
}



this.parasiteSquadList = {
	"wmu_s10140_0000",
	"wmu_s10140_0001",
	"wmu_s10140_0002",
	"wmu_s10140_0003",
}



this.disablePowerSettings = {
	"MINE",
	"DECOY",
}























































this.InitEnemy = function ()
	TppEnemy.UnRealizeParasiteSquad()
	this.SetTargetDistanceCheck()
end



this.SetUpEnemy = function ()
	
	this.FixFovaForDemoEnemy("zmb_s10140_0000")

	
	this.SetAllZombies(s10140_enemy.soldierDefine.s10140_zombies_cp)
	
	


	
	TppEnemy.AssignUniqueStaffType{
		locaterName = "CodeTalker",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.CODETALKER,
	}

end


this.OnLoad = function ()
end






this.StartCombatParasite = function()
	Fox.Log("#### s10140_enemy.StartCombatParasite ####")	
	GameObject.SendCommand( { type="TppParasite2" }, { id="StartCombat", harden=true } ) 
end




this.CheckEnableFultonParasite = function()
	local nowStorySeq	= TppStory.GetCurrentStorySequence()
	local allowStorySeq	= TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA	
	
	if ( nowStorySeq >= allowStorySeq ) then
		Fox.Log("#### s10140_enemy.CheckEnableFultonParasite #### Enable!")	
		GameObject.SendCommand( { type="TppParasite2" }, { id="SetFultonEnabled", enabled=true } ) 
	else
		Fox.Log("#### s10140_enemy.CheckEnableFultonParasite #### Disable...")	
	end
end



this.CheckParasiteMessage = function(gameObjectId)
	Fox.Log("#### s10140_enemy.CheckParasiteMessage ####")	
	Fox.Log("check where form message.")
	for i,paraId in pairs(this.parasiteSquadList) do
		if gameObjectId == GameObject.GetGameObjectId("TppParasite2",paraId)then
			return true
		end
	end
	return false
end



this.SetAllZombies = function ( targetCpArray )
	local gameObjectId
	local command

	for i, name in pairs( targetCpArray ) do
		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)

		


		
		



		
		if not( name == "zmb_s10140_0000" ) then
			Fox.Log("#### s10140_enemy.SetAllZombies #### change to zombie : "..name )
			command = { id = "SetZombie", enabled = true, isZombieSkin=true }
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end



this.WakeUpAllZombies = function ( targetCpArray )
	local gameObjectId
	local command

	for i, name in pairs( targetCpArray ) do
		Fox.Log("#### s10140_enemy.WakeUpAllZombies #### wake up zombie : "..name )
		
		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)

		



		
		command = { id = "RecoveryStamina", isDelay = true }
		GameObject.SendCommand( gameObjectId, command )
	end
end



this.UnsetAllZombies = function ( targetCpArray )
	local gameObjectId
	local command

	for i, name in pairs( targetCpArray ) do
		Fox.Log("#### s10140_enemy.UnsetAllZombies #### change to human : "..name )

		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)

		
		command = { id = "SetZombie", enabled = false }
		GameObject.SendCommand( gameObjectId, command )
		
		
		command = { id = "SetEverDown", enabled = true }
		GameObject.SendCommand( gameObjectId, command )
	end
end




this.UnsetZombie = function ( targetName )
	Fox.Log("#### s10140_enemy.UnsetZombie #### targetName : "..targetName )
	local gameObjectId = GameObject.GetGameObjectId("TppSoldier2",targetName)
	local command = { id = "SetZombie", enabled = false }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetZombie = function ( targetName )
	Fox.Log("#### s10140_enemy.SetZombie #### targetName : "..targetName )

	local gameObjectId = GameObject.GetGameObjectId("TppSoldier2",targetName)
	local command = { id = "SetZombie", enabled = true, isZombieSkin=true }
	GameObject.SendCommand( gameObjectId, command )
end




this.DisableAllZombies = function( targetCpArray )

	local gameObjectId
	local command = { id = "SetEnabled"	, enabled=false }

	for i, name in pairs( targetCpArray ) do
		Fox.Log("#### s10140_enemy.DisableAllZombies #### disable zombie : "..name )
		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)
		GameObject.SendCommand( gameObjectId, command )
	end
end



this.FogSetting = function(fogLv)
	Fox.Log("#### s10140_enemy.FogSetting #### fogLv = "..tostring(fogLv) )

	
	
	if ( fogLv == s10140_sequence.fogLvTable[1] ) then
		Fox.Log("#### s10140_enemy.FogSetting #### Execute Weather Control : "..tostring(s10140_sequence.fogLvTable[1]) )
		TppWeather.CancelForceRequestWeather( TppDefine.WEATHER.SUNNY, 5 )	
		
	elseif ( fogLv == s10140_sequence.fogLvTable[2] ) then
		Fox.Log("#### s10140_enemy.FogSetting #### Execute Weather Control : "..tostring(s10140_sequence.fogLvTable[2]) )
		
		
	elseif ( fogLv == s10140_sequence.fogLvTable[3] ) then
		Fox.Log("#### s10140_enemy.FogSetting #### Execute Weather Control : "..tostring(s10140_sequence.fogLvTable[3]) )
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.FOGGY, {fogDensity=0.01}, 1 )	

	else
		Fox.Log("#### s10140_enemy.FogSetting #### Not Execute Weather Control")
	
	end
end



this.ProhibitCodeTalkerUnlock = function( enable )
	Fox.Log("#### s10140_enemy.ProhibitCodeTalkerUnlock #### enable =  "..tostring(enable) )

	local gameObjectType	= "TppCodeTalker2"
	local locatorName		= "CodeTalker"
	local gameObjectId		= GameObject.GetGameObjectId( gameObjectType, locatorName )
	
	local command			= {}

	
	command = {
		id		= "SetHostage2Flag",
		flag	= "unlocked",			
		on		= true,					
	}
	GameObject.SendCommand( gameObjectId, command )
	
	
	command = {
		id		= "SetHostage2Flag",
        flag	= "disableCarry",			
        on		= enable,					
	}
	GameObject.SendCommand( gameObjectId, command )
	
end



this.SetTargetDistanceCheck = function()
	local targetName		= "CodeTalker"

	Fox.Log("#### s10140_enemy.SetTargetDistanceCheck ####")

	local command = { id = "SetPlayerDistanceCheck", enabled = true, near = 10, far = 15 }
	GameObject.SendCommand( GameObject.GetGameObjectId( targetName ), command )
end



this.FixFovaForDemoEnemy = function(targetEnemy)
	Fox.Log("#### s10140_enemy.FixFovaForDemoEnemy #### targetEnemy = "..tostring(targetEnemy))

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", targetEnemy )
	local command = { id = "ChangeFova", bodyId=50, seed=356  }
	GameObject.SendCommand( gameObjectId, command )

end



return this
