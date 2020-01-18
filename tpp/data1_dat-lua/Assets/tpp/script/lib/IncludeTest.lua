-- DOBUILD: 0
local this={}

  --local debugSplash=SplashScreen.Create("ooop","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)--tex ghetto as 'does it run?' indicator
  --SplashScreen.Show(InfMain.debugSplash,0,0.3,0)--tex eagle DEBUG
  
function this.ReservePlayerLoadingPositionNew(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  this.DisableGameStatus()
  if missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    local hasHeliRoute=gvars.heli_missionStartRoute~=0
    local isStartOnFoot=false
    local setFromHeliStartPosition=false
    
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    TppPlayer.ResetNoOrderBoxMissionStartPosition()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    gvars.ply_initialPlayerState=0
  
    if nextIsHeliSpace then
      TppHelicopter.ResetMissionStartHelicopterRoute()
    elseif isHeliSpace then    
      if hasHeliRoute then
        setFromHeliStartPosition=true
      else
        isStartOnFoot=true
        local noHeliMissionStartPos=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if noHeliMissionStartPos then
          TppPlayer.SetInitialPosition(noHeliMissionStartPos,0)
          TppPlayer.SetMissionStartPosition(noHeliMissionStartPos,0)
        end
      end
      TppMission.SetIsStartFromHelispace()
    elseif nextIsFreeMission then    
      if TppLocation.IsMotherBase()then
      else
        isStartOnFoot=true
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      --TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
      if TppMission.GetMissionClearType()==TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR then
        setFromHeliStartPosition=true
        TppMission.SetIsStartFromHelispace()
      end
    elseif(isFreeMission and TppLocation.IsMotherBase())then
      TppMission.SetIsStartFromHelispace()
    else
      if isFreeMission then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
        else
          local noBoxMissionStartPos={
          [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
          [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
          [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
          [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
          [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
          [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
          [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
          }
          noBoxMissionStartPos[11050]=noBoxMissionStartPos[10050]
          noBoxMissionStartPos[11080]=noBoxMissionStartPos[10080]
          noBoxMissionStartPos[11140]=noBoxMissionStartPos[10140]
          noBoxMissionStartPos[10151]=noBoxMissionStartPos[10150]
          noBoxMissionStartPos[11151]=noBoxMissionStartPos[10150]
          local posrot=noBoxMissionStartPos[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and posrot then
            TppPlayer.SetNoOrderBoxMissionStartPosition(posrot,posrot[4])
          end
        end
        local noOrderFixHeliRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if noOrderFixHeliRoute then
          TppMission.SetIsStartFromHelispace()
        else
          isStartOnFoot=true
          TppMission.SetIsStartFromFreePlay()
        end
        
        local missionClearType=TppMission.GetMissionClearType()
        --TppQuest.SpecialMissionStartSetting(missionClearType)
        if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END)then
          isStartOnFoot=true
          TppPlayer.SetNoOrderBoxMissionStartPosition({-1868.27,343.22,-84.6095},160.651)
          TppMission.SetIsStartFromFreePlay()
        elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END)then
          gvars.heli_missionStartRoute=Fox.StrCode32"drp_s10260"
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
        elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END)then
          isStartOnFoot=true
          TppPlayer.SetNoOrderBoxMissionStartPosition({-855.6097,515.6722,-1250.411},160.651)
          TppMission.SetIsStartFromFreePlay()
        end
      end
    end
    
    if not nextIsHeliSpace then
      if isStartOnFoot then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)   
      else
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
      end
      if setFromHeliStartPosition then
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
        end
      end
    end
    
    
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if abortWithSave then
      if nextIsFreeMission then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif nextIsHeliSpace then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if nextIsHeliSpace then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif nextIsFreeMission then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if isHeliSpace and isLocationChange then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end
  

return this