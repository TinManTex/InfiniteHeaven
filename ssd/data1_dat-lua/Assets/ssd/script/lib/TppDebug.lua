if Tpp.IsMaster()then
  return{}
end
local this={}
function this.SetPlayLogEnabled(e)
  if TppPlayLog then
    TppPlayLog.SetPlayLogEnabled(e)
  end
end
function this.RequestResetPlayLog()
  if TppPlayLog then
    TppPlayLog.RequestResetPlayLog()
  end
end
function this.RequestUploadPlayLog()
  if TppPlayLog then
    TppPlayLog.RequestUploadPlayLog()
  end
end
function this.ExportSavedPlayLog()
  if TppPlayLog and TppPlayLog.ExportSavedPlayLog then
    TppPlayLog.ExportSavedPlayLog()
  end
end
this.PERF_CHECK_TYPE=Tpp.Enum{"OnUpdate","OnMessage","OnEnter"}
local perfTimes={}
local c={}
local perfCheckTimesStrings={}
local p=2
local t=0
local d=0
local ApendArray=Tpp.ApendArray
local IsTypeTable=Tpp.IsTypeTable
local IsTimerActive=GkEventTimerManager.IsTimerActive
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
this.Colors={
  black=Color(0,0,0,1),
  white=Color(1,1,1,1),
  red=Color(1,0,0,1),
  green=Color(0,1,0,1),
  blue=Color(0,0,1,1),
  yellow=Color(1,1,0,1),
  magenta=Color(1,0,1,1),
  cyan=Color(0,1,1,1),
  darkRed=Color(.5,0,0,1),
  darkGreen=Color(0,.5,0,1),
  darkBlue=Color(0,0,.5,1),
  darkYellow=Color(.5,.5,0,1),
  purple=Color(.5,0,.5,1),
  darkCyan=Color(0,.5,.5,1)
}
function this.DEBUG_SetSVars(e)
  if not IsTypeTable(e)then
    return
  end
  for e,a in pairs(e)do
    Tpp._DEBUG_svars[e]=a
  end
end
function this.DEBUG_SetGVars(e)
  if not IsTypeTable(e)then
    return
  end
  for e,a in pairs(e)do
    Tpp._DEBUG_gvars[e]=a
  end
end
function this.DEBUG_RestoreSVars()
  if next(Tpp._DEBUG_svars)then
    for a,e in pairs(Tpp._DEBUG_svars)do
      svars[a]=e
    end
    TppSave.VarSave()
  end
end
function this.DEBUG_SetOrderBoxPlayerPosition()
  if next(Tpp._DEBUG_gvars)then
    if Tpp._DEBUG_gvars.mis_orderBoxName then
      TppMission.SetMissionOrderBoxPosition(Tpp._DEBUG_gvars.mis_orderBoxName)
      TppSave.VarSave()
    end
  end
end
function this.DEBUG_SVarsClear()
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
function this.DEBUG_GetSysVarsLog()
  local a=svars or{}
  local e=mvars or{}
  local e={"missionName = "..(tostring(e.mis_missionName)..(", vars.missionCode = "..(tostring(vars.missionCode)..(", vars.locationCode = "..tostring(vars.locationCode))))),"mvars.mis_missionStateIsNotInGame = "..tostring(e.mis_missionStateIsNotInGame),"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]),"gvars.pck_missionPackLabelName = "..tostring(gvars.pck_missionPackLabelName),"gvars.mis_orderBoxName = "..tostring(gvars.mis_orderBoxName),"gvars.heli_missionStartRoute = "..tostring(gvars.heli_missionStartRoute),"gvars.mis_nextMissionCodeForMissionClear = "..tostring(gvars.mis_nextMissionCodeForMissionClear),"mvars.mis_isOutsideOfMissionArea = "..tostring(e.mis_isOutsideOfMissionArea),"svars.mis_isDefiniteGameOver = "..(tostring(a.mis_isDefiniteGameOver)..(", svars.mis_isDefiniteMissionClear = "..tostring(a.mis_isDefiniteMissionClear))),"gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize),"gvars.canExceptionHandling = "..tostring(gvars.canExceptionHandling),"vars.playerVehicleGameObjectId = "..tostring(vars.playerVehicleGameObjectId),"svars.scoreTime = "..tostring(a.scoreTime)}
  return e
end
function this.DEBUG_WarpHelicopter(n,o,d,r,t)
  if not IsTypeTable(soldierNameTable)then
    soldierNameTable={soldierNameTable}
  end
  local i=GameObject.GetGameObjectId
  local e=GameObject.SendCommand
  if not r then
    r=0
  end
  for n,a in pairs(soldierNameTable)do
    local a=i(a)e(a,{id="SetEnabled",enabled=false})e(a,{id="SetSneakRoute",route=o,point=r})e(a,{id="SetCautionRoute",route=o,point=r})
    if t then
      e(a,{id="SetAlertRoute",enabled=true,route=o,point=r})
    else
      e(a,{id="SetAlertRoute",enabled=false,route="",point=r})
    end
    e(a,{id="SetEnabled",enabled=true})
  end
  local a=i(n)e(a,{id="SetPosition",position=d,rotY=0})
end
function this.DEBUG_WarpVehicleAndSoldier(o,d,t,n,r,l)
  if not IsTypeTable(o)then
    o={o}
  end
  local i=GameObject.GetGameObjectId
  local a=GameObject.SendCommand
  if not r then
    r=0
  end
  for o,e in pairs(o)do
    local e=i(e)a(e,{id="SetEnabled",enabled=false})a(e,{id="SetSneakRoute",route=t,point=r})a(e,{id="SetCautionRoute",route=t,point=r})
    if l then
      a(e,{id="SetAlertRoute",enabled=true,route=t,point=r})
    else
      a(e,{id="SetAlertRoute",enabled=false,route="",point=r})
    end
    a(e,{id="SetEnabled",enabled=true})
  end
  local r=i(d)a(r,{id="SetPosition",position=n,rotY=0})
end
this.DEBUG_SkipOnChangeSVarsLog={timeLimitforSneaking=true,timeLimitforNonAbort=true,displayTimeSec=true}
function this.DEBUG_AddSkipLogSVarsName(a)
  this.DEBUG_SkipOnChangeSVarsLog[a]=true
