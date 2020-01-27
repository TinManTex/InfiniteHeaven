-- DOBUILD: 0 --DEBUGWIP
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\location\mtbs\pack_common\mtbs_script.fpkd
local mtbs_item = {}





mtbs_item.Messages = function()
  return
    Tpp.StrCode32Table{
      MotherBaseStage = {
        {
          msg = "MotherBaseCurrentClusterLoadStart",
          func = function(clusterId)
            mtbs_item.RegisterGimmick( clusterId )
          end,
          option = { isExecDemoPlaying = true , isExecMissionPrepare = true},
        },
      },
      GameObject = {
        {
          msg = "BreakGimmick",
          func = TppGimmick.BreakGimmick,
          option = { isExecMissionPrepare = true },
        },
        {
          msg		= "SwitchGimmick",
          func	= TppGimmick.SwitchGimmick,
          option = { isExecMissionPrepare = true },
        },
        nil
      }
    }
end








mtbs_item.OnInitialize = function ()
  if TppMission.IsHelicopterSpace(vars.missionCode)
    or vars.missionCode == 30150 then
    MotherBaseConstructConnector.ClearVariableGimmickList()
    TppGimmick.GetMBItemAssetTable = nil
    TppGimmick.GetMbGimmickIdentifierTable = nil
    TppGimmick.GetMbGimmickPowerCutConnectTable = nil
  else
    mtbs_item.messageExecTable = Tpp.MakeMessageExecTable( mtbs_item.Messages() )
    mtbs_item._RegisterGetAssetTableFunc( )




    local clusterId = MotherBaseStage.GetCurrentCluster()
    if clusterId >= #TppDefine.CLUSTER_NAME then
      clusterId = MotherBaseStage.GetFirstCluster()
    end
    mtbs_item.RegisterGimmick( clusterId )
  end
end

