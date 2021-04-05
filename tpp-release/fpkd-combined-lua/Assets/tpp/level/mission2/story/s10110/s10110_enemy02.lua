local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

this.requires = {}





this.VEHICLE_SPAWN_LIST = {
	
	{ id = "Spawn", locator = "Vehicle2Locator0001", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
	{ id = "Spawn", locator = "Vehicle2Locator0002", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
}





this.soldierDefine = {
	nil
}





this.routeSets = {
	nil
}






this.InitEnemy = function ()

	Fox.Log("*** s10110_enemy02.InitEnemy() ***")

end



this.SetUpEnemy = function ()

	Fox.Log("*** s10110_enemy02.SetUpEnemy() ***")

	this.SetVehicleSpawn( this.VEHICLE_SPAWN_LIST )



























end


this.OnLoad = function ()

	Fox.Log("*** s10110_enemy02.OnLoad() ***")

end






this.SetVehicleSpawn = function( spawnList )
	Fox.Log("*** SetVehicleSpawn ***")
	for i, command in ipairs( spawnList ) do
		GameObject.SendCommand( { type="TppVehicle2", }, command )
	end
end




return this