end
function this.DEBUG_FobGPU()
  local e=function(a)math.randomseed(os.time())
    TppMotherBaseManagement.SetGmp{gmp=1e6}
    local e=300
    if TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs then
      TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs{count=e}
    end
    do
      local e={CommonMetal=100,MinorMetal=100,PreciousMetal=100,FuelResource=100,BioticResource=100}
      for a,e in pairs(e)do
        TppMotherBaseManagement.SetResourceSvars{resource=a,usableCount=e,processingCount=e,got=true,isNew=false}
      end
      local e={Plant2000=100,Plant2001=100,Plant2002=100,Plant2003=100,Plant2004=100,Plant2005=100,Plant2006=100,Plant2007=100,Plant2008=100}
      for e,a in pairs(e)do
        TppMotherBaseManagement.SetResourceSvars{resource=e,usableCount=a,processingCount=0,got=true,isNew=false}
      end
  end
  do
    local e={"Orange","Blue","Black","Blick","Gray","Od","Pink","Sand"}
    local r=math.random(1,#e)
    TppMotherBaseManagement.SetFobSvars{fob="Fob1",got=true,oceanAreaId=70,topologyType=a,color=e[r]}
    local e={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
    for e,a in ipairs(e)do
      local e=math.random(4,4)
      TppMotherBaseManagement.SetClusterSvars{base="Fob1",category=a,grade=e,buildStatus="Completed",timeMinute=0,isNew=false}
    end
    for a,e in ipairs(e)do
      local a=math.random(1,1)
      TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category=e,grade=a,buildStatus="Completed",timeMinute=0,isNew=false}
    end
  end
  TppSave.VarSave(40010,true)
  TppSave.VarSaveOnRetry()
  TppSave.SaveGameData()
  end
  e(90)
end
function this.DEBUG_SetFobPlayerSneak()
  vars.avatarFaceRaceIndex=0
  vars.avatarAcceFlag=0
  vars.avatarFaceTypeIndex=1
  vars.avatarFaceVariationIndex=1
  vars.avatarFaceColorIndex=0
  vars.avatarHairStyleIndex=0
  vars.avatarRightEyeColorIndex=0
  vars.avatarRightEyeBrightnessIndex=0
  vars.avatarLeftEyeColorIndex=1
  vars.avatarLeftEyeBrightnessIndex=0
  vars.avatarHairColor=1
  vars.avatarBerdStyle=0
  vars.avatarBerdLength=1
  vars.avatarEbrwStyle=3
  vars.avatarEbrwWide=1
  vars.avatarGashOrTatoVariationIndex=0
  vars.avatarTatoColorIndex=0
  vars.avatarMotionFrame[0]=4
  vars.avatarMotionFrame[1]=9
  vars.avatarMotionFrame[2]=5
  vars.avatarMotionFrame[3]=5
  vars.avatarMotionFrame[4]=7
  vars.avatarMotionFrame[5]=1
  vars.avatarMotionFrame[6]=7
  vars.avatarMotionFrame[7]=4
  vars.avatarMotionFrame[8]=4
  vars.avatarMotionFrame[9]=5
  vars.avatarMotionFrame[10]=5
  vars.avatarMotionFrame[11]=6
  vars.avatarMotionFrame[12]=5
  vars.avatarMotionFrame[13]=10
  vars.avatarMotionFrame[14]=8
  vars.avatarMotionFrame[15]=4
  vars.avatarMotionFrame[16]=6
  vars.avatarMotionFrame[17]=10
  vars.avatarMotionFrame[18]=0
  vars.avatarMotionFrame[19]=5
  vars.avatarMotionFrame[20]=5
  vars.avatarMotionFrame[21]=7
  vars.avatarMotionFrame[22]=3
  vars.avatarMotionFrame[23]=3
  vars.avatarMotionFrame[24]=6
  vars.avatarMotionFrame[25]=10
  vars.avatarMotionFrame[26]=8
  vars.avatarMotionFrame[27]=6
  vars.avatarMotionFrame[28]=6
  vars.avatarMotionFrame[29]=8
  vars.avatarMotionFrame[30]=2
  vars.avatarMotionFrame[31]=5
  vars.avatarMotionFrame[32]=2
  vars.avatarMotionFrame[33]=1
  vars.avatarMotionFrame[34]=5
  vars.avatarMotionFrame[35]=5
  vars.avatarMotionFrame[36]=4
  vars.avatarMotionFrame[37]=7
  vars.avatarMotionFrame[38]=6
  vars.avatarMotionFrame[39]=9
  vars.avatarMotionFrame[40]=4
  vars.avatarMotionFrame[41]=7
  vars.avatarMotionFrame[42]=6
  vars.avatarMotionFrame[43]=5
  vars.avatarMotionFrame[44]=1
  vars.avatarMotionFrame[45]=4
  vars.avatarMotionFrame[46]=2
  vars.avatarMotionFrame[47]=7
  vars.avatarMotionFrame[48]=8
  vars.avatarMotionFrame[49]=5
  vars.avatarMotionFrame[50]=8
  vars.avatarMotionFrame[51]=6
  vars.avatarMotionFrame[52]=7
  vars.avatarMotionFrame[53]=4
  vars.avatarMotionFrame[54]=7
  vars.avatarMotionFrame[55]=4
  vars.avatarMotionFrame[56]=5
  vars.avatarMotionFrame[57]=9
  vars.avatarMotionFrame[58]=3
  vars.avatarMotionFrame[59]=5
  vars.avatarSaveIsValid=1
  vars.playerType=PlayerType.AVATAR
  vars.playerCamoType=PlayerCamoType.BATTLEDRESS
  vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
  vars.playerFaceEquipId=1
  vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
  local e={{equipId=TppEquip.EQP_WP_30105,partsInfo={barrel=TppEquip.BA_30124,ammo=TppEquip.AM_30125,stock=TppEquip.SK_60304,muzzle=TppEquip.MZ_30105,muzzleOption=TppEquip.MO_30102,rearSight=TppEquip.ST_30305,frontSight=TppEquip.ST_30306,option1=TppEquip.LT_30105,option2=TppEquip.LS_40034,underBarrel=TppEquip.UB_50102,underBarrelAmmo=TppEquip.AM_40102}},{equipId=TppEquip.EQP_WP_60206,partsInfo={barrel=TppEquip.BA_60205,ammo=TppEquip.AM_30055,stock=TppEquip.SK_60203,muzzle=TppEquip.MZ_60203,muzzleOption=TppEquip.MO_60204,rearSight=TppEquip.ST_30204,frontSight=TppEquip.ST_20205,option1=TppEquip.LT_30025,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_40144,underBarrelAmmo=TppEquip.AM_40102}},{equipId=TppEquip.EQP_WP_20004,partsInfo={ammo=TppEquip.AM_20105,stock=TppEquip.SK_20002,muzzleOption=TppEquip.MO_10101,rearSight=TppEquip.ST_30114,option1=TppEquip.LT_10104}}}
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=e})
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})
end
function this.DEBUG_SetFobPlayerDefence()
  vars.avatarFaceRaceIndex=0
  vars.avatarAcceFlag=0
  vars.avatarFaceTypeIndex=1
  vars.avatarFaceVariationIndex=1
  vars.avatarFaceColorIndex=0
  vars.avatarHairStyleIndex=0
  vars.avatarRightEyeColorIndex=0
  vars.avatarRightEyeBrightnessIndex=0
  vars.avatarLeftEyeColorIndex=1
  vars.avatarLeftEyeBrightnessIndex=0
  vars.avatarHairColor=1
  vars.avatarBerdStyle=0
  vars.avatarBerdLength=1
  vars.avatarEbrwStyle=3
  vars.avatarEbrwWide=1
  vars.avatarGashOrTatoVariationIndex=0
  vars.avatarTatoColorIndex=0
  vars.avatarMotionFrame[0]=4
  vars.avatarMotionFrame[1]=9
  vars.avatarMotionFrame[2]=5
  vars.avatarMotionFrame[3]=5
  vars.avatarMotionFrame[4]=7
  vars.avatarMotionFrame[5]=1
  vars.avatarMotionFrame[6]=7
  vars.avatarMotionFrame[7]=4
  vars.avatarMotionFrame[8]=4
  vars.avatarMotionFrame[9]=5
  vars.avatarMotionFrame[10]=5
  vars.avatarMotionFrame[11]=6
  vars.avatarMotionFrame[12]=5
  vars.avatarMotionFrame[13]=10
  vars.avatarMotionFrame[14]=8
  vars.avatarMotionFrame[15]=4
  vars.avatarMotionFrame[16]=6
  vars.avatarMotionFrame[17]=10
  vars.avatarMotionFrame[18]=0
  vars.avatarMotionFrame[19]=5
  vars.avatarMotionFrame[20]=5
  vars.avatarMotionFrame[21]=7
  vars.avatarMotionFrame[22]=3
  vars.avatarMotionFrame[23]=3
  vars.avatarMotionFrame[24]=6
  vars.avatarMotionFrame[25]=10
  vars.avatarMotionFrame[26]=8
  vars.avatarMotionFrame[27]=6
  vars.avatarMotionFrame[28]=6
  vars.avatarMotionFrame[29]=8
  vars.avatarMotionFrame[30]=2
  vars.avatarMotionFrame[31]=5
  vars.avatarMotionFrame[32]=2
  vars.avatarMotionFrame[33]=1
  vars.avatarMotionFrame[34]=5
  vars.avatarMotionFrame[35]=5
  vars.avatarMotionFrame[36]=4
  vars.avatarMotionFrame[37]=7
  vars.avatarMotionFrame[38]=6
  vars.avatarMotionFrame[39]=9
  vars.avatarMotionFrame[40]=4
  vars.avatarMotionFrame[41]=7
  vars.avatarMotionFrame[42]=6
  vars.avatarMotionFrame[43]=5
  vars.avatarMotionFrame[44]=1
  vars.avatarMotionFrame[45]=4
  vars.avatarMotionFrame[46]=2
  vars.avatarMotionFrame[47]=7
  vars.avatarMotionFrame[48]=8
  vars.avatarMotionFrame[49]=5
  vars.avatarMotionFrame[50]=8
  vars.avatarMotionFrame[51]=6
  vars.avatarMotionFrame[52]=7
  vars.avatarMotionFrame[53]=4
  vars.avatarMotionFrame[54]=7
  vars.avatarMotionFrame[55]=4
  vars.avatarMotionFrame[56]=5
  vars.avatarMotionFrame[57]=9
  vars.avatarMotionFrame[58]=3
  vars.avatarMotionFrame[59]=5
  vars.avatarSaveIsValid=1
  vars.playerType=PlayerType.AVATAR
  vars.playerCamoType=PlayerCamoType.BATTLEDRESS
  vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
  vars.playerFaceEquipId=1
  vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
  local e={{equipId=TppEquip.EQP_WP_30235,partsInfo={barrel=TppEquip.BA_30214,ammo=TppEquip.AM_30232,stock=TppEquip.SK_30205,muzzle=TppEquip.MZ_30232,muzzleOption=TppEquip.MO_30235,rearSight=TppEquip.ST_30202,frontSight=TppEquip.ST_30114,option1=TppEquip.LT_40103,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_50002,underBarrelAmmo=TppEquip.AM_50002}},{equipId=TppEquip.EQP_WP_60317,partsInfo={barrel=TppEquip.BA_30044,ammo=TppEquip.AM_30102,stock=TppEquip.SK_60205,muzzle=TppEquip.MZ_30213,muzzleOption=TppEquip.MO_30105,rearSight=TppEquip.ST_50303,option1=TppEquip.LT_30025,option2=TppEquip.LS_30104,underBarrel=TppEquip.UB_40043,underBarrelAmmo=TppEquip.AM_40001}},{equipId=TppEquip.EQP_WP_20215,partsInfo={ammo=TppEquip.AM_20106,stock=TppEquip.SK_20216,muzzleOption=TppEquip.MO_20205,rearSight=TppEquip.ST_60102,option1=TppEquip.LS_10415}}}
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=e})
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})
end
function this.DEBUG_SetFullBuildingLv2()
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=5,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=5,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=6,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=7,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=8,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=9,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=10,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=11,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=12,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=13,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=14,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=15,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=16,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=17,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=18,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=19,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=20,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=21,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=22,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=23,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=24,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=25,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=26,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=27,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=7,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=8,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=9,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=10,buildingId=2047294370,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=10,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=11,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=12,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=13,buildingId=1863642738,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=13,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=14,buildingId=3112186681,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=15,buildingId=437535977,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=15,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=15,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=16,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=17,buildingId=3112186681,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=17,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=18,buildingId=1863642738,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=18,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=19,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=20,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=21,buildingId=2047294370,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=21,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=22,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=23,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=24,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=6,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=7,buildingId=1093098322,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=13,buildingId=1409296845,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=18,buildingId=1409296845,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=24,buildingId=1093098322,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=8,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=8,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=9,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=11,buildingId=3117056327,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=15,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=17,buildingId=2257713863,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=19,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=20,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=21,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=22,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=23,buildingId=383879117,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=16,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=18,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=23,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=9,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=6,buildingId=2047294370,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=10,buildingId=3720622844,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=20,buildingId=3021102576,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=25,buildingId=2047294370,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=13,buildingId=2613037565,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=18,buildingId=2613037565,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=24,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=11,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=7,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=9,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=12,buildingId=580776287,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=15,buildingId=3143437912,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=17,buildingId=3143437912,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=22,buildingId=1820501102,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=24,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=6,buildingId=1863642738,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=11,buildingId=1054361841,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=12,buildingId=1054361841,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=25,buildingId=1863642738,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=5,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=6,buildingId=2796709262,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=9,buildingId=3689573976,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=10,buildingId=4234203837,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=11,buildingId=1404046253,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=12,buildingId=2703659172,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=20,buildingId=1644834109,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=22,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=25,buildingId=2796709262,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=14,col=27,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=6,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=8,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=12,buildingId=2613037565,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=22,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=24,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=25,buildingId=437535977,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=25,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=26,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=27,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=7,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=16,buildingId=2625649824,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=23,buildingId=3957950430,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=26,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=27,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=5,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=6,buildingId=2796709262,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=8,buildingId=4116412189,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=10,buildingId=2223843695,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=11,buildingId=2506757893,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=12,buildingId=863306859,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=21,buildingId=2613037565,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=22,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=25,buildingId=2796709262,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=25,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=27,buildingId=163668932,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=6,buildingId=1863642738,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=12,buildingId=3376579107,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=20,buildingId=1397617911,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=25,buildingId=1863642738,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=18,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=12,buildingId=2116940568,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=13,buildingId=3945085880,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=14,buildingId=3578620159,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=15,buildingId=3803098091,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=20,buildingId=835115097,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=23,buildingId=1409296845,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=8,buildingId=1644834109,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=10,buildingId=944156047,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=13,buildingId=979467397,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=14,buildingId=1643368598,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=15,buildingId=1409296845,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=19,buildingId=3517572710,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=20,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=15,buildingId=3182362963,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=16,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=25,buildingId=2047294370,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=11,buildingId=714016154,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=13,buildingId=159237363,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=15,buildingId=3182362963,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=17,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=19,buildingId=3830834128,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=23,buildingId=383879117,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=7,buildingId=3720622844,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=9,buildingId=3737545838,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=10,buildingId=944156047,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=13,buildingId=3284077456,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=16,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=20,buildingId=3284077456,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=6,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=15,buildingId=186472885,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=17,buildingId=3957950430,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=19,buildingId=3517572710,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=21,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=22,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=25,buildingId=1093098322,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=26,buildingId=3525131870,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=5,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=9,buildingId=2047294370,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=11,buildingId=1697219898,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=13,buildingId=3117056327,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=15,buildingId=1863642738,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=16,buildingId=1002106857,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=16,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=18,buildingId=1863642738,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=18,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=21,buildingId=2047294370,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=27,buildingId=3383408509,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=5,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=7,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=8,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=9,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=10,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=11,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=12,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=13,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=14,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=15,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=16,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=17,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=18,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=19,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=20,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=21,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=22,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=23,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=24,buildingId=3525131870,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=27,buildingId=3550945654,edgeType=1}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=5,buildingId=3550945654,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=6,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=7,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=8,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=9,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=10,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=11,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=12,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=13,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=14,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=15,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=16,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=17,buildingId=163668932,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=18,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=19,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=20,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=21,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=22,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=23,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=24,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=25,buildingId=3383408509,edgeType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=27,col=26,buildingId=3550945654,edgeType=0}
end
function this.DEBUG_SetZombieBaitParam()
  for a,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
    if GameObject.DoesGameObjectExistWithTypeName(e)then
      local e=string.sub(e,4).."Dev"
      DebugMenu.SetDebugMenuValue(e,"WaveSearchRange",14)
      DebugMenu.SetDebugMenuValue(e,"WaveNoiseRange",25)
      DebugMenu.SetDebugMenuValue(e,"PlayerNoiseRange",10)
    end
  end
