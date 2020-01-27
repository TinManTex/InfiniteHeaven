-- SsdFastTravel.lua
local this={}
local StrCode32=Fox.StrCode32
local identifierLinkNameS32ToIdentifierName={}
local identifierLinkNameS32ToIdentifierLinkName={}
--REF fastTravelPointTableList
--{identifierLinkName="fast_afgh00",pointNameMessageID="map_ft_afgh_01_name",mapIconNameMessageID="map_icon_fastTravel_afgh_01_name",gimmickLocatorName="com_portal001_gim_n0000|srt_ftp0_main0_def_v00",gimmickDatasetName="/Assets/ssd/level/location/afgh/block_small/129/129_150/afgh_129_150_gimmick.fox2",waterTankGimmickLocatorName="ssde_tank002_vrtn003_gim_n0000|srt_ssde_tank002_vrtn003",waterTankGimmickDatasetName="/Assets/ssd/level/location/afgh/block_small/130/130_151/afgh_130_151_gimmick.fox2",identifierName="DataIdentifier_afgh_common_fasttravel",locationID=TppDefine.LOCATION_ID.SSD_AFGH,blankMapAreas=a.fast_base,autoBoot=true,enableLocationChange=true},
--...
function this.InitializeFastTravelPoints()
  identifierLinkNameS32ToIdentifierName={}
  identifierLinkNameS32ToIdentifierLinkName={}
  mvars.fastTravelPointTableTable={}
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=this.RegisterFastTravelPoints()
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      local identifierLinkName=travelPointInfo.identifierLinkName
      mvars.fastTravelPointTableTable[identifierLinkName]=travelPointInfo
      local isUnlocked=FastTravelSystem.IsUnlocked{identifierLinkName=identifierLinkName}
      Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,powerOff=not isUnlocked}
      identifierLinkNameS32ToIdentifierName[StrCode32(identifierLinkName)]=travelPointInfo.identifierName
      identifierLinkNameS32ToIdentifierLinkName[StrCode32(identifierLinkName)]=identifierLinkName
    end
    for i,returnPointInfo in ipairs(SsdFastTravelPointList.returnToBasePointTableList)do
      local identifierLinkName=returnPointInfo.identifierLinkName
      identifierLinkNameS32ToIdentifierName[StrCode32(identifierLinkName)]=returnPointInfo.identifierName
      identifierLinkNameS32ToIdentifierLinkName[StrCode32(identifierLinkName)]=identifierLinkName
    end
    Tpp.DEBUG_DumpTable(identifierLinkNameS32ToIdentifierLinkName)
  end
end
function this.RegisterFastTravelPoints()
  local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
  FastTravelSystem.RegisterPoints{pointInfos=fastTravelPointTableList}
  return fastTravelPointTableList
end
function this.UnlockFastTravelPoint(travelPointName)
  local travelPoints
  if Tpp.IsTypeString(travelPointName)then
    travelPoints={travelPointName}
  elseif Tpp.IsTypeTable(travelPointName)then
    travelPoints=travelPointName
  end
  if travelPoints then
    for i,identifierLinkName in ipairs(travelPoints)do
      FastTravelSystem.Unlock{identifierLinkName=identifierLinkName}
      this.UnlockFastTravelPointGimmick(identifierLinkName)
    end
  end
end
function this.UnlockFastTravelPointGimmick(travelPointName)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.identifierLinkName==travelPointName and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,powerOff=false}
        break
      end
    end
  end
end
function this.LockFastTravelPointGimmick(travelPointName)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.identifierLinkName==travelPointName and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,powerOff=true}break
      end
    end
  end
end
function this.InvisibleFastTravelPointGimmick(identifierLinkName,visible)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.identifierLinkName==identifierLinkName and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.InvisibleGimmick(0,travelPointInfo.gimmickLocatorName,travelPointInfo.gimmickDatasetName,visible,{gimmickId="GIM_P_Portal"})
        break
      end
    end
  end
end
function this.ActionFastTravelPointGimmick(travelPointName,action,param1)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.identifierLinkName==travelPointName and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.SetAction{gimmickId="GIM_P_Digger",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,action=action,param1=param1}
        break
      end
    end
  end
end
function this.ResetFastTravelPointGimmick(travelPointName)
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.identifierLinkName==travelPointName and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.ResetGimmick(0,travelPointInfo.gimmickLocatorName,travelPointInfo.gimmickDatasetName,{gimmickId="GIM_P_Portal"})
        break
      end
    end
  end
end
function this.UnlockAllFastTravelPointGimmick()
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if travelPointInfo.gimmickLocatorName and travelPointInfo.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,powerOff=false}
      end
    end
  end
end
function this.UnlockAllAutoBootFastTravelPointGimmick()
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if(travelPointInfo.autoBoot and travelPointInfo.gimmickLocatorName)and travelPointInfo.gimmickDatasetName then
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName,powerOff=false}
      end
    end
  end
end
function this.GetFastTravelPointNameFromGimmick(gimmickId,locatorNameS32,unkP3)
  if Tpp.IsTypeString(locatorNameS32)then
    locatorNameS32=Fox.StrCode32(locatorNameS32)
  end
  if Tpp.IsTypeString(unkP3)then
    unkP3=Fox.StrCode32(unkP3)
  end
  if Tpp.IsTypeTable(SsdFastTravelPointList)and Tpp.IsTypeTable(SsdFastTravelPointList.fastTravelPointTableList)then
    local fastTravelPointTableList=SsdFastTravelPointList.fastTravelPointTableList
    for i,travelPointInfo in ipairs(fastTravelPointTableList)do
      if travelPointInfo.gimmickLocatorName and Fox.StrCode32(travelPointInfo.gimmickLocatorName)==locatorNameS32 then
        local gameObjectId=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName}
        if gimmickId==gameObjectId then
          return travelPointInfo.identifierLinkName
        end
      end
    end
  end
end
function this.GetFastTravelPointName(identifierLinkNameS32)
  return identifierLinkNameS32ToIdentifierName[identifierLinkNameS32],identifierLinkNameS32ToIdentifierLinkName[identifierLinkNameS32]
end
function this.GetFastTravelPointGimmickIdentifier(travelPointName)
  if not mvars.fastTravelPointTableTable then
    return
  end
  local travelPointInfo=mvars.fastTravelPointTableTable[travelPointName]
  if not travelPointInfo then
    return
  end
  local gimmickInfo={gimmickId="GIM_P_Portal",name=travelPointInfo.gimmickLocatorName,dataSetName=travelPointInfo.gimmickDatasetName}
  return gimmickInfo
end
function this.GetQuestName(travelPointName)
  return SsdFastTravelPointList.FAST_TRAVEL_TO_QUEST[travelPointName]
end
return this
