local e={}
e.storySequenceTable={}
e.storySequenceTable_Master={
  {main="s10010"},
  {main="s10020"},
  {main="s10030"},
  {flag={"s10036","s10043","s10033"},proceedCount=2},
  {main="s10040"},
  {flag={"s10041","s10044","s10052","s10054"},
    sub={"s10050"},
    defaultClose={s10050=true},
    proceedCount=3,
    condition=function()
      local e
      if TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform then
        e=TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform()
      else
        e=true
      end
      return e
    end,
    updateTiming={OnMissionStart=true,OnCompletedPlatform=true}
  },
  {main="s10070",defaultClose={s10070=true}},
  {main="s10080"},
  {flag={"s10086"}},
  {flag={"s10082"}},
  {main="s10090",
    condition=function()
      if TppMotherBaseManagement.CanOpenS10091()then
        TppMotherBaseManagement.LockedStaffsS10091()
      end
      return true
    end},
  {flag={"s10091"}},
  {main="s10100",flag={"s10195"}},
  {main="s10110"},
  {flag={"s10121","s10115"},defaultClose={s10115=true}},
  {main="s10120"},
  {flag={"s10085","s10200"}},
  {flag={"s10211"},
    condition=function()
      if TppMotherBaseManagement.CanOpenS10130()then
        TppMotherBaseManagement.LockedStaffsS10130()
      end
      if TppMotherBaseManagement.CanOpenS10081()then
        TppMotherBaseManagement.LockedStaffS10081()
      end
      return true
    end
  },
  {flag={"s10081"}},
  {main="s10130"},
  {main="s10140"},
  {main="s10150"},
  {main="s10151",
    condition=function()
      e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,2)
      TppQuest.StartElapsedEvent(1)
      return true
    end
  },
  {flag={"s10045"},
    sub={"s11043","s11054"},
    condition=function()
      if TppQuest.IsCleard"tent_q99040"then
        e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,2)
        TppQuest.StartElapsedEvent(1)
        return true
      end
    end,
    updateTiming={OnSideOpsClear=true,OnMissionStart=true}
  },
  {flag={"s10093"},
    sub={"s11082","s11090"},
    condition=function()
      return TppQuest.OpenChildSoldier_1()
    end,
    updateTiming={OnSideOpsClear=true,OnMissionStart=true}
  },
  {flag={"s10156"},sub={"s11033","s11050"},defaultClose={s11050=true},
    condition=function()
      return(TppQuest.IsCleard"tent_q20910"and TppQuest.IsCleard"fort_q20911")and TppQuest.IsCleard"sovietBase_q20912"
    end,
    updateTiming={OnMissionStart=true,OnSideOpsClear=true}},
  {main="s10171",
    condition=function()
      e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,1)
      TppQuest.StartElapsedEvent(3)
      return true
    end},
  {sub={"s11140"},
    condition=function()
      if e.CanOpenS10240()then
        TppMotherBaseManagement.LockedStaffsS10240()
        return true
      else
        return false
      end
    end,
    updateTiming={OnMissionStart=true,OnUpdateCheckPoint=true,OnSideOpsClear=true}},
  {main="s10240",defaultClose={s10240=true},
    condition=function()
      e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,1)
      TppQuest.StartElapsedEvent(3)
      return true
    end},
  {sub={"s11080"},
    condition=function()
      local n=TppQuest.IsNowOccurringElapsed()
      local t=e.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
      if n or t then
        e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,1)
        TppQuest.StartElapsedEvent(3)
        return true
      end
    end,
    updateTiming={OnMissionStart=true,OnSideOpsClear=true}},
  {sub={"s11121"},
    condition=function()
      local t=TppQuest.IsNowOccurringElapsed()
      local n=e.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
      if t or n then
        e.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
        TppQuest.SetDoneElapsed()
        return true
      end
    end,
    updateTiming={OnMissionStart=true,OnSideOpsClear=true}},
  {sub={"s11130","s11044","s11151","s10260","s10280"},defaultClose={s10260=true,s10280=true},
    condition=function()
      if e.CanOpenS10280()and(not e.IsMissionOpen(10280))then
        e.MissionOpen(10280)
      end
      if e.IsMissionCleard(10280)then
        return true
      end
    end,
    updateTiming={BeforeBuddyBlockLoad=true}},
  {},
  {}
}
e.radioDemoTable={AttackedFromOtherPlayer_KnowWhereFrom={storyCondition=function()
  return true
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.AttackedFromOtherPlayer_KnowWhereFrom()
end,
demoName="AttackedFromOtherPlayer_KnowWhereFrom"},AttackedFromOtherPlayer_UnknowWhereFrom={storyCondition=function()
  return true
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.AttackedFromOtherPlayer_UnknowWhereFrom()
end,
demoName="AttackedFromOtherPlayer_UnknowWhereFrom"},AttackedFromOtherPlayerRadio={storyCondition=function(e)
  return e.demoName=="AttackedFromOtherPlayer_UnknowWhereFrom"or e.demoName=="AttackedFromOtherPlayer_KnowWhereFrom"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0500"}},NuclearEliminationCeremony={storyCondition=function()
  return true
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.NuclearEliminationCeremony()
end,
demoName="NuclearEliminationCeremony"},NuclearEliminationCeremonyRadio={storyCondition=function(e)
  return e.demoName=="NuclearEliminationCeremony"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0325"}},EntrustDdog={storyCondition=function()
  return e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.EntrustDdog()
end,
demoName="EntrustDdog"},EntrustDdogRadio={storyCondition=function(e)
  return e.demoName=="EntrustDdog"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0350"}},MoraleOfMBIsLow={storyCondition=function()
  return true
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.MoraleOfMBIsLow()
end,
demoName="MoraleOfMBIsLow"},MoraleOfMBIsLowRadio={storyCondition=function(e)
  return e.demoName=="MoraleOfMBIsLow"end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.MoraleOfMBIsLow()
end,
radioList={"f6000_rtrg0370"}},DdogComeToGet={storyCondition=function()
  return vars.missionCode==10040
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.DdogComeToGet()
end,
demoName="DdogComeToGet"},DdogComeToGetRadio={storyCondition=function(e)
  return e.demoName=="DdogComeToGet"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0380"}},DdogGoWithMe={storyCondition=function()
  return true
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.DdogGoWithMe()
end,
demoName="DdogGoWithMe"},DdogGoWithMeRadio={storyCondition=function(e)
  return e.demoName=="DdogGoWithMe"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0370"}},HappyBirthDayWithQuiet={storyCondition=function()
  return true
end,
detailCondition=function()
  TppDemo.UpdateHappyBirthDayFlag()
  local e=TppDemo.mtbsPriorityFuncList.HappyBirthDay()
  local n=TppMbFreeDemo.demoOptions.HappyBirthDay.GetNextDemoNameOrNil()~=nil
  return e and n
end,
demoName="HappyBirthDay"},HappyBirthDay={storyCondition=function()
  return true
end,
detailCondition=function()
  TppDemo.UpdateHappyBirthDayFlag()
  return TppDemo.mtbsPriorityFuncList.HappyBirthDay()
end,
demoName="HappyBirthDay"},HappyBirthDayRadio={storyCondition=function(e)
  return e.demoName=="HappyBirthDay"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0511"}},QuietTreatment={storyCondition=function(e)
  return e.demoName=="ArrivedMotherBaseAfterQuietBattle"end,
detailCondition=function(e)
  local e=not TppRadio.IsPlayed"f2000_rtrg1345"local n=TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)
  local i=TppQuest.IsOpen"sovietBase_q99020"local t=not TppQuest.IsCleard"sovietBase_q99020"return((e and n)and i)and t
end,
radioList={"f2000_rtrg1345","f2000_rtrg1347"}},QuietTreatment2={storyCondition=function(e)
  return e.demoName=="ArrivedMotherBaseAfterQuietBattle"end,
detailCondition=function(e)
  local t=not TppRadio.IsPlayed"f2000_rtrg1345"local n=TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)
  local e=not TppQuest.IsOpen"sovietBase_q99020"local i=TppQuest.IsCleard"sovietBase_q99020"return(t and n)and(e or i)
