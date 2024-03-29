--InfRevenge.lua
local this={}

--tex TODO: put in some util or math module
function this.round(num,idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

local function GetMinMaxIvars(name)
  return Ivars[name.."_MIN"],Ivars[name.."_MAX"]
end

local function GetNonDefaultRandom(ivarMin,ivarMax,nonDefaultOnly)
  if nonDefaultOnly and (ivarMin:IsDefault() and ivarMax:IsDefault()) then
    return nil
  end
  return math.random(ivarMin:Get(),ivarMax:Get())
end
--tex onlyNonDefault will only add powerTypes to revengeConfig if their repsective Ivar isn't its default.
function this.CreateCustomRevengeConfig(onlyNonDefault)
  local InfRevengeIvars=InfRevengeIvars

  local revengeConfig={}
  InfMain.RandomSetToLevelSeed()
  for n,powerTableName in ipairs(InfRevengeIvars.percentagePowerTables)do
    local powerTable=InfRevengeIvars[powerTableName]
    for m,powerType in ipairs(powerTable)do
      local ivarMin,ivarMax=GetMinMaxIvars(powerType)
      local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
      if random~=nil then
        random=this.round(random)
        --InfCore.DebugPrint(ivarName.." min:"..tostring(min).." max:"..tostring(max).. " random:"..tostring(random))--DEBUG
        if random>0 then
          revengeConfig[powerType]=tostring(random).."%"
        end
      end
    end
  end

  for n,powerType in ipairs(InfRevengeIvars.abilitiesWithLevels)do
    local ivarMin,ivarMax=GetMinMaxIvars(powerType)
    local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
    if random~=nil and random>0 then
      local powerType=powerType.."_"..ivarMin.settings[random+1]
      revengeConfig[powerType]=true
    end
  end

  for n,powerType in ipairs(InfRevengeIvars.weaponStrengthPowers)do
    local ivarMin,ivarMax=GetMinMaxIvars(powerType)
    local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
    if random~=nil and random==1 then
      revengeConfig[powerType]=true
    end
  end

  for n,powerType in ipairs(InfRevengeIvars.cpEquipBoolPowers)do
    local ivarMin,ivarMax=GetMinMaxIvars(powerType)
    local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
    if random~=nil and random==1 then
      revengeConfig[powerType]=true
    end
  end

  local ivarMin,ivarMax=GetMinMaxIvars"reinforceLevel"
  local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
  if random~=nil and random>0 then
    revengeConfig[ ivarMin.settings[random+1] ]=true
  end

  local ivarMin,ivarMax=GetMinMaxIvars"revengeIgnoreBlocked"
  local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
  if random~=nil and random>0 then
    revengeConfig.IGNORE_BLOCKED=true
  end

  local ivarMin,ivarMax=GetMinMaxIvars"reinforceCount"
  local random=GetNonDefaultRandom(ivarMin,ivarMax,onlyNonDefault)
  if random~=nil then
    revengeConfig.REINFORCE_COUNT=random
  end

  --tex TODO if not onlyNonDefault or not missionvar mbDDEquipNonLethal IsDefault
  if Ivars.mbDDEquipNonLethal:EnabledForMission() then
    revengeConfig.NO_KILL_WEAPON=true
  end

  local bodyInfo=InfEneFova.GetMaleBodyInfo()
  if bodyInfo and (not bodyInfo.hasArmor) and (vars.missionCode==30050 or vars.missionCode==30250) then--tex TODO: handle mother base special case better, especially with the male/female split
    revengeConfig.ARMOR=nil
  end

  InfMain.RandomResetToOsTime()

  --  InfCore.Log("CreateCustomRevengeConfig onlyNonDefault:"..tostring(onlyNonDefault))--DEBUG
  --  InfCore.PrintInspect(revengeConfig)
  return revengeConfig
end

local function AvePowerSetting(powerType)
  if Ivars[powerType.."_MIN"]==nil or Ivars[powerType.."_MAX"]==nil then
    InfCore.Log("WARNING: AvePowerSetting: cannot find powertype:"..powerType)--DEBUG
    return 0
  end

  return (Ivars[powerType.."_MIN"]:Get()+Ivars[powerType.."_MAX"]:Get())/2
end

function this.SetCustomRevengeUiParameters()
  --tex ui params range is 0-3
  local uiRange=3

  --tex just averaging between min/max, could probably save actual chosen value somewhere but would only be accurate for Global config and not per cp config mode
  local fulton=this.round(AvePowerSetting"FULTON")

  local headShot=this.round(uiRange*AvePowerSetting"HELMET")

  --REF stealth 5
  --    STEALTH_SPECIAL=true,
  --    HOLDUP_HIGH=true,
  --    ACTIVE_DECOY=true,
  --    GUN_CAMERA=true},

  local stealthPowers={
    "DECOY",
    "MINE",
    "CAMERA",
  }

  local ave=0
  for n,powerType in ipairs(stealthPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/#stealthPowers

  local stealth=this.round(uiRange*ave)--TODO incorporate-^- stralth and holdup abilities at least

  --REF combat 5
  --STRONG_WEAPON=true,
  --COMBAT_SPECIAL=true,
  --SUPER_REINFORCE=true,
  --BLACK_SUPER_REINFORCE=true,
  --REINFORCE_COUNT=3},
  local combatPowers={
    "ARMOR",
    "SOFT_ARMOR",
    "SHIELD",
    "MG",
    "SHOTGUN",
    "MISSILE",--tex in normal game I don't think missile is even accounted for in ui params?
  }
  local ave=0
  for n,powerType in ipairs(combatPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#combatPowers/2)--tex KLUDGE half the count

  local combat=this.round(uiRange*ave)--tex TODO incorporate rest of combat powers

  local nightPowers={
    "NVG",
    "GUN_LIGHT",
  }
  local ave=0
  for n,powerType in ipairs(nightPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#nightPowers/2)--tex KLUDGE bump
  if ave>1 then
    ave=1
  end
  local night=this.round(uiRange*ave)

  local sniperPowers={
    "SNIPER",
    "STRONG_SNIPER",--tex mixing unalike values here, sniper is percentage, strong is intbool
  }
  local ave=0
  for n,powerType in ipairs(sniperPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#sniperPowers/2)--tex KLUDGE bump
  if ave>1 then
    ave=1
  end
  local longRange=this.round(uiRange*ave)

  InfCore.Log("InfRevenge.SetCustomRevengeUiParameters "..tostring(vars.missionCode)..": fulton="..fulton.." headShot="..headShot.." stealth="..stealth.." combat="..combat.." night="..night.." longRange="..longRange)--DEBUG
  TppUiCommand.RegisterEnemyRevengeParameters{fulton=fulton,headShot=headShot,stealth=stealth,combat=combat,night=night,longRange=longRange}
end

--CALLER: TppRevenge._ApplyRevengeToCp
--REF balanceTypes={
--  "ARMOR",
--  "HELMET",
--  "NVG",
--  "GAS_MASK",
--}
--REF revengeConfig={
--  ARMOR = 1,
--  ASSAULT = "15%",
--  BLACK_SUPER_REINFORCE = true,
--  CAMERA = "100%",
--  FULTON_HIGH = true,
--  GAS_MASK = "99%",
--  GUN_LIGHT = "36%",
--  HELMET = "3%",
--  HOLDUP_HIGH = true,
--  MG = "20%",
--  MINE = "61%",
--  MISSILE = "10%",
--  NVG = "84%",
--  REINFORCE_COUNT = 5,
--  SHIELD = "10%",
--  SHOTGUN = "20%",
--  SMG = "20%",
--  SNIPER = "10%",
--  SOFT_ARMOR = "46%",
--  STRONG_MISSILE = true,
--  STRONG_SNIPER = true,
--  STRONG_WEAPON = true
--}
--PARAM/OUT: originalSettingsTable, found balanceTypes, as percentages
--Sums up any balanceTypes (as percentages) vs totalSoldierCount, this way you can see if a selection of power types is over 100% subscription
function this.GetSumBalance(balanceTypes,revengeConfig,totalSoldierCount)
  local ballancePowersAsPercent={}

  local sumBalance=0
  local numBalance=0

  for n,powerType in pairs(balanceTypes) do
    local powerSetting=revengeConfig[powerType]
    if powerSetting~=nil and powerSetting~=0 then--tex powersetting should never be 0 from what I've seen, but checking anyway

      local percentage=0
      --tex convert from num soldiers to percentage
      if Tpp.IsTypeNumber(powerSetting)then
        if powerSetting>totalSoldierCount then
          powerSetting=totalSoldierCount
        end
        if totalSoldierCount~=0 then
          percentage=(powerSetting/totalSoldierCount)*100
          ballancePowersAsPercent[powerType]=percentage
          numBalance=numBalance+1
          sumBalance=sumBalance+percentage
          --InfCore.DebugPrint("powerType:"..powerType.." powerSetting:"..tostring(powerSetting).." numtopercentage:"..percentage)--DEBUG
        end
      elseif Tpp.IsTypeString(powerSetting)then
        if powerSetting:sub(-1)=="%"then
          percentage=powerSetting:sub(1,-2)+0
          ballancePowersAsPercent[powerType]=percentage
          numBalance=numBalance+1
          sumBalance=sumBalance+percentage
          --InfCore.DebugPrint("powerType:"..powerType.." powerSetting:"..powerSetting.." stringtopercentage:"..percentage)--DEBUG
        end
      end
    end--if powersetting
  end--for balanceGearTypes

  return numBalance,sumBalance,ballancePowersAsPercent
end--GetSumBalance

--CALLER: TppRevenge._ApplyRevengeToCp,BalanceWeaponPowers
--PARAM/RETURN: revengeConfig
--tex tries to ballance revengConfig powers listed in balancePowersAsPercent
function this.BalancePowers(numBalance,reservePercent,balancePowersAsPercent,revengeConfig)
  if numBalance==0 then
    InfCore.DebugPrint"BalancePowers numballance==0"
    return
  end
  
  local balancePercent=0
  if numBalance>0 then
    local maxPercent=100-reservePercent
    balancePercent=maxPercent/numBalance--tex start with an even allocation for all the powers as a rough target
    --tex build up a pool from those under balancePercent
    --TODO: bump up on an individual power basis biased by those that have higher original requested percentage
    --local aboveBalance=numBalance
    local underflow=0
    for powerType,powerPercent in pairs(balancePowersAsPercent) do
      if powerPercent < balancePercent then
        underflow=underflow+(balancePercent-powerPercent)
        --aboveBalance=aboveBalance-1
      end
    end

    --InfCore.DebugPrint("numBalance:"..numBalance.." balancePercent:"..balancePercent.." underflow:"..underflow)--DEBUG

    --OFF if underflow>0 then--tex distribute underflow evenly
    -- balancePercent=balancePercent+(underflow/aboveBalance)
    -- underflow=0
    --end

    --tex distribute underflow in ballanceGearType order --DEBUGNOW huh? pairs isnt ordered, and balanceTypes isnt currently a param, or was this supposed to be labeled TODO?
    --alternative would be to sort by highest percentage so those get bump first
    for powerType,powerPercent in pairs(balancePowersAsPercent) do
      --tex is too high
      if powerPercent>balancePercent then
        local toOriginalPercent=powerPercent-balancePercent
        local bump=math.min(underflow,toOriginalPercent)
        underflow=underflow-bump
        local ballancedPower=balancePercent+bump
        -- InfCore.DebugPrint("numBalance:"..numBalance.." powerType:"..powerType.." balancePercent:"..balancePercent.." bump:"..bump)--DEBUG
        revengeConfig[powerType]=tostring(ballancedPower).."%"
      end
    end
    --InfCore.DebugPrint("numBalance:"..numBalance.." sumBalance:"..sumBalance.." balancePercent:"..balancePercent)--DEBUG
  end--if numbalance
  return revengeConfig--tex already been edited in-place, but this is clearer
end--BalancePowers
--OUT: revengeConfigCp
local function RandomizeSmallCpPowers(revengeConfigCp,totalSoldierCount)
  local smallCpBalanceLimit=5--tex TODO magic number
  if totalSoldierCount > smallCpBalanceLimit then
    return
  end

  --powertype={min,max}
    local smallCpBallanceList={
      ARMOR={0,totalSoldierCount},
      SNIPER={0,1},
      SHIELD={0,totalSoldierCount},--totalSoldierCount/2},
      MISSILE={0,totalSoldierCount},
      MG={0,totalSoldierCount},
      SHOTGUN={0,totalSoldierCount},
    }
    InfMain.RandomSetToLevelSeed()
    for powerType,range in pairs(smallCpBallanceList) do
      if revengeConfigCp[powerType] then
        local currentSetting=revengeConfigCp[powerType]
        if not Tpp.IsTypeNumber(currentSetting)then
          currentSetting=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
        end

        revengeConfigCp[powerType]=math.random(range[1],math.min(currentSetting,range[2]))
        if revengeConfigCp[powerType]==0 then
          revengeConfigCp[powerType]=nil
        end
      end
    end
    InfMain.RandomResetToOsTime()
end--RandomizeSmallCpPowers
--tex WIP>
--OUT: revengeConfigCp
local function BalanceWeaponPowers(revengeConfigCp,totalSoldierCount)
  local balanceWeaponTypes={--tex>
    "SNIPER",
    "SHOTGUN",
    "MG",
    "SMG",
    "ASSAULT",
  }

  --tex TODO: need a way to account for the shield force applying SMGs when smgs is also set?? or does this not actually happen
  --      local smgTypes={
  --        --"SMG",
  --        "SHIELD",--tex this is forced in TppEnemy.ApplyPowerSetting
  --        --"MISSILE",--TODO: need to include if allowMissileWeaponsCombo is off
  --      }
  --      local totalSmgs=0
  --      for n, powerType in ipairs(smgTypes) do
  --        totalSmgs=totalSmgs+this._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
  --      end
  local powerType="SMG"
  local totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)

  local smgForced=revengeConfigCp.SHIELD and revengeConfigCp.SMG==nil
  if smgForced then
    local powerType="SHIELD"
    totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
    revengeConfigCp.SMG=totalSmgs
    --    elseif revengeConfigCp.MISSILE and not revengeConfigCp.SMG then
    --      local powerType="MISSILE"
    --      local totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
    --      revengeConfigCp.SMG=totalSmgs
    --
    --      if Ivars.allowMissileWeaponsCombo:Is(0) then
    --        smgForced=true
    --      end
  end--if smgForced

  --  local wantedWeapons={}
  --  for n,powerType in pairs(balanceWeaponTypes)do
  --    wantedWeapons[powerType]=0
  --  end
  --
  --  local totalWanted=0
  --  for n,powerType in pairs(balanceWeaponTypes)do
  --    local wanted=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
  --    totalWanted=totalWanted+wanted
  --    wantedWeapons[powerType]=wanted
  --  end

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG
  --      InfCore.DebugPrint("totalSoldierCount:" .. totalSoldierCount.." totalWanted weapons:"..totalWanted)
  --      InfCore.PrintInspect(wantedWeapons)--DEBUG
  --    end--

  --    if revengeConfigCp.SMG==nil then
  --      revengeConfigCp.SMG=1
  --    end
  --
  --    local numTypes=0
  --    for n,powerType in pairs(balanceWeaponTypes)do
  --      numTypes=numTypes+1
  --    end

  revengeConfigCp.ASSAULT="10%"

  local sumBalance=0
  local numBalance=0

  local ballancePowersAsPercent={}

  numBalance,sumBalance,ballancePowersAsPercent=this.GetSumBalance(balanceWeaponTypes,revengeConfigCp,totalSoldierCount,ballancePowersAsPercent)

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG>
  --      InfCore.PrintInspect(ballancePowersAsPercent,"BalanceWeaponPowers ballancePowersAsPercent")
  --    end--<

  if numBalance>0 and sumBalance>Ivars.balanceWeaponPowers.balanceWeaponsThreshold then
    local reservePercent=0--tex TODO: reserve some for assault? or handle that
    revengeConfigCp=this.BalancePowers(numBalance,reservePercent,ballancePowersAsPercent,revengeConfigCp)
  end

  if smgForced then
    revengeConfigCp.SHIELD=revengeConfigCp.SMG
    revengeConfigCp.SMG=nil--tex don't want CreateCpConfig to actually assign since these will be forced in TppEnemy.ApplyPowerSetting
  end

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG>
  --      InfCore.DebugPrint("revengeConfig")
  --      InfCore.PrintInspect(revengeConfig)
  --      InfCore.DebugPrint("revengeConfigCp")
  --      InfCore.PrintInspect(revengeConfigCp)
  --    end--<
end--BalanceWeaponPowers

--CALLER: TppRevenge._ApplyRevengeToCp
--OUT: revengeConfigCp
function this.ModRevengeConfigCp(revengeConfigCp,totalSoldierCount,isLrrpCp,isOuterBaseCp)
  --tex limit armor, see 'limit armor' in _CreateRevengeConfig>
  if isLrrpCp or isOuterBaseCp then
    if revengeConfigCp.ARMOR then
      if IvarProc.EnabledForMission"allowHeavyArmor" or IvarProc.EnabledForMission"revengeMode" then
        revengeConfigCp.ARMOR=false
      end
    end
  end

  if Ivars.enableMgVsShotgunVariation:Is(1) then
    local setting=revengeConfigCp.MG_OR_SHOTGUN or 0
    if setting~=0 then
      InfMain.RandomSetToLevelSeed()
      local mgShottyLoadouts={
        {MG=setting,SHOTGUN=nil},
        {MG=nil,SHOTGUN=setting},
        {MG=math.floor(setting/2),SHOTGUN=math.floor(setting/2)},
      }
      local powerTable=mgShottyLoadouts[math.random(1,3)]
      for powerType,setting in pairs(powerTable)do
        revengeConfigCp[powerType]=setting
      end

      InfMain.RandomResetToOsTime()
    end
  end--enableMgVsShotgunVariation<

  if Ivars.randomizeSmallCpPowers:Is(1) then
    RandomizeSmallCpPowers(revengeConfigCp,totalSoldierCount)
  end--randomizeSmallCpPowers<

  if Ivars.balanceWeaponPowers:Is(1) then
    BalanceWeaponPowers(revengeConfigCp,totalSoldierCount)
  end--balanceWeaponPowers
  
  
end--ModRevengeConfigCp

--tex fix issues with RADIO body
--OUT: cpConfig
function this.FixRadioBody(cpConfig,soldierIdForConfigIdTable,isLrrpVehicleCp,isLrrpCp)
  local applyPowersToLrrp=Ivars.applyPowersToLrrp:Is()>0
  local isVehiclePatrols=Ivars.vehiclePatrolProfile:EnabledForMission()
  for soldierConfigId,soldierConfig in ipairs(cpConfig)do
    local soldierId=soldierIdForConfigIdTable[soldierConfigId]
    local addRadio=false

    --DEBUGNOW what am actually doing here? I'm only adding?   
    --GetBodyId has
    --elseif(mvars.ene_soldierLrrp[soldierId]or soldierPowerSettings.RADIO)and bodyIdTable.RADIO then
    --so are there any hits there (aparently not or I'd have handled it?)
    --do I need to change GetBodyId to only rely on RADIO not just all ene_soldierLrrp (while maintaining vanilla behavor)
    --I'm kind of doing that by adding it to llrps below, but I'm gating it with ih applyPowersToLrrp
    
    --tex DEBUGNOW what does isLrrpVehicleCp cover, do vanilla lrrp vehicle soldiers have RADIO? 
    --tex the radio light fx shows through enclosed vehicles like tanks
    if isLrrpVehicleCp and isVehiclePatrols then
      local vehicleInfo=InfVehicle.inf_patrolVehicleInfo[isLrrpVehicleCp]
      if vehicleInfo then
        local baseTypeInfo=InfVehicle.vehicleBaseTypes[vehicleInfo.baseType]
        if baseTypeInfo and not baseTypeInfo.enclosed then
          addRadio=true
        end
      end
    end

    --tex DEBUGNOW what's this doing vs vanilla behavior?
    if isLrrpCp and applyPowersToLrrp then
      if not isLrrpVehicleCp then--tex should be set above
        addRadio=true
      end
      if addRadio then
        --tex shield is fine, ARMOR probably wouldn't be, but getbodyid returns armor before radio so moot
        --soft_armor is fine for PFCs
        if soldierConfig.SOFT_ARMOR then
          if TppEnemy.GetSoldierType(soldierId)==EnemyType.TYPE_SOVIET then
            addRadio=false
          end
        end
      end
    end

    if addRadio then
      soldierConfig.RADIO=true
    end
  end--< for cpConfig
end--FixRadioBody

return this