end
function this.QARELEASE_DEBUG_Init()
  local e
  if DebugMenu then
    e=DebugMenu
  else
    return
  end
  mvars.qaDebug.returnSelect=false
  e.AddDebugMenu(" Select","Return select","bool",mvars.qaDebug,"returnSelect")
  e.AddDebugMenu("LuaSystem","showSysVars","bool",gvars,"DEBUG_showSysVars")
  e.AddDebugMenu("LuaSystem","gameStatus","bool",gvars,"DEBUG_showGameStatus")
  mvars.qaDebug.warpToBase=false
  e.AddDebugMenu(" DebugWarp","WarpToBase","bool",mvars.qaDebug,"warpToBase")
  mvars.qaDebug.forceCheckPointSave=false
  e.AddDebugMenu("LuaSystem","ForceCheckPointSave","bool",mvars.qaDebug,"forceCheckPointSave")
  mvars.qaDebug.forceMissionReload=false
  e.AddDebugMenu("LuaSystem","MissionReload","bool",mvars.qaDebug,"forceMissionReload")
  mvars.qaDebug.showWeaponVars=false
  e.AddDebugMenu("LuaSystem","ShowWeaponVars","bool",mvars.qaDebug,"showWeaponVars")
  mvars.qaDebug.showPlayerPartsType=false
  e.AddDebugMenu("LuaSystem","ShowPlayerPartsType","bool",mvars.qaDebug,"showPlayerPartsType")
  mvars.qaDebug.setFobForGPU=false
  e.AddDebugMenu("LuaSystem","setFobForGPU","bool",mvars.qaDebug,"setFobForGPU")
  mvars.qaDebug.setInitialInventory=false
  e.AddDebugMenu("LuaSystem","setInitialInventory","bool",mvars.qaDebug,"setInitialInventory")
  mvars.qaDebug.setInitialBuilding=false
  e.AddDebugMenu("LuaSystem","setInitialBuilding","bool",mvars.qaDebug,"setInitialBuilding")
  mvars.qaDebug.resetAllBuilding=false
  e.AddDebugMenu("LuaSystem","resetAllBuilding","bool",mvars.qaDebug,"resetAllBuilding")
  mvars.qaDebug.setFullBuildingLv2=false
  e.AddDebugMenu("LuaSystem","setFullBuildingLv2","bool",mvars.qaDebug,"setFullBuildingLv2")
  mvars.qaDebug.showUnlockedFastTravel=false
  e.AddDebugMenu("LuaSystem","showUnlockedFastTravel","bool",mvars.qaDebug,"showUnlockedFastTravel")
  mvars.qaDebug.showSavedGVarsFlag=false
  e.AddDebugMenu("LuaSystem","showSavedGVarsFlag","bool",mvars.qaDebug,"showSavedGVarsFlag")
  mvars.qaDebug.setZombieBaitParam=false
  e.AddDebugMenu(" <Ssd>","setZombieBaitParam","bool",mvars.qaDebug,"setZombieBaitParam")
  mvars.qaDebug.showEventTask=false
  e.AddDebugMenu("LuaUI","showEventTask","bool",mvars.qaDebug,"showEventTask")
  mvars.qaDebug.returnToAfghBase=false
  e.AddDebugMenu(" MatchingRoom","ReturnToAfghBase","bool",mvars.qaDebug,"returnToAfghBase")
  mvars.qaDebug.returnToMafrBase=false
  e.AddDebugMenu(" MatchingRoom","ReturnToMafrBase","bool",mvars.qaDebug,"returnToMafrBase")
  mvars.qaDebug.returnToMatchingRoom=false
  e.AddDebugMenu(" MatchingRoom","ReturnToMatchingRoom","bool",mvars.qaDebug,"returnToMatchingRoom")
