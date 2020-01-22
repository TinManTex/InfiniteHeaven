local TppUIInit=TppUI.Init
function TppUI.Init()
  TppUIInit()
  if TppUiCommand.IsTppUiReady()then
    if vars.rulesetId==4 then
      TppUiCommand.RegisterPauseMenuPage{GamePauseMenu.OPEN_OPTION_MENU,GamePauseMenu.GOTO_TPP}
    elseif not MgoMatchMakingManager.IsQuickmatch()then
      if("Xbox360"==Fox.GetPlatformName())then
        TppUiCommand.RegisterPauseMenuPage{GamePauseMenu.OPEN_OPTION_MENU,GamePauseMenu.INVITE_MENU,GamePauseMenu.INVITE_PARTY_MENU,GamePauseMenu.EXIT_MATCH}
      else
        TppUiCommand.RegisterPauseMenuPage{GamePauseMenu.OPEN_OPTION_MENU,GamePauseMenu.INVITE_MENU,GamePauseMenu.EXIT_MATCH}
      end
    else
      TppUiCommand.RegisterPauseMenuPage{GamePauseMenu.OPEN_OPTION_MENU,GamePauseMenu.EXIT_MATCH}
    end
  end
end
function TppPlayer.MakeFultonRecoverSucceedRatio(n,e,n,n,n,n)
  Player.SetFultonIconPercentage{percentage=100,targetId=e}
end
function TppMission.OnPlayerFultoned()
end
function TppMission.OnPlayerDead(e,e)
end
function TppVarInit.StartTitle(e)
  vars.rulesetId=4
  vars.locationCode=101
  vars.missionCode=6
  TppMission.ResetNeedWaitMissionInitialize()
  gvars.ini_isTitleMode=true
  gvars.ini_isReturnToTitle=false
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  vars.initialPlayerAction=PlayerInitialAction.STAND
  TppPlayer.ResetDisableAction()
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
  TppMission.ResetIsStartFromHelispace()
  TppMission.ResetIsStartFromFreePlay()
  TppMission.VarResetOnNewMission()
  if clock then
    TppClock.SetTime(clock)
    TppClock.SaveMissionStartClock()
  end
  TppSimpleGameSequenceSystem.Start()
  TppMission.Load(vars.missionCode,currentMissionCode)
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"
  end
end
function TppTerminal.AddStaffsFromTempBuffer(e)
end
local TppMissionInit=TppMission.Init
function TppMission.Init()
  TppMissionInit()
  mvars.mis_isAlertOutOfMissionArea=false
end
function TppMission.MgoCheckAlertArea()
  local e=MpRulesetManager.GetActiveRuleset()
  local e=e.currentState
  if not((e=="RULESET_STATE_ROUND_REGULAR_PLAY"or e=="RULESET_STATE_ROUND_OVERTIME")or e=="RULESET_STATE_ROUND_SUDDEN_DEATH")then
    TppMission.DisableAlertOutOfMissionArea()
    return false
  end
  if vars.playerLife<=0 then
    TppMission.DisableAlertOutOfMissionArea()
    return false
  end
  return true
end
function TppMission.CheckMissionClearOnOutOfMissionArea()
  TppMission.MgoCheckAlertArea()
  return false
end
function TppMission.EnableAlertOutOfMissionArea()
  if TppMission.MgoCheckAlertArea()then
  end
end
local TppSaveCheckSlotVersion=TppSave.CheckSlotVersion
function TppSave.CheckSlotVersion(e,s,i)
  if e==TppDefine.CATEGORY_MISSION_RESTARTABLE and TppDefine.CATEGORY_MISSION_RESTARTABLE==TppScriptVars.CATEGORY_MGO then
    return TppDefine.SAVE_FILE_LOAD_RESULT.OK
  else
    return TppSaveCheckSlotVersion(e,s,i)
  end
end
function TppPlayer._SetWeapons(e,e)
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    return
  end
end
function TppPlayer.RestorePlayerWeaponsOnMissionStart()
  if not vars.initWeapons then
    return
  end
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]
  vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]
  vars.handEquip=vars.initHandEquip
  for e=0,3 do
    vars.supportWeapons[e]=vars.initSupportWeapons[e]
  end
end
function TppMission._CreateMissionName(e)
  return nil
end
function TppDemo.IsNotPlayable()
  return false
end
return{}