mtbs_item.RegisterGimmick = function( clusterId )
  if clusterId >= #TppDefine.CLUSTER_NAME then
    Fox.Log("Special Cluster! Skip RegisterGimmick!")
    return
  end
  local layoutCode = vars.mbLayoutCode

  if mvars.mbItem_funcGetGimmickIdentifierTable then
    local table = mvars.mbItem_funcGetGimmickIdentifierTable( clusterId + 1 )
    if table == nil then
      Fox.Log("No identifier table. cluster:"..tostring(clusterId) )
      table = {}
    end
    TppGimmick.SetUpIdentifierTable( table )
    Gimmick.RegistGimmickNameIdentifier ( mvars.mbItem_funcGetGimmickIdentifierTable( clusterId + 1 ) )
  else
    TppGimmick.SetUpIdentifierTable( {} )
  end

  if mvars.mbItem_funcGetGimmickPowerCutConnectTable then
    local table = mvars.mbItem_funcGetGimmickPowerCutConnectTable( clusterId + 1 )
    if table == nil then
      Fox.Log("No power cut connect table. cluster:"..tostring(clusterId) )
      table = {}
    end
    TppGimmick.SetUpConnectPowerCutTable( table )
  else
    TppGimmick.SetUpConnectPowerCutTable( {} )
  end

  TppGimmick.SetUpBreakConnectTable( {} )
  TppGimmick.SetUpCheckBrokenAndBreakConnectTable( {} )
  TppGimmick.SetUpConnectVisibilityTable( {} )

  if mvars.mbItem_funcGetAssetTable then
    local dataSet = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", layoutCode, clusterId, layoutCode, clusterId )
    local assetTable = mvars.mbItem_funcGetAssetTable( clusterId + 1 )
    if assetTable then
      --tex>DEBUGWIP
      for k,v in ipairs(assetTable.containers)do
        if (k % 4) == 0 then
          if type(v)=="string" then
            --InfMenu.DebugPrint(tostring(v))
           -- Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,v,dataSet,true)
          end
        end
      end--<
      --tex>DEBUGWIP
      for k,v in ipairs(assetTable.eastAAGs)do
        --if (k % 4) == 0 then
          if type(v)=="string" then
            --InfMenu.DebugPrint(tostring(v))
          --  Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,v,dataSet,true)
          end
        --end
      end--<
      for k,v in ipairs(assetTable.westAAGs)do
        --if (k % 4) == 0 then
          if type(v)=="string" then
            --InfMenu.DebugPrint(tostring(v))
           -- Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,v,dataSet,true)
          end
        --end
      end--<
      
      for k,v in ipairs(assetTable.irsensors)do
        --if (k % 4) == 0 then
          if type(v)=="string" then
            --InfMenu.DebugPrint(tostring(v))
            --Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IR_SENSOR,v,dataSet,false)
          end
        --end
      end--<
      --      assetTable.containers=nil
      --      assetTable.eastAAGs=nil
      --      assetTable.westAAGs=nil
      
      


      if MotherBaseConstructConnector.SetVariableGimmickList then
        if assetTable.containers then
          MotherBaseConstructConnector.SetVariableGimmickList( "Container", assetTable.containers, dataSet )
          Fox.Log( "SetVariableGimmickList( Container "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.irsensors then
        --DEBUGWIP   MotherBaseConstructConnector.SetVariableGimmickList( "IrSensor", assetTable.irsensors, dataSet )
          Fox.Log( "SetVariableGimmickList( IrSensor "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.mortars then
          MotherBaseConstructConnector.SetVariableGimmickList( "Mortar", assetTable.mortars, dataSet )
          Fox.Log( "SetVariableGimmickList( Mortar "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.eastTurrets then
          MotherBaseConstructConnector.SetVariableGimmickList( "EastTurret", assetTable.eastTurrets, dataSet )
          Fox.Log( "SetVariableGimmickList( EastTurret "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.westTurrets then
          MotherBaseConstructConnector.SetVariableGimmickList( "WestTurret", assetTable.westTurrets, dataSet )
          Fox.Log( "SetVariableGimmickList( WestTurret "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.eastAAGs then
          MotherBaseConstructConnector.SetVariableGimmickList( "EastAAG", assetTable.eastAAGs, dataSet )
          Fox.Log( "SetVariableGimmickList( EastAAG "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.westAAGs then
          MotherBaseConstructConnector.SetVariableGimmickList( "WestAAG", assetTable.westAAGs, dataSet )
          Fox.Log( "SetVariableGimmickList( WestAAG "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.nuclearContainers then
          MotherBaseConstructConnector.SetVariableGimmickList( "NuclearContainer", assetTable.nuclearContainers, dataSet )
          Fox.Log( "SetVariableGimmickList( NuclearContainer "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.stolenAlarms then
         --DEBUGWIP MotherBaseConstructConnector.SetVariableGimmickList( "StolenAlarm", assetTable.stolenAlarms, dataSet )
          Fox.Log( "SetVariableGimmickList( StolenAlarm "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.slideDoors then
          MotherBaseConstructConnector.SetVariableGimmickList( "SlideDoor", assetTable.slideDoors, dataSet )
          Fox.Log( "SetVariableGimmickList( SlideDoor "..tostring(layoutCode)..", "..dataSet.." )" )
        end
        if assetTable.nuclearContainers then
        --DEBUGWIP   MotherBaseConstructConnector.SetVariableGimmickList( "NuclearContainer", assetTable.nuclearContainers, dataSet )
          Fox.Log( "SetVariableGimmickList( NuclearContainer "..tostring(layoutCode)..", "..dataSet.." )" )
        end
      else

        MotherBaseConstructConnector.SetContainerGimmickList( assetTable.containers, dataSet )
        Fox.Log( "SetContainerGimmickList( "..tostring(layoutCode)..", "..dataSet.." )" )
      end
    else
      Fox.Error("Asset Table is nil.  cluster: " ..tostring(TppDefine.CLUSTER_NAME[clusterId+1]) )
    end
  end
end




mtbs_item.OnReload = function( subScripts )
  mtbs_item.messageExecTable = Tpp.MakeMessageExecTable( mtbs_item.Messages() )
  mtbs_item._RegisterGetAssetTableFunc( )
end


mtbs_item.OnMessage = function( sender, messageId, arg0, arg1, arg2, arg3, strLogText )
  Tpp.DoMessage( mtbs_item.messageExecTable, TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText )
end




mtbs_item._RegisterGetAssetTableFunc = function()
  if TppGimmick.GetMBItemAssetTable then
    mvars.mbItem_funcGetAssetTable = TppGimmick.GetMBItemAssetTable
  elseif mvars.mbItem_funcGetAssetTable then
    TppGimmick.GetMBItemAssetTable = mvars.mbItem_funcGetAssetTable
  end

  if TppGimmick.GetMBGimmickIdentifierTable then
    mvars.mbItem_funcGetGimmickIdentifierTable = TppGimmick.GetMBGimmickIdentifierTable
  elseif mvars.mbItem_funcGetGimmickIdentifierTable then
    TppGimmick.GetMBGimmickIdentifierTable = mvars.mbItem_funcGetGimmickIdentifierTable
  end

  if TppGimmick.GetMBGimmickPowerCutConnectTable then
    mvars.mbItem_funcGetGimmickPowerCutConnectTable = TppGimmick.GetMBGimmickPowerCutConnectTable
  elseif mvars.mbItem_funcGetGimmickPowerCutConnectTable then
    TppGimmick.GetMBGimmickPowerCutConnectTable = mvars.mbItem_funcGetGimmickPowerCutConnectTable
  end
end




mtbs_item.OnMissionGameStart = function()
  mtbs_item._EnableCollectionStation()
end







function mtbs_item.SwitchingLockGoalDoor( clusterId, doorList, switch )
  local layoutCode = vars.mbLayoutCode
  local dataSetPath = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", layoutCode, clusterId, layoutCode, clusterId )
  local goalDoorList = doorList[clusterId]
  if goalDoorList == nil then
    Fox.Log("goalDoorList is nil. Skip LockGoalDoor:" ..tostring(clusterId) )
    return
  end
  for i, doorName in ipairs(goalDoorList) do
    Gimmick.SetEventDoorLock( doorName, dataSetPath, switch, 0 )
  end
end









function mtbs_item._EnableCollectionStation()
  local locationName	= TppLocation.GetLocationName()
  local missionId		= TppMission.GetMissionID()


  if locationName == "mtbs" and missionId == 30050 then
    local locationStationList = TppDefine.STATION_LIST[locationName]
    if locationStationList then
      for clusterId, clusterName in ipairs( locationStationList ) do
        local clusterConstruct	= mtbs_cluster.GetClusterConstruct( clusterId )
        local clusterData		= clusterId - 1
        local stationName		= string.format( "ly003_cl%02d_collct0000|cl%02dpl0_uq_00%d0_collct|col_stat_%s", clusterData, clusterData, clusterData, clusterName )
        if clusterConstruct then
          if clusterConstruct > 0 then
            if TppCollection.IsExistLocator( stationName ) then
              TppCollection.SetValidStation( stationName )
            end
          end
        end
      end
    end
  end
end

return mtbs_item
