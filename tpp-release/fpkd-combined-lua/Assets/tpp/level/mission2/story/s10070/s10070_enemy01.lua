local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}







local TARGET_HUEY = "TppHuey2GameObjectLocator"




this.soldierDefine = {
	

	
	nil
}




this.routeSets = {
	

	
	nil
}





this.combatSetting = {
	nil
}


this.disablePowerSettings = {
	"MISSILE",
	"SMG",
}





this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
		TppEnemy.SetRescueTargets( {TARGET_HUEY} )
end


this.OnLoad = function ()
	Fox.Log("*** s10070 onload ***")
end








return this
