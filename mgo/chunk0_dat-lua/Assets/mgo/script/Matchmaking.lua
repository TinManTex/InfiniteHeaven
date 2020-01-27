-- Matchmaking.lua
local this={}
function this.OnMatchmakeSuccess()
  MGOSoundtrack2.Stop()
end
function this.OnMatchmakeError()
end
function this.OnMatchStart(isGameplayHost,rulesetId,locationCode,isNight)
  if isGameplayHost then
    vars.isGameplayHost=1
  else
    vars.isGameplayHost=0
  end
  vars.locationCode=locationCode
  vars.missionCode=6
  vars.rulesetId=rulesetId
  vars.isNight=isNight
  Mission.LoadMission{force=true}
  Mission.LoadLocation()
  if isGameplayHost then
  else
    DemoDaemon.StopAll()
  end
  TppNetworkUtil.StartNetSynchronizer()
end
function this.OnExit()
end
function this.OnReturnToFreeplay()
  vars.isGameplayHost=1
  vars.locationCode=101
  vars.missionCode=6
  vars.rulesetId=4
  Mission.LoadMission{force=true}
  Mission.LoadLocation()
end
function this.OnStartTransition()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,nil,nil,{setMute=true})
end
function this.OnUnloadMission()
  Util.ClearIntervalAll()
  TppMain.EnableBlackLoading(true)
  vars.isGameplayHost=0
  vars.missionCode=65535
  vars.locationCode=65535
  Mission.LoadMission()
  Mission.LoadLocation{force=true}
end
function this.OnGotoTpp()
  Mission.SwitchApplication"tpp"end
return this
