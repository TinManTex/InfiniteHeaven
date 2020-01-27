local this={}

--from Shigu (discord)
--Used once in s1050_sequence.SetCameraParam_DriveSkull
--in conjunction with Player.SetAroundCameraManualModeParams useShakeParam = true
this.SetAroundCameraManualModeShakeParams={
	valueType="function",
	params={
		rangePosX="float", 
		rangePosY="float", 
		rangePosZ="float",
		rangeRotX="float", 
		rangeRotY="float",
		rangeRotZ="float",
		cyclePos="float",
		cycleRot="float",
		interpTime="float",
		speedRateBaseValue="float", 
		speedRateMin="float",
		cyclePosRateWhenSpeedRateIsMin="float", 
		cycleRotRateWhenSpeedRateIsMin="float",
	},
}

return this