end,
radioList={"f2000_rtrg1345","f2000_rtrg1346"}},QuietReceivesPersecution={storyCondition=function()
  local n=vars.missionCode==10085 or vars.missionCode==10200
  local e=e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
  return n and e
end,
detailCondition=function()
  local n=TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
  local e=e.CanArrivalQuietInMB(true)
  return e and n
end,
demoName="QuietReceivesPersecution"},QuietReceivesPersecutionRadio={storyCondition=function(e)
  return e.demoName=="QuietReceivesPersecution"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0360"}},QuietHasFriendshipWithChild={storyCondition=function()
  local n=e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RETRIEVE_VOLGIN
  local t=TppQuest.IsNowOccurringElapsed()
  local e=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)==1
  return n and(t or e)
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.QuietHasFriendshipWithChild()
end,
demoName="QuietHasFriendshipWithChild"},QuietHasFriendshipWithChildRadio={storyCondition=function(e)
  return e.demoName=="QuietHasFriendshipWithChild"end,
detailCondition=function()
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7350"}
  else
    return{"f6000_rtrg0350"}
  end
end,
radioList={"f6000_rtrg0350","f2000_rtrg7350"}},InterrogateQuiet={storyCondition=function()
  local t=TppQuest.IsNowOccurringElapsed()
  local n=e.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
  local e=e.IsMissionCleard(10093)
  return(n or t)and e
end,
detailCondition=function()
  return TppDemo.mtbsPriorityFuncList.InterrogateQuiet()
end,
demoName="InterrogateQuiet"},InterrogateQuietRadio={storyCondition=function()
  return e.CanPlayDemoOrRadio"InterrogateQuiet"end,
detailCondition=function(e)
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7330"}
  else
    return{"f6000_rtrg0330"}
  end
end,
radioList={"f6000_rtrg0330","f2000_rtrg7330"}},QuietPassage={storyCondition=function()
  return e.IsMissionCleard(10086)
end,
detailCondition=function()
  if TppQuest.IsOpen"mtbs_q99011"then
    local e=not TppQuest.IsCleard"mtbs_q99011"if e then
      TppCassette.Acquire{cassetteList={"tp_c_00000_13"},{delayTimeSec=2}}
      TppCassette.Acquire{cassetteList={"tp_m_10050_03"},{delayTimeSec=2}}
    end
    return e
  end
  return false
end,
radioList={"f2000_rtrg1350"}},WalkerGear={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON
end,
detailCondition=function()
  return TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform()
end,
radioList={"f2000_rtrg8420"}},WalkerGearRemind={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON
end,
detailCondition=function()
  return e.GetClearedMissionCount{10041,10044,10052,10054}==4
end,
radioList={"f2000_rtrg8421"}},AnableDevBattleGear={storyCondition=function()
  return vars.missionCode==10195
end,
detailCondition=function()
  return true
end,
demoName="AnableDevBattleGear"},AnableDevBattleGearRadio={storyCondition=function()
  return vars.missionCode==10195
end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0300"}},AfterAnableDevbattleGear={storyCondition=function()
  return TppDemo.IsPlayedMBEventDemo"AnableDevBattleGear"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg1515"}},DevelopedBattleGear_1={storyCondition=function()
  return vars.missionCode==10121
end,
detailCondition=function()
  return e.GetBattleGearDevelopLevel()==1
end,
demoName="DevelopedBattleGear1"},DevelopedBattleGear_1Radio={storyCondition=function()
  return e.CanPlayDemoOrRadio"DevelopedBattleGear_1"end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0400"}},OpenFindTheSecretWeapon={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_TO_MATHER_BASE
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8030"}},CleardFindTheSecretWeapon={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8060"}},CleardToMotherBase={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8000"}},OpenPicthDark={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8090"}},ZeroAndScalFace={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY
end,
detailCondition=function()
  local n=TppRadio.IsPlayed"f2000_rtrg8090"local e=TppMission.IsHelicopterSpace(vars.missionCode)
  return n and e
end,
radioList={"f2000_rtrg8100"}},OpenLinguaFranka={storyCondition=function()
  return e.IsMissionCleard(10080)and e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8115"}},OpenRemovalWalkerGear={storyCondition=function()
  return e.IsMissionCleard(10086)and e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_LINGUA_FRANKA
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8120"}},OpenCarLine={storyCondition=function()
  return e.IsMissionCleard(10082)and e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_DESTROY_THE_FLOW_STATION
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8130"}},OpenRescueIntelAgents={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8140"}},OpenEliminateThePows={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_INTEL_AGENTS
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8150"}},OpenVoice={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8160"}},OpenCaptureTheWeaponDealer={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8180"}},OpenWhiteMamba={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8185"}},OpenFlagMissionAfterWhiteMamba={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8440"}},GeneOfEli={storyCondition=function()
  return(e.IsMissionCleard(10085)or e.IsMissionCleard(10200))and e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8200"}},ParasiticWormCarrierQuarantine={storyCondition=function()
  local n=vars.missionCode==10085 or vars.missionCode==10200
  local e=e.GetClearedMissionCount{10085,10200}==2
  local t=not TppMotherBaseManagement.IsPandemicEventMode()
  return(n and e)and t
end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0310"}},OpenHuntDown={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_WHITE_MAMBA
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8210"}},OpenEliChallengeAndRootCause={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_COMMANDER
end,
detailCondition=function()
  if TppQuest.IsOpen"mtbs_q99050"then
    e.radioDemoTable.OpenEliChallengeAndRootCause.radioList={"f2000_rtrg8190","f2000_rtrg8220"}
  else
    e.radioDemoTable.OpenEliChallengeAndRootCause.radioList={"f2000_rtrg8220"}
  end
  return true
end,
radioList={"f2000_rtrg8220"}},OpenEliChallenge={storyCondition=function()
  return e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_COMMANDER
end,
detailCondition=function()
  return TppQuest.IsOpen"mtbs_q99050"and(not TppQuest.IsCleard"mtbs_q99050")
end,
radioList={"f2000_rtrg8190"}},ClearEliChallenge={storyCondition=function(e)
  return e.clearSideOpsName=="mtbs_q99050"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg1500"}},OpenCodeTalker={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_THE_BETRAYER
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8230"}},OpenMetallicArchaea={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_CODE_TALKER
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8240"}},OpenFlagMissionAfterOKBZERO={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8260"}},CanDevelopNuclear={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(vars.missionCode)
end,
radioList={"f2000_rtrg8261"}},RafeAccidentalDeath={storyCondition=function()
  local t=e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
  local n=TppQuest.IsNowOccurringElapsed()
  local e=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)==1
  return t and(n or e)
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8280"}},OpenSideOpsAiPod={storyCondition=function()
  local i=e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
  local t=TppQuest.IsNowOccurringElapsed()
  local n=e.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
  local e=e.IsMissionCleard(10045)
  return((t or n)and e)and i
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8270"}},EliLookSnake={storyCondition=function()
  return e.CanPlayDemoOrRadio"RafeAccidentalDeath"end,
detailCondition=function()
  return true
end,
demoName="EliLookSnake"},EliLookSnakeRadio={storyCondition=function()
  return e.CanPlayDemoOrRadio"RafeAccidentalDeath"end,
detailCondition=function()
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7325"}
  else
    return{"f6000_rtrg0325"}
  end
end,
radioList={"f6000_rtrg0325","f2000_rtrg7325"}},CompliteDevelopBattleGear={storyCondition=function()
  return e.CanPlayDemoOrRadio"OpenSideOpsAiPod"end,
detailCondition=function()
  return true
end,
demoName="DevelopedBattleGear5"},CompliteDevelopBattleGearRadio={storyCondition=function()
  return e.CanPlayDemoOrRadio"CompliteDevelopBattleGear"end,
detailCondition=function(e)
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7120"}
  else
    return{"f6000_rtrg2120"}
  end
end,
radioList={"f6000_rtrg2120","f2000_rtrg7120"}},AfterCompliteDevelopBattleGear={storyCondition=function(e)
  return e.demoName=="DevelopedBattleGear5"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg1517"}},LiquidAndChildSoldier={storyCondition=function()
  local n=vars.missionCode==10045 or vars.missionCode==10156
  local e=e.GetClearedMissionCount{10045,10156}==2
  return n and e
end,
detailCondition=function()
  return true
end,
demoName="LiquidAndChildSoldier"},RetrieveAIPod={storyCondition=function(e)
  return e.clearSideOpsName=="sovietBase_q99030"end,
detailCondition=function()
  TppQuest.OpenAndActivateSpecialQuest{"tent_q99040"}
  return true
end,
radioList={"f2000_rtrg1530","f2000_rtrg1540"}},AfterRetrieveVolgin={storyCondition=function(e)
  return e.clearSideOpsName=="tent_q99040"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8450"}},CorpseInAIPod={storyCondition=function()
  local t=e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RETRIEVE_VOLGIN
  local n=TppQuest.IsNowOccurringElapsed()
  local e=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)==1
  return t and(n or e)
