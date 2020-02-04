local this={
	description="Coral Complex",
	missionCode=12070,
    location="MBA0",
    -- packs={"/Assets/tpp/pack/mission2/ih/minimal_mission.fpk"},
    packs=function(missionCode)
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
      TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s12050/s12050_area.fpk"--DEBUGNOW
    end,--DEBUGNOW
    startPos={0,10,0},
}

return this