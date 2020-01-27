local this={	
	missionCode=12020,
    location="AFC0",
    --DEBUGNOW packs={"/Assets/tpp/pack/mission2/ih/minimal_mission.fpk"},
    packs=function(missionCode)
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
      TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s12000/s12000_area.fpk"--DEBUGNOW
    end,--DEBUGNOW
    startPos={-11.788,8.483,165.559},--rotY=-30.511,},--DEBUGNOW
}

return this