end,
detailCondition=function()
  TppCassette.Acquire{cassetteList={"tp_m_10190_01"},isShowAnnounceLog={delayTimeSec=2}}
  return true
end,
radioList={"f2000_rtrg8370"}},StartQuestChildSoldier={storyCondition=function()
  return TppQuest.OpenChildSoldier_1()
end,
detailCondition=function()
  TppCassette.Acquire{cassetteList={"tp_m_10160_05"},isShowAnnounceLog={delayTimeSec=2}}
  return true
end,
radioList={"f2000_rtrg8451","f2000_rtrg8290"}},ProgressQuestChildSoldier={storyCondition=function()
  local n=TppQuest.IsCleard"outland_q20913"and TppQuest.IsCleard"lab_q20914"local e=not((TppQuest.IsOpen"tent_q20910"and TppQuest.IsOpen"fort_q20911")and TppQuest.IsOpen"sovietBase_q20912")
  return n and e
end,
detailCondition=function()
  TppQuest.OpenAndActivateSpecialQuest{"tent_q20910","fort_q20911","sovietBase_q20912"}
  return true
end,
radioList={"f2000_rtrg8310"}},LeakRadiationInMB={storyCondition=function()
  local e=e.IsMissionCleard(10156)
  local n=(TppQuest.IsCleard"tent_q20910"and TppQuest.IsCleard"fort_q20911")and TppQuest.IsCleard"sovietBase_q20912"return e or n
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8380"}},OpenProxyWar={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR
end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8452"}},EliImprisonment={storyCondition=function()
  return e.CanPlayDemoOrRadio"TheGreatEscapeLiquid"end,
detailCondition=function(e)
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7332"}
  else
    return{"f6000_rtrg0332"}
  end
end,
radioList={"f6000_rtrg0332","f2000_rtrg7332"}},TheGreatEscapeLiquid={storyCondition=function()
  return vars.missionCode==10171
end,
detailCondition=function()
  return(not TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid")
end,
demoName="TheGreatEscapeLiquid"},AfterTheGreatEscapeLiquid={storyCondition=function(e)
  return e.demoName=="TheGreatEscapeLiquid"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8350"}},OpenMissionAfterTheGreatEscapeLiquid={storyCondition=function()
  return TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8453"}},ReasonSahelanMove={storyCondition=function()
  return TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid"end,
detailCondition=function()
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    TppCassette.Acquire{cassetteList={"tp_m_10190_02"},isShowAnnounceLog={delayTimeSec=2}}
    return true
  end
  return false
end,
radioList={"f2000_rtrg8360"}},PermitParasiticWormCarrierKill={storyCondition=function()
  return e.CanPlayDemoOrRadio"ParasiticWormCarrierKill"end,
detailCondition=function(e)
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7335"}
  else
    return{"f6000_rtrg0335"}
  end
end,
radioList={"f6000_rtrg0335","f2000_rtrg7335"}},OpenParasiticWormCarrierKill={storyCondition=function()
  return TppDemo.IsPlayedMBEventDemo"ParasiticWormCarrierKill"end,
detailCondition=function()
  return true
end,
radioList={"f2000_rtrg8391"}},ParasiticWormCarrierKill={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_MURDER_INFECTORS
end,
detailCondition=function()
  return(not TppDemo.IsPlayedMBEventDemo"ParasiticWormCarrierKill")
end,
demoName="ParasiticWormCarrierKill"},AfterParasiticWormCarrierKillFree={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS
end,
detailCondition=function()
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY,TppDefine.INIT_ELAPSED_MISSION_COUNT.DECISION_HUEY)
  return true
end,
radioList={"f2000_rtrg8900"}},AfterParasiticWormCarrierKillHeli={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_AFTER_MURDER_INFECTORS_ONE_MISSION
end,
detailCondition=function()
  TppCassette.Acquire{cassetteList={"tp_m_10190_03"},isShowAnnounceLog={delayTimeSec=2}}
  if TppBuddy2BlockController.DidObtainBuddyType(BuddyType.DOG)then
    TppCassette.Acquire{cassetteList={"tp_m_10190_04"},isShowAnnounceLog={delayTimeSec=2}}
  end
  return true
end,
radioList={"f2000_rtrg8400"}},OpenDecisionHuey={storyCondition=function()
  return e.CanPlayDemoOrRadio"DecisionHuey"end,
detailCondition=function(e)
  return true
end,
selectRadioFunction=function(e)
  if e.clearSideOpsName then
    return{"f2000_rtrg7338"}
  else
    return{"f6000_rtrg0338"}
  end
end,
radioList={"f6000_rtrg0338","f2000_rtrg7338"}},DecisionHuey={storyCondition=function()
  return e.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_AFTER_MURDER_INFECTORS_TWO_MISSIONS
end,
detailCondition=function()
  return(not TppDemo.IsPlayedMBEventDemo"DecisionHuey")
end,
demoName="DecisionHuey"},OpenQuietLost={storyCondition=function()
  return true
end,
detailCondition=function()
  if vars.missionCode==30050 then
    return false
  end
  return TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
end,
radioList={"f2000_rtrg2000","f2000_rtrg2010"}},AboutHeliSpace={storyCondition=function()
  return e.IsMissionCleard(10030)
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f2000_rtrg1010"}},AboutSideOps={storyCondition=function()
  if(e.GetClearedMissionCount{10036,10043,10033}==1)then
    return true
  end
  return false
end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f1000_rtrg4030"}},AboutQuietSniper={storyCondition=function()
  return TppQuest.IsOpen"waterway_q99010"and not(e.IsMissionOpen(10050))
end,
detailCondition=function()
  local e=TppMission.IsFreeMission(TppMission.GetMissionID())and TppLocation.IsAfghan()
  if e then
    TppCassette.Acquire{cassetteList={"tp_m_10050_01"},isShowAnnounceLog={delayTimeSec=2}}
    return true
  end
end,
radioList={"f2000_rtrg1330"}},AboutGunsmith_B={storyCondition=function()
  return TppQuest.IsActive"sovietBase_q99070"end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f1000_rtrg5100"}},AboutGunsmith_Master={storyCondition=function()
  return TppQuest.IsActive"tent_q99072"end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f1000_rtrg5110"}},AboutAnalyzer={storyCondition=function()
  if Player.GetItemLevel(TppEquip.EQP_IT_Binocle)>1 then
    return true
  end
  return false
end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f1000_rtrg5120"}},SuggestActiveSonar={storyCondition=function()
  return(TppMotherBaseManagement.IsEquipDevelopableWithDevelopID{equipDevelopID=18030})and not(TppMotherBaseManagement.IsEquipDeveloped{equipID=TppEquip.EQP_HAND_ACTIVESONAR})
end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f1000_rtrg4550"}},UnlockBuddyDog={storyCondition=function()
  return TppDemo.IsPlayedMBEventDemo"DdogGoWithMe"end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f2000_rtrg1410"}},UnlockBuddyQuiet={storyCondition=function()
  return e.CanArrivalQuietInMB(true)and TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f1000_rtrg4590"}},AboutCallBuddy={storyCondition=function()
  return TppBuddyService.CanSortieBuddyType(BuddyType.DOG)or TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
end,
detailCondition=function()
  local t=0
  local n=1
  local e=TppBuddy2BlockController.GetActiveBuddyType()
  if(e==t or e==n)then
    if((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)then
      return true
    end
  end
  return false
end,
radioList={"f1000_rtrg4560","f1000_rtrg4570"}},AboutBuddyDog={storyCondition=function()
  return TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f1000_rtrg4580"}},UnlockIntelSearch={storyCondition=function()
  return TppMotherBaseManagement.IsActiveSectionFunc{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SPY_ENEMY_SEARCH}
end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f2000_rtrg1300"}},UnlockSupportFire={storyCondition=function()
  return TppMotherBaseManagement.IsActiveSectionFunc{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_STRIKE}
end,
detailCondition=function()
  return((TppMission.GetMissionID()~=30050)and(TppMission.GetMissionID()~=30150))and(TppMission.GetMissionID()~=30250)
end,
radioList={"f2000_rtrg1310"}},AntiNuclearDeterrence={storyCondition=function()
  return TppHero.IsHero()
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f2000_rtrg1520"}},NuclearWorld={storyCondition=function()
  local t=TppServerManager.GetNuclearAbolitionCount()
  local n=TppServerManager.GetNuclearNum()
  local e=TppDemo.IsPlayedMBEventDemo"NuclearEliminationCeremony"if(t~=-1)then
    if(e)and(n>0)then
      return true
    end
  end
  return false
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f2000_rtrg1525"}},MotherBaseBurnOut={storyCondition=function()
  if(TppMotherBaseManagement.GetGmp()<0)then
    return true
  end
  return false
end,
detailCondition=function()
  return TppMission.IsHelicopterSpace(TppMission.GetMissionID())
end,
radioList={"f2000_rtrg1080"}},HowToPlayFreePlay={storyCondition=function()
  return true
end,
detailCondition=function()
  local n=Player.GetGameObjectIdIsRiddenToLocal()
  local e=7168
  if n~=e then
    if not(TppMission.IsHelicopterSpace(TppMission.GetMissionID()))then
      if(TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica())then
        return true
      end
    end
  end
  return false
end,
radioList={"f2000_rtrg0010"}},GeneralPurposeRadio={storyCondition=function(e)
  if e.demoName then
    return true
  end
  return false
end,
detailCondition=function()
  return true
end,
radioList={"f6000_rtrg0325"}}}
e.eventPlayTimmingTable={blackTelephone={{true,"OpenDecisionHuey"},{true,"EliImprisonment"},{false,"QuietReceivesPersecutionRadio"},{true,"PermitParasiticWormCarrierKill"},{true,"InterrogateQuietRadio"},{false,"QuietHasFriendshipWithChildRadio"},{true,"AnableDevBattleGearRadio"},{true,"ParasiticWormCarrierQuarantine"},{true,"CompliteDevelopBattleGearRadio"},{true,"DevelopedBattleGear_1Radio"},{true,"EliLookSnakeRadio"},{false,"EntrustDdogRadio"},{false,"DdogComeToGetRadio"},{false,"DdogGoWithMeRadio"},{false,"HappyBirthDayRadio"},{false,"AttackedFromOtherPlayerRadio"},{false,"NuclearEliminationCeremonyRadio"},{false,"MoraleOfMBIsLowRadio"},{false,"GeneralPurposeRadio"}},clearSideOpsForceMBDemo={{true,"DecisionHuey"},{true,"ParasiticWormCarrierKill"},{true,"TheGreatEscapeLiquid"},{true,"InterrogateQuiet"},{true,"QuietHasFriendshipWithChild"},{true,"CompliteDevelopBattleGear"},{true,"EliLookSnake"}},clearSideOpsForceMBRadio={{true,"OpenDecisionHuey"},{true,"PermitParasiticWormCarrierKill"},{true,"EliImprisonment"},{true,"InterrogateQuietRadio"},{true,"CompliteDevelopBattleGearRadio"},{true,"EliLookSnakeRadio"},{true,"QuietHasFriendshipWithChildRadio"}},forceMBDemo={{true,"DecisionHuey"},{true,"EliLookSnake"},{true,"QuietReceivesPersecution"},{true,"InterrogateQuiet"},{true,"QuietHasFriendshipWithChild"},{true,"AnableDevBattleGear"},{true,"TheGreatEscapeLiquid"},{true,"ParasiticWormCarrierKill"},{true,"CompliteDevelopBattleGear"},{true,"DevelopedBattleGear_1"},{true,"EntrustDdog"},{true,"DdogComeToGet"},{true,"DdogGoWithMe"},{true,"HappyBirthDayWithQuiet"},{true,"HappyBirthDay"},{true,"AttackedFromOtherPlayer_KnowWhereFrom"},{true,"AttackedFromOtherPlayer_UnknowWhereFrom"},{false,"NuclearEliminationCeremony"},{true,"MoraleOfMBIsLow"}},afterMBDemo={{true,"AfterTheGreatEscapeLiquid"},{true,"QuietTreatment"},{true,"QuietTreatment2"},{true,"AfterCompliteDevelopBattleGear"}},clearSideOps={{true,"AfterParasiticWormCarrierKillHeli"},{true,"RetrieveAIPod"},{true,"AfterRetrieveVolgin"},{true,"ClearEliChallenge"},{true,"ProgressQuestChildSoldier"},{true,"LeakRadiationInMB"},{true,"OpenProxyWar"}},freeHeliRadio={{true,"OpenQuietLost"},{true,"AfterParasiticWormCarrierKillFree"},{true,"AfterParasiticWormCarrierKillHeli"},{true,"ReasonSahelanMove"},{true,"OpenParasiticWormCarrierKill"},{true,"OpenMissionAfterTheGreatEscapeLiquid"},{true,"RafeAccidentalDeath"},{true,"OpenSideOpsAiPod"},{true,"OpenFindTheSecretWeapon"},{true,"OpenPicthDark"},{true,"ZeroAndScalFace"},{true,"OpenLinguaFranka"},{true,"OpenRemovalWalkerGear"},{true,"OpenCarLine"},{true,"OpenRescueIntelAgents"},{true,"OpenEliminateThePows"},{true,"OpenVoice"},{true,"OpenCaptureTheWeaponDealer"},{true,"OpenWhiteMamba"},{true,"OpenFlagMissionAfterWhiteMamba"},{true,"GeneOfEli"},{true,"OpenCodeTalker"},{true,"WalkerGear"},{true,"WalkerGearRemind"},{true,"QuietPassage"},{true,"CleardFindTheSecretWeapon"},{true,"CleardToMotherBase"},{true,"OpenHuntDown"},{true,"OpenEliChallengeAndRootCause"},{true,"OpenMetallicArchaea"},{true,"OpenFlagMissionAfterOKBZERO"},{true,"CanDevelopNuclear"},{true,"CorpseInAIPod"},{true,"StartQuestChildSoldier"},{true,"LeakRadiationInMB"},{true,"OpenProxyWar"},{true,"ProgressQuestChildSoldier"},{true,"OpenEliChallenge"},{true,"AboutHeliSpace"},{true,"AboutSideOps"},{true,"AboutQuietSniper"},{true,"AboutGunsmith_B"},{true,"AboutGunsmith_Master"},{true,"AboutAnalyzer"},{true,"SuggestActiveSonar"},{true,"UnlockBuddyDog"},{true,"UnlockBuddyQuiet"},{true,"AboutCallBuddy"},{true,"AboutBuddyDog"},{true,"UnlockIntelSearch"},{true,"UnlockSupportFire"},{true,"AntiNuclearDeterrence"},{true,"NuclearWorld"},{false,"MotherBaseBurnOut"},{true,"HowToPlayFreePlay"}}}
e.PLAY_DEMO_END_MISSION={[10010]=true,[10030]=true,[10050]=true,[10070]=true,[10100]=true,[10110]=true,[10120]=true,[10130]=true,[10140]=true,[10150]=true,[10151]=true,[10240]=true,[10260]=true,[10280]=true,[10230]=true,[11050]=true,[11070]=true,[11100]=true,[11110]=true,[11130]=true,[11140]=true,[11150]=true,[11151]=true,[11240]=true,[11260]=true,[11280]=true,[11230]=true}
function e.GetCurrentStorySequence()
  return gvars.str_storySequence
