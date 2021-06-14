--InfFulton.lua
--TODO: save extractSoldiers state so game reload works
--if using svars, crushing down to index wont be fun though
--really the issue is comming up with a max array size, making unique-insert and removes quick
--and needing not just a soldierid array, but dealing with the add>state change delay
--so it's probably better to use ih save (but that's worse on save time)
--TODO: animals, issue is there's no messages sent on state change, would have to start tracking on damage message, but I'm not even sure if can get animal state at all
local this={}

local StrCode32=InfCore.StrCode32
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
local GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local DoMessage=Tpp.DoMessage
local CheckMessageOption=TppMission.CheckMessageOption
local GetRawElapsedTimeSinceStartUp=Time.GetRawElapsedTimeSinceStartUp
local pairs=pairs
local ipairs=ipairs
local ClearArray=InfUtil.ClearArray

this.debugModule=false

this.updateRate=5
this.active=0--DEBUGNOW this.active execstate whatever on ivar
this.execState={
  nextUpdate=0,
}

this.checkDist=425
local defaultAddTime=1
local holdupStateChangeTime=30--GOTCHA: for some reason it takes foreeeever to change from normal state to holdup


local phaseFailMessageRate=15
local nextPhaseFailMessageTime=0

this.extractSoldiers={}

function this.Init()
  this.extractSoldiers={}

  this.messageExecTable=nil

  if not this.IsAutoFultonEnabled()then
    this.active=0
    return
  end

  this.active=1--update
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=nil

  if not this.IsAutoFultonEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.EstablishedMissionAbortTop()
  this.active=0

  if not this.IsAutoFultonEnabled()then
    return
  end

  if mvars.mis_abortIsTitleMode then
    return
  end

  --DEBUGNOW figure out the difference between abort as leave mission and abort as in abort timeline of having done mission (abort with save vs not?)
  local force=true
  this.CheckAndFultonExtractSoldiers(force)
end--EstablishedMissionAbortTop
function this.EstablishedMissionClearTop()
  this.active=0

  if not this.IsAutoFultonEnabled()then
    return
  end

  local force=true
  this.CheckAndFultonExtractSoldiers(force)
end--EstablishedMissionClearTop
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={      
      --CULL
      --{msg="Dying",func=this.OnDying},
      --{msg="Unconscious",func=this.OnUnconscious},
      --{msg="Holdup",func=this.OnHoldup},
      --{msg="TapHoldup",func=this.OnHoldup},--tactical action point holdup      
      {msg="Neutralize",func=this.OnNeutralize},
      {msg="Dead",func=this.OnDead},
      {msg="Fulton",func=this.OnFulton},
    },--GameObject
  }--StrCode32Table
