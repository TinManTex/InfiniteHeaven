-- DOBUILD: 1
-- NODEPS
local this={}

local incrementMultIncrementMult=1.5--tex i r good at naming
local maxIncrementMult=50
local defaultIncrementMult=1
local currentIncrementMult=defaultIncrementMult

--DOC: \BUTTON BITMASKS.TXT \buttonmasks.ods
--tex: Note: There were a bunch of bitmasks not identified in PlayerPad.<MASKNAME>.
--Currently either labeled UNKOWN, as seen from the existing codes it's possible that there's multiple buttons triggering/sharing one bitmask, so even after 'finding it' copy off instead of rename
--fox engine seems to be using bitops http://bitop.luajit.org
this.buttonMasks={
  NONE=0,
  DECIDE=0,
  STANCE=1,
  --UNKNOWN1dash=2,--DEBUG: see if it fires anywhere else than dash
  DASH=2,--tex Not in PlayerPad
  --UNKNOWN2RWep=3,--DEBUG: see if it fires anywhere else than ready_weapon
  READY_WEAPON=3,--tex Not in PlayerPad
  --UNKNOWN3atta=4,--DEBUG: see if it fires anywhere else than attack
  ATTACK=4,--tex Not in PlayerPad, might actually be CQC, but no way to differentiat
  RIDE_ON=5,
  RIDE_OFF=5,
  ACTION=5,
  MOVE_ACTION=5,
  JUMP=5,
  RELOAD=6,
  STOCK=7,--tex recenter cam i think
  ZOOM_CHANGE=7,
  VEHICLE_CHANGE_SIGHT=7,
  MB_DEVICE=8,
  CALL=9,
  INTERROGATE=9,
  UNKNOWN4binoc=10,--DEBUG: see if it fires anywhere else than binoc
  BINOCULARS=10,--tex Not in PlayerPad
  UP=11,
  PRIMARY_WEAPON=11,
  DOWN=12,
  SECONDARY_WEAPON=12,
  LEFT=13,
  RIGHT=14,
  VEHICLE_LIGHT_SWITCH=14,
  VEHICLE_TOGGLE_WEAPON=14,
  UNKNOWN5cqc=15,
  CQC=15,--tex Not in PlayerPad, might actually be ATTACK, but no way to differentiat
  SIDE_ROLL=16,
  LIGHT_SWITCH=17,
  EVADE=18,
  VEHICLE_FIRE=19,
  VEHICLE_CALL=20,
  VEHICLE_DASH=21,
  BUTTON_PLACE_MARKER=22,
  PLACE_MARKER=22,
  --UNKNOWN6esc=23,--DEBUG: see if it fires anywhere else than escape
  ESCAPE=23,--tex Not in PlayerPad
  UNKNOWN7=24,--tex triggered with Space/Quick dive, and RS click (which also triggers zoom change, stock, decide,vehicle_change_sight), don't know what it's supposed to indicate
  --
  UNKNOWN8=25,
  UNKNOWN9=26,
  UNKNOWN10=27,
  UNKNOWN11=28,
  UNKNOWN12=29,
  UNKNOWN13=30,
  --MAX=2^31,--tex max_int=(2^31)-1, guess at a sane enough limit, though should check bitops to figure out actual.
  --ALL=-1
}
--TABLESETUP: buttonMasks --tex convert mask index to bitmask
for name,maskIndex in pairs(this.buttonMasks) do
  this.buttonMasks[name]=2^maskIndex
end

--TABLESETUP: InfButton --tex for convenience of external reference fold back into this./InfButton
for name,maskIndex in pairs(this.buttonMasks) do
  this[name]=maskIndex
end

--TABLESETUP: buttonStates REFACTOR: check which vars dont really need to be per button
this.buttonStates={}
for name,buttonMask in pairs(this.buttonMasks) do
  this.buttonStates[buttonMask]={}
  local button=this.buttonStates[buttonMask]
  button.name=name
  button.isPressed=false
  button.holdTime=0.9--REFACTOR: this vs repeatrate
  button.startTime=0
  button.repeatRate=0.85
  --button.minRate=0.3
  button.decrement=0
