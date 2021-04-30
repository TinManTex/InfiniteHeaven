


















CharaTppGunEmplacement = {



















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
	charaObj.gadgetType = 16384

	
	charaObj.attachPointOffset = Vector3( 0, 0, 0 )
	
	charaObj.aimRotateAffects = false


end,











































}