end--Messages
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  DoMessage(this.messageExecTable,CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.PostModuleReload(prevModule)
  this.extractSoldiers=prevModule.extractSoldiers
  this.active=prevModule.active
end

function this.OnDead(gameId,attackerId,phase,damageFlag)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  if this.extractSoldiers[gameId]then
    this.extractSoldiers[gameId]=nil
  end
end--OnDead
function this.OnDying(gameId)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  this.AddExtractSoldier(gameId)
end--OnDying
function this.OnUnconscious(gameId,attackerId,playerPhase)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if not Tpp.IsPlayer(attackerId) then
  --return
  end
  this.AddExtractSoldier(gameId)
end--OnUnconscious
function this.OnHoldup(gameId)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  --GOTCHA: status hasnt actually changed at this point
  this.AddExtractSoldier(gameId)
end--OnHoldup
function this.OnFulton(gameId)
  if this.debugModule then
    InfLookup.PrintStatus(gameId)
  end
  this.extractSoldiers[gameId]=nil
end--OnFulton
function this.OnNeutralize(gameId,attackerId,neutralizeType,neutralizeCause)
  if neutralizeType==NeutralizeType.DEAD then
    this.extractSoldiers[gameId]=nil
  end

  if Tpp.IsPlayer(attackerId) then
    if neutralizeType==NeutralizeType.FAINT or
      neutralizeType==NeutralizeType.SLEEP or
      neutralizeType==NeutralizeType.DYING then
      this.AddExtractSoldier(gameId)
      return
    end
  end
  -- attackerId==NULL_ID
  if neutralizeType==NeutralizeType.HOLDUP then
    this.AddExtractSoldier(gameId,holdupStateChangeTime)
  end
end--OnNeutralize

function this.Update(currentChecks,currentTime,execChecks,execState)
  if not currentChecks.inGame then
    return
  end
  --if this.debugModule then
  --InfCore.Log("InfFulton.Update")--DEBUG
  --end
  this.CheckAndFultonExtractSoldiers()
end--Update

function this.IsAutoFultonEnabled()
  if not IvarProc.EnabledForMission("fulton_autoFulton")then
    return false
  end

  if vars.missionCode==30050 and not InfMainTpp.IsMbEvent()then
    return false
  end

  return true
end--AutoFultonEnabled

local SUPINE_HOLDUP=3--tex no enum in EnemyState
function this.DontExtract(gameId)
  local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  if lifeStatus==TppGameObject.NPC_LIFE_STATE_DEAD then
    return true
  end
  if lifeStatus==TppGameObject.NPC_LIFE_STATE_NORMAL then
    local status=SendCommand(gameId,{id="GetStatus"})
    if status~=EnemyState.STAND_HOLDUP and status~=SUPINE_HOLDUP then
      return true
    end
  end
  return false
end--DontExtract

function this.AddExtractSoldier(gameId,addDelta)
  addDelta=addDelta or defaultAddTime
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  if this.debugModule then
    InfCore.Log("InfFulton AddExtractSoldier "..tostring(gameId))
    InfLookup.PrintStatus(gameId)
  end
  this.extractSoldiers[gameId]=GetRawElapsedTimeSinceStartUp()+addDelta--tex need some leeway for state changes so DontExtract doesn't immediately boot them
end--AddExtractSoldier

function this.FurtherFromPlayerThanDistSqr(checkDistSqr,playerPosition,gameId)
  local position=SendCommand(gameId,{id="GetPosition"})
  local dirVector=playerPosition-position
  local currentDistSqr=dirVector:GetLengthSqr()
  if currentDistSqr>checkDistSqr then
    return true
  else
    return false
  end
end

--SIDE: this.extractSoldiers
local clearSoldiers={}
function this.CheckAndFultonExtractSoldiers(force)
  if this.debugModule then
    InfCore.LogFlow("CheckAndFultonExtractSoldiers")
  end
  ClearArray(clearSoldiers)

  local extractFailFromPhase=0

  local playerPosition=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local distSqr=this.checkDist*this.checkDist--TODO OPT
  local elapsedTime=GetRawElapsedTimeSinceStartUp()
  for gameId,addedTime in pairs(this.extractSoldiers)do
    --DEBUG
--    if this.debugModule then
--      InfLookup.PrintStatus(gameId)
--    end
    if addedTime and elapsedTime>addedTime then
      if this.DontExtract(gameId)then
        if this.debugModule then
          InfCore.Log("InfFulton DontExtract "..gameId)
          InfLookup.PrintStatus(gameId)
        end
        clearSoldiers[#clearSoldiers+1]=gameId
      else
        if this.FurtherFromPlayerThanDistSqr(distSqr,playerPosition,gameId) or force then
          --TODO: better to check the phase of the cp of the soldiers, but there isn't a quick soldierId>cpId lookup
          if vars.playerPhase>TppGameObject.PHASE_CAUTION and not force then
            extractFailFromPhase=extractFailFromPhase+1
          else
            clearSoldiers[#clearSoldiers+1]=gameId
            local percentage=TppPlayer.MakeFultonRecoverSucceedRatio(nil,gameId)
            --local percentage=100--DEBUG
            --tex see comments above SetFultonIconPercentage in MakeFultonRecoverSucceedRatio
            if percentage>0 then
              local exeFudge=20
              percentage=percentage+exeFudge
              if percentage>100 then
                percentage=100
              end
            end
            if this.debugModule then
              InfCore.Log("InfFulton FurtherFromPlayerThanDistSqr "..tostring(gameId).." fulton%:"..tostring(percentage))
            end
            --percentage=1--DEBUG
            if math.random(100)>percentage then 
              if this.debugModule then
                InfCore.Log("autofulton_fail "..gameId)
              end
              InfMenu.PrintLangId("autofulton_fail")
            else
              if force then
                --tex ASSUMPTION: force is due to EstablishedMissionClear/Abort
                --actual fulton in this case doesnt complete in time before mission end
                TppTerminal.OnFultonSoldier(gameId)
              else
                SendCommand(gameId,{id="RequestForceFulton"})
              end
              if this.debugModule then
                InfCore.Log("autofulton_success "..gameId)
              end
              InfMenu.PrintLangId("autofulton_success") 
            end
          end--if PHASE_CAUTION
        end--if FurtherFromPlayerThanDistSqr
      end--if not DontExtract
    end--if elapsedTime
  end--for extractSoldiers

  for i,gameId in ipairs(clearSoldiers)do
    this.extractSoldiers[gameId]=nil
  end

  if extractFailFromPhase>0 then
    if elapsedTime>nextPhaseFailMessageTime then
      nextPhaseFailMessageTime=elapsedTime+phaseFailMessageRate
      InfMenu.PrintLangId("autofulton_phase_too_high")
    end
  end
end--CheckAndFultonExtractSoldiers
--
this.registerIvars={
  "fultonMbSupportScale",
  "fultonMbMedicalScale",
  "fultonDyingPenalty",
  "fultonSleepPenalty",
  "fultonHoldupPenalty",
  "fultonHostageHandling",
  "fultonWildCardHandling",
  "fultonMotherBaseHandling",
}
--GOTCHA: use this.IsAutoFultonEnabled()
IvarProc.MissionModeIvars(
  this,
  "fulton_autoFulton",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    range=Ivars.switchRange,
    settingNames="set_switch",
  },
  {
    "FREE",
    "MISSION",
  }
)--fulton_autoFulton

--fulton success>
--this.fultonSoldierVariationRange={--WIP
--  save=IvarProc.CATEGORY_EXTERNAL,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--this.fultonOtherVariationRange={
--  save=IvarProc.CATEGORY_EXTERNAL,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--
--this.fultonVariationInvRate={
--  save=IvarProc.CATEGORY_EXTERNAL,
--  range={max=500,min=10,increment=10},
--}

local mbSupportScaleRange={max=400,min=0,increment=5}
this.fultonMbSupportScale={
  save=IvarProc.EXTERNAL,
  default=100,
  range=mbSupportScaleRange,
  isPercent=true,
}
this.fultonMbMedicalScale={
  save=IvarProc.EXTERNAL,
  default=100,
  range=mbSupportScaleRange,
  isPercent=true,
}

this.fultonDyingPenalty={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=70,
  range={max=100,min=0,increment=5},
}
this.fultonSleepPenalty={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=0,
  range={max=100,min=0,increment=5},
}
this.fultonHoldupPenalty={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=10,
  range={max=100,min=0,increment=5},
}

this.fultonHostageHandling={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}
this.fultonWildCardHandling={--WIP
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}
this.fultonMotherBaseHandling={ --WIP
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}
--<fulton success
--Ivars

this.registerMenus={
  "fultonMenu",
  "fultonSuccessMenu",
}

this.fultonMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "Ivars.fulton_autoFultonFREE",
    "Ivars.fulton_autoFultonMISSION",
    "Ivars.disableFulton",
    "InfMainTppIvars.fultonLevelMenu",
    "InfFulton.fultonSuccessMenu",
  },
}

this.fultonSuccessMenu={
  options={
    "Ivars.fultonMbSupportScale",
    "Ivars.fultonMbMedicalScale",
    "Ivars.fultonDyingPenalty",
    "Ivars.fultonSleepPenalty",
    "Ivars.fultonHoldupPenalty",
    "Ivars.fultonHostageHandling",
    "InfMenuCommandsTpp.PrintFultonSuccessBonus",
  },
}

this.langStrings={
  eng={
    autofulton_success="[Extraction team] reached soldier",
    autofulton_fail="[Extraction team] could not reach soldier",
    autofulton_phase_too_high="[Extraction team] CP too high alert",
    fulton_autoFultonFREE="Extraction team in Free Roam",
    fulton_autoFultonMISSION="Extraction team in Missions",
    fultonMenu="Fulton menu",
    fultonSuccessMenu="Fulton success menu",
    fultonMbSupportScale="MB fulton support scale",
    fultonMbMedicalScale="MB fulton medical scale",
    fultonDyingPenalty="Target dying penalty",
    fultonSleepPenalty="Target sleeping penalty",
    fultonHoldupPenalty="Target holdup penalty",--TODO: help note, not affected by mbMedical
    fulton_mb_support="Current MB support bonus +",
    fulton_mb_medical="Current MB medical bonus +",
    printFultonSuccessBonus="Print fulton success bonus",
    fultonHostageHandling="Hostage handling",
    fultonHostageHandlingSettings={"Default","Must extract (0%)"},
  },--eng
  help={
    eng={
      fulton_autoFultonFREE="Extraction team will recover enemies you have neutralized after you've travelled some distance from them (usually to next command post), using the same success rate as manual fultoning. This lets you do low/no fulton runs without having to sacrifice the recruitment side of gameplay.",
      fultonSuccessMenu="Adjust the success rate of fultoning",
      fultonMbSupportScale="Scales the success bonus from mother base support section (which itself scales by section level). In the base game this is mostly used to counter weather penalty.",
      fultonMbMedicalScale="Scales the success bonus from mother base medical section (which itself scales by section level). In the base game this used to counter injured target penalty",
      disableFulton="Disables fulton at the player-action level",
    },
  }--help
}--langStrings

--DEBUGNOW
function this.MakeFultonRecoverSucceedRatio(playerIndex,gameId,gimmickInstanceOrAnimalId,gimmickDataSet,staffOrResourceId,isDogFultoning)
  local targetId=gameId
  local percentage=0
  local baseLine=100
  local successForFultonType=0
  --RETAILPATCH: 1.0.4.4, was: -v- guess they missed updating this call when they added the param last patch CULL:
  --TppTerminal.DoFuncByFultonTypeSwitch(t,p,r,l,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
  successForFultonType=TppTerminal.DoFuncByFultonTypeSwitch(targetId,gimmickInstanceOrAnimalId,gimmickDataSet,staffOrResourceId,nil,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
  if successForFultonType==nil then
    successForFultonType=100
  end
  local mbSupportFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
  local mbSupportFultonSectionSuccess=this.mbSectionRankSuccessTable[mbSupportFultonRank]or 0
  mbSupportFultonSectionSuccess=Ivars.fultonMbSupportScale:Scale(mbSupportFultonSectionSuccess)--tex

  local weatherPenalty=this.fultonWeatherSuccessTable[vars.weather]or 0--tex gave weatherSuccessMod its own local for clarity
  --NMC: REF vanilla ranges of values
  --weatherSuccessMod: -70 to 0
  --mbSupportFultonSectionSuccess: 0 to 60
  --since this is capped to 0 means SECTION_FUNC_ID_SUPPORT_FULTON sole purpose is to counter weather
  local fultonInWeatherPenalty=weatherPenalty+mbSupportFultonSectionSuccess
  if fultonInWeatherPenalty>0 then
    fultonInWeatherPenalty=0
  end

  --NMC: REF vanilla ranges of values
  --baseLine: 100
  --successForFultonType: 0 (non soldier), -80 to 0 (soldier)
  --successMod: -70 to 0
  --GOTCHA: SetFultonIconPercentage seems to add 20% (if not 0)
  --So at S rank support and medical the worst case weather (sandstorm) and medical (dying soldier) is only 80%+the exe bumping it to 100%
  percentage=(baseLine+successForFultonType)+fultonInWeatherPenalty
  if this.debugModule then--tex>
    local logLine="MakeFultonRecoverSucceedRatio: initial percentage:"..tostring(percentage)
    logLine=logLine.."  successForFultonType:"..tostring(successForFultonType).." fultonInWeatherSuccess:"..tostring(fultonInWeatherPenalty)
    logLine=logLine.."  weatherSuccessMod:"..tostring(weatherPenalty).." mbSupportFultonSectionSuccess:"..tostring(mbSupportFultonSectionSuccess)
    InfCore.Log(logLine)
  end--<

  --  if Tpp.IsSoldier(gameId)then--tex fulton success variation WIP
  --    local fultonSoldierVariationRange=Ivars.fultonSoldierVariationRange:Get()
  --    if fultonSoldierVariationRange>0 then--tex
  --      local frequency=0.1
  --      local fultonVariationInvRate=
  --      local rate=fultonVariationInvRate/gvars.clockscale
  --      local t=math.fmod(vars.clock/rate,2*math.pi)--tex mod to sine range
  --      local amplitude=fultonSoldierVariationRange*0.5
  --      local bias=-amplitude
  --      local variationMod=amplitude*math.sin(t)+bias
  --
  --      --percentage=math.random(percentage-fultonSoldierVariationRange,percentage)
  --      percentage=percentage+variationMod
  --    end
  --  else
  --    if Ivars.fultonOtherVariationRange:Get()>0 then--tex
  --      --TODO
  --    end
  --  end--
  
  --NMC only s10030 in vanilla
  if mvars.ply_allways_100percent_fulton then
    percentage=100
  end
  --NMC: is mvars.ene_rescueTargetList[gameId]
  if TppEnemy.IsRescueTarget(targetId)then
    percentage=100
  end
  if Tpp.IsHostage(targetId) then--tex>
    if Ivars.fultonHostageHandling:Is"ZERO" then
      percentage=0
  end
  end--<

  --tex TODO: add own ivar
  --  if Tpp.IsSoldier(gameId) then --tex>
  --    if Ivars.fultonWildCardHandling:Is(1) and Ivars.enableWildCardFreeRoam:Is(1) and Ivars.enableWildCardFreeRoam:MissionCheck() then
  --      local soldierType=TppEnemy.GetSoldierType(gameId)
  --      local soldierSubType=TppEnemy.GetSoldierSubType(gameId,soldierType)
  --      if soldierSubType=="SOVIET_WILDCARD" or soldierSubType=="PF_WILDCARD" then--TODO: another way to ID wildcard soldiers
  --        percentage=0
  --      end
  --  end
  --  end--<
  --WIP
  --  if --[[Ivars.fultonMotherBaseHandling:Is(1) and--]] Ivars.mbWarGamesProfile:Is"INVASION" and vars.missionCode==30050 then--tex>
  --    percentage=0
  --  end--<
  if Tpp.IsFultonContainer(targetId) and vars.missionCode==30050 and Ivars.mbCollectionRepop:Is(1)then--tex> more weirdness
    percentage=0
  end--<

  local forcePercent
  if mvars.ply_forceFultonPercent then
    forcePercent=mvars.ply_forceFultonPercent[targetId]
  end
  if forcePercent then
    percentage=forcePercent
  end

  InfCore.Log("MakeFultonRecoverSucceedRatio percentage:"..tostring(percentage))--DEBUGNOW

  return percentage
  
  --tex without SetFultonIconPercentage call will be 0%
  --0 will be 0%
  --otherwise exe seems to add base level of 20%
  --not sure what its doing with targetId, 
  --it also obviously does fulton collision check in exe (but will still do that with nil targetId)
--tex WAS
--  if isDogFultoning then
--    Player.SetDogFultonIconPercentage{percentage=percentage,targetId=targetId}
--  else
--    Player.SetFultonIconPercentage{percentage=percentage,targetId=targetId}
--  end
end--MakeFultonRecoverSucceedRatio
--DEBUGNOW
return this
