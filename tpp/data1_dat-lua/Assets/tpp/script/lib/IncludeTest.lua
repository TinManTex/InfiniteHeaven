-- DOBUILD: 0
local this={}

 --function CreateCpConfig(totalSoldierCount,
local function CreateCpConfig(revengeConfig,totalSoldierCount,powerComboExclusionList,powerElimOrChildSoldierTable,abilitiesList,outerBaseSoldierTable,cpConfig)  
  for r,powerType in ipairs(TppEnemy.POWER_SETTING)do
    local powerSetting=revengeConfig[powerType]
    if powerSetting then
      local settingSoldierCount=this._GetSettingSoldierCount(powerType,powerSetting,totalSoldierCount)
      
     -- if mvars.ene_cpList[cpId]=="afgh_powerPlant_cp"then--DEBUGNOW
      --InfMenu.DebugPrint(mvars.ene_cpList[cpId].." powerType:"..powerType.."="..tostring(powerSetting).." settingSoldierCount="..settingSoldierCount.." of "..totalSoldierCount)--DEBUGNOW
     -- end--
      
      local comboExcludeList=powerComboExclusionList[powerType]or{}
      local soldierCount=settingSoldierCount
      for soldierConfigId=1,totalSoldierCount do
        local powerElimOrChild=powerElimOrChildSoldierTable[soldierConfigId]
        --DEBUG OFF local nonAbilityNonBase=(not abilitiesList[POWER_SETTING])and((outerBaseSoldierTable[soldierConfigId] and gvars.applyPowersToOuterBase==0)and(llrpSoldierTable[soldierConfigId] and gvars.applyPowersToLlrp==0))
        local nonAbilityNonBase=(not abilitiesList[powerType])and outerBaseSoldierTable[soldierConfigId]
        if(not powerElimOrChild and not nonAbilityNonBase)and soldierCount>0 then
          local setPower=true
          if cpConfig[soldierConfigId][powerType]then
            soldierCount=soldierCount-1
            setPower=false
          end
          if setPower then
            for m,excludePower in ipairs(comboExcludeList)do
              if cpConfig[soldierConfigId][excludePower]then
                setPower=false
              end
            end
          end
          if setPower then
            soldierCount=soldierCount-1
            cpConfig[soldierConfigId][powerType]=true
            if powerType=="MISSILE"and this.IsUsingStrongMissile()then
              cpConfig[soldierConfigId].STRONG_MISSILE=true
            end
            if powerType=="SNIPER"and this.IsUsingStrongSniper()then
              cpConfig[soldierConfigId].STRONG_SNIPER=true
            end
          end
          
        end--if applythisshit
        soldierConfigId=soldierConfigId+1--RETAILBUG: added, game didn't actually increment count--DEBUGNOW --tex even though its a bug should wrap it in option since it changes behaviour so massively
      end-- for soldiers
    end--if configPower
  end--for TppEnemy.POWER_SETTINGS
end

--tppenenyy
function this.ApplyPowerSetting(soldierId,powerSetting)
  if soldierId==NULL_ID then
    return
  end
  local soldierType=this.GetSoldierType(soldierId)
  local soldierSubType=this.GetSoldierSubType(soldierId,soldierType)
  local powerLoadout={}
  for e,t in pairs(powerSetting)do
    if Tpp.IsTypeNumber(e)then
      powerLoadout[t]=true
    else
      powerLoadout[e]=t
    end
  end
  local checkLoadPowers={SMG=true,MG=true,SHOTGUN=true,SNIPER=true,MISSILE=true,SHIELD=true}
  for power,t in pairs(checkLoadPowers)do
    if powerLoadout[power]and not mvars.revenge_loadedEquip[power]then
      powerLoadout[power]=nil
    end
  end
  if soldierType==EnemyType.TYPE_SKULL then
    if soldierSubType=="SKULL_CYPR"then
      powerLoadout.SNIPER=nil
      powerLoadout.SHOTGUN=nil
      powerLoadout.MG=nil
      powerLoadout.SMG=true
      powerLoadout.GUN_LIGHT=true
    else
      powerLoadout.HELMET=true
      powerLoadout.SOFT_ARMOR=true
    end
  end
  if powerLoadout.ARMOR and not TppRevenge.CanUseArmor(soldierSubType)then
    powerLoadout.ARMOR=nil
  end
  if powerLoadout.QUEST_ARMOR then
    powerLoadout.ARMOR=true
  end
  if powerLoadout.ARMOR then
    powerLoadout.SNIPER=nil
    powerLoadout.SHIELD=nil
    powerLoadout.MISSILE=nil
    powerLoadout.SMG=nil
    if not powerLoadout.SHOTGUN and not powerLoadout.MG then
      if mvars.revenge_loadedEquip.MG then
        powerLoadout.MG=true
      elseif mvars.revenge_loadedEquip.SHOTGUN then
        powerLoadout.SHOTGUN=true
      end
    end
    if powerLoadout.MG then
      powerLoadout.SHOTGUN=nil
    end
    if powerLoadout.SHOTGUN then
      powerLoadout.MG=nil
    end
  end
  if powerLoadout.MISSILE or powerLoadout.SHIELD then
    powerLoadout.SNIPER=nil
    powerLoadout.SHOTGUN=nil
    powerLoadout.MG=nil
    powerLoadout.SMG=true
  end
  if powerLoadout.GAS_MASK then
    if soldierSubType~="DD_FOB"then
      powerLoadout.HELMET=nil
      powerLoadout.NVG=nil
    end
  end
  if powerLoadout.NVG then
    if soldierSubType~="DD_FOB"then
      powerLoadout.HELMET=nil
      powerLoadout.GAS_MASK=nil
    end
  end
  if powerLoadout.HELMET then
    if soldierSubType~="DD_FOB"then
      powerLoadout.GAS_MASK=nil
      powerLoadout.NVG=nil
    end
  end
  mvars.ene_soldierPowerSettings[soldierId]=powerLoadout
  powerSetting=powerLoadout
  local n=0
  local o=this.GetBodyId(soldierId,soldierType,soldierSubType,powerSetting)
  local s=this.GetFaceId(soldierId,soldierType,soldierSubType,powerSetting)
  local l=this.GetBalaclavaFaceId(soldierId,soldierType,soldierSubType,powerSetting)
  local e,p,r=this.GetWeaponId(soldierId,powerSetting)
  if powerSetting.HELMET then
    n=n+WearEquip.HELMET
  end
  if powerSetting.GAS_MASK then
    n=n+WearEquip.GAS_MASK
  end
  if powerSetting.NVG then
    n=n+WearEquip.NVG
  end
  if powerSetting.SOFT_ARMOR then
    n=n+WearEquip.SOFT_ARMOR
  end
  if(e~=nil or secondaryWeapon~=nil)or r~=nil then
    GameObject.SendCommand(soldierId,{id="SetEquipId",primary=e,secondary=p,tertiary=r})
  end
  GameObject.SendCommand(soldierId,{id="ChangeFova",bodyId=o,faceId=s,balaclavaFaceId=l})
  GameObject.SendCommand(soldierId,{id="SetWearEquip",flag=n})
  local e={SOVIET_A=d.SOVIET_A,SOVIET_B=d.SOVIET_B,PF_A=d.PF_A,PF_B=d.PF_B,PF_C=d.PF_C,DD_A=d.DD_A,DD_FOB=d.DD_FOB,DD_PW=d.DD_PW,CHILD_A=d.CHILD_A,SKULL_AFGH=d.SKULL_AFGH,SKULL_CYPR=d.SKULL_CYPR}
  GameObject.SendCommand(soldierId,{id="SetSoldier2SubType",type=e[soldierSubType]})
end


--tpprevenge
function this._ApplyRevengeToCp(cpId,revengeConfig,RENsomeMotherbasecounter)--cpId,revengeConfig,RENAMEsomeMotherbasecounter)
  local soldierIds=mvars.ene_soldierIDList[cpId]
  local soldierIdForConfigIdTable={}
  local totalSoldierCount=0
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    local r=0
    local cp=mvars.ene_cpList[cpId]
    if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
      local clusterIdList=mtbs_enemy.cpNameToClsterIdList[cp]
      if clusterIdList then
        soldierIds={}
        local soldierLocators=mvars.mbSoldier_enableSoldierLocatorList[clusterIdList]
        for n,soldierName in ipairs(soldierLocators)do
          local RENsomeMbSomethingId=tonumber(string.sub(soldierName,-6,-6))
          if RENsomeMbSomethingId~=nil and RENsomeMbSomethingId==RENsomeMotherbasecounter then
            local soldierId=GameObject.GetGameObjectId("TppSoldier2",soldierName)
            soldierIds[soldierId]=r
          end
        end
      end
    end
  end
  if soldierIds==nil then
    return
  end
  local missionPowerSoldiers={}
  for soldierName,missionPowerSetting in pairs(mvars.ene_missionSoldierPowerSettings)do
    local missionPowerSoldierId=GetGameObjectId("TppSoldier2",soldierName)
    missionPowerSoldiers[missionPowerSoldierId]=missionPowerSetting
  end
  local missionAbilitySoldiers={}
  for soldierName,missionAbilitySetting in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
    local missionPowerAbilitySoldierId=GetGameObjectId("TppSoldier2",soldierName)
    missionAbilitySoldiers[missionPowerAbilitySoldierId]=missionAbilitySetting
  end
  local outerBaseCp=mvars.ene_outerBaseCpList[cpId]
  local powerElimOrChildSoldierTable={}
  local outerBaseOrLrrpSoldierTable={}
  for gameId,E in pairs(soldierIds)do
    table.insert(soldierIdForConfigIdTable,gameId)
    totalSoldierCount=totalSoldierCount+1
    if missionPowerSoldiers[gameId]then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif mvars.ene_eliminateTargetList[gameId]then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif TppEnemy.GetSoldierType(gameId)==EnemyType.TYPE_CHILD then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif outerBaseCp then
      outerBaseOrLrrpSoldierTable[totalSoldierCount]=true
    elseif mvars.ene_lrrpTravelPlan[cpId]then
      outerBaseOrLrrpSoldierTable[totalSoldierCount]=true
    end
  end
  local cpConfig={}
  for n=1,totalSoldierCount do
    if outerBaseCp then
      cpConfig[n]={OB=true}
    else
      cpConfig[n]={}
    end
  end
  local powerComboExclusionList={
    ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},
    SOFT_ARMOR={"ARMOR"},
    SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},
    SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},
    MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},
    SMG={"SNIPER","SHOTGUN","MG"},
    MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},
    SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},
    HELMET={"ARMOR","GAS_MASK","NVG"},
    GAS_MASK={"ARMOR","HELMET","NVG"},
    NVG={"ARMOR","HELMET","GAS_MASK"},
    GUN_LIGHT={"SNIPER","MG"}
  }
  local abilitiesList={
    STEALTH_LOW=true,
    STEALTH_HIGH=true,
    STEALTH_SPECIAL=true,
    COMBAT_LOW=true,
    COMBAT_HIGH=true,
    COMBAT_SPECIAL=true,
    HOLDUP_LOW=true,
    HOLDUP_HIGH=true,
    HOLDUP_SPECIAL=true,
    FULTON_LOW=true,
    FULTON_HIGH=true,
    FULTON_SPECIAL=true
  }
  for r,POWER_SETTING in ipairs(TppEnemy.POWER_SETTING)do
    local revengeConfigPower=revengeConfig[POWER_SETTING]
    if revengeConfigPower then
      local settingSoldierCount=this._GetSettingSoldierCount(POWER_SETTING,revengeConfigPower,totalSoldierCount)
      local comboExcludeList=powerComboExclusionList[POWER_SETTING]or{}
      local soldierCount=settingSoldierCount
      for soldierConfigId=1,totalSoldierCount do
        local powerElimOrChild=powerElimOrChildSoldierTable[soldierConfigId]
        local nonAbilityNonBase=(not abilitiesList[POWER_SETTING])and outerBaseOrLrrpSoldierTable[soldierConfigId]
        if(not powerElimOrChild and not nonAbilityNonBase)and soldierCount>0 then
          local setPower=true
          if cpConfig[soldierConfigId][POWER_SETTING]then
            soldierCount=soldierCount-1
            setPower=false
          end
          if setPower then
            for m,excludePower in ipairs(comboExcludeList)do
              if cpConfig[soldierConfigId][excludePower]then
                setPower=false
              end
            end
          end
          if setPower then
            soldierCount=soldierCount-1
            cpConfig[soldierConfigId][POWER_SETTING]=true
            if POWER_SETTING=="MISSILE"and this.IsUsingStrongMissile()then
              cpConfig[soldierConfigId].STRONG_MISSILE=true
            end
            if POWER_SETTING=="SNIPER"and this.IsUsingStrongSniper()then
              cpConfig[soldierConfigId].STRONG_SNIPER=true
            end
          end
        end
      end
    end
  end
  for soldierConfigId,powerSetting in ipairs(cpConfig)do
    local soldierId=soldierIdForConfigIdTable[soldierConfigId]
    TppEnemy.ApplyPowerSetting(soldierId,powerSetting)
    if missionAbilitySoldiers[soldierId]==nil then
      local personalAbilitySettings={}
      do
        local stealth
        if powerSetting.STEALTH_SPECIAL then
          stealth="sp"
        elseif powerSetting.STEALTH_HIGH then
          stealth="high"
        elseif powerSetting.STEALTH_LOW then
          stealth="low"
        end
        personalAbilitySettings.notice=stealth
        personalAbilitySettings.cure=stealth
        personalAbilitySettings.reflex=stealth
      end
      do
        local combat
        if powerSetting.COMBAT_SPECIAL then
          combat="sp"
        elseif powerSetting.COMBAT_HIGH then
          combat="high"
        elseif powerSetting.COMBAT_LOW then
          combat="low"
        end
        personalAbilitySettings.shot=combat
        personalAbilitySettings.grenade=combat
        personalAbilitySettings.reload=combat
        personalAbilitySettings.hp=combat
      end
      do
        local speed
        if powerSetting.STEALTH_SPECIAL or powerSetting.COMBAT_SPECIAL then
          speed="sp"
        elseif powerSetting.STEALTH_HIGH or powerSetting.COMBAT_HIGH then
          speed="high"
        elseif powerSetting.STEALTH_LOW or powerSetting.COMBAT_LOW then
          speed="low"
        end
        personalAbilitySettings.speed=speed
      end
      do
        local fulton
        if powerSetting.FULTON_SPECIAL then
          fulton="sp"
        elseif powerSetting.FULTON_HIGH then
          fulton="high"
        elseif powerSetting.FULTON_LOW then
          fulton="low"
        end
        personalAbilitySettings.fulton=fulton
      end
      do
        local holdup
        if powerSetting.HOLDUP_SPECIAL then
          holdup="sp"
        elseif powerSetting.HOLDUP_HIGH then
          holdup="high"
        elseif powerSetting.HOLDUP_LOW then
          holdup="low"
        end
        personalAbilitySettings.holdup=holdup
      end
      TppEnemy.ApplyPersonalAbilitySettings(soldierId,personalAbilitySettings)end
  end
