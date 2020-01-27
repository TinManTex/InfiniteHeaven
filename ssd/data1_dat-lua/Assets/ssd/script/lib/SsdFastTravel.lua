local this={}
local t=Fox.StrCode32
local n={}
local i={}
function this.InitializeFastTravelPoints()
  n={}
  i={}
  mvars.fastTravelPointTableTable={}
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=this.RegisterFastTravelPoints()
    for a,e in ipairs(a)do
      local a=e.identifierLinkName
      mvars.fastTravelPointTableTable[a]=e
      local s=FastTravelSystem.IsUnlocked{identifierLinkName=a}
      Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=e.gimmickLocatorName,dataSetName=e.gimmickDatasetName,powerOff=not s}
      n[t(a)]=e.identifierName
      i[t(a)]=a
    end
    for a,e in ipairs(SsdFastTravelPointList.returnToBasePointTableList)do
      local a=e.identifierLinkName
      n[t(a)]=e.identifierName
      i[t(a)]=a
    end
    Tpp.DEBUG_DumpTable(i)
  end
end
function this.RegisterFastTravelPoints()
  local a=SsdFastTravelPointList.fastTravelPointTableList
  FastTravelSystem.RegisterPoints{pointInfos=a}
  return a
end
function this.UnlockFastTravelPoint(i)
  local e
  if Tpp.IsTypeString(i)then
    e={i}
  elseif Tpp.IsTypeTable(i)then
    e=i
  end
  if e then
    for i,e in ipairs(e)do
      FastTravelSystem.Unlock{identifierLinkName=e}
      this.UnlockFastTravelPointGimmick(e)
    end
  end
end
function this.UnlockFastTravelPointGimmick(e)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for i,a in ipairs(a)do
      if(a.identifierLinkName==e and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName,powerOff=false}
        break
      end
    end
  end
end
function this.LockFastTravelPointGimmick(e)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for i,a in ipairs(a)do
      if(a.identifierLinkName==e and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName,powerOff=true}break
      end
    end
  end
end
function this.InvisibleFastTravelPointGimmick(i,e)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for t,a in ipairs(a)do
      if(a.identifierLinkName==i and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.InvisibleGimmick(0,a.gimmickLocatorName,a.gimmickDatasetName,e,{gimmickId="GIM_P_Portal"})
        break
      end
    end
  end
end
function this.ActionFastTravelPointGimmick(t,i,e)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for n,a in ipairs(a)do
      if(a.identifierLinkName==t and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.SetAction{gimmickId="GIM_P_Digger",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName,action=i,param1=e}
        break
      end
    end
  end
end
function this.ResetFastTravelPointGimmick(e)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for i,a in ipairs(a)do
      if(a.identifierLinkName==e and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.ResetGimmick(0,a.gimmickLocatorName,a.gimmickDatasetName,{gimmickId="GIM_P_Portal"})
        break
      end
    end
  end
end
function this.UnlockAllFastTravelPointGimmick()
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for e,a in ipairs(a)do
      if a.gimmickLocatorName and a.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName,powerOff=false}
      end
    end
  end
end
function this.UnlockAllAutoBootFastTravelPointGimmick()
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for e,a in ipairs(a)do
      if(a.autoBoot and a.gimmickLocatorName)and a.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName,powerOff=false}
      end
    end
  end
end
function this.GetFastTravelPointNameFromGimmick(i,e,a)
  if Tpp.IsTypeString(e)then
    e=Fox.StrCode32(e)
  end
  if Tpp.IsTypeString(a)then
    a=Fox.StrCode32(a)
  end
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local a=SsdFastTravelPointList.fastTravelPointTableList
    for t,a in ipairs(a)do
      if a.gimmickLocatorName and Fox.StrCode32(a.gimmickLocatorName)==e then
        local e=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName}
        if i==e then
          return a.identifierLinkName
        end
      end
    end
  end
end
function this.GetFastTravelPointName(a)
  return n[a],i[a]
end
function this.GetFastTravelPointGimmickIdentifier(a)
  if not mvars.fastTravelPointTableTable then
    return
  end
  local a=mvars.fastTravelPointTableTable[a]
  if not a then
    return
  end
  local a={gimmickId="GIM_P_Portal",name=a.gimmickLocatorName,dataSetName=a.gimmickDatasetName}
  return a
end
function this.GetQuestName(a)
  return SsdFastTravelPointList.FAST_TRAVEL_TO_QUEST[a]
end
return this
