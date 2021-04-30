
























CharaTppAntiAircraftGun = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
},


pluginIndexEnumInfoName = "TppGadgetPluginDefine",






OnCreate = function( chara )

	local charaObj = chara:GetCharacterObject()
	charaObj.gadgetType = 8

	charaObj.attachPointName = "CNP_ppos_a";
	charaObj.attachPointType = ATTACH_CONNECT_POINT;

	
	charaObj.attachPointOffset = Vector3( 0.0, 0.0, 0.0 )
	
	charaObj.aimRotateAffects = false
	

end,




















































}