end
--
function e._ApplyRevengeToCp(t,l,a)local E=mvars.ene_soldierIDList[t]local o={}local n=0
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    local r=0
    local e=mvars.ene_cpList[t]if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
      local e=mtbs_enemy.cpNameToClsterIdList[e]if e then
        E={}local e=mvars.mbSoldier_enableSoldierLocatorList[e]for n,e in ipairs(e)do
          local n=tonumber(string.sub(e,-6,-6))if n~=nil and n==a then
            local e=GameObject.GetGameObjectId("TppSoldier2",e)E[e]=r
          end
        end
      end
    end
  end
  if E==nil then
    return
  end
  local r={}for e,n in pairs(mvars.ene_missionSoldierPowerSettings)do
    local e=_("TppSoldier2",e)r[e]=n
  end
  local i={}for n,e in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
    local n=_("TppSoldier2",n)i[n]=e
  end
  local T=mvars.ene_outerBaseCpList[t]local a={}local _={}for e,E in pairs(E)do
    table.insert(o,e)n=n+1
    if r[e]then
      a[n]=true
    elseif mvars.ene_eliminateTargetList[e]then
      a[n]=true
    elseif TppEnemy.GetSoldierType(e)==EnemyType.TYPE_CHILD then
      a[n]=true
    elseif T then
      _[n]=true
    elseif mvars.ene_lrrpTravelPlan[t]then
      _[n]=true
    end
  end
  local t={}for e=1,n do
    if T then
      t[e]={OB=true}else
      t[e]={}end
  end
  local T={ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},SOFT_ARMOR={"ARMOR"},SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},SMG={"SNIPER","SHOTGUN","MG"},MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},HELMET={"ARMOR","GAS_MASK","NVG"},GAS_MASK={"ARMOR","HELMET","NVG"},NVG={"ARMOR","HELMET","GAS_MASK"},GUN_LIGHT={"SNIPER","MG"}}local s={STEALTH_LOW=true,STEALTH_HIGH=true,STEALTH_SPECIAL=true,COMBAT_LOW=true,COMBAT_HIGH=true,COMBAT_SPECIAL=true,HOLDUP_LOW=true,HOLDUP_HIGH=true,HOLDUP_SPECIAL=true,FULTON_LOW=true,FULTON_HIGH=true,FULTON_SPECIAL=true}for r,E in ipairs(TppEnemy.POWER_SETTING)do
    local r=l[E]
    if r then
      local r=e._GetSettingSoldierCount(E,r,n)
      local o=T[E]or{}
      local r=r
      for n=1,n do
        local a=a[n]
        local _=(not s[E])and _[n]
        if(not a and not _)and r>0 then
          local a=true
          if t[n][E]then
            r=r-1
            a=false
          end
          if a then
            for E,e in ipairs(o)do
              if t[n][e]then
                a=false
              end
            end
          end
          if a then
            r=r-1
            t[n][E]=true
            if E=="MISSILE"and e.IsUsingStrongMissile()then
              t[n].STRONG_MISSILE=true
            end
            if E=="SNIPER"and e.IsUsingStrongSniper()then
              t[n].STRONG_SNIPER=true
            end
          end
        end
      end
    end
  end
  for n,e in ipairs(t)do
    local t=o[n]TppEnemy.ApplyPowerSetting(t,e)
    if i[t]==nil then
      local n={}do
        local E
        if e.STEALTH_SPECIAL then
          E="sp"elseif e.STEALTH_HIGH then
          E="high"elseif e.STEALTH_LOW then
          E="low"end
        n.notice=E
        n.cure=E
        n.reflex=E
      end
      do
        local E
        if e.COMBAT_SPECIAL then
          E="sp"elseif e.COMBAT_HIGH then
          E="high"elseif e.COMBAT_LOW then
          E="low"end
        n.shot=E
        n.grenade=E
        n.reload=E
        n.hp=E
      end
      do
        local E
        if e.STEALTH_SPECIAL or e.COMBAT_SPECIAL then
          E="sp"elseif e.STEALTH_HIGH or e.COMBAT_HIGH then
          E="high"elseif e.STEALTH_LOW or e.COMBAT_LOW then
          E="low"end
        n.speed=E
      end
      do
        local E
        if e.FULTON_SPECIAL then
          E="sp"elseif e.FULTON_HIGH then
          E="high"elseif e.FULTON_LOW then
          E="low"end
        n.fulton=E
      end
      do
        local E
        if e.HOLDUP_SPECIAL then
          E="sp"elseif e.HOLDUP_HIGH then
          E="high"elseif e.HOLDUP_LOW then
          E="low"end
        n.holdup=E
      end
      TppEnemy.ApplyPersonalAbilitySettings(t,n)end
  end
