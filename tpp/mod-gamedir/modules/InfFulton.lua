--InfFulton.lua
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
this.checkDist=450
local addDelta=50

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
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Dead",func=this.OnDead},
      {msg="Dying",func=this.OnDying},
      {msg="Unconscious",func=this.OnUnconscious},
      {msg="Holdup",func=this.OnHoldup},
      {msg="TapHoldup",func=this.OnHoldup},--tactical action point holdup
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
  this.PrintStatus(gameId)--DEBUGNOW
  if not Tpp.IsPlayer(attackerId) then
  --return
  end
  this.AddExtractSoldier(gameId)
end--OnUnconscious
function this.OnHoldup(gameId)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  this.PrintStatus(gameId)--DEBUGNOW
  --GOTCHA: status hasnt actually changed at this point
  this.AddExtractSoldier(gameId)
end--OnHoldup
function this.OnFulton(gameId)
  this.PrintStatus(gameId)--DEBUGNOW
  this.extractSoldiers[gameId]=nil
end--OnFulton

function this.Update(currentChecks,currentTime,execChecks,execState)
  if not currentChecks.inGame then
    return
  end
  InfCore.Log("InfFulton.Update")--DEBUGNOW

  this.CheckAndFultonExtractSoldiers()--DEBUGNOW TODO also on mission end
end--Update

function this.IsAutoFultonEnabled()
  if not IvarProc.EnabledForMission("fulton_autoFulton")then
    return false
  end

  if var.missionCode==30050 and not InfMainTpp.IsMbEvent()then
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

function this.AddExtractSoldier(gameId)
  if GetTypeIndex(gameId)~=GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  if this.debugModule then
    InfCore.Log("AddExtractSoldier "..tostring(gameId))--DEBUGNOW
  end
  this.extractSoldiers[gameId]=GetRawElapsedTimeSinceStartUp()+addDelta--tex need some leeway for state changes
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
function this.CheckAndFultonExtractSoldiers()
  ClearArray(clearSoldiers)
  
  local extractFailFromPhase=0

  local playerPosition=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local distSqr=this.checkDist*this.checkDist--TODO OPT
  local elapsedTime=GetRawElapsedTimeSinceStartUp()
  for gameId,addedTime in pairs(this.extractSoldiers)do
    if addedTime and elapsedTime>addedTime then
      if this.DontExtract(gameId)then
        InfCore.Log("DontExtract "..gameId)--DEBUGNOW
        this.PrintStatus(gameId)--DEBUGNOW
        clearSoldiers[#clearSoldiers+1]=gameId
      else
        if this.FurtherFromPlayerThanDistSqr(distSqr,playerPosition,gameId)then
          --TODO: better to check the phase of the cp of the soldiers, but there isn't a quick soldierId>cpId lookup
          if vars.playerPhase==TppGameObject.PHASE_ALERT then
            --InfCore.Log("Extraction Team: CP on too high alert",true,true)--DEBUGNOW ADDLANG TODO only on specific cp, batch announce so only 1 per update
            extractFailFromPhase=extractFailFromPhase+1
          else
            clearSoldiers[#clearSoldiers+1]=gameId
            local percentage=TppPlayer.MakeFultonRecoverSucceedRatio(nil,gameId)
            --local percentage=100--DEBUGNOW 
            --tex see comments above SetFultonIconPercentage in MakeFultonRecoverSucceedRatio
            if percentage>0 then
              local exeFudge=20
              percentage=percentage+exeFudge
            end
            if this.debugModule then
              InfCore.Log("InfFulton FurtherFromPlayerThanDistSqr "..tostring(gameId).." fulton%:"..tostring(percentage))
            end
            --percentage=1--DEBUG
            if math.random(100)>percentage then
              InfMenu.PrintLangId("autofulton_success")
            else
              SendCommand(gameId,{id="RequestForceFulton"})
              InfMenu.PrintLangId("autofulton_fail")
            end
          end
        end
      end--if not DontExtract
    end--if elapsedTime
  end--for extractSoldiers

  for i,gameId in ipairs(clearSoldiers)do
    this.extractSoldiers[gameId]=nil
  end

  if extractFailFromPhase then
    InfMenu.PrintLangId("autofulton_phase_too_high")
  end
end--CheckAndFultonExtractSoldiers

--DEBUGNOW TODO InfLookup
function this.PrintStatus(gameId)
  InfCore.Log("PrintStatus "..tostring(gameId))
  local status=GameObject.SendCommand(gameId,{id="GetStatus"})
  local lifeStatus=GameObject.SendCommand(gameId,{id="GetLifeStatus"})
  InfCore.Log("status:"..tostring(status).." lifeStatus:"..tostring(lifeStatus))
end--PrintStatus

--
this.registerIvars={
  "fulton_autoFulton",
}
--DEBUGNOW ADDLANG
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
    autofulton_success="[Extraction team] Extracted soldier",--DEBUGNOW wording, support? extraction team?
    autofulton_fail="[Extraction team] Failed to extract soldier",
    autofulton_phase_too_high="[Extraction team] CP too high alert",
    fulton_autoFultonFREE="Extraction team in Free Roam",
    fulton_autoFultonMISSION="Extraction team in Missions",
    --fultonMenu="",--DEBUGNOW
  },--eng
  help={
    eng={
      fulton_autoFultonFREE="Extraction team will recover neutralized enemies",
    },
  }--help
}--langStrings

return this
