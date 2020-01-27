do
return{}
end
local n={}
function n.SetPlayLogEnabled(e)
if TppPlayLog then
TppPlayLog.SetPlayLogEnabled(e)
end
end
function n.RequestResetPlayLog()
if TppPlayLog then
TppPlayLog.RequestResetPlayLog()
end
end
function n.RequestUploadPlayLog()
if TppPlayLog then
TppPlayLog.RequestUploadPlayLog()
end
end
function n.ExportSavedPlayLog()
if TppPlayLog and TppPlayLog.ExportSavedPlayLog then
TppPlayLog.ExportSavedPlayLog()
end
end
n.PERF_CHECK_TYPE=Tpp.Enum{"OnUpdate","OnMessage","OnEnter"}
local i={}
local g={}
local l={}
local p=2
local t=0
local r=0
local e=Tpp.ApendArray
local s=Tpp.IsTypeTable
local u=GkEventTimerManager.IsTimerActive
local d=Tpp.DEBUG_StrCode32ToString
n.Colors={black=Color(0,0,0,1),white=Color(1,1,1,1),red=Color(1,0,0,1),green=Color(0,1,0,1),blue=Color(0,0,1,1),yellow=Color(1,1,0,1),magenta=Color(1,0,1,1),cyan=Color(0,1,1,1),darkRed=Color(.5,0,0,1),darkGreen=Color(0,.5,0,1),darkBlue=Color(0,0,.5,1),darkYellow=Color(.5,.5,0,1),purple=Color(.5,0,.5,1),darkCyan=Color(0,.5,.5,1)}
function n.DEBUG_SetSVars(e)
if not s(e)then
return
end
for a,e in pairs(e)do
Tpp._DEBUG_svars[a]=e
end
end
function n.DEBUG_SetGVars(e)
if not s(e)then
return
end
for e,a in pairs(e)do
Tpp._DEBUG_gvars[e]=a
end
end
function n.DEBUG_RestoreSVars()
if next(Tpp._DEBUG_svars)then
for e,a in pairs(Tpp._DEBUG_svars)do
svars[e]=a
end
TppSave.VarSave()
end
end
function n.DEBUG_SetOrderBoxPlayerPosition()
if next(Tpp._DEBUG_gvars)then
if Tpp._DEBUG_gvars.mis_orderBoxName then
TppMission.SetMissionOrderBoxPosition(Tpp._DEBUG_gvars.mis_orderBoxName)
TppSave.VarSave()
end
end
end
function n.DEBUG_SVarsClear()
if next(Tpp._DEBUG_svars)then
for e,a in pairs(Tpp._DEBUG_svars)do
if e=="dbg_seq_sequenceName"then
TppSave.ReserveVarRestoreForContinue()
end
end
Tpp._DEBUG_svars={}
TppSave.VarSave()
end
end
function n.DEBUG_GetSysVarsLog()
local a=svars or{}
local e=mvars or{}
local e={"missionName = "..(tostring(e.mis_missionName)..(", vars.missionCode = "..(tostring(vars.missionCode)..(", vars.locationCode = "..tostring(vars.locationCode))))),"mvars.mis_missionStateIsNotInGame = "..tostring(e.mis_missionStateIsNotInGame),"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]),"gvars.pck_missionPackLabelName = "..tostring(gvars.pck_missionPackLabelName),"gvars.mis_orderBoxName = "..tostring(gvars.mis_orderBoxName),"gvars.heli_missionStartRoute = "..tostring(gvars.heli_missionStartRoute),"gvars.mis_nextMissionCodeForMissionClear = "..tostring(gvars.mis_nextMissionCodeForMissionClear),"gvars.mis_nextMissionCodeForEmergency = "..tostring(gvars.mis_nextMissionCodeForEmergency),"vars.mbLayoutCode = "..(tostring(vars.mbLayoutCode)..(", mvars.mis_nextLayoutCode = "..tostring(e.mis_nextLayoutCode))),"vars.mbClusterId = "..(tostring(vars.mbClusterId)..(", mvars.mis_nextClusterId = "..tostring(e.mis_nextClusterId))),"mvars.mis_isOutsideOfMissionArea = "..tostring(e.mis_isOutsideOfMissionArea),"svars.mis_isDefiniteGameOver = "..(tostring(a.mis_isDefiniteGameOver)..(", svars.mis_isDefiniteMissionClear = "..tostring(a.mis_isDefiniteMissionClear))),"gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize),"gvars.canExceptionHandling = "..tostring(gvars.canExceptionHandling),"vars.playerVehicleGameObjectId = "..tostring(vars.playerVehicleGameObjectId),"TppServerManager.FobIsSneak() = "..tostring(TppServerManager.FobIsSneak()),"svars.scoreTime = "..tostring(a.scoreTime)}
return e
end
function n.DEBUG_WarpHelicopter(r,o,i,a,t)
if not s(soldierNameTable)then
soldierNameTable={soldierNameTable}
end
local s=GameObject.GetGameObjectId
local e=GameObject.SendCommand
if not a then
a=0
end
for i,n in pairs(soldierNameTable)do
local n=s(n)e(n,{id="SetEnabled",enabled=false})e(n,{id="SetSneakRoute",route=o,point=a})e(n,{id="SetCautionRoute",route=o,point=a})
if t then
e(n,{id="SetAlertRoute",enabled=true,route=o,point=a})
else
e(n,{id="SetAlertRoute",enabled=false,route="",point=a})
end
e(n,{id="SetEnabled",enabled=true})
end
local a=s(r)e(a,{id="SetPosition",position=i,rotY=0})
end
function n.DEBUG_WarpVehicleAndSoldier(o,r,t,i,a,l)
if not s(o)then
o={o}
end
local s=GameObject.GetGameObjectId
local e=GameObject.SendCommand
if not a then
a=0
end
for o,n in pairs(o)do
local n=s(n)e(n,{id="SetEnabled",enabled=false})e(n,{id="SetSneakRoute",route=t,point=a})e(n,{id="SetCautionRoute",route=t,point=a})
if l then
e(n,{id="SetAlertRoute",enabled=true,route=t,point=a})
else
e(n,{id="SetAlertRoute",enabled=false,route="",point=a})
end
e(n,{id="SetEnabled",enabled=true})
end
local a=s(r)e(a,{id="SetPosition",position=i,rotY=0})
end
n.DEBUG_SkipOnChangeSVarsLog={timeLimitforSneaking=true,timeLimitforNonAbort=true}
function n.DEBUG_AddSkipLogSVarsName(e)n.DEBUG_SkipOnChangeSVarsLog[e]=true
end
function n.QARELEASE_DEBUG_Init()
local e
do
return
end
e.AddDebugMenu("LuaSystem","showSysVars","bool",gvars,"DEBUG_showSysVars")
e.AddDebugMenu("LuaSystem","gameStatus","bool",gvars,"DEBUG_showGameStatus")
mvars.qaDebug.forceCheckPointSave=false
e.AddDebugMenu("LuaSystem","ForceCheckPointSave","bool",mvars.qaDebug,"forceCheckPointSave")
mvars.qaDebug.showWeaponVars=false
e.AddDebugMenu("LuaSystem","ShowWeaponVars","bool",mvars.qaDebug,"showWeaponVars")
mvars.qaDebug.showPlayerPartsType=false
e.AddDebugMenu("LuaSystem","ShowPlayerPartsType","bool",mvars.qaDebug,"showPlayerPartsType")
end
function n.QAReleaseDebugUpdate()
local e=svars
local s=mvars
local e=(nil).Print
local a=(nil).NewContext()
if s.seq_doneDumpCanMissionStartRefrainIds then
e(a,{1,0,0},"TppSequence: Mission.CanStart() wait is time out!\nPlease screen shot [Mission > ViewStartRefrain > true] , [Pause > ShowFlags > true] and [Pause > ShowInstances > true]")
end
if s.qaDebug.forceCheckPointSave then
s.qaDebug.forceCheckPointSave=false
TppMission.UpdateCheckPoint{ignoreAlert=true,atCurrentPosition=true}
end
if gvars.DEBUG_showSysVars then
local n=n.DEBUG_GetSysVarsLog()e(a,{.5,.5,1},"LuaSystem showSysVars")
for s,n in ipairs(n)do
e(a,n)
end
end
if gvars.DEBUG_showGameStatus then
e(a,"")e(a,{.5,.5,1},"LuaSystem gameStatus")
for s,n in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
local n=TppGameStatus.IsSet("TppMain.lua",s)
if n then
e(a," statusType = "..(tostring(s)..(", IsSet = "..tostring(n))))
end
end
local n=TppGameStatus.IsSet("TppMain.lua","S_IS_BLACK_LOADING")
if n then
e(a," statusType = "..(tostring"S_IS_BLACK_LOADING"..(", IsSet = "..tostring(n))))
end
e(a,"UIStatus")
local n={{CallMenu="INVALID"},{PauseMenu="INVALID"},{EquipHud="INVALID"},{EquipPanel="INVALID"},{CqcIcon="INVALID"},{ActionIcon="INVALID"},{AnnounceLog="SUSPEND_LOG"},{AnnounceLog="INVALID_LOG"},{BaseName="INVALID"},{Damage="INVALID"},{Notice="INVALID"},{HeadMarker="INVALID"},{WorldMarker="INVALID"},{HudText="INVALID"},{GmpInfo="INVALID"},{AtTime="INVALID"},{InfoTypingText="INVALID"}}
for s,n in pairs(n)do
for n,s in pairs(n)do
if(TppUiStatusManager.CheckStatus(n,s)==true)then
e(a,string.format(" UI = %s, Status = %s",n,s))
end
end
end
end
if s.qaDebug.showWeaponVars then
local n={"PRIMARY_HIP","PRIMARY_BACK","SECONDARY"}e(a,{.5,.5,1},"LuaSystem WeaponVars")
for n,s in ipairs(n)do
local n=TppDefine.WEAPONSLOT[s]e(a,string.format("Slot:%16s : vars.initWeapons = %04d, vars.weapons = %04d",s,vars.initWeapons[n],vars.weapons[n]))
end
for n=0,7 do
e(a,string.format("Slot:%d : vars.supportWeapons = %04d, vars.initSupportWeapons = %04d, gvars.ply_lastWeaponsUsingTemp = %04d",n,vars.supportWeapons[n],vars.initSupportWeapons[n],gvars.ply_lastWeaponsUsingTemp[n+TppDefine.WEAPONSLOT.SUPPORT_0]))
end
for n=0,7 do
e(a,string.format("Slot:%d : vars.items = %04d, vars.initItems = %04d, gvars.ply_lastItemsUsingTemp = %04d",n,vars.items[n],vars.initItems[n],gvars.ply_lastItemsUsingTemp[n]))
end
end
if s.qaDebug.showPlayerPartsType then
e(a,{.5,.5,1},"LuaSystem ShowPlayerPartsType")e(a,"gvars.ply_isUsingTempPlayerType = "..tostring(gvars.ply_isUsingTempPlayerType))e(a,string.format("vars.playerPartsType = %04d, gvars.ply_lastPlayerPartsTypeUsingTemp = %04d",vars.playerPartsType,gvars.ply_lastPlayerPartsTypeUsingTemp))e(a,string.format("vars.playerCamoType = %04d, gvars.ply_lastPlayerCamoTypeUsingTemp = %04d",vars.playerCamoType,gvars.ply_lastPlayerCamoTypeUsingTemp))e(a,string.format("vars.playerType = %04d, gvars.ply_lastPlayerTypeUsingTemp = %04d",vars.playerType,gvars.ply_lastPlayerTypeUsingTemp))
end
end
function n.Print2D(e)
if(e==nil)then
return
end
local s=e.showTime or(3*30)
local o=e.xPos or 25
local i=e.yPos or 425
local t=e.size or 20
local a=e.color or"white"local e=e.text or""a=n._GetColor(a)GrxDebug.Print2D{life=s,x=o,y=i,size=t,color=a,args={e}}
end
function n.DEBUG_MakeUserSVarList(e)
if not s(e)then
return
end
mvars.dbg_userSaveVarList={}
for a,e in pairs(e)do
table.insert(mvars.dbg_userSaveVarList,e.name)
end
end
function n.AddReturnToSelector(e)e:AddItem("< return",DebugSelector.Pop)
end
function n.DEBUG_Init()
mvars.debug.returnSelect=false;(nil).AddDebugMenu(" Select","Return select","bool",mvars.debug,"returnSelect")
mvars.debug.showSVars=false;(nil).AddDebugMenu("LuaMission","DBG.showSVars","bool",mvars.debug,"showSVars")
mvars.debug.showMVars=false;(nil).AddDebugMenu("LuaMission","DBG.showMVars","bool",mvars.debug,"showMVars")
mvars.debug.showMissionArea=false;(nil).AddDebugMenu("LuaMission","MIS.missionArea","bool",mvars.debug,"showMissionArea")
mvars.debug.showClearState=false;(nil).AddDebugMenu("LuaMission","MIS.clearState","bool",mvars.debug,"showClearState")
mvars.debug.openEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.openEmergencyTimer","bool",mvars.debug,"openEmergencyTimer")
mvars.debug.closeEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.closeEmergencyTimer","bool",mvars.debug,"closeEmergencyTimer")
mvars.debug.showDebugPerfCheck=false;(nil).AddDebugMenu("LuaSystem","DBG.showPerf","bool",mvars.debug,"showDebugPerfCheck")
mvars.debug.showSysSVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysSVars","bool",mvars.debug,"showSysSVars")
mvars.debug.showSysMVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysMVars","bool",mvars.debug,"showSysMVars")
mvars.debug.AnimalBlock=false;(nil).AddDebugMenu("LuaSystem","DBG.AnimalBlock","bool",mvars.debug,"AnimalBlock")
mvars.debug.ply_rotCheck=0;(nil).AddDebugMenu("LuaSystem","PLY.rotCheck","int32",mvars.debug,"ply_rotCheck")
mvars.debug.ply_intelTrap=false;(nil).AddDebugMenu("LuaSystem","PLY.intelTrap","bool",mvars.debug,"ply_intelTrap")
mvars.debug.enableAllMessageLog=false;(nil).AddDebugMenu("LuaMessage","enableAllMessageLog","bool",mvars.debug,"enableAllMessageLog")
mvars.debug.showSubscriptMessageTable=0;(nil).AddDebugMenu("LuaMessage","subScripts","int32",mvars.debug,"showSubscriptMessageTable")
mvars.debug.showSequenceMessageTable=0;(nil).AddDebugMenu("LuaMessage","sequence","int32",mvars.debug,"showSequenceMessageTable")
mvars.debug.showLocationMessageTable=0;(nil).AddDebugMenu("LuaMessage","location","int32",mvars.debug,"showLocationMessageTable")
mvars.debug.showLibraryMessageTable=0;(nil).AddDebugMenu("LuaMessage","library","int32",mvars.debug,"showLibraryMessageTable")
mvars.debug.showWeaponSelect=false;(nil).AddDebugMenu("LuaWeapon","showWeaponSelect","bool",mvars.debug,"showWeaponSelect")
mvars.debug.weaponCategory=1;(nil).AddDebugMenu("LuaWeapon","category","int32",mvars.debug,"weaponCategory")
mvars.debug.weaponCategoryList={{"Develop:Hundgan",8,{"EQP_WP_1"}},{"Develop:Submachingun",8,{"EQP_WP_2"}},{"Develop:AssaultRifle",8,{"EQP_WP_3"}},{"Develop:Shotgun",8,{"EQP_WP_4"}},{"Develop:Granader",8,{"EQP_WP_5"}},{"Develop:SniperRifle",8,{"EQP_WP_6"}},{"Develop:MachineGun",8,{"EQP_WP_7"}},{"Develop:Missile",8,{"EQP_WP_8"}},{"EnemyWeapon",8,{"EQP_WP_W","EQP_WP_E","EQP_WP_Q","EQP_WP_C"}},{"SupportWeapon",7,{"EQP_SWP"}},{"Equipment",7,{"EQP_IT_"}}}
mvars.debug.selectedWeaponId=0;(nil).AddDebugMenu("LuaWeapon","weaponSelect","int32",mvars.debug,"selectedWeaponId")
mvars.debug.enableWeaponChange=false;(nil).AddDebugMenu("LuaWeapon","enableWeaponChange","bool",mvars.debug,"enableWeaponChange")
end
function n.DEBUG_OnReload(e)i={}g={}l={}t=0
r=0
n.PERF_CHECK_TYPE=Tpp.Enum(n.PERF_CHECK_TYPE)
end
function n.DebugUpdate()
local t=svars
local e=mvars
local o=e.debug
local s=(nil).Print
local a=(nil).NewContext()
if(not TppUiCommand.IsEndMissionTelop())then
s(a,{.5,.5,1},"Now showing result.")
end
if gvars.needWaitMissionInitialize then
s(a,{.5,.5,1},"Now neew wait mission initialize.")
end
if o.returnSelect then
TppUI.FadeOut(0)
TppSave.ReserveVarRestoreForMissionStart()
TppMission.SafeStopSettingOnMissionReload()tpp_editor_menu2.StartTestStage(6e4)o.returnSelect=false
end
if o.showSVars then
s(a,"")s(a,{.5,.5,1},"LuaMission DBG.showSVars")
for n,e in pairs(e.dbg_userSaveVarList)do
s(a,string.format(" %s = %s",tostring(e),tostring(t[e])))
end
end
if o.showMVars then
s(a,{.5,.5,1},"LuaMission DBG.showMVars")
for e,n in pairs(e)do
s(a,string.format(" %s = %s",tostring(e),tostring(n)))
end
end
if o.showMissionArea then
s(a,{.5,.5,1},"LuaMission MIS.missionArea")
local n
if e.mis_isOutsideOfMissionArea then
n="Outside"else
n="Inside"end
s(a,"outerZone : "..n)
if e.mis_isAlertOutOfMissionArea then
n="Outside"else
n="Inside"end
s(a,"innerZone : "..n)
if e.mis_isOutsideOfHotZone then
n="Outside"else
n="Inside"end
s(a,"hotZone : "..n)s(a,"hotZone clear check : isNotAlert = "..(tostring(e.debug.notHotZone_isNotAlert)..(", isPlayerStatusNormal = "..(tostring(e.debug.notHotZone_isPlayerStatusNormal)..(", isNotHelicopter = "..tostring(e.debug.notHotZone_isNotHelicopter))))))s(a,"Mission clear timer: "..tostring(u"Timer_OutsideOfHotZoneCount"))s(a,{.5,1,.5},"Recent all target status")
local e=e.debug.checkedTargetStatus or{}
for e,n in pairs(e)do
s(a,"  TargetName = "..(e..(" : "..n)))
end
end
if e.debug.showClearState then
s(a,{.5,.5,1},"LuaMission MIS.showClearState")s(a,"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]))
end
if e.debug.openEmergencyTimer then
e.debug.openEmergencyTimer=false
if e.mis_openEmergencyMissionTimerName then
GkEventTimerManager.Stop(e.mis_openEmergencyMissionTimerName)GkEventTimerManager.Start(e.mis_openEmergencyMissionTimerName,1)
end
end
if e.debug.closeEmergencyTimer then
e.debug.closeEmergencyTimer=false
if e.mis_closeEmergencyMissionTimerName then
GkEventTimerManager.Stop(e.mis_closeEmergencyMissionTimerName)GkEventTimerManager.Start(e.mis_closeEmergencyMissionTimerName,1)
end
end
if o.showSysSVars then
s(a,"")s(a,{.5,.5,1},"LuaSystem DBG.showSysSVars")
for e,n in pairs(t.__as)do
if(n<=1)then
s(a,string.format(" %s = %s",tostring(e),tostring(t[e])))
else
s(a,string.format(" %s = %s",tostring(e),tostring(n)))
for n=0,(n-1)do
s(a,string.format("   %s[%d] = %s",tostring(e),n,tostring(t[e][n])))
end
end
end
end
if o.showDebugPerfCheck then
s(a,{.5,.5,1},"LuaSystem DBG.showPerf")
for o,e in pairs(l)do
s(a," perf["..(n.PERF_CHECK_TYPE[o]..("] = "..e)))
end
end
if e.debug.AnimalBlock then
s(a,{.5,.5,1},"LuaSystem DBG.AnimalBlock")
local o,t=Tpp.GetCurrentStageSmallBlockIndex()s(a,string.format("current block position (x,y) = (%03d, %03d)",o,t))s(a,"Load animal block area = "..tostring(e.animalBlockAreaName))
local t=ScriptBlock.GetScriptBlockId"animal_block"local o
if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
o=ScriptBlock.GetScriptBlockState(t)
end
local t
if o==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
t="SCRIPT_BLOCK_STATE_EMPTY"elseif o==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING then
t="SCRIPT_BLOCK_STATE_PROCESSING"elseif o==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
t="SCRIPT_BLOCK_STATE_INACTIVE"elseif o==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
t="SCRIPT_BLOCK_STATE_ACTIVE"end
s(a,"animal block state : "..tostring(t))
if e.animalBlockScript then
s(a,"animalBlockScript exist")
local o=""if e.animalBlockScript.OnMessage then
o="exist"else
o="  not"end
local t=""if e.animalBlockScript.OnReload then
t="exist"else
t="  not"end
s(a,"OnMessage "..(tostring(o)..(" OnReload "..tostring(t))))n.ShowMessageTable(a,"MessageTable",e.animalBlockScript.messageExecTable)
else
if o==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or o==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
s(a,{1,0,0},"this data is invalid!!!! please check data!!!")
else
s(a,"animalBlockScript   not")
end
end
end
if e.debug.ply_intelTrap then
s(a,{.5,.5,1},"LuaSystem PLY.intelTrap")
for e,n in pairs(e.ply_intelTrapInfo)do
if Tpp.IsTypeString(e)then
s(a,{.5,1,.5},"intelName = "..tostring(e))
for n,e in pairs(n)do
s(a,tostring(n)..(" = "..tostring(e)))
end
end
end
end
if(o.showSubscriptMessageTable>0)then
s(a,{.5,.5,1},"LuaMessage subScripts")
local s={"sequence","enemy","demo","radio","sound"}
local s=s[e.debug.showSubscriptMessageTable]
if s then
local o=TppMission.GetMissionName()..("_"..s)
if e.rad_subScripts[s]then
local e=e.rad_subScripts[s]._messageExecTable
n.ShowMessageTable(a,o,e)
end
end
end
if(o.showSequenceMessageTable>0)then
s(a,{.5,.5,1},"LuaMessage sequence")
local s=TppSequence.GetSequenceNameWithIndex(e.debug.showSequenceMessageTable)
if e.seq_sequenceTable then
local e=e.seq_sequenceTable[s]
if e then
local e=e._messageExecTable
n.ShowMessageTable(a,s,e)
end
end
end
if(o.showLocationMessageTable>0)then
s(a,{.5,.5,1},"LuaMessage location")
end
if(o.showLibraryMessageTable>0)then
s(a,{.5,.5,1},"LuaMessage library")
local e=Tpp._requireList[o.showLibraryMessageTable]
local s=_G[e].messageExecTable
n.ShowMessageTable(a,e,s)
end
if e.debug.showWeaponSelect then
s(a,{.5,.5,1},"LuaWeapon")
if e.debug.weaponCategory<1 then
e.debug.weaponCategory=1
end
if e.debug.weaponCategory>#e.debug.weaponCategoryList then
e.debug.weaponCategory=#e.debug.weaponCategoryList
end
local n=e.debug.weaponCategory
local t=e.debug.weaponCategoryList[e.debug.weaponCategory]s(a,{.5,1,.5},"Current weapon category : "..t[1])
local l,d
local n,o,r=0,1,5
if e.debug.selectedWeaponId>0 then
o=e.debug.selectedWeaponId
end
for e,u in pairs(TppEquip)do
local g=string.sub(e,1,t[2])
local i=false
for a,e in ipairs(t[3])do
if g==e then
i=true
end
end
if i then
n=n+1
if(o-n)<=r then
if n==o then
l=u
d=e
s(a,{.5,1,.5},"> EquipId = TppEquip."..e)
else
s(a,"  EquipId = TppEquip."..e)
end
end
if n==(o+r)then
break
end
end
end
if e.debug.enableWeaponChange then
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId={l}})
e.debug.enableWeaponChange=false
end
end
end
function n.ShowMessageTable(e,s,n)
local a=(nil).Print
a(e,{.5,1,.5},s)
if n==nil then
return
end
for s,n in pairs(n)do
local s=d(s)
if n then
for o,n in pairs(n)do
local o=d(o)
if n.func then
a(e,{1,1,1},s..(" : "..(o..(" : "..tostring(n.func)))))
end
local n=n.sender
if n then
for n,t in pairs(n)do
a(e,{1,1,1},s..(" : "..(o..(" : Sender = "..(d(n)..(" : "..tostring(t)))))))
end
end
end
end
end
end
function n.PerfCheckStart(a)
local e=n
if((a<=0)and(a>#e.PERF_CHECK_TYPE))then
return
end
if(a==e.PERF_CHECK_TYPE.OnUpdate)then
if(i[e.PERF_CHECK_TYPE.OnUpdate]~=nil)then
t=t+(os.clock()-i[e.PERF_CHECK_TYPE.OnUpdate])
end
end
i[a]=os.clock()
end
function n.PerfCheckEnd(e,a)
local o=mvars
local s=n
if((e<=0)and(e>#s.PERF_CHECK_TYPE))then
return
end
local d=a or""local n=0
local a=os.clock()-i[e]
if(e==s.PERF_CHECK_TYPE.OnUpdate)then
if(t<p)then
if(a>r)then
r=a
end
else
t=0
r=a
end
n=r
else
n=a
end
l[e]=string.format("%4.2f",n*1e3)..("ms."..d)
if o.debug and o.debug.showDebugPerfCheck then
if(n>1/60)then
else
if(e~=s.PERF_CHECK_TYPE.OnUpdate)then
end
end
end
end
function n.ErrorNotSupportYet(e)
end
function n._GetColor(e)
local e=n.Colors[e]
if(e==nil)then
return nil
end
return e
end
return n