end
function e.Messages()return Tpp.StrCode32Table{GameObject={{msg="HeadShot",func=e._OnHeadShot},{msg="Dead",func=e._OnDead},{msg="Unconscious",func=e._OnUnconscious},{msg="ComradeFultonDiscovered",func=e._OnComradeFultonDiscovered},{msg="CommandPostAnnihilated",func=e._OnAnnihilated},{msg="ChangePhase",func=e._OnChangePhase},{msg="Damage",func=e._OnDamage},{msg="AntiSniperNoticed",func=e._OnAntiSniperNoticed},{msg="SleepingComradeRecoverd",func=e._OnSleepingComradeRecoverd},{msg="SmokeDiscovered",func=e._OnSmokeDiscovered},{msg="ReinforceRespawn",func=e._OnReinforceRespawn}},Trap={{msg="Enter",func=e._OnEnterTrap}}}end
function e.Init(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnReload(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())end
function e.OnMessage(r,E,n,t,a,o,_)Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,E,n,t,a,o,_)end
local r=function(e)if(((((((((((((attackid==TppDamage.ATK_VehicleHit or e==TppDamage.ATK_Tankgun_20mmAutoCannon)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Tankgun_105mmRifledBoreGun)or e==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Wav1)or e==TppDamage.ATK_WavCannon)or e==TppDamage.ATK_TankCannon)or e==TppDamage.ATK_WavRocket)or e==TppDamage.ATK_HeliMiniGun)or e==TppDamage.ATK_HeliChainGun)or attackid==TppDamage.ATK_WalkerGear_BodyAttack then
  return true
end
return false
end
--
--local debugSplash=SplashScreen.Create("ooop","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(InfMain.debugSplash,0,0.3,0)--tex eagle DEBUG

function this.ReservePlayerLoadingPositionNew(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  this.DisableGameStatus()
  if missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    local hasHeliRoute=gvars.heli_missionStartRoute~=0
    local isStartOnFoot=false
    local setFromHeliStartPosition=false

    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    TppPlayer.ResetNoOrderBoxMissionStartPosition()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    gvars.ply_initialPlayerState=0

    if nextIsHeliSpace then
      TppHelicopter.ResetMissionStartHelicopterRoute()
    elseif isHeliSpace then
      if hasHeliRoute then
        setFromHeliStartPosition=true
      else
        isStartOnFoot=true
        local noHeliMissionStartPos=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if noHeliMissionStartPos then
          TppPlayer.SetInitialPosition(noHeliMissionStartPos,0)
          TppPlayer.SetMissionStartPosition(noHeliMissionStartPos,0)
        end
      end
      TppMission.SetIsStartFromHelispace()
    elseif nextIsFreeMission then
      if TppLocation.IsMotherBase()then
      else
        isStartOnFoot=true
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      --TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
      if TppMission.GetMissionClearType()==TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR then
        setFromHeliStartPosition=true
        TppMission.SetIsStartFromHelispace()
      end
    elseif(isFreeMission and TppLocation.IsMotherBase())then
      TppMission.SetIsStartFromHelispace()
    else
      if isFreeMission then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
        else
          local noBoxMissionStartPos={
            [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
            [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
            [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
            [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
            [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
            [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
            [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
          }
          noBoxMissionStartPos[11050]=noBoxMissionStartPos[10050]
          noBoxMissionStartPos[11080]=noBoxMissionStartPos[10080]
          noBoxMissionStartPos[11140]=noBoxMissionStartPos[10140]
          noBoxMissionStartPos[10151]=noBoxMissionStartPos[10150]
          noBoxMissionStartPos[11151]=noBoxMissionStartPos[10150]
          local posrot=noBoxMissionStartPos[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and posrot then
            TppPlayer.SetNoOrderBoxMissionStartPosition(posrot,posrot[4])
          end
        end
        local noOrderFixHeliRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if noOrderFixHeliRoute then
          TppMission.SetIsStartFromHelispace()
        else
          isStartOnFoot=true
          TppMission.SetIsStartFromFreePlay()
        end

        local missionClearType=TppMission.GetMissionClearType()
        --TppQuest.SpecialMissionStartSetting(missionClearType)
        if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END)then
          isStartOnFoot=true
          TppPlayer.SetNoOrderBoxMissionStartPosition({-1868.27,343.22,-84.6095},160.651)
          TppMission.SetIsStartFromFreePlay()
        elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END)then
          gvars.heli_missionStartRoute=Fox.StrCode32"drp_s10260"
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
        elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END)then
          isStartOnFoot=true
          TppPlayer.SetNoOrderBoxMissionStartPosition({-855.6097,515.6722,-1250.411},160.651)
          TppMission.SetIsStartFromFreePlay()
        end
      end
    end

    if not nextIsHeliSpace then
      if isStartOnFoot then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
      else
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
      end
      if setFromHeliStartPosition then
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
        end
      end
    end


  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if abortWithSave then
      if nextIsFreeMission then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif nextIsHeliSpace then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if nextIsHeliSpace then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif nextIsFreeMission then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if isHeliSpace and isLocationChange then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end


return this
