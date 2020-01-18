local e={}
local n=Fox.StrCode32
local t=GameObject.GetGameObjectId
local r=GameObject.NULL_ID
local p=Tpp.IsTypeTable
local g=Tpp.IsTypeString
local _=Tpp.IsTypeNumber
local d=GameObject.SendCommand
e.GoalTypes={none="GOAL_NONE",moving="GOAL_MOVE",attack="GOAL_ATTACK",defend="GOAL_DEFENSE",moving_fix="GOAL_MOVE_FIX"}e.ViewTypes={map={"VIEW_MAP_GOAL"},all={"VIEW_MAP_GOAL","VIEW_WORLD_GOAL"},map_only_icon={"VIEW_MAP_ICON"},map_and_world_only_icon={"VIEW_MAP_ICON","VIEW_WORLD_ICON"}}
function e.Messages()
  return Tpp.StrCode32Table{Player={{msg="LookingTarget",func=function(r,a)e._OnSearchTarget(a,r,"LookingTarget")
    end}},GameObject={{msg="Carried",func=function(a,r)
    if r==0 then
      e._OnSearchTarget(a,nil,"Carried")
    end
    end},{msg="Restraint",func=function(a,r)
      if r==0 then
        e._OnSearchTarget(a,nil,"Restraint")
      end
    end}},Marker={{msg="ChangeToEnable",func=e._OnMarkerChangeToEnable}},nil}
end
function e.Enable(c,s,m,T,i,d,h,f,l,o,p)
  local a
  if Tpp.IsTypeString(c)then
    a=t(c)
  elseif Tpp.IsTypeNumber(c)then
    a=c
  else
    return
  end
  if a==r then
    return
  end
  if(not e._CanSetMarker(a))then
    return
  end
  s=s or 0
  m=m or"moving"T=T or"map"i=i or 9
  if(type(s)~="number")then
    return
  end
  if(s<0 or s>9)then
    return
  end
  if(type(i)~="number")then
    return
  end
  if(i<0 or i>9)then
    return
  end
  local r=e.GoalTypes[m]if(r==nil)then
    return
  end
  local e=e.ViewTypes[T]if(e==nil)then
    return
  end
  TppMarker2System.EnableMarker{gameObjectId=a,viewLayer=e}
  local e={gameObjectId=a,radiusLevel=s,goalType=r,randomLevel=i}
  TppMarker2System.SetMarkerGoalType(e)
  if d~=nil then
    local e={gameObjectId=a,isImportant=d}
    TppMarker2System.SetMarkerImportant(e)
  end
  if h~=nil then
    local e={gameObjectId=a,isNew=h}
    TppMarker2System.SetMarkerNew(e)
  end
  if p~=nil then
    local e={gameObjectId=a,isInterrogation=p}
    if TppMarker2System.SetMarkerInterrogation then
      TppMarker2System.SetMarkerInterrogation(e)
    end
  end
  if f~=nil then
    local e=n(f)
    TppUiCommand.RegisterMapRadio(a,e)
  end
  if l~=nil then
    if o~=nil then
      TppUiCommand.RegisterIconUniqueInformation{markerId=a,iconLangId=l,goalLangId=o}
    else
      TppUiCommand.RegisterIconUniqueInformation{markerId=a,langId=l}
    end
  elseif o~=nil then
    TppUiCommand.RegisterIconUniqueInformation{markerId=a,goalLangId=o}
  end
end
function e.Disable(n,i,s)
  local a
  if g(n)then
    a=t(n)
  elseif _(n)then
    a=n
  end
  if a==r then
    return
  end
  if(not e._CanSetMarker(a))then
    return
  end
  if Tpp.IsMarkerLocator(a)or s then
    TppMarker2System.DisableMarker{gameObjectId=a}
  else
    TppMarker2System.SetMarkerImportant{gameObjectId=a,isImportant=false}
  end
  TppUiCommand.UnRegisterIconUniqueInformation(a)
  if i~=nil then
    TppUiCommand.UnregisterMapRadio(a)
  end
end
function e.DisableAll()
  TppMarker2System.DisableAllMarker()
end
function e.SetUpSearchTarget(e)
  if p(e)then
    for a,e in pairs(e)do
      mvars.mar_searchTargetPrePareList[e.gameObjectName]={gameObjectName=e.gameObjectName,gameObjectType=e.gameObjectType,messageName=e.messageName,skeletonName=e.skeletonName,offSet=e.offSet,targetFox2Name=e.targetFox2Name,doDirectionCheck=e.doDirectionCheck,objectives=e.objectives,func=e.func,notImportant=e.notImportant,wideCheckRange=e.wideCheckRange}
    end
  end
end
function e.CompleteSearchTarget(a)
  local a=t(a)
  if a~=r then
    e._OnSearchTarget(a,nil,"script")
  end
end
function e.EnableSearchTarget(a)
  if not e._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==n(a)then
      svars.mar_searchTargeEnable[e]=true
      return
    end
  end
end
function e.DisableSearchTarget(a)
  if not e._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==n(a)then
      svars.mar_searchTargeEnable[e]=false
      return
    end
  end
end
function e.GetSearchTargetIsFound(a)
  if not e._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==n(a)then
      return svars.mar_searchTargeIsFound[e]end
  end
  return false
end
function e.SetQuestMarker(e)
  local a
  if Tpp.IsTypeString(e)then
    a=t(e)
  elseif Tpp.IsTypeNumber(e)then
    a=e
  end
  if a==r then
  else
    local e={gameObjectId=a,isImportant=true,isQuestImportant=true}
    TppMarker2System.SetMarkerImportant(e)
  end
