





CharaTppHeliGunEmplacement = {



















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
	charaObj.gadgetType = 131072

	
	charaObj.attachPointName = "CNP_ppos"
	charaObj.attachPointType = "ATTACH_CONNECT_POINT"
	charaObj.attachPointOffset = Vector3( 0, 0, 0 )
	
	charaObj.aimRotateAffects = false
	
	charaObj.forceSubjectiveMode = true

end,


AddGadgetPlugins = function( chara )

	
	chara:AddPlugins{
		
		
		
		"PLG_NEW_INVENTORY",
		TppMechaInventoryPlugin {
			name			= "NewInventory",
			weaponId		= "WP_HeliMachinegun",
			connectPointName = "CNP_awp_a",
		},

		
		
		

		
		"PLG_GADGET_EMPLACEMENT_ACTION",
		TppGadgetAttackEmplacementActionPlugin{
			name			= "AttackEmplacementAction",
			parent			= "ActionRoot",
			headName		= "CNP_REAR_SIGHT",
			leftHandName	= "CNP_LEFT_HAND",
			rightHandName	= "CNP_RIGHT_HAND",
			boneRotationType	= "ROT_BONE_WEAPON",
			boneNameDirection	= "SKL_001_GUNBASE",
			boneNameAngle		= "SKL_002_GUNBODY",
			boneNameAimRoot		= "SKL_005_ARM_E",
			isSleepStart	= true,
		},

	}

end,

}
