local this={}
local i=Fox.StrCode32
local a=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local o=Tpp.IsTypeTable
local r=Tpp.IsTypeString
local m=Tpp.IsTypeNumber
local t=GameObject.SendCommand
this.GoalTypes={none="MISSION_001",moving="MISSION_001",attack="MISSION_002",defend="MISSION_002",moving_fix="MISSION_001",quest="MISSION_002"}
this.ViewTypes={map="MAP_VIEW",all="ALL_VIEW",map_only_icon="MAP_VIEW",map_and_world_only_icon="ALL_VIEW",map_and_near3d_icon="MAP_AND_NEAR3D_VIEW",world_only_icon="3D_VIEW"}
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="LookingTarget",func=function(r,a)
        this._OnSearchTarget(a,r,"LookingTarget")
      end}},
    GameObject={
      {msg="Carried",func=function(r,a)
        if a==0 then
          this._OnSearchTarget(r,nil,"Carried")
        end
      end},
      {msg="Restraint",func=function(r,a)
        if a==0 then
          this._OnSearchTarget(r,nil,"Restraint")
        end
      end}},
    Marker={{msg="ChangeToEnable",func=this._OnMarkerChangeToEnable}},
    nil}
end
function this.Enable(i,t,d,o,s,r,f,m,l,c)
  local r
  if Tpp.IsTypeString(i)then
    r=a(i)
  elseif Tpp.IsTypeNumber(i)then
    r=i
  else
    return
  end
  if r==n then
    return
  end
  if(not this._CanSetMarker(r))then
    return
  end
  t=t or 0
  d=d or"moving"
  o=o or"map"
  s=s or 9
  c=c or-1
  if(type(t)~="number")then
    return
  end
  if(t<0 or t>9)then
    return
  end
  if(type(s)~="number")then
    return
  end
  if(s<0 or s>9)then
    return
  end
  local a=this.GoalTypes[d]
  if(a==nil)then
    return
  end
  local e=this.ViewTypes[o]
  if(e==nil)then
    return
  end
  SsdMarker.RegisterMarker{gameObjectId=r,flag=e,randomLevel=s,vagueLevel=t,type=a,isNew=f,nearDistance=c}
  SsdMarker.RegisterMarkerSubInfo{gameObjectId=r,mapTextId=m,guidelinesId=l}
end
function this.Disable(s,t,t)
  local t
  if r(s)then
    t=a(s)
  elseif m(s)then
    t=s
  end
  if t==n then
    return
  end
  if(not this._CanSetMarker(t))then
    return
  end
  SsdMarker.Enable{gameObjectId=t,enable=false}
end
function this.DisableAll()
  mvars.mar_missionMarkerList={}
  SsdMarker.InitializeMissionMarker()
end
function this.RegisterMissionMarkerParent(e)
  mvars.mar_missionMarkerList={}
  if not o(e)then
    return
  end
  for a,e in ipairs(e)do
    if r(e)then
      mvars.mar_missionMarkerList[e]={}
    end
  end
end
function this.RegisterMissionMarker(s,i,h,o,T,d,c,l,g,f,_)
  local t
  if r(s)then
    t=a(s)
  elseif m(s)then
    t=s
  end
  if t==n then
    return
  end
  if not r(i)then
    return
  end
  if not mvars.mar_missionMarkerList[i]then
    return
  end
  if this.IsRegisteredMissionMarker(mvars.mar_missionMarkerList[i],t)then
    return
  end
  this.Enable(t,h,o,T,d,c,l,f,_)
  table.insert(mvars.mar_missionMarkerList[i],t)
  if g then
    SsdMarker.Enable{gameObjectId=t,enable=false}
  end
end
function this.UnregisterMissionMarker(s,i)
  local t
  if r(s)then
    t=a(s)
  elseif m(s)then
    t=s
  end
  if t==n then
    return
  end
  if not r(i)then
    return
  end
  if not mvars.mar_missionMarkerList[i]then
    return
  end
  local r=this.IsRegisteredMissionMarker(mvars.mar_missionMarkerList[i],t)
  if not r then
    return
  end
  table.remove(mvars.mar_missionMarkerList[i],r)
  this.Disable(t)
end
function this.IsRegisteredMissionMarker(s,t)
  if not o(s)or not next(s)then
    return false
  end
  local e
  if r(t)then
    e=a(t)
    if e==n then
      return
    end
  else
    e=t
  end
  for a,r in ipairs(s)do
    if r==e then
      return a
    end
  end
  return false
end
function this.EnableMissionMarker(e)
  if not r(e)then
    return
  end
  if not mvars.mar_missionMarkerList[e]then
    return
  end
  for r,e in ipairs(mvars.mar_missionMarkerList[e])do
    SsdMarker.Enable{gameObjectId=e,enable=true}
  end
end
function this.DisableMissionMarker(e)
  if not r(e)then
    return
  end
  if not mvars.mar_missionMarkerList[e]then
    return
  end
  for r,e in ipairs(mvars.mar_missionMarkerList[e])do
    SsdMarker.Enable{gameObjectId=e,enable=false}
  end
end
function this.SetUpSearchTarget(e)
  if o(e)then
    for r,e in pairs(e)do
      mvars.mar_searchTargetPrePareList[e.gameObjectName]={gameObjectName=e.gameObjectName,gameObjectType=e.gameObjectType,messageName=e.messageName,skeletonName=e.skeletonName,offSet=e.offSet,targetFox2Name=e.targetFox2Name,doDirectionCheck=e.doDirectionCheck,objectives=e.objectives,func=e.func,notImportant=e.notImportant,wideCheckRange=e.wideCheckRange}
    end
  end
