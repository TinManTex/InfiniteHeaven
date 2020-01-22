local n={}
function n.OnMatchmakeSuccess()
TppUiCommand.EnableTipsGroup("fre",false)
TppUiCommand.EnableTipsGroup("gam",true)
TppUiCommand.UpdateTips()
TppUiCommand.SeekTips"mgo_tips_gam_001"TppUiCommand.UpdateTips()MGOSoundtrack2.Stop()
end
function n.OnMatchmakeError()
end
function n.OnMatchStart(n,o,i,a)
if n then
vars.isGameplayHost=1
else
vars.isGameplayHost=0
end
vars.locationCode=i
vars.missionCode=6
vars.rulesetId=o
vars.isNight=a
Mission.LoadMission{force=true}Mission.LoadLocation()
if n then
else
DemoDaemon.StopAll()
end
TppNetworkUtil.StartNetSynchronizer()
end
function n.OnExit()
TppUiCommand.EnableTipsGroup("fre",true)
TppUiCommand.EnableTipsGroup("gam",false)
TppUiCommand.UpdateTips()
TppUiCommand.SeekTips"mgo_tips_fre_001"TppUiCommand.UpdateTips()
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
