local l={}
local e=Fox.StrCode32
local e=Tpp.StrCode32Table
function l.CreateInstance(e)
  local e={}
  function e.GetSpawnLocatorNames(a)
    local n=e.waveSettingTable
    if Tpp.IsTypeTable(n)then
      local t={}
      local n=n[a]
      while n do
        if n.endLoop then
          break
        end
        local a=n.spawnTableName
        if a then
          local a=e.spawnSettingTable[a]
          if Tpp.IsTypeTable(a)then
            local a=a.locatorSet
            if Tpp.IsTypeTable(a)then
              local a=a.spawnLocator
              if a then
                local l=true
                for n,e in ipairs(t)do
                  if e==a then
                    l=false
                  end
                end
                if l then
                  table.insert(t,a)
                end
                n=e.waveSettingTable[n.nextWave]
              else
                n=nil
              end
            else
              n=nil
            end
          else
            n=nil
          end
        else
          n=nil
        end
      end
      return t
    end
  end
  function e.GetSpawnRouteNameTable(a)
    local n=e.waveSettingTable
    if Tpp.IsTypeTable(n)then
      local t={}
      local n=n[a]
      while n do
        if n.endLoop then
          break
        end
        local a=n.spawnTableName
        if a then
          local a=e.spawnSettingTable[a]
          if Tpp.IsTypeTable(a)then
            local a=a.locatorSet
            if Tpp.IsTypeTable(a)then
              local a=a.route
              if Tpp.IsTypeString(a)then
                a={a}
              end
              if Tpp.IsTypeTable(a)then
                for n,e in ipairs(a)do
                  t[e]=true
                end
              end
              n=e.waveSettingTable[n.nextWave]
            else
              n=nil
            end
          else
            n=nil
          end
        else
          n=nil
        end
      end
      return t
    end
  end
  function e.InitEnemy()
  end
  function e.SetUpEnemy()
    local a={type="TppCommandPost2"}
    local n=e.spawnSettingTable
    if Tpp.IsTypeTable(n)then
      GameObject.SendCommand(a,{id="SetSpawnSetting",settingTable=n})
    end
    local n=e.waveSettingTable
    if Tpp.IsTypeTable(n)then
      GameObject.SendCommand(a,{id="SetWaveSetting",settingTable=n})
    end
    Mission.RegisterEnemyLaneRouteTable(e.mapRouteNameListTable)
    local n=e.routeSettingTableList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        local l=e.gameObjectType
        local t=e.gameObjectName
        local n=e.routeName
        local a=e.routePoint
        local e=e.warp
        GameObject.SendCommand(GameObject.GetGameObjectId(l,t),{id="SetSneakRoute",route=n,point=a,isWarp=e})
      end
    end
    local n=e.enemyLevelSettingTable
    if Tpp.IsTypeTable(n)then
      for a,e in ipairs(TppDefine.ENEMY_TYPE_LIST)do
        if GameObject.DoesGameObjectExistWithTypeName(e)then
          local e={type=e}
          local a=n.missionLevel
          if Tpp.IsTypeNumber(a)then
            local n={id="SetMissionLv",level=a}
            GameObject.SendCommand(e,n)
          end
          local a=n.randomRange
          if Tpp.IsTypeNumber(a)then
            local n={id="SetRandLv",level=a}
            GameObject.SendCommand(e,n)
          end
          local n=n.areaSettingTableList
          if Tpp.IsTypeTable(n)then
            for a,n in ipairs(n)do
              local t=n.areaName
              local a=n.level
              local n=n.randomRange
              if Tpp.IsTypeString(t)and Tpp.IsTypeNumber(a)then
                local n={id="SetAreaLv",areaName=t,level=a,randVal=n}
                GameObject.SendCommand(e,n)
              end
            end
          end
          local n={id="ReloadLevel"}
          GameObject.SendCommand(e,n)
        end
      end
    end
    local n=e.lookTargetSettingTableList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        GameObject.SendCommand(GameObject.GetGameObjectId(e.locatorName),{id="SetSneakTarget",target=e.targetName})
      end
    end
    local n=e.dropInstanceCountSettingTableList
    if Tpp.IsTypeTable(n)then
      for e,n in ipairs(n)do
        local e=n.typeName
        local n=n.count
        if GameObject.DoesGameObjectExistWithTypeName(e)then
          GameObject.SendCommand({type=e},{id="SetDropInstanceCount",count=n})
        end
      end
    end
    local n={
      itemList1={10,"RES_AmmoBox_01"},
      itemList2={10,"RES_Wood","RES_Wood","RES_Wood","RES_Nail","RES_Wire","RES_Wood","RES_Nail","RES_Wire"},
      itemList3={10,"RES_Iron","RES_Iron","RES_Iron","RES_Iron","RES_Wire","RES_Iron","RES_Wire","RES_Battery_High"},
      itemList4={10,"RES_Iron","RES_Cement","RES_Iron","RES_Cement","RES_Iron","RES_Cement","RES_Nail","RES_Iron"},
      itemList5={10,"RES_Iron","RES_Steel","RES_Iron","RES_Steel","RES_Wire","RES_Steel","RES_Screw","RES_Steel"},
      itemList6={10,"RES_Iron","RES_GunPowder","RES_Steel","RES_Spring","RES_Gear","RES_Steel","RES_Spring","RES_Gear"},
      itemList7={10,"RES_Wood","RES_Wood","RES_Iron","RES_Wood","RES_Oil","RES_Iron","RES_Rag","RES_Oil"},
      itemList8={10,"RES_Wood","RES_Wood","RES_Wood","RES_Battery_High","RES_Battery_High","RES_Wood","RES_String_Piano","RES_String_Piano"}}
    GameObject.SendCommand({type="SsdZombiePack"},{id="SetDefaultPackItem",itemTable=n})
    local e=e.AfterSetUpEnemy
    if Tpp.IsTypeFunc(e)then
      e()
    end
  end
  function e.OnLoad()
  end
  return e
end
return l