end
function this.CompleteSearchTarget(r)
  local r=a(r)
  if r~=n then
    this._OnSearchTarget(r,nil,"script")
  end
end
function this.EnableSearchTarget(r)
  if not this._IsCheckSVarsSearchTargetName(r)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==i(r)then
      svars.mar_searchTargeEnable[e]=true
      return
    end
  end
end
function this.DisableSearchTarget(r)
  if not this._IsCheckSVarsSearchTargetName(r)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==i(r)then
      svars.mar_searchTargeEnable[e]=false
      return
    end
  end
end
function this.GetSearchTargetIsFound(r)
  if not this._IsCheckSVarsSearchTargetName(r)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==i(r)then
      return svars.mar_searchTargeIsFound[e]
    end
  end
  return false
end
function this.SetQuestMarker(e)
end
function this.SetQuestMarkerGimmick(e)
end
function this.EnableQuestTargetMarker(e)
end
function this.DeclareSVars()
  return{
    {name="mar_searchTargetName",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mar_searchTargeEnable",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mar_searchTargeIsFound",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil}
end
function this.OnAllocate()
  mvars.mar_searchTargetList={}
  mvars.mar_searchTargetPrePareList={}
end
function this.Init(r)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  mvars.mar_missionMarkerList={}SsdMarker.InitializeMissionMarker()
end
function this.OnMissionCanStart()
  for t,r in pairs(mvars.mar_searchTargetPrePareList)do
    local a=a(t)
    if a==n then
    else
      mvars.mar_searchTargetList[a]=r
      if not this._IsCheckSVarsSearchTargetName(t)then
        for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
          if svars.mar_searchTargetName[e]==0 then
            svars.mar_searchTargetName[e]=i(t)break
          end
        end
      end
      if not this._IsCheckSVarsSearchTarget(a,"mar_searchTargeIsFound")then
        TppPlayer.SetSearchTarget(t,r.gameObjectType,r.messageName,r.skeletonName,r.offSet,r.targetFox2Name,r.doDirectionCheck,r.wideCheckRange)
        this.EnableSearchTarget(t)
      end
    end
  end
  mvars.mar_searchTargetPrePareList=nil
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(r,a,n,o,s,i,t)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,a,n,o,s,i,t)
end
function this.RestoreMarkerLocator()SsdMarker.Restore()
end
function this.StoreMarkerLocator()SsdMarker.Store()
end
function this.IsExistMarkerLocatorSystem()
  if GameObject.GetGameObjectIdByIndex("TppMarker2LocatorSystem",0)~=n then
    return true
  else
    return false
  end
end
function this._OnSearchTarget(r,s,t)
  if not mvars.mar_searchTargetList[r]then
    return
  end
  if this._IsCheckSVarsSearchTarget(r,"mar_searchTargeIsFound")then
    return
  end
  if not this._IsCheckSVarsSearchTarget(r,"mar_searchTargeEnable")then
    return
  end
  for n=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local a=this._GetStrCode32SearchTargetName(r)
    if svars.mar_searchTargetName[n]==a then
      if mvars.mar_searchTargetList[r].objectives==nil then
        local a
        if mvars.mar_searchTargetList[r].notImportant then
          a=false
        else
          a=true
        end
        this.Enable(mvars.mar_searchTargetList[r].gameObjectName,0,"moving","map_and_world_only_icon",0,a,true)
      else
        local e={}
        if o(mvars.mar_searchTargetList[r].objectives)then
          e=mvars.mar_searchTargetList[r].objectives
        else
          table.insert(e,mvars.mar_searchTargetList[r].objectives)
        end
        TppMission.UpdateObjective{objectives=e}
      end
      if mvars.mar_searchTargetList[r].func then
        mvars.mar_searchTargetList[r].func(s,r,t)
      end
      TppSoundDaemon.PostEvent"sfx_s_enemytag_main_tgt"
      this._CallSearchTargetEnabledRadio(r)
      svars.mar_searchTargeIsFound[n]=true
      return
    end
  end
end
function this._GetStrCode32SearchTargetName(r)
  for n,e in pairs(mvars.mar_searchTargetList)do
    local e=e.gameObjectName
    if r==a(e)then
      return i(e)
    end
  end
  return nil
end
function this._IsCheckSVarsSearchTargetName(e)
  local r=i(e)
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==r then
      return true
    end
  end
  return false
end
function this._IsCheckSVarsSearchTarget(r,a)
  local r=this._GetStrCode32SearchTargetName(r)
  if r==nil then
    return false
  end
  for n=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local e=false
    if a==nil then
      e=true
    else
      e=svars[a][n]
    end
    if svars.mar_searchTargetName[n]==r and e then
      return true
    end
  end
  return false
end
function this._OnMarkerChangeToEnable(n,n,a,r)
  if r==Fox.StrCode32"Player"then
    this._CallMarkerRadio(a)
  end
end
function this._CallMarkerRadio(r)
  if not this._IsRadioTarget(r)then
    return
  end
  if mvars.mar_searchTargetList[r]and this._IsCheckSVarsSearchTarget(r,"mar_searchTargeEnable")then
    if not this._IsCheckSVarsSearchTarget(r,"mar_searchTargeIsFound")then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_MARKED)
    end
  else
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
  end
end
function this._CallSearchTargetEnabledRadio(r)
  if not this._IsRadioTarget(r)then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
end
function this._IsRadioTarget(e)
  local r=TppEnemy.IsEliminateTarget(e)
  local e=TppEnemy.IsRescueTarget(e)
  if not r and not e then
    return false
  end
  return true
end
function this._CanSetMarker(e)
  return true
end
return this
