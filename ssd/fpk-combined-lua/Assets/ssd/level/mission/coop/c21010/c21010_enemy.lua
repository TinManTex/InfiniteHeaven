local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
	nil
}





this.routeSets = {
	nil
}





this.combatSetting = {
	nil
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )
end


this.OnLoad = function ()
	Fox.Log("*** s10211 onload ***")
end




return this