end
function e.IncrementStorySequence()
  gvars.str_storySequence=gvars.str_storySequence+1
end
function e.PermitMissionOpen(e)
  local e=TppDefine.MISSION_ENUM[tostring(e)]
  if e then
    gvars.str_missionOpenPermission[e]=true
  end
end
function e.MissionOpen(n)
  e.SetMissionOpenFlag(n,true)
  TppCassette.AcquireOnMissionOpen(n)
  e.EnableMissionNewOpenFlag(n)
end
function e.MissionClose(n)
  e.SetMissionOpenFlag(n,false)
end
function e.SetMissionOpenFlag(e,t)
  local e=TppDefine.MISSION_ENUM[tostring(e)]
  if e then
    local n=gvars.str_missionOpenPermission[e]
    if n then
      gvars.str_missionOpenFlag[e]=t
    end
  end
end
function e.IsMissionOpen(e)
  local e=TppDefine.MISSION_ENUM[tostring(e)]
  if e then
    return gvars.str_missionOpenFlag[e]
  end
end
function e.IsMissionCleard(e)
  local e=TppDefine.MISSION_ENUM[tostring(e)]
  if e then
    return gvars.str_missionClearedFlag[e]
  end
end
function e.CheckAllMissionCleared()
  local r=true
  local t=true
  local n=true
  local i=true
  local a=true
  local s=true
  for e,d in pairs(TppDefine.MISSION_ENUM)do
    local o=TppDefine.MISSING_NUMBER_MISSION_ENUM[e]
    if not o then
      local o=tonumber(e)
      if(not gvars.str_missionClearedFlag[d])then
        if TppDefine.HARD_MISSION_ENUM[e]then
          a=false
        else
          n=false
        end
        r=false
      end
      local n=true
      local r={[10240]=true,[10115]=true,[10030]=true}
      if r[o]then
        n=false
      end
      if n and(TppResult.GetBestRank(o)~=TppDefine.MISSION_CLEAR_RANK.S)then
        if TppDefine.HARD_MISSION_ENUM[e]then
          s=false
        else
          i=false
        end
        t=false
      end
    end
  end
  return r,t,n,i,a,s