end

function this.DEBUG_PrintPressed()
  for name,buttonMask in pairs(this.buttonMasks) do
    if this.OnButtonDown(buttonMask) then
    --TppUiCommand.AnnounceLogView("scannedButtonsDirect: ".. PlayerVars.scannedButtonsDirect)
    --TppUiCommand.AnnounceLogView("scannedButtons: ".. PlayerVars.scannedButtons)
    --if bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask then--DEBUG: scannedbuttons instead of direct
     TppUiCommand.AnnounceLogView(name .. "=" .. buttonMask)
    end
  end
end
function this.UpdatePressed()
  for name,buttonMask in pairs(this.buttonMasks) do
    this.buttonStates[buttonMask].isPressed = this.ButtonDown(buttonMask)
  end
end
function this.UpdateHeld()
  for name,buttonMask in pairs(this.buttonMasks) do
    if this.buttonStates[buttonMask].holdTime~=0 then
      if this.OnButtonDown(buttonMask)then
        this.buttonStates[buttonMask].startTime=Time.GetRawElapsedTimeSinceStartUp()
      end
      if not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--this.ButtonDown(button)then
        this.buttonStates[buttonMask].startTime=0
      end
    end
  end
end
function this.ButtonDown(buttonMask)
  --[[if bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask then
    TppUiCommand.AnnounceLogView("ButtonDown:" .. buttonMask)--tex DEBUG: CULL:
  end--]]
  return bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask
end
--tex GOTCHA: OnButton functions will have a gameframe of latency, sorry to dissapoint all the pro gamers
function this.OnButtonDown(buttonMask)
  return not this.buttonStates[buttonMask].isPressed and (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask)
end
function this.OnButtonUp(buttonMask)
  return this.buttonStates[buttonMask].isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask)
end
function this.OnButtonHoldTime(buttonMask)
  local buttonState = this.buttonStates[buttonMask]
  if buttonState.holdTime~=0 and buttonState.startTime~=0 then
    if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > buttonState.holdTime then
      buttonState.startTime=0
      return true
    end
  end
  return false
end
function this.ButtonRepeatReset(buttonMask)
  local buttonState = this.buttonStates[buttonMask]
  if buttonState.decrement ~= 0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--tex OnButtonUp reset
      currentIncrementMult=defaultIncrementMult
    end
  end
end
function this.OnButtonRepeat(buttonMask)
  local buttonState = this.buttonStates[buttonMask]
  --tex REF: {isPressed=false,holdTime=0,startTime=0,repeatRate=0,minRate=0,decrement=0},
  if buttonState.decrement ~= 0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--tex OnButtonUp reset
      --buttonState.repeatRate=buttonState.holdTime
      currentIncrementMult=defaultIncrementMult
      return false
    end
    --local repeatRate=buttonState.repeatRate
    --if repeatRate~=0 and 
    if buttonState.startTime~=0 then
      if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > buttonState.repeatRate then
        buttonState.startTime=Time.GetRawElapsedTimeSinceStartUp()
        --[[OFF: if repeatRate > buttonState.minRate then
          repeatRate=repeatRate-buttonState.decrement
        end
        buttonState.repeatRate=repeatRate--]]
        currentIncrementMult=currentIncrementMult*incrementMultIncrementMult
        --TppUiCommand.AnnounceLogView("DBG:MNU: currentIncrementMult:".. currentIncrementMult)--tex DEBUG: CULL:
        if currentIncrementMult>maxIncrementMult then
          currentIncrementMult=maxIncrementMult
        end
        return true
      end
    end
  end
  return false  
end
function this.GetRepeatMult()
  return currentIncrementMult
end

return this