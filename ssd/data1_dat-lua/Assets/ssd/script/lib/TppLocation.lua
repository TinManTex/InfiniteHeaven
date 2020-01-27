local this={}
function this.GetLocationName()
  local locationCode=vars.locationCode
  if locationCode==TppDefine.LOCATION_ID.AFGH or locationCode==TppDefine.LOCATION_ID.SSD_AFGH then
    return"afgh"
  elseif locationCode==TppDefine.LOCATION_ID.SSD_AFGH2 then
    return"ssd_afgh2"
  elseif locationCode==TppDefine.LOCATION_ID.MAFR then
    return"mafr"
  elseif locationCode==TppDefine.LOCATION_ID.SBRI then
    return"sbri"
  elseif locationCode==TppDefine.LOCATION_ID.SPFC then
    return"spfc"
  elseif locationCode==TppDefine.LOCATION_ID.SSAV then
    return"ssav"
  elseif locationCode==TppDefine.LOCATION_ID.AFTR then
    return"aftr"
  elseif locationCode==TppDefine.LOCATION_ID.INIT then
    return"init"
  elseif locationCode>=6e4 then
  elseif vars.locationCode==TppDefine.LOCATION_ID.SSD_OMBS then
    return"ombs"
  end
end
function this.IsAfghan()
  local e=vars.locationCode
  if(e==TppDefine.LOCATION_ID.AFGH or e==TppDefine.LOCATION_ID.SSD_AFGH)or e==TppDefine.LOCATION_ID.AFTR then
    return true
  else
    return false
  end
end
function this.IsMiddleAfrica()
  if vars.locationCode==TppDefine.LOCATION_ID.MAFR then
    return true
  else
    return false
  end
end
function this.IsCyprus()
  if vars.locationCode==TppDefine.LOCATION_ID.CYPR then
    return true
  else
    return false
  end
end
function this.IsMotherBase()
  if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
    return true
  else
    return false
  end
end
function this.IsMBQF()
  if vars.locationCode==TppDefine.LOCATION_ID.MBQF then
    return true
  else
    return false
  end
end
function this.IsOMBS()
  if vars.locationCode==TppDefine.LOCATION_ID.SSD_OMBS then
    return true
  else
    return false
  end
end
function this.IsInit()
  if vars.locationCode==TppDefine.LOCATION_ID.INIT then
    return true
  else
    return false
  end
end
function this.SetBuddyBlock(e)
  if TppGameSequence.GetGameTitleName()=="TPP"then
    if e==10 or e==20 then
      if TppBuddy2BlockController.CreateBlock then
        TppBuddy2BlockController.CreateBlock()
      end
    else
      if TppBuddy2BlockController.DeleteBlock then
        TppBuddy2BlockController.DeleteBlock()
      end
    end
  end
  return locationPackagePath
end
function this.RegistBaseAssetTable(n,e)
  if n then
    mvars.loc_locationBaseAssetOnActive={}
    for n,e in pairs(n)do
      mvars.loc_locationBaseAssetOnActive[Fox.StrCode32(n)]=e
    end
  end
  if e then
    mvars.loc_locationBaseOnActiveSmallBlock=e
    for n,e in pairs(e)do
      local n=e.activeArea
      if n then
        local e=Tpp.AreaToIndices(n)StageBlock.AddSmallBlockIndexForMessage(e)
      end
      if not e.OnActive then
      end
    end
  end
end
function this.RegistMissionAssetInitializeTable(n,e)
  if n then
    mvars.loc_missionAssetOnActive={}
    for n,e in pairs(n)do
      mvars.loc_missionAssetOnActive[Fox.StrCode32(n)]=e
    end
  end
  if e then
    mvars.loc_missionAssetOnActiveSmallBlock=e
    for e,n in pairs(e)do
      local e=n.activeArea
      if e then
        local e=Tpp.AreaToIndices(e)StageBlock.AddSmallBlockIndexForMessage(e)
      end
      if not n.OnActive then
      end
    end
  end
end
function this.RegistBossAssetInitializeTable(n,e)
  if n then
    mvars.loc_bossAssetOnActive=n
  end
  if e then
    mvars.loc_bossAssetOnActiveSmallBlock=e
    for e,n in pairs(e)do
      local e=n.activeArea
      if e then
        local e=Tpp.AreaToIndices(e)StageBlock.AddSmallBlockIndexForMessage(e)
      end
      if not n.OnActive then
      end
    end
  end
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.ActivateBlock()
  local n={[1]=true,[30]=true,[47]=true,[50]=true,[55]=true}
  if n[vars.locationCode]then
    return
  end
  local n=StageBlock.GetLoadedLargeBlocks(0)
  for t,n in pairs(n)do
    this.OnActiveLargeBlock(n,StageBlock.ACTIVE)
  end
  local o=4
  local n,t=StageBlock.GetCurrentMinimumSmallBlockIndex()
  if not((n==0)and(t==0))then
    local i=n+o
    local o=t+o
    for i=n,i do
      for n=t,o do
        this.OnActiveSmallBlock(i,n,StageBlock.ACTIVE)
      end
    end
  end
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(a,s,i,l,o,t,n)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,a,s,i,l,o,t,n)
end
function this.Messages()
  return Tpp.StrCode32Table{Block={{msg="OnChangeLargeBlockState",func=this.OnActiveLargeBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true,isExecFastTravel=true,isExecMissionClear=true,isExecGameOver=true}},{msg="OnChangeSmallBlockState",func=this.OnActiveSmallBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true,isExecFastTravel=true,isExecMissionClear=true,isExecGameOver=true}}},nil}
end
function this.OnActiveLargeBlock(e,n)
  if n==StageBlock.INACTIVE then
    return
  end
  if TppSequence.IsEndSaving()==false then
    return
  end
  local n=mvars.loc_locationBaseAssetOnActive
  if n then
    local e=n[e]
    if e then
      e()
    end
  end
  local n=mvars.loc_missionAssetOnActive
  if n then
    local e=n[e]
    if e then
      e()
    end
  end
  local n=mvars.loc_bossAssetOnActive
  if n then
    n(e)
  end
end
function this.OnActiveSmallBlock(e,n,t)
  if t==StageBlock.INACTIVE then
    return
  end
  local t=mvars.loc_locationBaseOnActiveSmallBlock
  if t then
    for o,t in pairs(t)do
      local t,o=t.activeArea,t.OnActive
      if t then
        if Tpp.CheckBlockArea(t,e,n)then
          o()
        end
      end
    end
  end
  local t=mvars.loc_missionAssetOnActiveSmallBlock
  if t then
    for o,t in pairs(t)do
      local t,o=t.activeArea,t.OnActive
      if t then
        if Tpp.CheckBlockArea(t,e,n)then
          o()
        end
      end
    end
  end
  local t=mvars.loc_bossAssetOnActiveSmallBlock
  if t then
    for o,t in pairs(t)do
      local t,o=t.activeArea,t.OnActive
      if t then
        if Tpp.CheckBlockArea(t,e,n)then
          o()
        end
      end
    end
  end
end
return this