end
function e.CalcAllMissionClearedCount()
  local e=0
  local n=0
  for t,r in pairs(TppDefine.MISSION_ENUM)do
    local i=TppDefine.MISSING_NUMBER_MISSION_ENUM[t]
    if not i then
      local t=tonumber(t)
      if(gvars.str_missionClearedFlag[r])then
        e=e+1
      end
      n=n+1
    end
  end
  return e,n
end
function e.CalcAllMissionTaskCompletedCount()
  local e=0
  local n=0
  for t,i in pairs(TppDefine.MISSION_ENUM)do
    local i=TppDefine.MISSING_NUMBER_MISSION_ENUM[t]
    if not i then
      local t=tonumber(t)e=e+TppUI.GetTaskCompletedNumber(t)n=n+TppUI.GetMaxMissionTask(t)
    end
  end
  return e,n
end
function e.UpdateMissionCleardFlag(e)
  local n=TppDefine.MISSION_ENUM[tostring(e)]
  if n then
    gvars.str_missionClearedFlag[n]=true
    TppCassette.AcquireOnMissionClear(e)
    TppEmblem.AcquireOnMissionClear(e)
    TppTerminal.AddUniqueVolunteerStaff(e)
    TppTrophy.UnlockOnMissionClear(e)
  end
end
function e.CloseEmergencyMission()
  for e,e in ipairs(TppDefine.EMERGENCY_MISSION_LIST)do
  end
end
function e.GetStorySequenceName(e)
  return TppDefine.STORY_SEQUENCE_LIST[e+1]
end
function e.GetStorySequenceTable(n)
  return e.storySequenceTable[n+1]
end
function e.GetCurrentStorySequenceTable()
  local n=e.GetCurrentStorySequence()
  local e=e.GetStorySequenceTable(n)
  return e
end
function e.IsMainMission()
  for e,n in pairs(e.storySequenceTable)do
    local e=0
    if n.main then
      e=TppMission.ParseMissionName(n.main)
    end
    if e==vars.missionCode then
      return true
    end
  end
  return false
end
function e.GetOpenMissionCount()
  local e=0
  for n=0,TppDefine.MISSION_COUNT_MAX do
    if gvars.str_missionOpenFlag[n]then
      e=e+1
    end
  end
  return e
end
function e.GetClearedMissionCount(t)
  local n=0
  for i,r in ipairs(t)do
    if e.IsMissionCleard(t[i])==true then
      n=n+1
    end
  end
  return n
end
function e.GetElapsedMissionEventName(e)
  return TppDefine.ELAPSED_MISSION_EVENT_LIST[e+1]
end
function e.StartElapsedMissionEvent(t,n)
  if not e.GetElapsedMissionEventName(t)then
    return
  end
  if not Tpp.IsTypeNumber(n)then
    return
  end
  if n<1 or n>128 then
    return
  end
  gvars.str_elapsedMissionCount[t]=n
end
function e.GetElapsedMissionCount(n)
  if not e.GetElapsedMissionEventName(n)then
    return
  end
  local e=gvars.str_elapsedMissionCount[n]
  return e
end
function e.IsNowOccurringElapsedMission(n)
  if not e.GetElapsedMissionEventName(n)then
    return
  end
  if gvars.str_elapsedMissionCount[n]==TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
    return true
  else
    return false
  end
end
function e.SetDoneElapsedMission(n)
  if not TppDefine.ELAPSED_MISSION_EVENT_LIST[n+1]then
    return
  end
  if e.IsNowOccurringElapsedMission(n)then
    gvars.str_elapsedMissionCount[n]=TppDefine.ELAPSED_MISSION_COUNT.DONE_EVENT
  else
    if gvars.str_elapsedMissionCount[n]>TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
    end
  end
end
function e.SetMissionClearedS10030()
  gvars.isMissionClearedS10030=e.IsMissionCleard(10030)
end
function e.CanOccurRetakeThePlatform()
  local n={[10121]=true}
  local n=n[vars.missionCode]
  if not n then
    return false
  end
  if TppTerminal.IsCleardRetakeThePlatform()then
    return false
  end
  local n=true
  local e=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.FAILED_RETAKE_THE_PLATFORM)
  if(e==TppDefine.ELAPSED_MISSION_COUNT.INIT)then
    if vars.missionCode==10121 then
      return true
    end
  end
  return false
end
function e.OpenRetakeThePlatform()
  if TppMotherBaseManagement.CanOpenS10115{section="Develop"}then
    TppMotherBaseManagement.LockedStaffsS10115{section="Develop"}
  end
  e.MissionOpen(10115)
  TppMotherBaseManagement.CompletedClusterBuild{base="MotherBase",category="Develop",grade=1}
  TppRadio.Play"f1000_rtrg1010"TppUI.ShowEmergencyAnnounceLog()
  TppUI.ShowAnnounceLog"missionListUpdate"end
function e.CheckAndOpenRetakeThePlatform()
  if e.CanOccurRetakeThePlatform()then
    if not e.IsMissionOpen(10115)then
      e.OpenRetakeThePlatform()
    end
  end
end
function e.IsAlwaysOpenRetakeThePlatform()
  local n=TppDefine.MISSION_ENUM[tostring(10115)]
  if(gvars.str_missionOpenPermission[n]==false)then
    return false
  end
  if TppTerminal.IsCleardRetakeThePlatform()then
    return true
  end
  local e=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.FAILED_RETAKE_THE_PLATFORM)
  if(e==TppDefine.ELAPSED_MISSION_COUNT.INIT)then
    return false
  else
    return true
  end
end
function e.CloseRetakeThePlatform()
  TppMotherBaseManagement.UnlockedStaffsS10115{crossMedal=false}
  e.MissionClose(10115)
end
function e.FailedRetakeThePlatform()
  TppUI.ShowAnnounceLog"deleteEmergencyMission"local n=TppMotherBaseManagement.GetStaffsS10115()
  TppMotherBaseManagement.RemoveStaffsS10115{staffIds={n[1],n[2],n[3],n[4],n[5],n[6]}}
  TppMotherBaseManagement.UnlockedStaffsS10115{crossMedal=false}
  TppUiCommand.SetMission10115Emergency(false)
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.FAILED_RETAKE_THE_PLATFORM,TppDefine.INIT_ELAPSED_MISSION_COUNT.FAILED_RETAKE_THE_PLATFORM)
end
function e.FailedRetakeThePlatformIfOpened()
  if e.IsMissionOpen(10115)and(not e.IsAlwaysOpenRetakeThePlatform())then
    e.FailedRetakeThePlatform()
  end
