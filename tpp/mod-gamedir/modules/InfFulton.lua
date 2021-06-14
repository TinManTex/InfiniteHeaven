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
  "fulton_autoFulton",
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
)

this.registerMenus={
  "fultonMenu"
}

this.fultonMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "Ivars.fulton_autoFultonFREE",
    "Ivars.fulton_autoFultonMISSION",
  },
}

this.langStrings={
  eng={
    autofulton_success="[Extraction team] reached soldier",
    autofulton_fail="[Extraction team] could not reach soldier",
    autofulton_phase_too_high="[Extraction team] CP too high alert",
    fulton_autoFultonFREE="Extraction team in Free Roam",
    fulton_autoFultonMISSION="Extraction team in Missions",
  --fultonMenu="",--DEBUGNOW
  },--eng
  help={
    eng={
      fulton_autoFultonFREE="Extraction team will recover enemies you have neutralized after you've travelled some distance from them (usually to next command post). This lets you do low/no fulton runs without having to sacrifice the recruitment side of gameplay.",
    },
  }--help
}--langStrings

return this
