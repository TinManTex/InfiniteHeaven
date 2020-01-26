local n={}
function n.OnMatchmakeSuccess()MGOSoundtrack2.Stop()
end
function n.OnMatchmakeError()
end
function n.OnMatchStart(n,i,o,s)
if n then
vars.isGameplayHost=1
else
vars.isGameplayHost=0
end
vars.locationCode=o
vars.missionCode=6
vars.rulesetId=i
vars.isNight=s
Mission.LoadMission{force=true}Mission.LoadLocation()
if n then
else
DemoDaemon.StopAll()
end
TppNetworkUtil.StartNetSynchronizer()
end
function n.OnExit()
end
function n.OnReturnToFreeplay()
vars.isGameplayHost=1
vars.locationCode=101
vars.missionCode=6
vars.rulesetId=4
Mission.LoadMission{force=true}Mission.LoadLocation()
end
function n.OnStartTransition()
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,nil,nil,{setMute=true})
end
function n.OnUnloadMission()Util.ClearIntervalAll()
TppMain.EnableBlackLoading(true)
vars.isGameplayHost=0
vars.missionCode=65535
vars.locationCode=65535
Mission.LoadMission()Mission.LoadLocation{force=true}
end
function n.OnGotoTpp()Mission.SwitchApplication"tpp"end
return n