end
function this.QAReleaseDebugUpdate()
  local svars=svars
  local mvars=mvars
  local DebugPrint=DebugText.Print
  local context=DebugText.NewContext()
  if mvars.qaDebug then
    local e=(DebugMenu.GetDebugMenuValue(" <Ssd>","OfflineMode")=="ON")
    if e then
      DebugPrint(context,{1,.1,.1},"OFFLINE MODE")
    end
  end
  if mvars.qaDebug.returnSelect then
    TppUI.FadeOut(0)
    SsdUiSystem.RequestForceClose()
    TitleMenuSystem.RequestClose()
    TppSave.ReserveVarRestoreForMissionStart()
    TppMission.SafeStopSettingOnMissionReload()
    tpp_editor_menu2.StartTestStage(6e4)
    mvars.qaDebug.returnSelect=false
  end
  if mvars.qaDebug.warpToBase then
    local basePositions={afgh=Vector3(-442,288,2239),mafr=Vector3(2790,96,-910)}
    if mvars.ply_deliveryWarpState~=TppPlayer.DELIVERY_WARP_STATE.START_WARP then
      local pos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
      local locationName=TppLocation.GetLocationName()
      if basePositions[locationName]then
        pos=basePositions[locationName]
      end
      mvars.qaDebug.warpToBase=false
      local playerId={type="TppPlayer2",index=0}
      local command={id="WarpAndWaitBlock",pos=pos,unrealize=true}
      GameObject.SendCommand(playerId,command)
    end
  end
  if mvars.seq_doneDumpCanMissionStartRefrainIds then
    DebugPrint(context,{1,0,0},"TppSequence: Mission.CanStart() wait is time out!\nPlease screen shot [Mission > ViewStartRefrain > true] , [Pause > ShowFlags > true] and [Pause > ShowInstances > true]")
  end
  if TppSave.DEBUG_EraseAllGameDataCounter then
    if TppSave.DEBUG_EraseAllGameDataCounter>0 then
      DebugPrint(context,{1,.5,.5},"TppSave.EraseAllGameDataSaveRequest : erase game data save request!")
      TppSave.DEBUG_EraseAllGameDataCounter=TppSave.DEBUG_EraseAllGameDataCounter-Time.GetFrameTime()
    else
      TppSave.DEBUG_EraseAllGameDataCounter=nil
    end
  end
  if mvars.qaDebug.forceCheckPointSave then
    mvars.qaDebug.forceCheckPointSave=false
    TppMission.VarSaveOnUpdateCheckPoint()
  end
  if gvars.DEBUG_showSysVars then
    local e=this.DEBUG_GetSysVarsLog()
    DebugPrint(context,{.5,.5,1},"LuaSystem showSysVars")
    DebugPrint(context,"hordeTimer = "..tostring(vars.timeUntilNextHorde))
    for a,e in ipairs(e)do
      DebugPrint(context,e)
    end
    local fobModeToString={[FobMode.MODE_ACTUAL]="MODE_ACTUAL",[FobMode.MODE_SHAM]="MODE_SHAM",[FobMode.MODE_VISIT]="MODE_VISIT",[FobMode.MODE_NONE]="MODE_NONE"}
    DebugPrint(context,"killCount = "..tostring(svars.killCount))DebugPrint(context,"totalKillCount = "..tostring(gvars.totalKillCount))
  end
  if gvars.DEBUG_showGameStatus then
    DebugPrint(context,"")DebugPrint(context,{.5,.5,1},"LuaSystem gameStatus")
    for a,e in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local e=TppGameStatus.IsSet("TppMain.lua",a)
      if e then
        DebugPrint(context," statusType = "..(tostring(a)..(", IsSet = "..tostring(e))))
      end
    end
    local e=TppGameStatus.IsSet("TppMain.lua","S_IS_BLACK_LOADING")
    if e then
      DebugPrint(context," statusType = "..(tostring"S_IS_BLACK_LOADING"..(", IsSet = "..tostring(e))))
    end
    DebugPrint(context,"UIStatus")
    local e={{CallMenu="INVALID"},{PauseMenu="INVALID"},{EquipHud="INVALID"},{EquipPanel="INVALID"},{CqcIcon="INVALID"},{ActionIcon="INVALID"},{AnnounceLog="SUSPEND_LOG"},{AnnounceLog="INVALID_LOG"},{BaseName="INVALID"},{Damage="INVALID"},{Notice="INVALID"},{HeadMarker="INVALID"},{WorldMarker="INVALID"},{HudText="INVALID"},{GmpInfo="INVALID"},{AtTime="INVALID"},{InfoTypingText="INVALID"},{ResourcePanel="SHOW_IN_HELI"}}
    for a,e in pairs(e)do
      for a,e in pairs(e)do
        if(TppUiStatusManager.CheckStatus(a,e)==true)then
          DebugPrint(context,string.format(" UI = %s, Status = %s",a,e))
        end
      end
    end
  end
  if mvars.qaDebug.showWeaponVars then
    local e={"PRIMARY_HIP","PRIMARY_BACK","SECONDARY"}DebugPrint(context,{.5,.5,1},"LuaSystem WeaponVars")
    for a,e in ipairs(e)do
      local a=TppDefine.WEAPONSLOT[e]DebugPrint(context,string.format("Slot:%16s : vars.initWeapons = %04d, vars.weapons = %04d",e,vars.initWeapons[a],vars.weapons[a]))
    end
    for e=0,7 do
      DebugPrint(context,string.format("Slot:%d : vars.supportWeapons = %04d, vars.initSupportWeapons = %04d, gvars.ply_lastWeaponsUsingTemp = %04d",e,vars.supportWeapons[e],vars.initSupportWeapons[e],gvars.ply_lastWeaponsUsingTemp[e+TppDefine.WEAPONSLOT.SUPPORT_0]))
    end
    for e=0,7 do
      DebugPrint(context,string.format("Slot:%d : vars.items = %04d, vars.initItems = %04d, gvars.ply_lastItemsUsingTemp = %04d",e,vars.items[e],vars.initItems[e],gvars.ply_lastItemsUsingTemp[e]))
    end
  end
  if mvars.qaDebug.showPlayerPartsType then
    DebugPrint(context,{.5,.5,1},"LuaSystem ShowPlayerPartsType")DebugPrint(context,"gvars.ply_isUsingTempPlayerType = "..tostring(gvars.ply_isUsingTempPlayerType))
    DebugPrint(context,string.format("vars.playerPartsType = %04d, gvars.ply_lastPlayerPartsTypeUsingTemp = %04d",vars.playerPartsType,gvars.ply_lastPlayerPartsTypeUsingTemp))
    DebugPrint(context,string.format("vars.playerCamoType = %04d, gvars.ply_lastPlayerCamoTypeUsingTemp = %04d",vars.playerCamoType,gvars.ply_lastPlayerCamoTypeUsingTemp))
    DebugPrint(context,string.format("vars.playerType = %04d, gvars.ply_lastPlayerTypeUsingTemp = %04d",vars.playerType,gvars.ply_lastPlayerTypeUsingTemp))
  end
  if mvars.qaDebug.gotFobStatusCount then
    DebugPrint(context,{.5,.5,1},">> Done TppServerManager.GetFobStatus()")mvars.qaDebug.gotFobStatusCount=mvars.qaDebug.gotFobStatusCount+1
    if mvars.qaDebug.gotFobStatusCount>120 then
      mvars.qaDebug.gotFobStatusCount=nil
    end
  end
  if mvars.qaDebug.setFobForGPU then
    mvars.qaDebug.setFobForGPU=false
    this.DEBUG_FobGPU()
  end
  if mvars.qaDebug.showEventTask then
    if not mvars.ui_eventTaskDefine then
      mvars.qaDebug.showEventTask=false
      return
    end
    DebugPrint(context,{.5,.5,1},"LuaUI ShowEventTask")
    local function d(i,e,d)
      local t
      if FobUI.IsCompleteEventTask(e,d)then
        t=" o "else
        t=" x "end
      local n=i[e]and i[e].detectType
      if n then
        local a=mvars.qaDebug.debugEventTaskTextTable and mvars.qaDebug.debugEventTaskTextTable[n]
        if not a then
          a="threshold is"
        end
        DebugPrint(context,string.format("   Task %1d : [%s] %s %06.2f : ( Current %06.2f )",e,t,a,i[e].threshold,FobUI.GetCurrentEventTaskValue(e,d)))
      end
    end
    DebugPrint(context,{.5,1,.5},"FobSneak eventTask")
    for o=0,7 do
      local e=mvars.ui_eventTaskDefine.sneak
      if e and e[o]then
        d(e,o,true)
      end
    end
    DebugPrint(context,{.5,1,.5},"FobDefence eventTask")
    for r=0,7 do
      local e=mvars.ui_eventTaskDefine.defence
      if e and e[r]then
        d(e,r,false)
      end
    end
  end
  if mvars.qaDebug.forceMissionReload then
    mvars.qaDebug.forceMissionReload=false
    TppMission.Reload()
  end
  if mvars.qaDebug.setInitialInventory then
    mvars.qaDebug.setInitialInventory=false
    SsdSbm.AddProduction{id="PRD_EQP_WP_Machete_A",tryEquip=true}
    SsdSbm.AddProduction{id="PRD_ACC_Body_21",tryEquip=true}
    SsdSbm.AddProduction{id="PRD_ACC_Foot_03",tryEquip=true}
    SsdSbm.AddProduction{id="PRD_ACC_Arm_06",tryEquip=true}
  end
  if mvars.qaDebug.setInitialBuilding then
    mvars.qaDebug.setInitialBuilding=false
    TppVarInit.InitializeBuildingData(true)
  end
  if mvars.qaDebug.resetAllBuilding then
    mvars.qaDebug.resetAllBuilding=false
    SsdBuilding.DEBUG_RemoveAllNetwork()
  end
  if mvars.qaDebug.setFullBuildingLv2 then
    mvars.qaDebug.setFullBuildingLv2=false
    this.DEBUG_SetFullBuildingLv2()
  end
  if(mvars.qaDebug.returnToAfghBase or mvars.qaDebug.returnToMafrBase)or mvars.qaDebug.returnToMatchingRoom then
    if not TppMission.IsMatchingRoom()then
      mvars.qaDebug.returnToAfghBase=false
      mvars.qaDebug.returnToMafrBase=false
      mvars.qaDebug.returnToMatchingRoom=false
    end
  end
  if mvars.qaDebug.showUnlockedFastTravel then
    DebugPrint(context,{.5,.5,1},"showUnlockedFastTravel")
    if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
      local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
      for e,a in ipairs(fastTravelPointTableList)do
        local identifierLinkName=a.identifierLinkName
        local isUnloacked=FastTravelSystem.IsUnlocked{identifierLinkName=identifierLinkName}
        if isUnloacked then
          DebugPrint(context,tostring(identifierLinkName)..(" / "..tostring(a.mapIconNameMessageID)))
        end
      end
    end
  end
  if mvars.qaDebug.showSavedGVarsFlag then
    DebugPrint(context,{.5,.5,1},"showServerSavedGVarsFlag")
    if TppGVars.DeclareGVarsTable then
      for a,e in ipairs(TppGVars.DeclareGVarsTable)do
        if e.server then
          local e=e.name
          DebugPrint(context,"gvars."..(tostring(e)..(" : "..tostring(gvars[e]))))
        end
      end
    end
  end
  if mvars.qaDebug.setZombieBaitParam then
    mvars.qaDebug.setZombieBaitParam=false
    this.DEBUG_SetZombieBaitParam()
  end
