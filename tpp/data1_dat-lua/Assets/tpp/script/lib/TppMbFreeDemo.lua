local e={}
local t=Fox.StrCode32
local t=Tpp.StrCode32Table
local O=2
local b="/Assets/tpp/pack/mission2/free/f30050/f30050_mbQuiet.fpk"local c="/Assets/tpp/pack/mission2/free/f30050/f30050_Buddy.fpk"e.demoList={EntrustDdog="p51_010010",DdogComeToGet="p51_010020_000_final",DdogGoWithMe="p51_010030",LongTimeNoSee_DDSoldier="p51_010060_000_final",LongTimeNoSee_DdogPup="p51_010050_000_final",LongTimeNoSee_DdogLowLikability="p51_010053_000_final",LongTimeNoSee_DdogHighLikability="p51_010057_000_final",LongTimeNoSee_DdogSuperHighLikability="p51_010059_000_final",AttackedFromOtherPlayer_KnowWhereFrom="p51_010150_000_final",AttackedFromOtherPlayer_UnknowWhereFrom="p51_010150_001_final",MoraleOfMBIsLow="p51_010040_000_final",OcelotIsPupilOfSnake="p51_010350_000_final",HappyBirthDay="p51_010270_000",HappyBirthDayWithQuiet="p51_010270_001",QuietOnHeliInRain="p51_010300_000_final",QuietHasFriendshipWithChild="p51_010310_000",QuietWishGoMission="p51_010330_000_final",QuietReceivesPersecution="p51_010360_000",SnakeHasBadSmell_WithoutQuiet="p51_010160_000_final",SnakeHasBadSmell_000="p51_010165_000_final",SnakeHasBadSmell_001="p51_010165_001_final",EliLookSnake="p51_010220_000_final",LiquidAndChildSoldier="p51_010340_000_final",InterrogateQuiet="p51_010210",AnableDevBattleGear="p51_010140_000_final",DevelopedBattleGear1="p51_010145_001",DevelopedBattleGear2="p51_010145_002",DevelopedBattleGear4="p51_010145_004",DevelopedBattleGear5="p51_010145_005",CodeTalkerSunBath="p51_010170_000_final",ParasiticWormCarrierKill="p51_070010_000_final",GoToMotherBaseAfterQuietBattle="p31_030210",ArrivedMotherBaseAfterQuietBattle="p31_030220_000_final",ArrivedMotherBaseLiquid="p41_010050_000_final",ArrivedMotherBaseFromDeathFactory="p41_040200_000_final",ArrivedMotherBaseChildren="p41_020050_000_final",NuclearEliminationCeremony="p51_020010_000_final",DetailsNuclearDevelop="p51_020030_01movie",ForKeepNuclearElimination="p51_020020_000_final",SacrificeOfNuclearElimination="p51_020040_000_final",EndingSacrificeOfNuclear="p51_020030_02movie",TheGreatEscapeLiquid="p61_010030_000_final",VisitQuiet="p31_030020_001_final",DecisionHuey="p31_060030_000_final",PazPhantomPain1="p51_080010_000_final",PazPhantomPain2="p51_080020",PazPhantomPain4="p51_080040",PazPhantomPain4_jp="p51_080041",LiquidQuest="p51_010550_000_final"}
e.demoBlockList={EntrustDdog={"/Assets/tpp/pack/mission2/free/f30050/f30050_d070.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},DdogComeToGet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d071.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},DdogGoWithMe={"/Assets/tpp/pack/mission2/free/f30050/f30050_d072.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},LongTimeNoSee_DDSoldier={"/Assets/tpp/pack/mission2/free/f30050/f30050_d001.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},LongTimeNoSee_DdogPup={"/Assets/tpp/pack/mission2/free/f30050/f30050_d073.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},LongTimeNoSee_DdogLowLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d074.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},LongTimeNoSee_DdogHighLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d075.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},LongTimeNoSee_DdogSuperHighLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d076.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},AttackedFromOtherPlayer_KnowWhereFrom={"/Assets/tpp/pack/mission2/free/f30050/f30050_d010.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},AttackedFromOtherPlayer_UnknowWhereFrom={"/Assets/tpp/pack/mission2/free/f30050/f30050_d011.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},MoraleOfMBIsLow={"/Assets/tpp/pack/mission2/free/f30050/f30050_d000.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},OcelotIsPupilOfSnake={"/Assets/tpp/pack/mission2/free/f30050/f30050_d002.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},HappyBirthDay={"/Assets/tpp/pack/mission2/free/f30050/f30050_d030.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},HappyBirthDayWithQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d031.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},QuietOnHeliInRain={"/Assets/tpp/pack/mission2/free/f30050/f30050_d100.fpk"},QuietHasFriendshipWithChild={"/Assets/tpp/pack/mission2/free/f30050/f30050_d040.fpk"},QuietWishGoMission={"/Assets/tpp/pack/mission2/free/f30050/f30050_d050.fpk"},QuietReceivesPersecution={"/Assets/tpp/pack/mission2/free/f30050/f30050_d101.fpk"},SnakeHasBadSmell_WithoutQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d020.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},SnakeHasBadSmell_000={"/Assets/tpp/pack/mission2/free/f30050/f30050_d021.fpk"},SnakeHasBadSmell_001={"/Assets/tpp/pack/mission2/free/f30050/f30050_d022.fpk",b},EliLookSnake={"/Assets/tpp/pack/mission2/free/f30050/f30050_d080.fpk"},LiquidAndChildSoldier={"/Assets/tpp/pack/mission2/free/f30050/f30050_d060.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},InterrogateQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d090.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},AnableDevBattleGear={"/Assets/tpp/pack/mission2/free/f30050/f30050_d120.fpk"},CodeTalkerSunBath={"/Assets/tpp/pack/mission2/free/f30050/f30050_d110.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},ParasiticWormCarrierKill={"/Assets/tpp/pack/mission2/free/f30050/f30050_d700.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},GoToMotherBaseAfterQuietBattle={"/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk"},ArrivedMotherBaseAfterQuietBattle={"/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk"},ArrivedMotherBaseLiquid={"/Assets/tpp/pack/mission2/story/s10120/s10120_d04.fpk"},ArrivedMotherBaseFromDeathFactory={"/Assets/tpp/pack/mission2/story/s10110/s10110_d03.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},ArrivedMotherBaseChildren={"/Assets/tpp/pack/mission2/story/s10100/s10100_d02.fpk"},NuclearEliminationCeremony={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1000.fpk"},DetailsNuclearDevelop={"/Assets/tpp/pack/mission2/free/f30050/f30050_m20030.fpk"},ForKeepNuclearElimination={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1010.fpk"},SacrificeOfNuclearElimination={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1020.fpk"},EndingSacrificeOfNuclear={"/Assets/tpp/pack/mission2/free/f30050/f30050_m20031.fpk"},TheGreatEscapeLiquid={"/Assets/tpp/pack/mission2/free/f30050/f30050_d600.fpk"},DecisionHuey={"/Assets/tpp/pack/mission2/free/f30050/f30050_d300.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},PazPhantomPain1={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8010.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},PazPhantomPain2={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8020.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},PazPhantomPain3={"/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_dEmpty.fpk"},PazPhantomPain4={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8040.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},PazPhantomPain4_jp={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8041.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},Empty={"/Assets/tpp/pack/mission2/free/f30050/f30050_dEmpty.fpk"}}
e._PazPhantomPain4Settings={OnEnter=function()
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
end,OnEnd=function()
TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,"mtbs_q99060")
end,time="17:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"}
e.demoOptions={EntrustDdog={OnEnd=function()
TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET,TppDefine.INIT_ELAPSED_MISSION_COUNT.D_DOG_COME_TO_GET)
TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME,TppDefine.INIT_ELAPSED_MISSION_COUNT.D_DOG_GO_WITH_ME)
end,time="10:20:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},isUseGrassOcelot=true},DdogComeToGet={OnEnd=function()
TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET)
TppBuddyService.SetBuddyPuppyMBDemoPlayed()
end,time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010020_0000"}},enableOcelotDemoEnd=true},DdogGoWithMe={OnEnd=function()
TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
TppBuddyService.SetSortieBuddyType(BuddyType.DOG)
TppEmblem.Add("front63",true)Player.SetPause()
vars.buddyType=BuddyType.DOG
if f30050_sequence then
f30050_sequence.ReserveMissionClear()
end
if mvars.mbDemo_isFirstPlay then
TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_303",rewardType=TppReward.TYPE.COMMON}
end
local e=TppDefine.QUEST_INDEX.Mtbs_child_dog
gvars.qst_questRepopFlag[e]=false
gvars.qst_questClearedFlag[e]=true
TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])
end,isFinishFadeOut=true,heliEnableAfterDemo=true},LongTimeNoSee_DDSoldier={time="14:30:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,OnEnter=function()
local e="/Assets/tpp/level/mission2/free/f30050/f30050_gimmick_target.fox2"local t="mtbs_bord001_vrtn003_gim_n0000|srt_mtbs_bord001_vrtn003"local n="mtbs_bord001_vrtn003_gim_n0001|srt_mtbs_bord001_vrtn003"local o="mtbs_bord001_vrtn003_gim_n0002|srt_mtbs_bord001_vrtn003"local l="mtbs_bord001_vrtn003_gim_n0003|srt_mtbs_bord001_vrtn003"Gimmick.InvisibleGimmick(-1,t,e,true)Gimmick.InvisibleGimmick(-1,n,e,true)Gimmick.InvisibleGimmick(-1,o,e,true)Gimmick.InvisibleGimmick(-1,l,e,true)
gvars.elapsedTimeSinceLastPlay=0
end,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},enableOcelotDemoEnd=true,demoSoldierLocator={},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005"},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003"}},LongTimeNoSee_DdogPup={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,OnEnd=function()
TppBuddyService.SetBuddyPuppyMBDemoPlayed()
gvars.elapsedTimeSinceLastPlay=0
end,heliEnableAfterDemo=true,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0000"}},isUseGrassOcelot=true,enableOcelotDemoEnd=true},LongTimeNoSee_DdogLowLikability={time="12:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,OnEnd=function()
gvars.elapsedTimeSinceLastPlay=0
end,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},LongTimeNoSee_DdogHighLikability={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,OnEnd=function()
gvars.elapsedTimeSinceLastPlay=0
end,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},LongTimeNoSee_DdogSuperHighLikability={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,OnEnd=function()
gvars.elapsedTimeSinceLastPlay=0
end,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},AttackedFromOtherPlayer_KnowWhereFrom={time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,OnEnd=function()
TppUiCommand.RequestMbDvcOpenCondition{isDisableTutorial=true}Player.RequestToOpenMBTerminal()
end,heliEnableAfterDemo=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003"},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000"},forceBalaclavaLocator={}},AttackedFromOtherPlayer_UnknowWhereFrom={time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,OnEnd=function()
TppUiCommand.RequestMbDvcOpenCondition{isDisableTutorial=true}Player.RequestToOpenMBTerminal()
end,heliEnableAfterDemo=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003"},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000"},forceBalaclavaLocator={}},MoraleOfMBIsLow={time="20:00:00",weather=TppDefine.WEATHER.RAINY,heliEnableAfterDemo=true,OnEnter=function()
TppPlayer.Refresh()
TppMotherBaseManagement.IncrementAllStaffMorale{morale=1}
end,telopLangIdList={"area_demo_mb","platform_main"},demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010040_0002"}},enableOcelotDemoEnd=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000"},forceMaleLocator={},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000"}},OcelotIsPupilOfSnake={time="13:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0000"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0002"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0004"}},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},enableOcelotDemoEnd=true},HappyBirthDay={GetNextDemoNameOrNil=function()
local n=TppStory.IsMissionCleard(10086)
local e=TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)
local l=not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
local t=not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)
if((n and e)and l)and t then
return"HappyBirthDayWithQuiet"end
return nil
end,OnEnd=function()
gvars.isPlayedHappyBirthDayToday=true
end,time="18:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"birthday","area_demo_mb","platform_main"}},HappyBirthDayWithQuiet={time="19:00:00",weather=TppDefine.WEATHER.SUNNY,OnEnter=function()
local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))Gimmick.PauseSharedAnim(e,t,true,0)
end,OnEnd=function()
local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))Gimmick.PauseSharedAnim(e,t,false)
end},QuietOnHeliInRain={weather=TppDefine.WEATHER.RAINY,time="12:00:00",OnEnter=function()
local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))Gimmick.PauseSharedAnim(e,t,true,0)
end,OnEnd=function()
local t="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"local e="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))Gimmick.PauseSharedAnim(t,e,false)Player.OnPlayerRefresh()
end},QuietHasFriendshipWithChild={plntName="plnt1",clusterName="Medical",time="19:00:00",weather=TppDefine.WEATHER.SUNNY,isFinishFadeOut=true,OnPrevPlayRequest=function()svars.isCollect_Injury=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Injury]svars.isCollect_YellowHood=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]svars.isCollect_Aflo=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Aflo]svars.isCollect_ShortAflo=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]svars.isCollect_BlackCoat=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
end,OnEnd=function()
TppBuddyService.QuietHospitalized()
local t={8.647,.8,-28.748}
local e=-25
t,e=mtbs_cluster.GetPosAndRotY("Medical","plnt0",t,e)
TppPlayer.Warp{pos=t,rotY=e}
TppPlayer.SetInitialPosition(t,e)
mvars.f30050_isOverwriteDemoEndPos=true
Player.RequestToSetCameraRotation{rotX=0,rotY=e}
end,telopLangIdList={"area_demo_mb","platform_medical"}},QuietWishGoMission={OnEnd=function()
TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION)
TppCassette.Acquire{cassetteList={"tp_c_00000_13"},isShowAnnounceLog=true}
TppCassette.Acquire{cassetteList={"tp_m_10050_03"},isShowAnnounceLog=true}Player.SetPause()
if f30050_sequence then
f30050_sequence.ReserveMissionClear()
end
end,isFinishFadeOut=true,heliEnableAfterDemo=true,demoSoldierLocator={},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005"},forceBalaclavaLocator={}},QuietReceivesPersecution={time="13:00:00",weather=TppDefine.WEATHER.SUNNY,OnEnter=function()
TppPlayer.Refresh()
end,OnEnd=function()
local t={8.647,.8,-28.748}
local e=-25
t,e=mtbs_cluster.GetPosAndRotY("Medical","plnt0",t,e)
TppPlayer.Warp{pos=t,rotY=e}Player.RequestToSetCameraRotation{rotX=0,rotY=e}
TppPlayer.SetInitialPosition(t,e)
mvars.f30050_isOverwriteDemoEndPos=true
mtbs_enemy.OnDeactivateDemoBlock(mtbs_cluster.GetCurrentClusterId())svars.isPlayedAfterDeathFactory=true
end,telopLangIdList={"area_demo_mb","platform_main"},demoSoldierLocator={},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004"},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004"},isFinishFadeOut=true},SnakeHasBadSmell_WithoutQuiet={time="20:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,OnEnd=function()Player.OnPlayerRefresh()
end,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0000"}},enableOcelotDemoEnd=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},loadBuddyBlock=true},SnakeHasBadSmell_000={GetNextDemoNameOrNil=function()
return"SnakeHasBadSmell_001"end,time="20:00:00",weather=TppDefine.WEATHER.CLOUDY,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},isVisibleCurrentBudy=true},SnakeHasBadSmell_001={clusterName="Medical",weather=TppDefine.WEATHER.CLOUDY,time="20:00:00",OnEnd=function()Player.OnPlayerRefresh()
end,demoSoldierLocator={},forceMaleLocator={"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0000","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0003","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0001"},forceBalaclavaLocator={"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0000","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0003"}},EliLookSnake={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,isVisibleCurrentBudy=true,telopLangIdList={"area_demo_mb","platform_main"},demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0001"}},loadBuddyBlock=true,disableBuddyAfterDemo=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003"},forceMaleLocator={},forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001"}},LiquidAndChildSoldier={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0001"},{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0000"}},enableOcelotDemoEnd=true,demoSoldierLocator={},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001"},forceBalaclavaLocator={}},InterrogateQuiet={weather=TppDefine.WEATHER.SUNNY,time="00:00:00",OnEnter=function()
TppPlayer.Refresh()
end,OnEnd=function()
TppPlayer.SetInitialPosition({10.762,0,-6.521},90)
mvars.f30050_isOverwriteDemoEndPos=true
TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3015,pushReward=true}
end,telopLangIdList={"area_demo_mb","area_demo_room101"},isShowReward=true},AnableDevBattleGear={weather=TppDefine.WEATHER.SUNNY,time="00:00:00",isShowReward=true,OnEnter=function()
TppPlayer.Refresh()
end,OnEnd=function()
vars.mbmBipedalismWeaponDevelopmentSkill=1
if f30050_sequence then
local e={pos={-30,-7.4,6.35},rotY=-90}
TppPlayer.Warp(e)
TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_114",rewardType=TppReward.TYPE.COMMON}f30050_sequence.EnableBattleHangerMarker()
end
end,telopLangIdList={"area_demo_mb","area_demo_room101"}},DevelopedBattleGear1={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,OnEnter=function()
local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,true)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_190602_103","btg01_demo_hide_group",false,false)
end,OnEnd=function()
local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,false)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_190602_103","btg01_demo_hide_group",true,false)
end,telopLangIdList={"area_demo_mb","area_demo_battle_gear"}},DevelopedBattleGear2={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,OnEnter=function()
local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_191810_465","btg02_demo_hide_group",false,false)
end,OnEnd=function()
local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,false)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_191810_465","btg02_demo_hide_group",true,false)
end},DevelopedBattleGear4={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,OnEnter=function()
local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_192737_376","btg04_demo_hide_group",false,false)
end,OnEnd=function()
local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,false)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_192737_376","btg04_demo_hide_group",true,false)
end},DevelopedBattleGear5={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,OnEnter=function()
local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_193056_215","btg05_demo_hide_group",false,false)
end,OnEnd=function()
local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,false)
TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_193056_215","btg05_demo_hide_group",true,false)
end,telopLangIdList={"area_demo_mb","area_demo_battle_gear"}},CodeTalkerSunBath={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true},ParasiticWormCarrierKill={time="07:00:00",weather=TppDefine.WEATHER.CLOUDY,OnEnd=function()
TppStory.MissionOpen(10240)
TppUI.ShowAnnounceLog"missionListUpdate"TppUI.ShowAnnounceLog"missionAdd"if f30050_sequence then
f30050_sequence.ReserveMissionClear()
end
end,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"}},GoToMotherBaseAfterQuietBattle={noHeli=true,outOfCluster=true,GetNextDemoNameOrNil=function()
return"ArrivedMotherBaseAfterQuietBattle"end,weather=TppDefine.WEATHER.SUNNY,time="14:30:00",enableWaitBlockLoadOnDemoSkip=false,OnEnter=function()
TppEffectUtility.SetOceanBaseHeight(-27)
TppEffectUtility.SetOceanProjectionScale(64)
TppEffectUtility.SetOceanBlendEnd(384)
TppEffectUtility.SetOceanFarProjectionAmplitude(0)
TppEffectUtility.SetOceanSpecularIntensity(0)
TppEffectUtility.SetOceanVelocity(20)
TppEffectUtility.SetOceanDisplacementStrength(.001)
TppEffectUtility.SetOceanWaveAmplitude(.5)
TppEffectUtility.SetOceanWindDirection(-.04,-.1)
end,OnEnd=function()
TppEffectUtility.RestoreOceanParameters()
end,loadBuddyBlock=true,telopLangIdList={"area_demo_quiet_01","area_demo_quiet_02"}},ArrivedMotherBaseAfterQuietBattle={noHeli=true,OnEnd=function()
gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterQuietBattle]=false
local e=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=TppMotherBaseManagementConst.STAFF_UNIQUE_TYPE_ID_QUIET}
TppMotherBaseManagement.DirectAddStaff{staffId=e}
if f30050_sequence and(not mvars.mbDemo_isFirstPlay)then
f30050_sequence.ReserveMissionClear()
end
end,time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},loadBuddyBlock=true},ArrivedMotherBaseLiquid={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,OnEnd=function()
gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterWhiteMamba]=false
end,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003"}},ArrivedMotherBaseFromDeathFactory={weather=TppDefine.WEATHER.SUNNY,time="18:00:00",heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},OnPrevPlayRequest=function()svars.isCollect_Injury=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_Injury]svars.isCollect_YellowHood=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]svars.isCollect_Aflo=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_Aflo]svars.isCollect_ShortAflo=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]svars.isCollect_BlackCoat=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
end,OnEnd=function()
gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Injury]=svars.isCollect_Injury
gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]=svars.isCollect_YellowHood
gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Aflo]=svars.isCollect_Aflo
gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]=svars.isCollect_ShortAflo
gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]=svars.isCollect_BlackCoat
gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterDethFactory]=false
end,demoSoldierLocator={},forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002"},forceBalaclavaLocator={}},ArrivedMotherBaseChildren={weather=TppDefine.WEATHER.SUNNY,time="11:00:00",heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},OnEnter=function()
TppSoundDaemon.ResetMute"Outro"end,OnPrevPlayRequest=function()svars.isCollect_Injury=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_Injury]svars.isCollect_YellowHood=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]svars.isCollect_Aflo=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_Aflo]svars.isCollect_ShortAflo=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]svars.isCollect_BlackCoat=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
end},NuclearEliminationCeremony={weather=TppDefine.WEATHER.SUNNY,time="17:20:00",GetNextDemoNameOrNil=function()
if TppMotherBaseManagement.IsNuclearDeveloped()then
return"DetailsNuclearDevelop"elseif TppMotherBaseManagement.IsNuclearDiscarded()then
return"ForKeepNuclearElimination"else
return"SacrificeOfNuclearElimination"end
end,OnEnter=function()
TppPlayer.Refresh()PlatformConfiguration.SetShareScreenEnabled(false)
function f30050_sequence.FinishNuclearAbolitionEndint()
TppUiStatusManager.UnsetStatus("AnnounceLog","INVALID_LOG")PlatformConfiguration.SetShareScreenEnabled(true)
TppSoundDaemon.ResetMute"Result"f30050_sequence.ReserveMissionClear()
local e=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
if gvars.f30050_discardNuclearCountFromLastAbolition<e then
TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.NuclearAbolition,nil,"announce_nuclear_zero")
end
gvars.f30050_discardNuclearCountFromLastAbolition=e
end
end,telopLangIdList={"area_demo_mb","platform_main"}},ForKeepNuclearElimination={weather=TppDefine.WEATHER.SUNNY,time="17:45:00",GetNextDemoNameOrNil=function()
return"SacrificeOfNuclearElimination"end,clusterName="Medical",OnEnter=function()
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_AssetIdentifier","mtbs_antn001_0001",false,false)
end,OnEnd=function()
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_AssetIdentifier","mtbs_antn001_0001",true,false)
end},SacrificeOfNuclearElimination={weather=TppDefine.WEATHER.SUNNY,time="10:00:00",clusterName="Develop",GetNextDemoNameOrNil=function()
return"EndingSacrificeOfNuclear"end,OnEnter=function()Player.SetPause()
TppDataUtility.SetVisibleDataFromIdentifier("MtbsCommon","sahelan_spl",false,false)
end,OnEnd=function()
TppSoundDaemon.SetMute"Result"end},DetailsNuclearDevelop={isMovie=true,OnEnter=function()
TppSoundDaemon.SetMute"Result"end,GetNextDemoNameOrNil=function()
if TppMotherBaseManagement.IsNuclearDiscarded()then
return"ForKeepNuclearElimination"else
return"SacrificeOfNuclearElimination"end
end},EndingSacrificeOfNuclear={isMovie=true,OnEnter=function()
TppSound.SetSceneBGM"bgm_nuclear_ending"TppUiCommand.NukeCountDownText("set","cmmn_nuclear_weapon_num",5,166666,15)
end,OnEnd=function()
local e=TppServerManager.GetNuclearAbolitionCount()
if e>0 then
gvars.f30050_NuclearAbolitionCount=e
end
TppUiCommand.NukeCountDownText"reset"end},TheGreatEscapeLiquid={OnEnter=function()
TppPlayer.Refresh()
end,OnEnd=function()
TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.THE_GREAT_ESCAPE_LIQUID,TppDefine.INIT_ELAPSED_MISSION_COUNT.THE_GREAT_ESCAPE_LIQUID)
TppCassette.Acquire{cassetteList={"tp_m_10160_04"},pushReward=true}svars.isVisibleBrokenHanger=true
TppClock.SetTime"20:00:00"mvars.f30050_isOverwriteDemoEndPos=true
TppEmblem.Add("front71",true)
TppEmblem.Add("word1",true)
TppEmblem.Add("word40",true)
TppEmblem.Add("word45",true)
TppEmblem.Add("word58",true)
TppEmblem.Add("word99",true)
TppEmblem.Add("word112",true)
end,time="15:45:00",weather=TppDefine.WEATHER.SUNNY,telopLangIdList={"area_demo_mb","area_demo_room101"},isShowReward=true},DecisionHuey={OnEnter=function()
TppPlayer.Refresh()
TppDataUtility.SetVisibleDataFromIdentifier("cp05_off_AssetIdentifier","mtbs_antn001_0001",false,false)
TppEffectUtility.SetOceanDisplacementStrength(.0115)
TppEffectUtility.SetOceanWindDirection(-.8,.5)
TppEffectUtility.SetOceanWaveAmplitude(.4)
end,OnEnd=function()
TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY)
TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3007,pushReward=true}
TppCassette.Acquire{cassetteList={"tp_m_10190_05","tp_m_10190_06","tp_m_10240_03","tp_m_10240_04"},pushReward=true}
TppEmblem.Add("front82",true,false)
TppEmblem.Add("word37",true,false)
TppEmblem.Add("word127",true,false)
TppEmblem.Add("word128",true,false)
TppEmblem.Add("word129",true,false)
TppEffectUtility.RestoreOceanParameters()
vars.mbmBanHeuy=1
if f30050_sequence then
f30050_sequence.ReserveMissionClear()
end
end,time="07:10:00",weather=TppDefine.WEATHER.CLOUDY,telopLangIdList={"area_demo_mb","area_demo_room101"}},PazPhantomPain1={OnEnter=function()
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_bed_AssetIdentifier","paz_room_bed",true,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
TppPaz.SetDemoEndType(TppPaz.DEMO_END_TYPE_SIT)
TppPaz.OnDemoEnter()
end,OnEnd=function()
end,time="00:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"},PazPhantomPain2={OnEnter=function()
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_bed_AssetIdentifier","paz_room_bed",true,false)
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
local t={"photo01","photo02","photo03","photo04","photo05","photo06","photo07","photo08","photo09","photo10"}
for e=1,gvars.pazLookedPictureCount do
TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier",t[e],true,false)
end
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
TppPaz.SetDemoEndType(TppPaz.DEMO_END_TYPE_DOWN)
TppPaz.OnDemoEnter()
end,OnEnd=function()f30050_sequence.SetPazDone()
end,time="17:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"},PazPhantomPain4=e._PazPhantomPain4Settings,PazPhantomPain4_jp=e._PazPhantomPain4Settings}
function e.PlayMtbsEventDemo(o)
if not Tpp.IsTypeTable(o)then
end
local l=o.demoName
if not e.demoList[l]then
return
end
Player.UnsetPause()
mvars.mbDemo_isFirstPlay=not TppDemo.IsPlayedMBEventDemo(l)
local A=false
local b=o.onEnd
local r=nil
local p=nil
local t=e.demoOptions[l]
local i,a=nil,nil
local n=e.GetNextDemo(l)
local S=nil
local T=nil
local m=false
local u=false
local f=true
local c=false
local _=false
local d={}
local s=nil
local y=false
local E=vars.buddyType
local N=vars.buddyType
local k=false
local h=nil
local E=false
local D=false
if t then
p=t.OnEnter
r=t.OnEnd
i=t.weather
S=t.outOfCluster
T=t.heliEnableAfterDemo
m=t.isMovie
u=t.isVisibleCurrentBudy
s=t.demoEndRouteList
y=t.enableOcelotDemoEnd
if t.noUseDemoBlock then
f=false
end
if n then
A=true
a=e.GetDemoTime(n)
end
_=t.isShowReward
d=t.telopLangIdList
c=t.noHeli
if t.OnPrevPlayRequest then
t.OnPrevPlayRequest()
end
h=t.enableWaitBlockLoadOnDemoSkip
E=t.isFinishFadeOut
D=t.isUseGrassOcelot
end
local E=((A or mvars.f30050_needReload)or _)or E
local t={onInit=function()
TppBuddyService.SetIgnoreDisableNpc(true)
if i then
TppWeather.ForceRequestWeather(i,0)
end
local n,t
if S then
n=Vector3(5e3,0,5e3)t=Quat.RotationY(0)
else
local e,l=e.GetDemoPlayCluster(l)n,t=mtbs_cluster.GetDemoCenter(e,l)
end
DemoDaemon.SetDemoTransform(f30050_demo.demoList[l],t,n)
if not c then
if T then
GameObject.SendCommand({type="TppHeli2",index=0},{id="SetDemoToAfterDropEnabled",enabled=true,route="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_tkof",isTakeOff=true})
else
GameObject.SendCommand({type="TppHeli2",index=0},{id="SetDemoToAfterDropEnabled",enabled=false,route="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_tkof"})
end
end
if D then
local e={type="TppOcelot2",index=0}
local t={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=371}
GameObject.SendCommand(e,t)
end
e.SetInvisibleUniqueCharacter(u)GkEventTimerManager.Start("TelopStartOnDemo",O)
mvars.f30050_demoTelopLangIdList=d
end,onStart=function()
if s then
e.SetupDemoEndRoute(s)
end
if p then
p()
end
end,onEnd=function()
e.DisableBuddyForForceRealized(l)
vars.buddyType=mvars.f30050_buddyTypeOnMissionStart
TppBuddyService.SetIgnoreDisableNpc(false)
local t=TppDefine.MB_FREEPLAY_DEMO_ENUM[l]
if t then
gvars.mbFreeDemoPlayedFlag[t]=true
end
if r then
r()
end
if b then
b()
end
if not y then
e.DisableOcelot()
end
if k then
vars.buddyType=N
end
if n then
Player.SetPause()
e.ChangeBlock(l,n)
if a then
TppClock.SetTime(a)
end
end
if not n then
local e,t=TppStory.GetForceMBDemoNameOrRadioList("afterMBDemo",{demoName=l})
if e then
svars.requestPlayAfterDemoRadioIndex=t
end
end
TppWeather.CancelForceRequestWeather()
TppBuddyService.SetVarsMissionStart()
TppDemoUtility.SetInvisibleUniqueCharacter{invisible={}}
if _ then
e.ShowMissionRewardAfterDemo()
mvars.dem_resereveEnableInGameFlag=false
end
end}
local n={useDemoBlock=f,finishFadeOut=E,startNoFadeIn=true,exceptGameStatus=o.exceptGameStatus,waitBlockLoadEndOnDemoSkip=h}
if TppStory.DEBUG_SkipDemoRadio then
t.onEnd()
return
end
if m then
local e=e.demoList[l]
TppMovie.Play{videoName=e,onStart=t.onStart,onEnd=t.onEnd,memoryPool=e}
else
TppDemo.Play(l,t,n)
end
end
function e.DisableBuddyForForceRealized(t)
if vars.buddyType~=BuddyType.QUIET and vars.buddyType~=BuddyType.DOG then
return
end
local e=e.demoOptions[t]
if e and(e.forceEnableBuddyType or e.disableBuddyAfterDemo)then
local t={id="SetEnabled",enabled=false}
local e={type="TppBuddyDog2",index=0}
if vars.buddyType==BuddyType.QUIET then
e={type="TppBuddyQuiet2",index=0}
end
GameObject.SendCommand(e,t)
end
end
function e.SetupDemoEndRoute(e)
for t,e in ipairs(e)do
local t=GameObject.GetGameObjectId(e.locatorName)
local e={id="SetSneakRoute",route=e.routeName}
GameObject.SendCommand(t,e)
end
end
function e.SetInvisibleUniqueCharacter(t)
local e={}
if not TppStory.CanArrivalLiquidInMB()then
table.insert(e,"Liquid")
end
if not TppStory.CanArrivalHueyInMB()then
table.insert(e,"Huey")
end
if not TppStory.CanArrivalCodeTalkerInMB()then
table.insert(e,"CodeTalker")
end
if not TppStory.CanArrivalSahelanInMB()then
table.insert(e,"Sahelan")
end
if t then
if vars.buddyType~=BuddyType.QUIET then
table.insert(e,"Quiet")
end
if vars.buddyType~=BuddyType.DOG then
table.insert(e,"Dog")
end
else
if not TppStory.CanArrivalQuietInMB()then
table.insert(e,"Quiet")
end
if not TppStory.CanArrivalDDogInMB()then
table.insert(e,"Dog")
end
end
for e,e in ipairs(e)do
end
TppDemoUtility.SetInvisibleUniqueCharacter{invisible=e}
end
function e.DisableOcelot()
local e=GameObject.GetGameObjectId"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator"local t={id="SetEnabled",enabled=false}
if e~=GameObject.NULL_ID then
GameObject.SendCommand(e,t)
end
end
function e.ChangeBlock(t,l)
local t=e.demoBlockList[t]
local o=e.demoBlockList[l]
local n=#t~=#o
if not n then
for e=1,#t do
if t[e]~=c then
if t[e]~=o[e]then
n=true
break
end
end
end
end
if n then
local t=f30050_demo.GetDemoPlayCluster(l)
local t=TppDefine.CLUSTER_DEFINE[t]f30050_sequence.RegisterFovaFpk(t)
e.UpdatePackList(l)
TppScriptBlock.LoadDemoBlock(l,true)
end
end
function e.GetNextDemo(l)
local t=nil
local e=e.demoOptions[l]
if e and e.GetNextDemoNameOrNil then
t=e.GetNextDemoNameOrNil()
end
return t
end
function e.GetDemoPlayCluster(n)
local t="Command"local l="plnt0"local e=e.demoOptions[n]
if e and e.clusterName then
t=e.clusterName
end
if e and e.plntName then
l=e.plntName
end
return t,l
end
function e.HasPlant(t)
local e,t=e.GetDemoPlayCluster(t)
return mtbs_cluster.HasPlant(e,t)
end
function e.GetDemoTime(l)
local t=nil
local e=e.demoOptions[l]
if e and e.time then
t=e.time
end
return t
end
function e.UpdatePackList(t)
if not t then
return
end
local l={}l[t]={}
local n=false
if e.demoBlockList[t]then
Tpp.ApendArray(l[t],e.demoBlockList[t])
local e=e.demoOptions[t]
if e and e.loadBuddyBlock then
table.insert(l[t],c)
end
elseif TppQuestList.questPackList[t]then
n=true
Tpp.ApendArray(l[t],TppQuestList.questPackList[t])
end
if n or t=="Empty"then
Tpp.ApendArray(l[t],e.GetPackListForStorySequence())
end
if mvars.f30050demo_fovaPackList then
Tpp.ApendArray(l[t],mvars.f30050demo_fovaPackList)
end
if#l[t]~=0 then
TppQuest.RegisterQuestPackList(l,"demo_block")
end
end
function e.RegisterFovaPack(e)
mvars.f30050demo_fovaPackList=e
end
function e.GetPackListForStorySequence()
mvars.f30050_isSetLiquid=false
mvars.f30050_isSetCodeTalker=false
local e={}
local t=MotherBaseStage.GetCurrentCluster()
if t>#TppDefine.CLUSTER_NAME then
t=MotherBaseStage.GetFirstCluster()
end
if t==TppDefine.CLUSTER_DEFINE.Medical then
if TppStory.CanArrivalQuietInMB(false)or TppQuest.IsActive"mtbs_q99011"then
table.insert(e,b)
end
elseif t==TppDefine.CLUSTER_DEFINE.Develop then
if TppStory.CanArrivalSahelanInMB()then
local t="/Assets/tpp/pack/mission2/free/f30050/f30050_ly00"..(tostring(vars.mbLayoutCode).."_sahelan.fpk")table.insert(e,t)
end
if TppStory.CanArrivalAIPodInMB()then
local t="/Assets/tpp/pack/mission2/free/f30050/f30050_ly00"..(tostring(vars.mbLayoutCode).."_aipod.fpk")table.insert(e,t)
end
elseif t==TppDefine.CLUSTER_DEFINE.Command then
if TppStory.CanArrivalLiquidInMB()and(not TppQuest.IsActive"mtbs_q99050")then
local t="/Assets/tpp/pack/mission2/free/f30050/f30050_command_liquid.fpk"table.insert(e,t)
mvars.f30050_isSetLiquid=true
end
if TppStory.CanArrivalCodeTalkerInMB()then
local t="/Assets/tpp/pack/mission2/free/f30050/f30050_command_codeTalker.fpk"table.insert(e,t)
mvars.f30050_isSetCodeTalker=true
end
end
if(vars.buddyType==BuddyType.DOG)or(vars.buddyType==BuddyType.QUIET)then
table.insert(e,c)
mvars.f30050_needLoadBuddyController=true
end
return e
end
function e.ShowMissionRewardAfterDemo()
TppMission.ShowMissionReward()
mvars.f30050_showMissionRewardAfterDemo=true
end
function e.GetSoldierListInDemo(l)
local t={}
local e=e.demoOptions[l]
if e then
if e.forceMaleLocator then
Tpp.ApendArray(t,e.forceMaleLocator)
end
if e.demoSoldierLocator then
Tpp.ApendArray(t,e.demoSoldierLocator)
end
end
return t
end
function e.GetForceMaleSoldierList(l)
local t={}
local e=e.demoOptions[l]
if e and e.forceMaleLocator then
t=e.forceMaleLocator
end
return t
end
function e.SetupEnemy(t)
local l=e.GetDemoPlayCluster(t)
local l=TppDefine.CLUSTER_DEFINE[l]+1
local e=e.GetSoldierListInDemo(t)mtbs_enemy.SetSoldierForDemo(l,e)
end
function e.IsBalaclava(t,l)
local e=e.demoOptions[t]
if e and e.forceBalaclavaLocator then
for t,e in ipairs(e.forceBalaclavaLocator)do
if e==l then
return true
end
end
end
return false
end
function e.NeedLoadBuddyBlock(t)
local e=e.demoOptions[t]
if e and e.loadBuddyBlock then
if e.forceEnableBuddyType then
return true
end
if e.disableBuddyType~=vars.buddyType and vars.buddyType==BuddyType.DOG then
return true
end
end
return false
end
function e.SetupBuddy(t)
if e.NeedLoadBuddyBlock(t)then
local e=e.demoOptions[t]
if e and e.forceEnableBuddyType then
vars.buddyType=e.forceEnableBuddyType
end
TppBuddy2BlockController.Load()
TppBuddy2BlockController.ReserveCallBuddy(vars.buddyType,BuddyInitStatus.RIDE,Vector3(0,0,0),0)
end
end
function e.IsShowReward(t)
local e=e.demoOptions[t]
if e then
return e.isShowReward
end
return false
end
return e