end
function e.CanOpenS10240()
  local t=e.GetClearedMissionCount{10010,10020,10030,10036,10043,10033,10040,10041,10044,10052,10054,10050,10070,10080,10086,10082,10090,10091,10195,10100,10110,10121,10115,10120,10085,10200,10211,10081,10130,10140,10150,10151,10045,10156,10093,10171}
  local n=e.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
  local i=TppQuest.IsNowOccurringElapsed()
  local e=TppMotherBaseManagement.CanOpenS10240()
  if((t>=36)and e)and(n or i)then
    return true
  else
    return false
  end
end
function e.CanOpenS10260()
  local i=TppDemo.IsPlayedMBEventDemo"DecisionHuey"local r=TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
  local n=TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)
  local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)
  local e=not TppUiCommand.IsUsingButterflyEmblem()
  if(((i and r)and(not n))and(t>=100))and e then
    return true
  else
    return false
  end
end
function e.CanOpenS10280()
  if TppGameSequence.GetSpecialVersionName()=="e3_2015"then
    return false
  end
  local t=TppDemo.IsPlayedMBEventDemo"DecisionHuey"local e="tp_m_10160_11"local n=TppMotherBaseManagement.IsGotCassetteTapeTrack(e)
  local e=TppMotherBaseManagement.IsNewCassetteTapeTrack(e)
  return(t and n)and not(e)
end
function e.CanPlayMgo(e)
  local e=e or gvars.str_storySequence
  if e<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    return false
  else
    return true
  end
end
function e.OnReload(n)
  e.SetUpStorySequenceTable()
end
function e.SetUpStorySequenceTable()
  e.storySequenceTable=e.storySequenceTable_Master
end
function e.Init(n)
  if e.IsAlwaysOpenRetakeThePlatform()then
    e.SetMissionOpenFlag(missionId,true)
  end
  e.UpdateStorySequence{updateTiming="OnMissionStart"}
end
e.SetUpStorySequenceTable()
function e.UpdateStorySequence(t)
  if not Tpp.IsTypeTable(t)then
    return
  end
  if TppMission.IsFOBMission(vars.missionCode)or TppMission.IsFOBMission(TppMission.GetNextMissionCodeForEmergency())then
    return
  end
  if(gvars.str_storySequence==TppDefine.STORY_SEQUENCE.CLEARD_ENDRESS_PROXY_WAR)and(not TppSave.CanSaveMbMangementData())then
    return
  end
  local n
  local i=t.updateTiming
  local r=t.isInGame
  e._UpdateS11050OpenFlag(storySequence)
  if i=="BeforeBuddyBlockLoad"or i=="OnMissionClear"then
    e._UpdateS10260OpenFlag(storySequence)
  end
  if i=="OnMissionClear"then
    local t=t.missionId
    n=e.UpdateStorySequenceOnMissionClear(t)
  else
    local t=e.GetCurrentStorySequenceTable()
    if(t and t.updateTiming)and t.updateTiming[i]then
      n=e._UpdateStorySequence()
    end
  end
  if n and r then
    TppMission.ExecuteSystemCallback("OnUpdateStorySequenceInGame",n)
  end
  if n then
    if next(n)then
      gvars.mis_isExistOpenMissionFlag=true
    end
    local e=e.GetCurrentStorySequence()
    if TppDefine.CONTINUE_TIPS_TABLE[e]then
      gvars.continueTipsCount=1
    end
  end
  return n
end
function e.UpdateStorySequenceOnMissionClear(n)
  for t,e in pairs(TppDefine.SYS_MISSION_ID)do
    if(n==e)then
      return
    end
  end
  local t=TppDefine.MISSION_ENUM[tostring(n)]
  if not t then
    return
  end
  if gvars.str_missionOpenFlag[t]==false then
    return
  end
  e.UpdateMissionCleardFlag(n)
  e.DecreaseElapsedMissionClearCount()
  e.UpdateDemoFlagQuietWishGoMission()
  local e=e._UpdateStorySequence()
  TppTerminal.AcquirePrivilegeStaff()
  return e
end
function e._UpdateS11050OpenFlag()
  local n=e.GetCurrentStorySequence()
  if(n>=TppDefine.STORY_SEQUENCE.CLEARD_RETRIEVE_CHILD_DESERTER and TppDemo.IsPlayedMBEventDemo"ArrivedMotherBaseAfterQuietBattle")and(not e.IsMissionOpen(11050))then
    e.MissionOpen(11050)
  end
end
function e._UpdateS10260OpenFlag()
  if(not e.IsMissionCleard(10260))and e.CanOpenS10260()then
    TppBuddyService.SetBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
    TppBuddyService.SetDisableBuddyType(BuddyType.QUIET)
    TppMotherBaseManagement.RefreshQuietStatus()
  end
end
function e._UpdateStorySequence()
  local n=e.GetCurrentStorySequence()
  if n>=TppDefine.STORY_SEQUENCE.STORY_FINISH then
    return
  end
  local i,t
  local r
  repeat
    t=e.GetStorySequenceTable(n)
    if t==nil then
      return
    end
    local t=e.CheckNeedProceedStorySequence(t)
    if not t then
      break
    end
    i=e.ProceedStorySequence()n=e.GetCurrentStorySequence()
    if n<TppDefine.STORY_SEQUENCE.STORY_FINISH then
      r=false
    else
      r=true
    end
  until(r or next(i))
  return i
end
function e.CheckNeedProceedStorySequence(n)
  local t={}
  local function i(n)
    local n=TppMission.ParseMissionName(n)
    local e=e.IsMissionCleard(n)table.insert(t,e)
  end
  if n.main then
    i(n.main)
  end
  if n.flag then
    for n,e in pairs(n.flag)do
      i(e)
    end
  end
  local e=true
  local i=0
  for e=1,#t do
    if t[e]then
      i=i+1
    end
  end
  local t=#t
  if n.proceedCount then
    t=n.proceedCount
  end
  if i<t then
    e=false
  end
  if e and n.condition then
    e=n.condition()
  end
  return e
end
function e.ProceedStorySequence()
  e.IncrementStorySequence()
  local n=e.GetCurrentStorySequence()
  local n=e.GetStorySequenceTable(n)
  if n==nil then
    return
  end
  local i={}
  local function t(n,t)
    local r=t or{}
    local t=TppMission.ParseMissionName(n)
    e.PermitMissionOpen(t)
    if not r[n]then
      table.insert(i,n)
      e.MissionOpen(t)
    end
  end
  if n.main then
    t(n.main,n.defaultClose)
  end
  if n.flag then
    for i,e in pairs(n.flag)do
      t(e,n.defaultClose)
    end
  end
  if n.sub then
    for i,e in pairs(n.sub)do
      t(e,n.defaultClose)
    end
  end
  for e,e in pairs(i)do
  end
  return i
end
function e.CompleteAllMissionCleared()
  if not gvars.str_isAllMissionCleared then
    gvars.str_isAllMissionCleared=true
    TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.ALL_MISSION_CLEAR)
  end
end
function e.CompleteAllMissionSRankCleared()
  if not gvars.str_isAllMissionSRankCleared then
    gvars.str_isAllMissionSRankCleared=true
    TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.ALL_MISSION_S_RANK_CLEAR)
  end
end
function e.CompleteAllNormalMissionCleared()
  TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3016,pushReward=true}
end
function e.CompleteAllNormalMissionSRankCleared()
  TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3017,pushReward=true}
end
function e.CompleteAllHardMissionCleared()
  TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3018,pushReward=true}
end
function e.CompleteAllHardMissionSRankCleared()
  TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3019,pushReward=true}
end
function e.IsCompletedMbMedicalSpecialPlatform(e,n,t)
  if((e==Fox.StrCode32"MotherBase")and(n==Fox.StrCode32"Medical"))and(t==1)then
    return true
  else
    return false
  end
