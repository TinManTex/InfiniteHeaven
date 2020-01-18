local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
}





this.routeSets = {
}





this.combatSetting = {
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	this.UnlockedCodeTalker()

end


this.OnLoad = function ()
	Fox.Log("*** s10130 onload ***")
end






function this.UnlockedCodeTalker()

	local locatorName = "CodeTalker"
	local gameObjectType = "TppCodeTalker2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id = "SetHostage2Flag",
		
		flag = "unlocked",            
		on = true,
	}
	GameObject.SendCommand( gameObjectId, command )

end





return this
