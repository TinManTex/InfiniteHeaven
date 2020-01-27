local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
function this.CreateInstance(missionName)
  local instance=BaseMissionSequence.CreateInstance(missionName)
  instance.NO_RESULT=true
  instance.sequenceList={
    "Seq_Demo_SwitchSequence",
    "Seq_Demo_StorySequenceDemo",
    "Seq_Demo_WaitStorySequenceBlackRadio",
    "Seq_Demo_StorySequenceBlackRadio",
    "Seq_Demo_WaitMainGame",
    "Seq_Demo_WaitLoadingMission",
    "Seq_Game_MainGame"
  }
  instance.AddSaveVarsList{acceptMissionId=0}
  instance.missionObjectiveTree={}

  function instance.AfterMissionPrepare()
    local missionCallbacks={
      OnEstablishMissionClear=function(e)
        TppMission.MissionGameEnd()
      end,
      OnDisappearGameEndAnnounceLog=function(missionClearType)
        Player.SetPause()
        TppMission.ShowMissionReward()
        if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.LOCATION_CHANGE_WITH_FAST_TRAVEL)then
          TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
        end
      end,
      OnEndMissionReward=function()
        TppMission.MissionFinalize{isNoFade=true}
      end,
      OnOutOfMissionArea=function()
        TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)
      end,
      OnGameOver=instance.OnGameOver,OnUpdateStorySequenceInGame=function()
        local bfm_demoScript=mvars.bfm_demoScript
        if bfm_demoScript then
          local nextDemoName=bfm_demoScript.GetNextStorySequenceDemoName()
          if nextDemoName then
            TppScriptBlock.LoadDemoBlock(nextDemoName)
          end
        end
      end,
      OnAlertOutOfDefenseGameArea=function(e)
        SsdFlagMission.ExecuteSystemCallback("OnAlertOutOfDefenseGameArea",e)
      end,
      OnOutOfDefenseGameArea=function(e)
        SsdFlagMission.ExecuteSystemCallback("OnOutOfDefenseGameArea",e)
      end,
      nil
    }--missionCallbacks
    TppMission.RegiserMissionSystemCallback(missionCallbacks)
    TppMission.RegisterWaveList(mvars.loc_locationCommomnWaveSettings.waveList)
    TppMission.RegisterWavePropertyTable(mvars.loc_locationCommomnWaveSettings.propertyTable)
    local orderBoxListModule=_G[tostring(missionName).."_orderBoxList"]
    if orderBoxListModule then
      instance.orderBoxBlockList=orderBoxListModule.orderBoxBlockList
      TppScriptBlock.RegisterCommonBlockPackList("orderBoxBlock",instance.orderBoxBlockList)
    end
    mvars.bfm_sequenceScript=_G[tostring(missionName).."_sequence"]
    mvars.bfm_enemyScript=_G[tostring(missionName).."_enemy"]
    mvars.bfm_demoScript=_G[tostring(missionName).."_demo"]
    mvars.bfm_radioScript=_G[tostring(missionName).."_radio"]
    local bfm_demoScript=mvars.bfm_demoScript
    if IsTypeTable(bfm_demoScript)then
      local nextDemoName=bfm_demoScript.GetNextStorySequenceDemoName()
      if nextDemoName then
        TppScriptBlock.PreloadRequestOnMissionStart{{demo_block=nextDemoName}}
      end
    end
    mvars.bfm_checkLoadNextMission=false
    mvars.bfm_storySequenceBlackRadioSettings={}
  end

  function instance.AfterOnRestoreSVars()
  end

  instance.messageTable=instance.AddMessage(instance.messageTable,{
    UI={
      {msg="FacilityListMenuMoveToAnotherLocationSelected",func=function()
        local nextMissionId
        if TppLocation.IsAfghan()then
          nextMissionId=30020
        elseif TppLocation.IsMiddleAfrica()then
          if(TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.BEFORE_s10050)then
            nextMissionId=10050
          else
            nextMissionId=30010
          end
        end
        if nextMissionId then
          TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.LOCATION_CHANGE_WITH_FAST_TRAVEL,nextMissionId=nextMissionId,isLocationChangeWithFastTravel=true}
        end
      end},
      {msg="EndFadeIn",sender="FadeIn_BFM_Seq_Game_MainGame",func=function()
        instance.StartReturnResult(mvars.bfm_needSaveForMissionStart)
        mvars.bfm_needSaveForMissionStart=false
        RewardPopupSystem.RequestOpen(RewardPopupSystem.OPEN_TYPE_ALL)
        SsdFlagMission.Activate()
      end}},
    Mission={
      {msg="OnBaseDefenseEnd",func=function()
        TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"
      end},
      {msg="OnFlagMissionUnloaded",func=function()
        local bfm_demoScript=mvars.bfm_demoScript
        if bfm_demoScript then
          local nextDemoName=bfm_demoScript.GetNextStorySequenceDemoName()
          if nextDemoName then
            TppScriptBlock.LoadDemoBlock(nextDemoName)
          end
        end
        TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"
      end}},
    GameObject={
      {msg="RailPoint",func=function(n,n,railPointMessageS32)
        if railPointMessageS32==StrCode32"Terminal"then
          mvars.bfm_enemyScript.SetEndKaiju()
        end
      end,option={isExecFastTravel=true}}},
    Timer={
      {msg="Finish",sender="TimerKaijuEnable",func=function()
        mvars.bfm_enemyScript.SetStartKaiju()
      end,option={isExecFastTravel=true}}}
  })

  function instance.PlayStorySequenceRadio()
    if instance.radioScript and Tpp.IsTypeFunc(instance.radioScript.PlayStorySequenceRadio)then
      instance.radioScript.PlayStorySequenceRadio()
    end
  end

  function instance.SetObjectiveInfoAtAnotherLocation()
    local objectveInfo=TppStory.GetObjectiveInfoAtAnotherLocation()
    if objectveInfo then
      MissionObjectiveInfoSystem.Clear()
      for i,langId in ipairs(objectveInfo)do
        MissionObjectiveInfoSystem.SetParam{index=i-1,langId=langId}
      end
      MissionObjectiveInfoSystem.Open()
    end
  end

  function instance.SetGuideLinesAtAnotherLocation()
    local guideLineInfo=TppStory.GetGuideLineInfoAtAnotherLocation()
    if guideLineInfo then
      SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=guideLineInfo}
    end
  end

  function instance.SetMarkerAtAnotherLocation()
    local markerInfo=TppStory.GetMarkerInfoAtAnotherLocation()
    if markerInfo then
      local currentStorySequence=TppStory.GetCurrentStorySequence()
      if currentStorySequence==TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL and TppLocation.IsAfghan()then
      else
        if(markerInfo.location and markerInfo.vagueLevel)and markerInfo.pos then
          local handle=SsdMarker.RegisterMarker{type="MISSION_001",flag="ALL_VIEW",vagueLevel=markerInfo.vagueLevel,location=markerInfo.location,pos=markerInfo.pos,enable=true}
          if handle and markerInfo.guidelinesId then
            SsdMarker.RegisterMarkerSubInfo{handle=handle,guidelinesId=markerInfo.guidelinesId}
          end
        end
      end
    end
  end

  function instance.IsFlagMissionAllowedToPlayRadio(o)
    local missionAllowedToPlayRadioTable=instance.missionAllowedToPlayRadioTable
    if IsTypeTable(missionAllowedToPlayRadioTable)then
      return instance.missionAllowedToPlayRadioTable[o]
    end
  end

  function instance.LoadNextMission()
    if SsdFlagMission.GetCurrentFlagMissionName()then
      return false
    end
    local nextMissionInfo=TppStory.GetNextMissionInfo()
    if not nextMissionInfo then
      return false
    end
    if not next(nextMissionInfo)then
      return false
    end
    local missionName=nextMissionInfo.missionName
    local missionCodeStr=string.sub(missionName,-5)
    local missionType=nextMissionInfo.missionType
    local locationName=SsdMissionList.LOCATION_BY_MISSION_CODE[missionCodeStr]
    if not locationName or locationName~=TppLocation.GetLocationName()then
      if missionType==Fox.StrCode32"FLAG"or missionType==Fox.StrCode32"STORY"then
        MissionListMenuSystem.SetCurrentMissionCode(tonumber(missionCodeStr))
      end
      return false
    end
    if missionType==Fox.StrCode32"FLAG"then
      if Tpp.IsQARelease()or nil then
        if tpp_editor_menu2.reentryTable and tpp_editor_menu2.reentryTable.flagStepNumber then
          gvars.fms_currentFlagStepNumber=tpp_editor_menu2.reentryTable.flagStepNumber
          tpp_editor_menu2.reentryTable.flagStepNumber=nil
          SsdFlagMission.LoadMission(missionName)
          return true
        end
      end
      SsdFlagMission.SelectAndLoadMission(missionName)
      return true
    elseif missionType==Fox.StrCode32"STORY"then
      local missionCode=tonumber(missionCodeStr)
      TppMission.AcceptMissionOnFreeMission(missionCode,instance.orderBoxBlockList,"acceptMissionId")
      return true
    end
    return false
  end

  function instance.ShouldReturnSwitchSequence()
    if mvars.bfm_checkLoadNextMission then
      return false
    end
    local currentFlagMissionName=SsdFlagMission.GetCurrentFlagMissionName()
    if currentFlagMissionName then
      local nextMissionInfo=TppStory.GetNextMissionInfo()
      if not nextMissionInfo then
        return true
      end
      if not next(nextMissionInfo)then
        return true
      end
      local missionName=nextMissionInfo.missionName
      if currentFlagMissionName==missionName then
        return false
      end
    end
    return true
  end

  instance.sequences.Seq_Demo_SwitchSequence={
    OnEnter=function(e)
      local bfm_demoScript=mvars.bfm_demoScript
      if IsTypeTable(bfm_demoScript)then
        local demoName=bfm_demoScript.GetCurrentStorySequenceDemoName()
        if IsTypeString(demoName)then
          TppSequence.SetNextSequence"Seq_Demo_StorySequenceDemo"return
        end
      end
      local bfm_radioScript=mvars.bfm_radioScript
      if IsTypeTable(bfm_radioScript)then
        local radioSettings=bfm_radioScript.GetCurrentStorySequenceBlackRadioSettings()
        if IsTypeTable(radioSettings)then
          mvars.bfm_storySequenceBlackRadioSettings=radioSettings
          TppSequence.SetNextSequence"Seq_Demo_WaitStorySequenceBlackRadio"
          return
        end
      end
      local currentStorySequenceTable=TppStory.GetCurrentStorySequenceTable()
      if IsTypeTable(currentStorySequenceTable)then
        if currentStorySequenceTable.reload then
          gvars.sav_needCheckPointSaveOnMissionStart=true
          TppMission.Reload()
          return
        end
      end
      TppSequence.SetNextSequence"Seq_Demo_WaitMainGame"
    end,

    OnLeave=function(n)
      instance.LockAndUnlockUI()
    end}

  instance.sequences.Seq_Demo_StorySequenceDemo={
    OnEnter=function(e)
      local bfm_demoScript=mvars.bfm_demoScript
      if IsTypeTable(bfm_demoScript)then
        local demoName=bfm_demoScript.GetCurrentStorySequenceDemoName()
        if IsTypeString(demoName)then
          TppDemo.Play(demoName,{
            onStart=function()
              TppSoundDaemon.ResetMute"Loading"
            end,
            onEnd=function()
              if not mvars.bfm_storySequenceDemoFinished then
                mvars.bfm_storySequenceDemoFinished={}
              end
              mvars.bfm_storySequenceDemoFinished[TppStory.GetCurrentStorySequence()]=true
              TppPlayer.ResetAroundCameraRotation()
              TppStory.UpdateStorySequence{updateTiming="OnStorySequenceDemoFinished"}
              TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"
            end},
          {isSnakeOnly=false,useDemoBlock=true,finishFadeOut=true})
          return
        end
      end
      TppSequence.SetNextSequence"Seq_Demo_WaitMainGame"
    end,
    OnLeave=function(e)
      TppMission.UpdateCheckPointAtCurrentPosition()
    end}

  instance.sequences.Seq_Demo_WaitStorySequenceBlackRadio={
    OnEnter=function(e)
      local bfm_storySequenceBlackRadioSettings=mvars.bfm_storySequenceBlackRadioSettings
      if not IsTypeTable(bfm_storySequenceBlackRadioSettings)then
        e.EndBlackRadio()
        return
      end
      if not next(bfm_storySequenceBlackRadioSettings)then
        e.EndBlackRadio()
        return
      end
      local n=bfm_storySequenceBlackRadioSettings[1]
      if not IsTypeString(n)then
        e.EndBlackRadio()
        return
      end
      table.remove(mvars.bfm_storySequenceBlackRadioSettings,1)
      BlackRadio.Close()
      BlackRadio.ReadJsonParameter(n)
      TppSequence.SetNextSequence"Seq_Demo_StorySequenceBlackRadio"
    end,
    EndBlackRadio=function()
      if not mvars.bfm_storySequenceBlackRadioFinished then
        mvars.bfm_storySequenceBlackRadioFinished={}
      end
      TppSoundDaemon.SetKeepBlackRadioEnable(false)
      mvars.bfm_storySequenceBlackRadioFinished[TppStory.GetCurrentStorySequence()]=true
      TppStory.UpdateStorySequence{updateTiming="OnStorySequenceBlackRadioFinished"}
      TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"
    end
  }
  instance.sequences.Seq_Demo_StorySequenceBlackRadio={
    Messages=function(e)
      return StrCode32Table{
        UI={
          {msg="BlackRadioClosed",
            func=function(e)
              TppSequence.SetNextSequence"Seq_Demo_WaitStorySequenceBlackRadio"
            end,
            option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}
          }}}
    end,
    OnEnter=function(e)
      TppSoundDaemon.SetKeepBlackRadioEnable(true)
      TppRadio.StartBlackRadio()
    end,
    OnLeave=function(e)
      TppMission.UpdateCheckPointAtCurrentPosition()
    end}
  instance.sequences.Seq_Demo_WaitMainGame={
    OnEnter=function(e)
      if not TppSave.IsSaving()then
        TppSequence.SetNextSequence"Seq_Demo_WaitLoadingMission"
      end
    end,
    OnUpdate=function(e)
      if not TppSave.IsSaving()then
        TppSequence.SetNextSequence"Seq_Demo_WaitLoadingMission"
      end
    end}

  instance.sequences.Seq_Demo_WaitLoadingMission={
    OnEnter=function(n)
      TppMission.EnableInGameFlag()
      mvars.bfm_checkLoadNextMission=true
      mvars.bfm_missionLoadedAutomatically=instance.LoadNextMission()
      if not mvars.bfm_missionLoadedAutomatically then
        TppSequence.SetNextSequence"Seq_Game_MainGame"
        SsdUiSystem.MissionSystemDidStart()
      end
    end,
    OnUpdate=function(e)
      if SsdFlagMission.IsLoaded()then
        TppSequence.SetNextSequence"Seq_Game_MainGame"
      end
    end}

  instance.sequences.Seq_Game_MainGame={
    OnEnterCommon=function(n)
      if instance.ShouldReturnSwitchSequence()then
        TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"
        return
      end
      mvars.bfm_checkLoadNextMission=true
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeIn_BFM_Seq_Game_MainGame",TppUI.FADE_PRIORITY.MISSION)
      TppSoundDaemon.ResetMute"Loading"
      local bfm_missionLoadedAutomatically=mvars.bfm_missionLoadedAutomatically
      if gvars.fms_currentFlagMissionCode==0 and not bfm_missionLoadedAutomatically then
        instance.PlayStorySequenceRadio()
        instance.SetObjectiveInfoAtAnotherLocation()
        instance.SetGuideLinesAtAnotherLocation()
        instance.SetMarkerAtAnotherLocation()
      end
      TppQuest.UpdateActiveQuest()
    end,
    OnEnter=function(e)
      e.OnEnterCommon(e)
    end,
    Messages=function(e)
      if e.messageTable then
        return StrCode32Table(e.messageTable)
      end
    end,
    OnLeaveCommon=function(e)
    end,
    OnLeave=function(e)
      e.OnLeaveCommon(e)
    end}

  return instance
end
return this