end
function e.IsOccuringBossQuiet()
  local e=e.GetClearedMissionCount{10041,10044,10052,10054}
  local t=TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform()
  local i=TppBuddy2BlockController.DidObtainBuddyType(BuddyType.QUIET)
  local n=TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BOSS_QUIET_KILL)
  if((t and(e>=1))and(not i))and(not n)then
    return true
  else
    return false
  end
end
function e.CanArrivalQuietInMB(n)
  local i=TppBuddy2BlockController.DidObtainBuddyType(BuddyType.QUIET)
  local e=not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_HOSPITALIZE)
  if n then
    e=true
  end
  local n=not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
  local t=not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)
  return((i and e)and n)and t
end
function e.RequestLoseQuiet()
  if not gvars.str_didLostQuiet then
    gvars.str_didLostQuiet=true
    TppBuddyService.UnsetObtainedBuddyType(BuddyType.QUIET)
    TppBuddyService.UnsetSortieBuddyType(BuddyType.QUIET)
    TppBuddyService.UnsetBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_DYING)
    TppBuddyService.SetFriendlyPoint(BuddyFriendlyType.QUIET,0)
  end
end
function e.CanArrivalLiquidInMB()
  local e=e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
  local n=not TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid"return e and n
end
function e.CanArrivalHueyInMB()
  local n=e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY
  local e=not TppDemo.IsPlayedMBEventDemo"DecisionHuey"return n and e
end
function e.HueyHasKantokuGrass()
  return e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA
end
function e.CanArrivalCodeTalkerInMB()
  return e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CODE_TALKER
end
function e.CanArrivalDDogInMB()
  local e=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
  local n=not TppBuddyService.IsDeadBuddyType(BuddyType.DOG)
  return e and n
end
function e.CanArrivalSahelanInMB()
  local e=e.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
  local n=not TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid"return e and n
end
function e.CanArrivalChildrenInMB()
  if e.IsMissionCleard(10100)then
    if TppDemo.IsPlayedMBEventDemo"TheGreatEscapeLiquid"then
      return false
    end
    local n=TppQuest.IsCleard"outland_q20913"or TppQuest.IsCleard"lab_q20914"local e=(TppQuest.IsCleard"tent_q20910"and TppQuest.IsCleard"fort_q20911")and TppQuest.IsCleard"sovietBase_q20912"if n and(not e)then
      return false
    end
    return true
  end
  return false
end
function e.CanArrivalAIPodInMB()
  return TppQuest.IsCleard"sovietBase_q99030"end
function e.GetBattleGearDevelopLevel()
  local n=e.GetCurrentStorySequence()
  if gvars.forceMbRadioPlayedFlag[TppDefine.FORCE_MB_RETURN_RADIO_ENUM.CompliteDevelopBattleGearRadio]or TppDemo.IsPlayedMBEventDemo"DevelopedBattleGear5"then
    return 5
  elseif n>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    return 4
  elseif n>=TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_COMMANDER then
    return 3
  elseif e.GetClearedMissionCount{10085,10200}>=1 then
    return 2
  elseif e.IsMissionCleard(10121)then
    return 1
  elseif TppDemo.IsPlayedMBEventDemo"AnableDevBattleGear"then
    return 0
  end
  return-1
end
function e.CanPlayDemoOrRadio(n)
  local e=e.radioDemoTable[n]
  if e then
    return e.storyCondition()and e.detailCondition()
  end
  return false
end
function e.GetStoryRadioListFromIndex(n,t)
  local n=e.eventPlayTimmingTable[n]
  if not n then
    return nil
  end
  local n=n[t][2]
  return e.radioDemoTable[n].radioList
end
function e.GetForceMBDemoNameOrRadioList(n,i)
  if i==nil then
    i={}
  end
  if not e.eventPlayTimmingTable[n]then
    return
  end
  if(n=="forceMBDemo"or n=="blackTelephone")and e.PLAY_DEMO_END_MISSION[vars.missionCode]then
    return
  end
  for a,t in ipairs(e.eventPlayTimmingTable[n])do
    local s=t[1]
    local r=t[2]
    local t=e.radioDemoTable[r]
    local o=e._GetRadioList(t,i)
    if(not e.IsDoneEvent(t,s,n,r)and t.storyCondition(i))and t.detailCondition(i)then
      if t.demoName then
        if e.DEBUG_SkipDemoRadio then
          TppMbFreeDemo.PlayMtbsEventDemo{demoName=t.demoName}
        end
        return t.demoName,a
      elseif o then
        if n=="blackTelephone"or n=="clearSideOpsForceMBRadio"then
          gvars.forceMbRadioPlayedFlag[TppDefine.FORCE_MB_RETURN_RADIO_ENUM[r]]=true
        end
        if n=="freeHeliRadio"then
          mvars.str_currentFreeHeliRadioList=o
        end
        return o,a
      end
    end
  end
end
function e.GetCurrentFreeHeliRadioList()
  return mvars.str_currentFreeHeliRadioList
end
function e._GetRadioList(e,n)
  if e.selectRadioFunction then
    return e.selectRadioFunction(n)
  end
  return e.radioList
end
function e.IsDoneEvent(e,t,n,i)
  if not t then
    return false
  end
  if e.demoName then
    return TppDemo.IsPlayedMBEventDemo(e.demoName)
  end
  if e.radioList then
    for n,e in ipairs(e.radioList)do
      if TppRadio.IsPlayed(e)then
        return true
      end
    end
    if n=="blackTelephone"or n=="clearSideOpsForceMBRadio"then
      if gvars.forceMbRadioPlayedFlag[TppDefine.FORCE_MB_RETURN_RADIO_ENUM[i]]then
        for n,e in ipairs(e.radioList)do
          TppRadio.SetPlayedGlobalFlag(e)
        end
        return true
      end
    end
    return false
  end
  return true
end
function e.UpdateDemoFlagQuietWishGoMission()
  if not TppDemo.IsPlayedMBEventDemo"QuietWishGoMission"and gvars.mis_quietCallCountOnMissionStart~=vars.buddyCallCount[BuddyType.QUIET]then
    e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION,TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_WITH_GO_MISSION)
  end
end
function e.DEBUG_GetUnclearedMissionCode()
  for t,e in pairs(TppDefine.MISSION_ENUM)do
    local n=gvars.str_missionOpenFlag[e]
    local e=gvars.str_missionClearedFlag[e]
    if n and(not e)then
      return tonumber(t)
    end
  end
end
function e.DEBUG_TestStorySequence()
  e.DEBUG_SkipDemoRadio=true
  TppScriptVars.InitForNewGame()
  TppGVars.AllInitialize()
  TppVarInit.InitializeOnNewGame()
  function TppMission.IsHelicopterSpace()
    return true
  end
  e.DEBUG_InitQuestFlagsForTest()
  local t
  repeat
    local i=""for t,n in ipairs(TppDefine.MISSION_LIST)do
      if e.IsMissionCleard(n)then
        i=i..(","..tostring(n))
      end
    end
    coroutine.yield()
    TppTerminal.ReleaseMbSection()
    e.UpdateStorySequence{updateTiming="OnMissionClear",missionId=TppMission.GetMissionID()}
    e.DEBUG_SetNeedStoryTest(vars.missionCode)
    local n=e.GetForceMBDemoNameOrRadioList"forceMBDemo"e.GetForceMBDemoNameOrRadioList("blackTelephone",{demoName=n})
    e.GetForceMBDemoNameOrRadioList"freeHeliRadio"e.GetForceMBDemoNameOrRadioList"freeHeliRadio"repeat
      coroutine.yield()
      TppQuest.UpdateActiveQuest{debugUpdate=true}until(not e.DEBUG_ClearQuestForTest(vars.missionCode))
    e.MissionOpen(10260)
    local n=e.DEBUG_GetUnclearedMissionCode()
    if mvars.str_DEBUG_needClearOneMission then
      n=10036
      mvars.str_DEBUG_needClearOneMission=false
    end
    if n==nil then
      break
    end
    vars.missionCode=n
    local n=e.GetCurrentStorySequence()
    if n<TppDefine.STORY_SEQUENCE.STORY_FINISH then
      t=false
    else
      t=true
    end
    coroutine.yield()until(t or mvars.str_testBreak)
  e.DEBUG_SkipDemoRadio=nil