end
if Tpp.IsQARelease()then
  return this
end
function this.Print2D(a)
  if(a==nil)then
    return
  end
  local o=a.showTime or(3*30)
  local n=a.xPos or 25
  local i=a.yPos or 425
  local t=a.size or 20
  local r=a.color or"white"local a=a.text or""r=this._GetColor(r)
  GrxDebug.Print2D{life=o,x=n,y=i,size=t,color=r,args={a}}
end
function this.DEBUG_MakeUserSVarList(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.dbg_userSaveVarList={}
  for a,e in pairs(e)do
    table.insert(mvars.dbg_userSaveVarList,e.name)
  end
end
function this.AddReturnToSelector(e)
  e:AddItem("< return",DebugSelector.Pop)
end
function this.DEBUG_Init()
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
function this.DEBUG_OnReload(missionTable)
  perfTimes={}
  c={}
  perfCheckTimesStrings={}
  t=0
  d=0
  this.PERF_CHECK_TYPE=Tpp.Enum(this.PERF_CHECK_TYPE)
  local strings={}
  ApendArray(strings,TppDbgStr32.DEBUG_strCode32List)
  for k,v in pairs(missionTable)do
    if v.DEBUG_strCode32List then
      ApendArray(strings,v.DEBUG_strCode32List)
    end
  end
  TppDbgStr32.DEBUG_RegisterStrcode32invert(strings)
end
function this.DebugUpdate()
  local svars=svars
  local mvars=mvars
  local debug=mvars.debug
  local DebugPrint=DebugText.Print
  local context=DebugText.NewContext()
  if(not TppUiCommand.IsEndMissionTelop())then
    DebugPrint(context,{.5,.5,1},"Now showing result.")
  end
  if gvars.needWaitMissionInitialize then
    DebugPrint(context,{.5,.5,1},"Now neew wait mission initialize.")
  end
  if debug.showSVars then
    DebugPrint(context,"")DebugPrint(context,{.5,.5,1},"LuaMission DBG.showSVars")
    for k,v in pairs(mvars.dbg_userSaveVarList)do
      DebugPrint(context,string.format(" %s = %s",tostring(v),tostring(svars[v])))
    end
  end
  if debug.showMVars then
    DebugPrint(context,{.5,.5,1},"LuaMission DBG.showMVars")
    for k,v in pairs(mvars)do
      DebugPrint(context,string.format(" %s = %s",tostring(k),tostring(v)))
    end
  end
  if debug.showMissionArea then
    DebugPrint(context,{.5,.5,1},"LuaMission MIS.missionArea")
    local e
    if mvars.mis_isOutsideOfMissionArea then
      e="Outside"
    else
      e="Inside"
    end
    DebugPrint(context,"outerZone : "..e)
    if mvars.mis_isAlertOutOfMissionArea then
      e="Outside"
    else
      e="Inside"
    end
    DebugPrint(context,"innerZone : "..e)
    if mvars.mis_isOutsideOfHotZone then
      e="Outside"
    else
      e="Inside"
    end
    DebugPrint(context,"hotZone : "..e)
    DebugPrint(context,"hotZone clear check : isNotAlert = "..(tostring(mvars.debug.notHotZone_isNotAlert)..(", isPlayerStatusNormal = "..(tostring(mvars.debug.notHotZone_isPlayerStatusNormal)..(", isNotHelicopter = "..tostring(mvars.debug.notHotZone_isNotHelicopter))))))
    DebugPrint(context,"Mission clear timer: "..tostring(IsTimerActive"Timer_OutsideOfHotZoneCount"))
    DebugPrint(context,{.5,1,.5},"Recent all target status")
    local checkedTargetStatus=mvars.debug.checkedTargetStatus or{}
    for e,a in pairs(checkedTargetStatus)do
      DebugPrint(context,"  TargetName = "..(e..(" : "..a)))
    end
  end
  if mvars.debug.showClearState then
    DebugPrint(context,{.5,.5,1},"LuaMission MIS.showClearState")
    DebugPrint(context,"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]))
  end
  if mvars.debug.openEmergencyTimer then
    mvars.debug.openEmergencyTimer=false
    if mvars.mis_openEmergencyMissionTimerName then
      GkEventTimerManager.Stop(mvars.mis_openEmergencyMissionTimerName)GkEventTimerManager.Start(mvars.mis_openEmergencyMissionTimerName,1)
    end
  end
  if mvars.debug.closeEmergencyTimer then
    mvars.debug.closeEmergencyTimer=false
    if mvars.mis_closeEmergencyMissionTimerName then
      GkEventTimerManager.Stop(mvars.mis_closeEmergencyMissionTimerName)GkEventTimerManager.Start(mvars.mis_closeEmergencyMissionTimerName,1)
    end
  end
  if debug.showSysSVars then
    DebugPrint(context,"")DebugPrint(context,{.5,.5,1},"LuaSystem DBG.showSysSVars")
    for e,a in pairs(svars.__as)do
      if(a<=1)then
        DebugPrint(context,string.format(" %s = %s",tostring(e),tostring(svars[e])))
      else
        DebugPrint(context,string.format(" %s = %s",tostring(e),tostring(a)))
        for a=0,(a-1)do
          DebugPrint(context,string.format("   %s[%d] = %s",tostring(e),a,tostring(svars[e][a])))
        end
      end
    end
  end
  if debug.showDebugPerfCheck then
    DebugPrint(context,{.5,.5,1},"LuaSystem DBG.showPerf")
    for i,a in pairs(perfCheckTimesStrings)do
      DebugPrint(context," perf["..(this.PERF_CHECK_TYPE[i]..("] = "..a)))
    end
  end
  if mvars.debug.AnimalBlock then
    DebugPrint(context,{.5,.5,1},"LuaSystem DBG.AnimalBlock")
    local t,i=Tpp.GetCurrentStageSmallBlockIndex()
    DebugPrint(context,string.format("current block position (x,y) = (%03d, %03d)",t,i))
    DebugPrint(context,"Load animal block area = "..tostring(mvars.animalBlockAreaName))
    local t=ScriptBlock.GetScriptBlockId"animal_block"local i
    if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
      i=ScriptBlock.GetScriptBlockState(t)
    end
    local t
    if i==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
      t="SCRIPT_BLOCK_STATE_EMPTY"elseif i==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING then
      t="SCRIPT_BLOCK_STATE_PROCESSING"elseif i==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
      t="SCRIPT_BLOCK_STATE_INACTIVE"elseif i==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
      t="SCRIPT_BLOCK_STATE_ACTIVE"end
    DebugPrint(context,"animal block state : "..tostring(t))
    if mvars.animalBlockScript then
      DebugPrint(context,"animalBlockScript exist")
      local i=""if mvars.animalBlockScript.OnMessage then
        i="exist"else
        i="  not"end
      local t=""if mvars.animalBlockScript.OnReload then
        t="exist"else
        t="  not"end
      DebugPrint(context,"OnMessage "..(tostring(i)..(" OnReload "..tostring(t))))
      this.ShowMessageTable(context,"MessageTable",mvars.animalBlockScript.messageExecTable)
    else
      if i==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or i==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
        DebugPrint(context,{1,0,0},"this data is invalid!!!! please check data!!!")
      else
        DebugPrint(context,"animalBlockScript   not")
      end
    end
  end
  if mvars.debug.ply_intelTrap then
    DebugPrint(context,{.5,.5,1},"LuaSystem PLY.intelTrap")
    for e,a in pairs(mvars.ply_intelTrapInfo)do
      if Tpp.IsTypeString(e)then
        DebugPrint(context,{.5,1,.5},"intelName = "..tostring(e))
        for a,e in pairs(a)do
          DebugPrint(context,tostring(a)..(" = "..tostring(e)))
        end
      end
    end
  end
  if(debug.showSubscriptMessageTable>0)then
    DebugPrint(context,{.5,.5,1},"LuaMessage subScripts")
    local o={"sequence","enemy","demo","radio","sound"}
    local o=o[mvars.debug.showSubscriptMessageTable]
    if o then
      local i=TppMission.GetMissionName()..("_"..o)
      if mvars.rad_subScripts[o]then
        local a=mvars.rad_subScripts[o]._messageExecTable
        this.ShowMessageTable(context,i,a)
      end
    end
  end
  if(debug.showSequenceMessageTable>0)then
    DebugPrint(context,{.5,.5,1},"LuaMessage sequence")
    local o=TppSequence.GetSequenceNameWithIndex(mvars.debug.showSequenceMessageTable)
    if mvars.seq_sequenceTable then
      local a=mvars.seq_sequenceTable[o]
      if a then
        local a=a._messageExecTable
        this.ShowMessageTable(context,o,a)
      end
    end
  end
  if(debug.showLocationMessageTable>0)then
    DebugPrint(context,{.5,.5,1},"LuaMessage location")
  end
  if(debug.showLibraryMessageTable>0)then
    DebugPrint(context,{.5,.5,1},"LuaMessage library")
    local a=Tpp._requireList[debug.showLibraryMessageTable]
    local o=_G[a].messageExecTable
    this.ShowMessageTable(context,a,o)
  end
  if mvars.debug.showWeaponSelect then
    DebugPrint(context,{.5,.5,1},"LuaWeapon")
    if mvars.debug.weaponCategory<1 then
      mvars.debug.weaponCategory=1
    end
    if mvars.debug.weaponCategory>#mvars.debug.weaponCategoryList then
      mvars.debug.weaponCategory=#mvars.debug.weaponCategoryList
    end
    local e=mvars.debug.weaponCategory
    local t=mvars.debug.weaponCategoryList[mvars.debug.weaponCategory]
    DebugPrint(context,{.5,1,.5},"Current weapon category : "..t[1])
    local l,s
    local e,i,n=0,1,5
    if mvars.debug.selectedWeaponId>0 then
      i=mvars.debug.selectedWeaponId
    end
    for a,u in pairs(TppEquip)do
      local g=string.sub(a,1,t[2])
      local d=false
      for a,e in ipairs(t[3])do
        if g==e then
          d=true
        end
      end
      if d then
        e=e+1
        if(i-e)<=n then
          if e==i then
            l=u
            s=a
            DebugPrint(context,{.5,1,.5},"> EquipId = TppEquip."..a)
          else
            DebugPrint(context,"  EquipId = TppEquip."..a)
          end
        end
        if e==(i+n)then
          break
        end
      end
    end
    if mvars.debug.enableWeaponChange then
      GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId={l}})
      mvars.debug.enableWeaponChange=false
    end
  end
