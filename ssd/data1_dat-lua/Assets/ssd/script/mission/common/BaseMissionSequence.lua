-- BaseMissionSequence.lua
local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeNumber=Tpp.IsTypeNumber
local unkM1Tips1={
  TIPS_FOGAREA={startRadio="f3010_rtrg0316",tipsTypes={{HelpTipsType.TIPS_23_A,HelpTipsType.TIPS_23_B,HelpTipsType.TIPS_23_C}}},
  TIPS_TREASURE={tipsTypes={{HelpTipsType.TIPS_26_A,HelpTipsType.TIPS_26_C,HelpTipsType.TIPS_26_B}},tipsRadio="f3010_rtrg0328"},TIPS_BUILDING={tipsTypes={{HelpTipsType.TIPS_13_A,HelpTipsType.TIPS_13_B,HelpTipsType.TIPS_13_C},{HelpTipsType.TIPS_14_A,HelpTipsType.TIPS_14_B,HelpTipsType.TIPS_14_C}}},
  TIPS_CREWDEPLOYMENT={tipsTypes={{HelpTipsType.TIPS_45_A,HelpTipsType.TIPS_45_B,HelpTipsType.TIPS_45_C},{HelpTipsType.TIPS_46_A,HelpTipsType.TIPS_46_B,HelpTipsType.TIPS_46_C}}},
  TIPS_VEHICLE={tipsTypes={{HelpTipsType.TIPS_87_A,HelpTipsType.TIPS_87_B,HelpTipsType.TIPS_87_C}}},
  TIPS_BASE_INFORMATION={tipsRadio="f3000_rtrg2003",tipsTypes={{HelpTipsType.TIPS_52_A,HelpTipsType.TIPS_52_B,HelpTipsType.TIPS_52_C}}},
  TIPS_CURE={tipsTypes={{HelpTipsType.TIPS_3_A,HelpTipsType.TIPS_3_B,HelpTipsType.TIPS_3_C}}},
  TIPS_WALKERGEAR={tipsTypes={{HelpTipsType.TIPS_100_A,HelpTipsType.TIPS_100_B,HelpTipsType.TIPS_100_C}}},
  TIPS_ATTRIBUTE={tipsTypes={{HelpTipsType.TIPS_42_A,HelpTipsType.TIPS_42_B,HelpTipsType.TIPS_42_C}}},
  TIPS_ADVANCEDCRAFT={tipsTypes={{HelpTipsType.TIPS_93_A,HelpTipsType.TIPS_93_B}}},
  TIPS_FLAG={tipsTypes={{HelpTipsType.TIPS_35_A,HelpTipsType.TIPS_35_B}}},
  TIPS_WORMHOLE={tipsTypes={{HelpTipsType.TIPS_83_A}}},
  TIPS_CAMPSET={tipsTypes={{HelpTipsType.TIPS_56_A,HelpTipsType.TIPS_56_B}}},
  TIPS_WATERPUMP={tipsTypes={{HelpTipsType.TIPS_102_A,HelpTipsType.TIPS_102_B,HelpTipsType.TIPS_102_C}}},
  TIPS_CURESPARY={tipsTypes={{HelpTipsType.TIPS_110_A,HelpTipsType.TIPS_110_B}}},
  TIPS_REPAIR={tipsTypes={{HelpTipsType.TIPS_66_A,HelpTipsType.TIPS_66_B,HelpTipsType.TIPS_66_C}}},
  TIPS_JUNK={tipsTypes={{HelpTipsType.TIPS_94_A,HelpTipsType.TIPS_94_B,HelpTipsType.TIPS_94_C}}},
  TIPS_CUSTOMIZE_ENHANCEMENT={tipsTypes={{HelpTipsType.TIPS_95_A,HelpTipsType.TIPS_95_B}}},
  TIPS_CUSTOMIZE_PERK={tipsTypes={{HelpTipsType.TIPS_96_A,HelpTipsType.TIPS_96_B}}},
  TIPS_CUSTOMIZE_OPTIONALPARTS={tipsTypes={{HelpTipsType.TIPS_98_A,HelpTipsType.TIPS_98_B,HelpTipsType.TIPS_98_C}}},
  TIPS_CUSTOMIZE_COLOR={tipsTypes={{HelpTipsType.TIPS_99_A,HelpTipsType.TIPS_99_B,HelpTipsType.TIPS_99_C}}},
  TIPS_SUBCLASS={tipsTypes={{HelpTipsType.TIPS_103_A,HelpTipsType.TIPS_103_B,HelpTipsType.TIPS_103_C}}},
  TIPS_OUTSIDE_MISSION_AREA={tipsRadio="f3000_rtrg0150",tipsTypes={{HelpTipsType.TIPS_40_A,HelpTipsType.TIPS_40_B}}},
  TIPS_ORDER={tipsTypes={{HelpTipsType.TIPS_111_A,HelpTipsType.TIPS_111_B,HelpTipsType.TIPS_111_C}}},
  TIPS_OPENING_THE_CASE={tipsTypes={{HelpTipsType.TIPS_114_A,HelpTipsType.TIPS_114_B}}},
  TIPS_BUILDING_ASSAULT_RAID={tipsTypes={{HelpTipsType.TIPS_117_A,HelpTipsType.TIPS_117_B}}},
  TIPS_BASE_DEFENSE={tipsTypes={{HelpTipsType.TIPS_43_A,HelpTipsType.TIPS_43_B,HelpTipsType.TIPS_43_C},{HelpTipsType.TIPS_44_A,HelpTipsType.TIPS_44_B,HelpTipsType.TIPS_44_C}}}
}
local unkM1Tips2={
  TIPS_WATER={tipsTypes={HelpTipsType.TIPS_12_A,HelpTipsType.TIPS_12_B,HelpTipsType.TIPS_12_C,HelpTipsType.TIPS_7_A,HelpTipsType.TIPS_7_B,HelpTipsType.TIPS_7_C}},
  TIPS_CORE={startRadio="f3010_rtrg0204",tipsTypes={HelpTipsType.TIPS_6_A,HelpTipsType.TIPS_6_B,HelpTipsType.TIPS_6_C}},
  TIPS_BED={tipsTypes={HelpTipsType.TIPS_17_A,HelpTipsType.TIPS_17_B}},
  TIPS_PLANTFARM={tipsTypes={HelpTipsType.TIPS_48_A,HelpTipsType.TIPS_48_B,HelpTipsType.TIPS_48_C}},
  TIPS_ANIMALFARM={tipsTypes={HelpTipsType.TIPS_49_A,HelpTipsType.TIPS_49_B,HelpTipsType.TIPS_49_C}},
  TIPS_ANIMALFARM={tipsTypes={HelpTipsType.TIPS_49_A,HelpTipsType.TIPS_49_B,HelpTipsType.TIPS_49_C}},
  TIPS_RADIOSTATION={tipsTypes={HelpTipsType.TIPS_63_A,HelpTipsType.TIPS_63_B,HelpTipsType.TIPS_63_C}},
  TIPS_LOSTCARDBOARD={tipsTypes={HelpTipsType.TIPS_65_A,HelpTipsType.TIPS_65_B,HelpTipsType.TIPS_65_C}},
  TIPS_BUDO_POINTS={tipsTypes={HelpTipsType.TIPS_112_A,HelpTipsType.TIPS_112_B,HelpTipsType.TIPS_112_C}}}
