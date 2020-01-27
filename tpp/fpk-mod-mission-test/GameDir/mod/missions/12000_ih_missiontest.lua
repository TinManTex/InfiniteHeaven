local this={
	description="IH Mission test",
	missionCode=12000,--DEBUGNOW
    location="AFGH",
    packs=function(missionCode)
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
      TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10000_ih/s10000_ih_area.fpk"
    end,--DEBUGNOW
    startPos={-11.788,8.483,165.559},--rotY=-30.511,},--DEBUGNOW
}

return this