end
function this.ShowMessageTable(context,o,r)
  local DebugPrint=DebugText.Print
  DebugPrint(context,{.5,1,.5},o)
  if r==nil then
    return
  end
  for o,r in pairs(r)do
    local i=DEBUG_StrCode32ToString(o)
    if r then
      for o,r in pairs(r)do
        local o=DEBUG_StrCode32ToString(o)
        if r.func then
          DebugPrint(context,{1,1,1},i..(" : "..(o..(" : "..tostring(r.func)))))
        end
        local r=r.sender
        if r then
          for t,r in pairs(r)do
            DebugPrint(context,{1,1,1},i..(" : "..(o..(" : Sender = "..(DEBUG_StrCode32ToString(t)..(" : "..tostring(r)))))))
          end
        end
      end
    end
  end
end
function this.PerfCheckStart(a)
  local this=this
  if((a<=0)and(a>#this.PERF_CHECK_TYPE))then
    return
  end
  if(a==this.PERF_CHECK_TYPE.OnUpdate)then
    if(perfTimes[this.PERF_CHECK_TYPE.OnUpdate]~=nil)then
      t=t+(os.clock()-perfTimes[this.PERF_CHECK_TYPE.OnUpdate])
    end
  end
  perfTimes[a]=os.clock()
end
function this.PerfCheckEnd(perfCheckTypeEnum,r)
  local mvars=mvars
  local this=this
  if((perfCheckTypeEnum<=0)and(perfCheckTypeEnum>#this.PERF_CHECK_TYPE))then
    return
  end
  local l=r or""
  local e=0
  local perfDelta=os.clock()-perfTimes[perfCheckTypeEnum]
  if(perfCheckTypeEnum==this.PERF_CHECK_TYPE.OnUpdate)then
    if(t<p)then
      if(perfDelta>d)then
        d=perfDelta
      end
    else
      t=0
      d=perfDelta
    end
    e=d
  else
    e=perfDelta
  end
  perfCheckTimesStrings[perfCheckTypeEnum]=string.format("%4.2f",e*1e3)..("ms."..l)
  if mvars.debug and mvars.debug.showDebugPerfCheck then
    if(e>1/60)then
    else
      if(perfCheckTypeEnum~=this.PERF_CHECK_TYPE.OnUpdate)then
      end
    end
  end
end
function this.ErrorNotSupportYet(e)
end
function this._GetColor(colorName)
  local color=this.Colors[colorName]
  if(color==nil)then
    return nil
  end
  return color
end
return this