end
function e.SetQuestMarkerGimmick(e)
  local a,e=TppGimmick.GetGameObjectId"q40010_cntn001"
  if e==r then
  else
    local e={gameObjectId=e,isImportant=true,isQuestImportant=true}
    TppMarker2System.SetMarkerImportant(e)
  end
end
function e.EnableQuestTargetMarker(n)
  local a
  if Tpp.IsTypeString(n)then
    a=t(n)
  elseif Tpp.IsTypeNumber(n)then
    a=n
  end
  if a==r then
  else
    e.Enable(a,0,"defend","map_and_world_only_icon",0,false,true)e.SetQuestMarker(a)
    TppUI.ShowAnnounceLog("updateMap",nil,nil,1)
  end
end
function e.DeclareSVars()
  return{{name="mar_searchTargetName",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_searchTargeEnable",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_searchTargeIsFound",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_locatorMarker",arraySize=100,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.OnAllocate()mvars.mar_searchTargetList={}mvars.mar_searchTargetPrePareList={}
end
function e.Init(a)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMissionCanStart()
  for s,a in pairs(mvars.mar_searchTargetPrePareList)do
    local t=t(s)
    if t==r then
    else
      mvars.mar_searchTargetList[t]=a
      if not e._IsCheckSVarsSearchTargetName(s)then
        for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
          if svars.mar_searchTargetName[e]==0 then
            svars.mar_searchTargetName[e]=n(s)break
          end
        end
      end
      if not e._IsCheckSVarsSearchTarget(t,"mar_searchTargeIsFound")then
        TppPlayer.SetSearchTarget(s,a.gameObjectType,a.messageName,a.skeletonName,a.offSet,a.targetFox2Name,a.doDirectionCheck,a.wideCheckRange)
        e.EnableSearchTarget(s)
      end
    end
  end
  mvars.mar_searchTargetPrePareList=nil
end
function e.OnReload()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(i,n,s,r,t,o,a)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,i,n,s,r,t,o,a)
end
function e.RestoreMarkerLocator()
  if e.IsExistMarkerLocatorSystem()then
    local e={type="TppMarker2LocatorSystem"}d(e,{id="RestoreFromSVars"})
  end
end
function e.StoreMarkerLocator()
  if e.IsExistMarkerLocatorSystem()then
    local e={type="TppMarker2LocatorSystem"}d(e,{id="StoreToSVars"})
  end
end
function e.IsExistMarkerLocatorSystem()
  if GameObject.GetGameObjectIdByIndex("TppMarker2LocatorSystem",0)~=r then
    return true
  else
    return false
  end
end
function e._OnSearchTarget(a,t,s)
  if not mvars.mar_searchTargetList[a]then
    return
  end
  if e._IsCheckSVarsSearchTarget(a,"mar_searchTargeIsFound")then
    return
  end
  if not e._IsCheckSVarsSearchTarget(a,"mar_searchTargeEnable")then
    return
  end
  for n=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local r=e._GetStrCode32SearchTargetName(a)
    if svars.mar_searchTargetName[n]==r then
      if mvars.mar_searchTargetList[a].objectives==nil then
        local r
        if mvars.mar_searchTargetList[a].notImportant then
          r=false
        else
          r=true
        end
        e.Enable(mvars.mar_searchTargetList[a].gameObjectName,0,"moving","map_and_world_only_icon",0,r,true)
      else
        local e={}
        if p(mvars.mar_searchTargetList[a].objectives)then
          e=mvars.mar_searchTargetList[a].objectives
        else
          table.insert(e,mvars.mar_searchTargetList[a].objectives)
        end
        TppMission.UpdateObjective{objectives=e}
      end
      if mvars.mar_searchTargetList[a].func then
        mvars.mar_searchTargetList[a].func(t,a,s)
      end
      TppSoundDaemon.PostEvent"sfx_s_enemytag_main_tgt"e._CallSearchTargetEnabledRadio(a)svars.mar_searchTargeIsFound[n]=true
      return
    end
  end
end
function e._GetStrCode32SearchTargetName(a)
  for r,e in pairs(mvars.mar_searchTargetList)do
    local e=e.gameObjectName
    if a==t(e)then
      return n(e)
    end
  end
  return nil
end
function e._IsCheckSVarsSearchTargetName(e)
  local a=n(e)
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==a then
      return true
    end
  end
  return false
end
function e._IsCheckSVarsSearchTarget(a,r)
  local n=e._GetStrCode32SearchTargetName(a)
  if n==nil then
    return false
  end
  for a=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local e=false
    if r==nil then
      e=true
    else
      e=svars[r][a]end
    if svars.mar_searchTargetName[a]==n and e then
      return true
    end
  end
  return false
end
function e._OnMarkerChangeToEnable(n,n,r,a)
  if a==Fox.StrCode32"Player"then
    e._CallMarkerRadio(r)
  end
end
function e._CallMarkerRadio(a)
  if not e._IsRadioTarget(a)then
    return
  end
  if mvars.mar_searchTargetList[a]and e._IsCheckSVarsSearchTarget(a,"mar_searchTargeEnable")then
    if not e._IsCheckSVarsSearchTarget(a,"mar_searchTargeIsFound")then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_MARKED)
    end
  else
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
  end
end
function e._CallSearchTargetEnabledRadio(a)
  if not e._IsRadioTarget(a)then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
end
function e._IsRadioTarget(e)
  local a=TppEnemy.IsEliminateTarget(e)
  local e=TppEnemy.IsRescueTarget(e)
  if not a and not e then
    return false
  end
  return true
end
function e._CanSetMarker(e)
  if Tpp.IsVehicle(e)then
    return TppEnemy.IsVehicleAlive(e)
  else
    return true
  end
end
return e