local l={[CrewType.MOB_MALE]="RescueCrew_Man",[CrewType.MOB_FEMALE]="RescueCrew_Woman"}
function this.EnableBaseCheckPoint()
  TppMission.EnableBaseCheckPoint()
end
function this.DisableBaseCheckPoint()
  TppMission.DisableBaseCheckPoint()
end
function this.CreateInstance(missionName)
  local instance={}
  instance.missionName=missionName
  instance.sequences={}
  instance.checkPointList={}
  function instance.AddCheckPoint(n)
    if Tpp.IsTypeString(n)then
      n={n}
    end
    if IsTypeTable(n)then
      for i,n in ipairs(n)do
        table.insert(instance.checkPointList,n)
      end
    end
  end
  function instance.AddSaveVarsList(n)
    if not instance.saveVarsList then
      instance.saveVarsList={}
    end
    for n,i in pairs(n)do
      instance.saveVarsList[n]=i
    end
  end
  function instance.OnLoad()
    TppSequence.RegisterSequences(instance.sequenceList)
    TppSequence.RegisterSequenceTable(instance.sequences)
    instance.enemyScript=_G[tostring(missionName).."_enemy"]
    instance.radioScript=_G[tostring(missionName).."_radio"]
  end
  function instance.MissionPrepare()
    if IsTypeTable(mvars.loc_locationTreasureBox)and IsTypeTable(mvars.loc_locationTreasureBox.treasureBoxTableList)then
      for n,e in ipairs(mvars.loc_locationTreasureBox.treasureBoxTableList)do
        Gimmick.SetTreasureBoxResources(e)
      end
    end
    if IsTypeTable(mvars.loc_locationTreasurePoint)and IsTypeTable(mvars.loc_locationTreasurePoint.treasurePointTableList)then
      for n,e in ipairs(mvars.loc_locationTreasurePoint.treasurePointTableList)do
        Gimmick.SetTreasurePointResources(e)
      end
    end
    if IsTypeTable(mvars.loc_locationWormhole)and IsTypeTable(mvars.loc_locationWormhole.wormholePointTable)then
      for n,e in ipairs(mvars.loc_locationWormhole.wormholePointTable)do
        Gimmick.SetWormholePointResources(e)
      end
    end
    if IsTypeTable(mvars.loc_locationGimmick)and IsTypeTable(mvars.loc_locationGimmick.easterEggTableList)then
      for n,e in ipairs(mvars.loc_locationGimmick.easterEggTableList)do
        Gimmick.SetEasterEggResource(e)
      end
    end
    instance.SetMissionGimmickResource(mvars.loc_locationTreasureMission)
    instance.SetMissionGimmickResource(mvars.loc_locationTreasureQuest)
    if Tpp.IsTypeTable(SsdWaterPumpList)and Tpp.IsTypeTable(SsdWaterPumpList.waterPumpTableList)then
      for n,e in ipairs(SsdWaterPumpList.waterPumpTableList)do
        Gimmick.SetDefaultInvisible(e)
      end
    end
    mvars.mis_reservedNextMissionCodeForAbort=instance.nextMissionIdForAbort
    if instance.AfterMissionPrepare then
      instance.AfterMissionPrepare()
    end
  end
  function instance.OnRestoreSVars()
    instance.RestoreBase()
    instance.UpdateVisibilitySettings()
    instance.UpdatePowerOffSettings()SsdFastTravel.InitializeFastTravelPoints()
    if not instance.disableEnemyRespawn then
      TppEnemy.SetRespawnFlagAllForEnemyNpcs()
    end
    if instance.AfterOnRestoreSVars then
      instance.AfterOnRestoreSVars()
    end
  end
  function instance.OnEndMissionPrepareSequence()
    local n=false
    if Tpp.IsEditorNoLogin()then
      n=true
    elseif Tpp.IsQARelease()or nil then
      n=(DebugMenu.GetDebugMenuValue(" <Ssd>","OfflineMode")=="ON")
    end
    TppVarInit.InitializeBuildingData(n)
    instance.LockAndUnlockUI()
    if TppMission.IsFromAvatarRoom()then
      if TppMission.IsFreeMission(vars.missionCode)then
        Player.SetEditAvatarToSkillTrainer()
      end
      TppMission.SetIsFromAvatarRoom(false)
    end
    if instance.AfterOnEndMissionPrepareSequence then
      instance.AfterOnEndMissionPrepareSequence()
    end
  end
  function instance.RestoreBase()
    TppVarInit.SetBuildingLevel()
    if afgh_base then
      afgh_base.SetAiVisibility(true)
      afgh_base.SetDiggerVisibility(true)
      afgh_base.OnBaseActivated()
    end
  end
  function instance.LockAndUnlockUI()
    local currentStorySequence=TppStory.GetCurrentStorySequence()
    instance.UpdateVisibilitySettings()
    instance.UpdatePowerOffSettings()
    Gimmick.BreakAtTheBaseDefenseEnd()
    SsdUiSystem.ClearScriptFlag()
    SsdUiSystem.ClearLock()
    SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs={}}
    SsdMbDvc.SetShowOxygenUiThreshold(70)
    FastTravelMenuSystem.SetLocationMoveEnabled(true)
    if TppLocation.IsAfghan()then
      local e={"defaultReachedArea0000","defaultReachedArea0001","defaultReachedArea0002","defaultReachedArea0003","defaultReachedArea0004"}
      for n,e in ipairs(e)do
        local data=Tpp.GetDataWithIdentifier("DataIdentifier_f30010_sequence",e,"TransformData")
        if data then
          local position=data.worldTransform.translation
          local radius=data.size
          SsdBlankMap.SetReachedArea{position=position,radius=radius}
        end
      end
    elseif TppLocation.IsMiddleAfrica()then
      local defaultReachedAreaData=Tpp.GetDataWithIdentifier("DataIdentifier_f30020_sequence","defaultReachedArea","TransformData")
      if defaultReachedAreaData then
        local position=defaultReachedAreaData.worldTransform.translation
        local radius=defaultReachedAreaData.size
        SsdBlankMap.SetReachedArea{position=position,radius=radius}
      end
    end
    for n,e in ipairs{"uniq_nrs","uniq_boy"}do
      SsdCrewSystem.LockUniqueCrewDeploy{uniqueId=e,lock=true}
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
      TppClock.SetTime"07:30:00"end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
      TppClock.Stop()
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
      SsdUiSystem.Lock(SsdUiLockType.REPAIR)
      SsdUiSystem.Lock(SsdUiLockType.CUSTOMIZE)
      SsdUiSystem.Lock(SsdUiLockType.DISASSEMBLE)
      SsdUiSystem.Lock(SsdUiLockType.EQUIP)
      SsdUiSystem.Lock(SsdUiLockType.AI_EXIST)
    else
      SsdUiSystem.Unlock(SsdUiLockType.REPAIR)
      SsdUiSystem.Unlock(SsdUiLockType.CUSTOMIZE)
      SsdUiSystem.Unlock(SsdUiLockType.DISASSEMBLE)
      SsdUiSystem.Unlock(SsdUiLockType.EQUIP)
      SsdUiSystem.Unlock(SsdUiLockType.AI_EXIST)
    end
    vars.playerDisableActionFlag=PlayerDisableAction.NONE
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      vars.playerDisableActionFlag=bit.bor(vars.playerDisableActionFlag,PlayerDisableAction.MB_TERMINAL)
    end
    --RETAILPATCH: 1.0.5.0>
    if currentStorySequence==TppDefine.STORY_SEQUENCE.BEFORE_k40040 then
      vars.playerDisableActionFlag=bit.bor(vars.playerDisableActionFlag,((PlayerDisableAction.BASE_FACILITY+PlayerDisableAction.RIP_OUT)+PlayerDisableAction.PICKUP)+PlayerDisableAction.SEARCH_ITEM)
    end
    --<
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40060 then
      vars.playerDisableActionFlag=bit.bor(vars.playerDisableActionFlag,PlayerDisableAction.FULTON)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=true}
    else
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=false}
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=true}
    else
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=false}
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=true}
    else
      ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=false}
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_HUNGER)
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_THIRST)
      Player.SetRequestToResetLifeToRecoveryLimit()
      Player.SetRequestToResetStaminaToRecoveryLimit()
    else
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_HUNGER)
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_THIRST)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_LOCATION_TAB)
    else
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_LOCATION_TAB)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_PRESS_STAMP)
    else
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_PRESS_STAMP)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40040 then
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_PRESS_USER_MARKER)
    else
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.DISABLE_MBDVC_PRESS_USER_MARKER)
    end
    if not SsdSbm.HasRecipe"RCP_EQP_SWP_WaterPump"then
      SsdUiSystem.Lock(SsdUiLockType.WATER_PUMP)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
      CraftMenu.SetDisablePutCraftedIntoWarehouse(true)
    else
      CraftMenu.SetDisablePutCraftedIntoWarehouse(false)
    end
    TppUI.SetCoopFullUiLockType()
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40070 and not SsdSbm.IsGasCylinderAvailable()then
      SsdSbm.AddProduction{id="PRD_SVE_GasCylinder_Lv1",count=1,tryEquip=true}
      SsdSbm.OpenGasCylinder()
      Gear.SetMaskLevel(GearMaskLevel.ALLON_LV1)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN)
    else
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN)
    end
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
      SsdFastTravel.UnlockAllAutoBootFastTravelPointGimmick()
      SsdFastTravel.UnlockFastTravelPoint"fast_afgh00"
    end
    if TppLocation.IsAfghan()then
      if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40015 then
        SsdFastTravel.UnlockFastTravelPoint"fast_afgh01"
      end
    elseif TppLocation.IsMiddleAfrica()then
      if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40160 then
        SsdFastTravel.UnlockFastTravelPoint"fast_mafr00"
      else
        SsdFastTravel.LockFastTravelPointGimmick"fast_mafr00"
      end
      if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40220 then
        SsdFastTravel.UnlockFastTravelPoint"fast_mafr05"
      end
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
      for n,e in ipairs{SsdUiLockType.CREW_MANAGEMENT,SsdUiLockType.RESOURCE_MANAGEMENT,SsdUiLockType.RESOURCE_POPITEM}do
        SsdUiSystem.Lock(e)
      end
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
      Mission.SetReeveInjury(true)
    else
      Mission.SetReeveInjury(false)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40080 then
      for n,e in ipairs{SsdUiLockType.BASE_INFORMATION,SsdUiLockType.CREW_BADSTATUS,SsdUiLockType.CREW_HUNGRY,SsdUiLockType.RESOURCE_CYCLE,SsdUiLockType.RESOURCE_LACK_ANNOUNCE,SsdUiLockType.CREW_VOLUNTEER_CYCLE}do
        SsdUiSystem.Lock(e)
      end
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40130 then
      for n,e in ipairs{SsdUiLockType.FOOD_GROUP,SsdUiLockType.MEDICAL_GROUP}do
        SsdUiSystem.Lock(e)
      end
    end
    if(currentStorySequence>=TppDefine.STORY_SEQUENCE.BEFORE_k40160)and(currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_s10050)then
      for n,e in ipairs{SsdUiLockType.BASE_INFORMATION,SsdUiLockType.CREW_BADSTATUS,SsdUiLockType.CREW_HUNGRY,SsdUiLockType.RESOURCE_CYCLE,SsdUiLockType.RESOURCE_LACK_ANNOUNCE,SsdUiLockType.CREW_VOLUNTEER_CYCLE,SsdUiLockType.CREW_MANAGEMENT}do
        SsdUiSystem.Lock(e)
      end
    end
    if(currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40230)and(currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_s10050)then
      SsdCrewSystem.SetUniqueCrewAbsence{uniqueId="uniq_boy",absence=true}
    else
      SsdCrewSystem.SetUniqueCrewAbsence{uniqueId="uniq_boy",absence=false}
    end
    if(currentStorySequence<TppDefine.STORY_SEQUENCE.BEFORE_k40080)or(currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40080)then
      SsdCrewSystem.SetUniqueCrewAbsence{uniqueId="uniq_mlt",absence=false}
      SsdCrewSystem.SetUniqueCrewAbsence{uniqueId="uniq_nrs",absence=false}
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_s10050 then
      SsdUiSystem.Lock(SsdUiLockType.DEVELOP_GROUP)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST then
      for n,e in ipairs{SsdUiLockType.BASE_DEFENSE,SsdUiLockType.DEFENSE_GROUP}do
        SsdUiSystem.Lock(e)
      end
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40090 then
      SsdUiSystem.Lock(SsdUiLockType.EXPLORE_GROUP)Mission.SetHasWheelChair(false)
    else
      Mission.SetHasWheelChair(true)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40030 then
      SsdUiSystem.Lock(SsdUiLockType.WORMHOLE_FULTON_EX)
    end
    --RETAILPATCH: 1.0.5.0>
    if SsdBaseDefense.IsCleared"d53010"then
      SsdBuilding.SetLevel{level=3}--<
    elseif currentStorySequence<TppDefine.STORY_SEQUENCE.BEFORE_k40155 then
      SsdBuilding.SetLevel{level=1}
    else
      SsdBuilding.SetLevel{level=2}
    end
    local i=TppStory.GetMissionGuideLine()
    if i and IsTypeTable(i)then
      SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=i}
    end
    this.SetEnemyLevel(currentStorySequence)
    if TppDefine.STORY_SEQUENCE.BEFORE_RETURN_TO_AFGH<=currentStorySequence then
      Mission.SetLocationReleaseState(Mission.LOCATION_RELEASE_STATE_AFGH_AND_MAFR)
    elseif TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST<currentStorySequence then
      Mission.SetLocationReleaseState(Mission.LOCATION_RELEASE_STATE_MAFR)
    else
      Mission.SetLocationReleaseState(Mission.LOCATION_RELEASE_STATE_AFGH)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40060 then
      SsdUiSystem.Lock(SsdUiLockType.KUB_FLAGMENT)
    end
    if TppStory.GetCurrentStorySequence()>TppDefine.STORY_SEQUENCE.BEFORE_k40230 then
      SsdUiSystem.UnsetScriptFlag(SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION)
    else
      SsdUiSystem.SetScriptFlag(SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION)
    end
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_BASE_DEFENSE_TUTORIAL then
      BaseDefenseManager.SetClosedFlag(TppDefine.BASE_DEFENSE_TUTORIAL_MISSION,true)
    else
      BaseDefenseManager.SetClosedFlag(TppDefine.BASE_DEFENSE_TUTORIAL_MISSION,false)
    end
    if TppLocation.IsMiddleAfrica()then
      Mission.SetMafrBaseArea{center={2864.409,101.5907,-915.1037},size={30,1e3,60}}
    end
    instance.SetStorySequenceTreasurePointValidity(mvars.loc_locationTreasurePoint)
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST then
      SsdSbm.AddNamePlate(102)
    end
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST then
      SsdSbm.AddNamePlate(54)SsdSbm.AddNamePlate(55)
    end
    if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40310 then
      SsdSbm.AddNamePlate(40)
      SsdSbm.AddNamePlate(41)
      SsdSbm.AddNamePlate(42)
      SsdSbm.AddNamePlate(43)
    end
  end
  function instance.UpdateVisibilitySettings()
    local e=mvars.loc_locationVisibilitySettings
    if IsTypeTable(e)then
      local e=e.gimmickTableList
      if IsTypeTable(e)then
        for n,e in ipairs(e)do
          local n=e.visibility
          local i=TppStory.GetCurrentStorySequence()
          if(i<e.targetStorySequence)or(e.greaterThanStorySequence and(i>=e.greaterThanStorySequence))then
            n=not n
          end
          Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetPath,not n)
        end
      end
    end
    if TppLocation.IsAfghan()then
      TppGimmick.SetStoryDiggerFinCount()
      TppGimmick.ResetAfghBaseDiggerTarget()
    end
    if TppLocation.IsMiddleAfrica()then
      mafr_base.SetFobAiVisibility()
    end
  end
  function instance.UpdatePowerOffSettings(s)
    local i=TppStory.GetCurrentStorySequence()
    local e=mvars.loc_locationVisibilitySettings
    if IsTypeTable(e)then
      local e=e.powerOffGimmickTableList
      if IsTypeTable(e)then
        for n,e in ipairs(e)do
          local n=false
          if not s then
            if e.storySequence then
              if i<e.storySequence then
                n=true
              end
            else
              n=true
            end
          end
          Gimmick.SetSsdPowerOff{gimmickId=e.gimmickId,name=e.gimmickName,dataSetName=e.dataSetName,powerOff=n}
          if e.isNoTransfering then
            Gimmick.SetNoTransfering{gimmickId=e.gimmickId,name=e.gimmickName,dataSetName=e.dataSetName,noTransfering=n}
          end
        end
      end
    end
  end
  function instance.UpdatesetInOutMessageSettings()
  end
  function instance.OnTerminate()BaseResultUiSequenceDaemon.ClearCallbackOnPutAllOfPlayersInventoryInABase()
    TppMission.StopDefenseGame()
    instance.UpdatePowerOffSettings(true)ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=false}
    ScriptParam.ResetValueToDefault{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger"}
    ScriptParam.ResetValueToDefault{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst"}
    SsdUiSystem.ClearScriptFlag()
    SsdUiSystem.ClearLock()
    SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs={}}
    CraftMenu.SetDisablePutCraftedIntoWarehouse(false)
    TppEffectUtility.RemoveEnemyRootView()
    if IsTypeFunc(instance.AfterOnTerminate)then
      instance.AfterOnTerminate()
    elseif IsTypeTable(instance.AfterOnTerminate)then
      for n,e in ipairs(instance.AfterOnTerminate)do
        e()
      end
    end
  end
  function instance.AddOnTerminateFunction(i)
    local n=instance.AfterOnTerminate
    if not IsTypeTable(n)then
      instance.AfterOnTerminate={}
    end
    if IsTypeFunc(n)then
      table.insert(instance.AfterOnTerminate,n)
    end
    table.insert(instance.AfterOnTerminate,i)
  end
  function instance.AddMessage(n,i)
    if not n then
      n={}
    end
    for e,i in pairs(i)do
      if not n[e]then
        n[e]={}
      end
      for t,i in ipairs(i)do
        table.insert(n[e],i)
      end
    end
    return n
  end
  instance.messageTable=instance.AddMessage(instance.messageTable,{
    GameObject={
      {msg="EnterBaseCheckpoint",func=function()
        if not instance.isBaseCheckPointEnabled()then
          return
        end
        mvars.frm_mobCrewTypeForDemo=nil
        local i
        local n=this.ExecuteEnterBaseCheckPointCallback()
        if n then
          if n.isDefiniteFlagMissionClear then
            BaseResultUiSequenceDaemon.SetReserved(true)i=true
          end
        end
        local n=GameObject.SendCommand({type="SsdCrew"},{id="RegisterCarriedCrewToBase"})
        if n then
          local e=l[n]
          if e then
            mvars.frm_mobCrewTypeForDemo=n
            TppDemo.PlayRescueDemo(e,nil,nil,{onEnd=function()
              mvars.frm_mobCrewTypeForDemo=nil
              TppQuest.UnloadCurrentQuestBlock"quest_block_3"end},
            {finishFadeOut=i},
            {resetPlayerPosition=true})
          end
        end
        instance.OnEnterBaseCheckPoint()
      end,option={isExecFastTravel=true}},
      {msg="LeaveBaseCheckpoint",func=function()
        SsdBlankMap.StartExploration()
        instance.UpdateBaseCheckPoint(false)
        if SsdSbm.IsSurviveCboxExist()then
          instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_LOSTCARDBOARD)
        end
      end,option={isExecFastTravel=true}},
      {msg="ChangeFogAreaState",func=function()
        if instance.IsStartCommonHelpTipsMenu(unkM1Tips1.TIPS_FOGAREA)then
          local e=TppStory.GetCurrentStorySequence()
          if e>=TppDefine.STORY_SEQUENCE.BEFORE_k40040 and e<=TppDefine.STORY_SEQUENCE.CLEARED_k40060 then
            if TppGameStatus.IsSet("","S_FOG_PASSAGE")then
              TppTutorial.StartHelpTipsMenu(unkM1Tips1.TIPS_FOGAREA)
            end
          end
        end
      end,option={isExecFastTravel=true}},
      {msg="OnGetItem",func=function(e,n,n,n)
        SsdRecipe.UnlockConditionClearedRecipe(e)
      end},
      {msg="SwitchGimmick",func=function(n)
        if(n~=TppGimmick.GetCurrentLocationDiggerGameObjectId())then
          return
        end
        local n=TppStory.GetCurrentStorySequence()
        if n==TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_BASE_DEFENSE)
        end
      end}},
    Sbm={
      {msg="OnGetItem",func=function(e,n,n,n)
        SsdRecipe.UnlockConditionClearedRecipe(e)
      end}},
    UI={
      {msg="CraftMenuOpened",func=function(n)
        if n==CraftMenu.ENTRY_CRAFT_WEAPON then
          if instance.IsStartCommonHelpTipsMenu(unkM1Tips1.TIPS_ADVANCEDCRAFT)then
            local e=SsdSbm.HasRecipe"RCP_BLD_WeaponPlant_B"if e==true then
              TppTutorial.StartHelpTipsMenu(unkM1Tips1.TIPS_ADVANCEDCRAFT)
            end
          end
        elseif n==CraftMenu.ENTRY_REPAIR_WEAPON or n==CraftMenu.ENTRY_REPAIR_ACCESSORY then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_REPAIR)
        end
      end},
      {msg="CraftMenuOnCursor",func=function(n,t)
        if n==StrCode32"RCP_EQP_SWP_Flag"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_FLAG)
        elseif n==StrCode32"RCP_EQP_SWP_CampSet"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CAMPSET)
        elseif n==StrCode32"RCP_EQP_SWP_WaterPump"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_WATERPUMP)
        elseif n==StrCode32"RCP_IT_CureSpray"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CURESPARY)
        elseif n==StrCode32"RCP_SVE_Fulton"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_WORMHOLE)
        elseif n==StrCode32"RCP_BL_ARW_Flame"or n==StrCode32"RCP_EQP_WP_StunRod_A"then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_ATTRIBUTE)
        elseif t==true then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_JUNK)
        end
      end},
      {msg="CustomizeMenuOpened",func=function(n)
        if n==CraftMenu.CUSTOMIZE_GRADEUP then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CUSTOMIZE_ENHANCEMENT)
        elseif n==CraftMenu.CUSTOMIZE_PERK then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CUSTOMIZE_PERK)
        elseif n==CraftMenu.CUSTOMIZE_OPTION then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CUSTOMIZE_OPTIONALPARTS)
        elseif n==CraftMenu.CUSTOMIZE_COLOR then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CUSTOMIZE_COLOR)
        end
      end},
      {msg="CrewDeploymentMenuOpened",func=function()
        instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_CREWDEPLOYMENT)
      end},
      {msg="BaseInformationMenuOpened",func=function()
        instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_BASE_INFORMATION)
      end},
      {msg="FacilityPanelStartOpen",func=function(n,i)
        if n==SsdSbm.FACILITY_TYPE_Bed then
          instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_BED)
        elseif n==SsdSbm.FACILITY_TYPE_PlantFarm then
          instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_PLANTFARM)
        elseif n==SsdSbm.FACILITY_TYPE_AnimalFarm then
          instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_ANIMALFARM)
        elseif n==SsdSbm.FACILITY_TYPE_RadioStation then
          instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_RADIOSTATION)
        elseif n==SsdSbm.FACILITY_TYPE_FoodPlant then
          if Mission.GetDefenseGameState()==TppDefine.DEFENSE_GAME_STATE.NONE then
            local n={pos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ),heavySearch=false,onlyBuilding=true,searchRadius=1.5}
            for i,e in ipairs{"PRD_BLD_Kitchen_D","PRD_BLD_Kitchen_E","PRD_BLD_Kitchen_F","PRD_BLD_Kitchen_G"}do
              n.productionId=e
              local n,i,i=Gimmick.SearchNearestSsdGimmick(n)
              if n then
                SsdRecipe.UnlockRecipeOnAccessCockingFacility(e)
              end
            end
          end
        end
      end},
      {msg="SkillMenuOpened",func=function()
        if instance.IsStartCommonHelpTipsMenu(unkM1Tips1.TIPS_SUBCLASS)then
          local n=TppStory.GetCurrentStorySequence()
          if n>=TppDefine.STORY_SEQUENCE.STORY_FINISH then
            instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_SUBCLASS)
          end
        end
      end},
      {msg="SkillMenuEditAvatarSelected",func=function()
        TppMission.GoToAvatarEditWithSave()
      end},
      {msg="FacilityListMenuOnCursor",func=function(t,n)
        if t==SsdSbm.FACILITY_TYPE_Ai then
          if n==FacilityMenuType.ORDER_LIST then
            instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_ORDER)
          elseif n==FacilityMenuType.BATTLE_PACK then
            instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_OPENING_THE_CASE)
          elseif n==FacilityMenuType.EVENT_LIST then
            instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_BUDO_POINTS)
          end
        end
      end}},
    Terminal={
      {msg="MbTerminalOpened",func=function()
        if instance.IsStartCommonHelpTipsMenu(unkM1Tips1.TIPS_CURE)then
          local e=((Player.DoesHaveInjuryLocal(SsdSbm.INJURY_TYPE_Sprain)or Player.DoesHaveInjuryLocal(SsdSbm.INJURY_TYPE_Bleeding))or Player.DoesHaveInjuryLocal(SsdSbm.INJURY_TYPE_Laceration))or Player.DoesHaveInjuryLocal(SsdSbm.INJURY_TYPE_Bruise)
          if e then
            TppTutorial.StartHelpTipsMenu(unkM1Tips1.TIPS_CURE)
          end
        end
      end}},
    SsdBuilding={
      {msg="OpenMenu",func=function()
        local n=TppStory.GetCurrentStorySequence()
        if n>=TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL then
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_BUILDING_ASSAULT_RAID)
        else
          instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_BUILDING)
        end
      end}},
    Player={
      {msg="OnUiTreasureBox",func=function()
        instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_TREASURE)
      end},
      {msg="OnUiVehicle",func=function()
        instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_VEHICLE)
      end},
      {msg="OnUiWalkerGear",func=function()
        instance.StartCommonHelpTipsMenu(unkM1Tips1.TIPS_WALKERGEAR)
      end},
      {msg="Exit",sender="innerZone",func=function()
        if instance.IsStartCommonHelpTipsMenu(unkM1Tips1.TIPS_OUTSIDE_MISSION_AREA)then
          TppTutorial.StartHelpTipsMenu(unkM1Tips1.TIPS_OUTSIDE_MISSION_AREA)
        else
          TppRadio.Play("f3000_rtrg0150",{delayTime="mid"})
        end
      end}},
    Trap={
      {sender={"trap_water0000","trap_water0001"},msg="Enter",func=function(n,n)
        instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_WATER)
      end,option={isExecFastTravel=true}},
      {sender={"trap_crystal0000","trap_crystal0001","trap_crystal0002","trap_crystal0003"},msg="Enter",func=function(n,n)
        instance.StartCommonHelpTipsMenuOnlyAnnounce(unkM1Tips2.TIPS_CORE)
      end,option={isExecFastTravel=true}}},
    Timer={
      {msg="Finish",sender="WaitCheckPointSaveForUnloadQuest",func=function()
        instance.UnloadQuestBlock()
        instance.UpdateBaseCheckPoint(true)
      end,option={isExecFastTravel=true}}}
  })
  function instance.Messages()
    if instance.messageTable then
      return StrCode32Table(instance.messageTable)
    end
  end
  function instance.UnloadQuestBlock()
    for n,e in ipairs(TppDefine.QUEST_BLOCK_TYPE_DEFINE)do
      if mvars.frm_mobCrewTypeForDemo and e=="quest_block_3"then
      else
        TppQuest.UnloadCurrentQuestBlock(e)
      end
    end
  end
  function instance.OnEnterBaseCheckPoint()
    instance.UnloadQuestBlock()
    instance.OnReturnToBaseOrCamp()
    instance.StartReturnResult(true)
    local e=TppStory.GetCurrentStorySequence()
    if e>=TppDefine.STORY_SEQUENCE.STORY_FINISH then
      this.SetEnemyLevel(e)
    end
    TppEnemy.RespawnAllForEnemyNpcs()SsdMbDvc.ResetOxygenConvertCount()
  end
  function instance.OnReturnToBaseOrCamp()
    SsdBlankMap.UpdateReachInfo()
    SsdBaseDefense.ResetSkipBreakDiggingGameOverFlag()
  end
  function instance.isBaseCheckPointEnabled()
    return(not instance.disableBaseCheckPoint and TppMission.IsBaseCheckPointEnabled())
  end
  function instance.UpdateBaseCheckPoint(n)
    if not instance.isBaseCheckPointEnabled()then
      if n then
        instance.BeforeServerSaveInBase()
      else
        instance.BeforeServerSaveOutBase()
      end
      return
    end
    if n then
      if TppQuest.IsNeedWaitCheckPoint()then
        GkEventTimerManager.Start("WaitCheckPointSaveForUnloadQuest",.1)
        return
      end
    end
    local i=true
    if n then
      local n=instance.checkPointList
      if IsTypeTable(n)then
        for n,e in ipairs(n)do
          if e=="CHK_InBase"then
            i=false
            break
          end
        end
      end
      instance.BeforeServerSaveInBase()
    else
      i=true
      instance.BeforeServerSaveOutBase()
    end
    if i then
      TppMission.UpdateCheckPointAtCurrentPosition()
    else
      TppMission.UpdateCheckPoint{checkPoint="CHK_InBase",ignoreAlert=true}
    end
  end
  function instance.StartReturnResult(n)
    if not instance.isBaseCheckPointEnabled()then
      return
    end
    if not n then
      BaseResultUiSequenceDaemon.Start(BaseResultUiSequenceDaemonType.RETURN)
      return
    end
    local e=function()
      instance.UpdateBaseCheckPoint(true)
    end
    BaseResultUiSequenceDaemon.SetCallBackOnPutAllOfPlayersInventoryInABase(e)
    BaseResultUiSequenceDaemon.Start(BaseResultUiSequenceDaemonType.RETURN)
  end
  function instance.BeforeServerSaveInBase()
    TppQuest.UpdateActiveQuest()
    local e=function()RewardPopupSystem.RequestOpen(RewardPopupSystem.OPEN_TYPE_CHECK_POINT)
    end
    TppSave.AddServerSaveCallbackFunc(e)
  end
  function instance.BeforeServerSaveOutBase()
    TppQuest.UpdateQuestTimeCount()
  end
  function instance.SetMissionGimmickResource(e)
    if IsTypeTable(e)and IsTypeTable(e.treasureTableList)then
      for n,e in pairs(e.treasureTableList)do
        if IsTypeTable(e.treasureBoxResourceTable)then
          for n,e in ipairs(e.treasureBoxResourceTable)do
            Gimmick.SetTreasureBoxResources(e)
            local e={name=e.name,dataSetName=e.dataSetName,validity=false}
            Gimmick.SetResourceValidity(e)
          end
        end
        if IsTypeTable(e.treasurePointResourceTable)then
          for n,e in ipairs(e.treasurePointResourceTable)do
            Gimmick.SetTreasurePointResources(e)
            local e={name=e.name,dataSetName=e.dataSetName,validity=false}
            Gimmick.SetResourceValidity(e)
          end
        end
      end
    end
  end
  function instance.SetStorySequenceTreasurePointValidity(e)
    if IsTypeTable(e)and IsTypeTable(e.treasurePointValidityTableList)then
      local n=TppStory.GetCurrentStorySequence()
      for i,e in pairs(e.treasurePointValidityTableList)do
        if n>=e.validityStorySequence then
          if e.name and e.dataSetName then
            Gimmick.InvisibleGimmick(e.type,e.name,e.dataSetName,true)
            local e={name=e.name,dataSetName=e.dataSetName,validity=false}
            Gimmick.SetResourceValidity(e)
          end
        end
      end
    end
  end
  function instance.StartCommonHelpTipsMenu(n)
    if instance.IsStartCommonHelpTipsMenu(n)==false then
      return
    end
    TppTutorial.StartHelpTipsMenu(n)
  end
  function instance.StartCommonHelpTipsMenuOnlyAnnounce(n)
    if instance.IsCommonHelpTipsPageOpenedOnlyAnnounce(n)==true then
      return
    end
    TppTutorial.StartHelpTipsMenuOnlyAnnounce(n)
  end
  function instance.IsCommonHelpTipsPageOpenedOnlyAnnounce(e)
    if not IsTypeTable(e)then
      return true
    end
    local e=e.tipsTypes[1]
    if not IsTypeNumber(e)then
      return true
    end
    local e=HelpTipsMenuSystem.IsPageOpened(e)
    return e
  end
  function instance.IsCommonHelpTipsPageOpened(e)
    if not IsTypeTable(e)then
      return true
    end
    local e=e.tipsTypes[1]
    local e=e[1]
    if not IsTypeNumber(e)then
      return true
    end
    local e=HelpTipsMenuSystem.IsPageOpened(e)
    return e
  end
  function instance.IsStartCommonHelpTipsMenu(n)
    if not IsTypeTable(n)then
      return false
    end
    local i=TppStory.GetCurrentStorySequence()
    if i<TppDefine.STORY_SEQUENCE.BEFORE_k40040 then
      return false
    end
    if instance.IsCommonHelpTipsPageOpened(n)==true then
      return false
    end
    if TppTutorial.IsHelpTipsMenu()then
      return false
    end
    if TppRadioCommand.IsPlayingRadio()then
      return false
    end
    return true
  end
  return instance
end
function this.RegisterEnterBaseCheckPointCallback(n,e)
  if Tpp.IsTypeFunc(e)then
    mvars.bms_enterBaseCheckPointCallback=mvars.bms_enterBaseCheckPointCallback or{}
    mvars.bms_enterBaseCheckPointCallback[n]=e
  end
end
function this.UnregisterEnterBaseCheckPointCallback()
  mvars.bms_enterBaseCheckPointCallback=nil
end
function this.ExecuteEnterBaseCheckPointCallback()
  if not mvars.bms_enterBaseCheckPointCallback then
    return
  end
  local e=SsdFlagMission.GetCurrentStepName()
  if not e then
    return
  end
  if mvars.bms_enterBaseCheckPointCallback[e]then
    return mvars.bms_enterBaseCheckPointCallback[e]()
  end
end
function this.SetEnemyLevel(e)
  TppEnemy.SetEnemyLevelBySequence(e)
end
function this.SetRegionEnemyLevel(n,e)
  TppEnemy.SetEnemyLevelByRegion(n,e)
end
return this
