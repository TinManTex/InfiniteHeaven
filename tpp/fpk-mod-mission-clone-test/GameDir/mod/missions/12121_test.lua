local this={
	description="10121 clone test",
	missionCode=12121,
    location="MAFR",
    packs=function(missionCode)
	  TppPackList.AddLocationCommonScriptPack(missionCode)
	  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
	  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
	  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
	  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
	  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
	  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
	  TppPackList.AddDefaultMissionAreaPack(missionCode)
	  do
	    local settings={
	      {type="enemy",name="sol_pfCamp_vip_0001",faceId=617,bodyId=TppEnemyBodyId.pfa0_v00_b},
	      {type="enemy",name="sol_pfCamp_vip_guard",faceId=618,bodyId=254}
	    }
	    TppEneFova.AddUniqueSettingPackage(settings)
	  end
	end,
}

return this