end
function e.DEBUG_InitQuestFlagsForTest()
  for n,e in ipairs(TppDefine.QUEST_INDEX)do
    gvars.qst_questOpenFlag[e]=false
    gvars.qst_questActiveFlag[e]=false
    gvars.qst_questClearedFlag[e]=false
    gvars.qst_questRepopFlag[e]=false
  end
end
function e.DEBUG_ClearQuestForTest(e)
  for n,e in ipairs(TppDefine.QUEST_DEFINE)do
    if TppQuest.IsOpen(e)and not TppQuest.IsCleard(e)then
      TppQuest.Clear(e)
      return true
    end
  end
  return false
end
function e.DEBUG_SetNeedStoryTest(n)
  if n==10050 then
    if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
    else
      TppBuddy2BlockController.SetObtainedBuddyType(BuddyType.QUIET)
      local n=e.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION)
      if n==TppDefine.ELAPSED_MISSION_COUNT.INIT then
        e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION,TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_WITH_GO_MISSION)
        e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.QUIET_VISIT_MISSION,TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_VISIT_MISSION)
      end
      if TppQuest.IsCleard"mtbs_q99011"then
        TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
        TppBuddyService.UnsetDeadBuddyType(BuddyType.QUIET)
      end
    end
    TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
    e.MissionOpen(10070)
    vars.mbmTppGmp=-1e3
  end
  if n==10121 then
    e.MissionOpen(10115)
  end
  if n==10043 then
    TppBuddyService.SetObtainedBuddyType(BuddyType.DOG)
  end
  if e.GetClearedMissionCount{10041,10044,10052,10054}==2 then
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Medical",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
  end
  if n==10200 then
    TppMotherBaseManagement.SetMbsClusterParam{category="Develop",grade=4,buildStatus="Completed"}coroutine.yield()
  end
  if n==10151 then
    TppMotherBaseManagement.SetMbsClusterParam{category="Medical",grade=4,buildStatus="Completed"}coroutine.yield()
  end
  if n==10054 then
    e.MissionOpen"10050"end
  if n==10171 then
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Command",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Combat",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Develop",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="BaseDev",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Support",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Spy",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Medical",grade=4,buildStatus="Completed",timeMinute=0,isNew=false}coroutine.yield()
    TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs{count=3500}
  end
  if n==10240 then
    TppBuddyService.SetFriendlyPoint(BuddyFriendlyType.QUIET,100)
    TppMotherBaseManagement.SetCassetteTapeTrackNewFlag("tp_m_10160_11",false)
  end
  vars.personalBirthdayMonth=3
  vars.personalBirthdayDay=10
end
function e.DEBUG_SetStorySequence(n,o)do
  return
end
if(n<TppDefine.STORY_SEQUENCE.STORY_START)and(n>TppDefine.STORY_SEQUENCE.STORY_FINISH)then
  return
end
gvars.str_storySequence=n
for e=0,TppDefine.MISSION_COUNT_MAX do
  gvars.str_missionOpenPermission[e]=false
  gvars.str_missionOpenFlag[e]=false
  gvars.str_missionClearedFlag[e]=false
  gvars.str_missionNewOpenFlag[e]=false
end
if TppDebugMbDevelop then
  local n
  local i
  for t=TppDefine.STORY_SEQUENCE.STORY_START,gvars.str_storySequence do
    local e=e.GetStorySequenceName(t)
    if TppDebugMbDevelop[e]then
      n=TppDebugMbDevelop[e]i=e
    end
  end
  if n then
    n()
  else
    TppDebugMbDevelop.AllDeveloped()
  end
end
local function r(i,o,a,t,n)
  local r=n or{}
  local n=TppMission.ParseMissionName(i)
  local t=(i==t)
  e.PermitMissionOpen(n)
  if(not r[i])or(t)then
    e.MissionOpen(n)
    if(o<a)and(not t)then
      e.DisableMissionNewOpenFlag(n)
      e.UpdateMissionCleardFlag(n)
    end
  end
  return t
end
local t
for i=0,n do
  local e=e.GetStorySequenceTable(i)
  if e==nil then
    break
  end
  if e.main then
    local e=r(e.main,i,n,o,e.defaultClose)t=t or e
  end
  if e.flag then
    for s,a in pairs(e.flag)do
      local e=r(a,i,n,o,e.defaultClose)t=t or e
    end
  end
  if e.sub then
    for s,a in pairs(e.sub)do
      local e=r(a,i,n,o,e.defaultClose)t=t or e
    end
  end
  if t then
    gvars.str_storySequence=i
    break
  end
end
local n=TppResult.CalcMissionClearHistorySize()
TppResult.SetMissionClearHistorySize(n)
if gvars.str_storySequence>TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
  TppVarInit.SetHorseObtainedAndCanSortie()
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON then
  e.MissionOpen(10050)
  e.UpdateMissionCleardFlag(10050)
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
  e.MissionOpen(10070)
  e.UpdateMissionCleardFlag(10070)
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER then
  e.MissionOpen(10115)
  e.UpdateMissionCleardFlag(10115)
  TppMotherBaseManagement.SetFobSvars{fob="Fob1",got=true,oceanAreaId=2,topologyType=10,color="Orange"}
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR then
  e.MissionOpen(11050)
  e.UpdateMissionCleardFlag(11050)
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
  e.MissionOpen(10240)
  e.UpdateMissionCleardFlag(10240)
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
  local n={11080,11121,11130,11044,11151,10260,10280}
  if TppGameSequence.GetSpecialVersionName()=="e3_2015"then
    n={11080,11121,11130,11044,11151,10260}
  end
  for t,n in ipairs(n)do
    e.MissionOpen(n)
    e.UpdateMissionCleardFlag(n)
  end
  if TppQuest.QAReleaseFullOpen then
    TppQuest.QAReleaseFullOpen()
  end
end
if TppTerminal.PandemicTutorialStoryCondition()then
  TppTerminal.FinishPandemicTutorial()
  TppTerminal.StartPandemicEvent()
end
if TppTerminal.CheckPandemicEventFinish()then
  TppTerminal.FinishPandemicTutorial()
  TppTerminal.FinishPandemicEvent()
end
if e.IsAlwaysOpenRetakeThePlatform()then
  TppUiCommand.SetMission10115Emergency(false)
else
  TppUiCommand.SetMission10115Emergency(true)
end
if gvars.str_storySequence==TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,2)
  TppQuest.StartElapsedEvent(1)
end
if gvars.str_storySequence==TppDefine.STORY_SEQUENCE.CLEARD_RETRIEVE_VOLGIN then
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,2)
  TppQuest.StartElapsedEvent(1)
end
if gvars.str_storySequence==TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,1)
  TppQuest.StartElapsedEvent(3)
end
if gvars.str_storySequence==TppDefine.STORY_SEQUENCE.CLEARD_AFTER_MURDER_INFECTORS_ONE_MISSION then
  e.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE,1)
  TppQuest.StartElapsedEvent(3)
end
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
  gvars.qst_questOpenFlag[TppDefine.QUEST_INDEX.sovietBase_q99030]=true
  gvars.qst_questOpenFlag[TppDefine.QUEST_INDEX.tent_q99040]=true
end
TppTerminal.OnEstablishMissionClear()
TppRanking.UpdateOpenRanking()
end
function e.DecreaseElapsedMissionClearCount()
  for n=0,TppDefine.ELAPSED_MISSION_COUNT_MAX-1 do
    if n~=TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE or(not e.PLAY_DEMO_END_MISSION[vars.missionCode])then
      if gvars.str_elapsedMissionCount[n]>0 then
        local e=gvars.str_elapsedMissionCount[n]-1
        gvars.str_elapsedMissionCount[n]=e
      end
    end
  end
end
function e.EnableMissionNewOpenFlag(n)
  e.SetMissionNewOpenFlag(n,true)
end
function e.DisableMissionNewOpenFlag(n)
  e.SetMissionNewOpenFlag(n,false)
end
function e.SetMissionNewOpenFlag(e,n)
  if TppMission.IsSysMissionId(e)then
    return
  end
  local e=TppDefine.MISSION_ENUM[tostring(e)]
  if e then
    gvars.str_missionNewOpenFlag[e]=n
  end
end
return e
