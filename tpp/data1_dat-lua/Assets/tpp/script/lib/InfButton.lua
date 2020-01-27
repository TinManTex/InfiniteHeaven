-- DOBUILD: 1
-- NODEPS
local this={}
--LOCALOPT:
local bit=bit
local Time=Time
local PlayerVars=PlayerVars

this.incrementMultIncrementMult=1.5--tex i r good at naming
local maxIncrementMult=50
local defaultIncrementMult=1
local currentIncrementMult=defaultIncrementMult

--DOC: \BUTTON BITMASKS.TXT \buttonmasks.ods
--tex Note: There were a bunch of bitmasks not identified in PlayerPad.<MASKNAME>.
--Currently either labeled UNKOWN, as seen from the existing codes it's possible that there's multiple buttons triggering/sharing one bitmask, so even after 'finding it' copy off instead of rename
--fox engine seems to be using bitops http://bitop.luajit.org
this.buttonMasks={
  DECIDE=0,
  STANCE=1,
  DASH=2,
  HOLD=3,--tex ready weapon
  FIRE=4,
  RIDE_ON=5,
  RIDE_OFF=5,
  ACTION=5,
  MOVE_ACTION=5,
  JUMP=5,
  RELOAD=6,
  STOCK=7,--tex recenter cam
  ZOOM_CHANGE=7,
  VEHICLE_CHANGE_SIGHT=7,
  MB_DEVICE=8,
  CALL=9,
  INTERROGATE=9,
  SUBJECT=10,--tex tap=recenter, hold binoc/FP --TODO see if trigger on binocular, and see if disable butttons is the same
  UP=11,
  PRIMARY_WEAPON=11,
  DOWN=12,
  SECONDARY_WEAPON=12,
  LEFT=13,
  RIGHT=14,
  VEHICLE_LIGHT_SWITCH=14,
  VEHICLE_TOGGLE_WEAPON=14,
  CQC=15,
  SIDE_ROLL=16,
  LIGHT_SWITCH=17,
  EVADE=18,
  VEHICLE_FIRE=19,
  VEHICLE_CALL=20,
  VEHICLE_DASH=21,
  BUTTON_PLACE_MARKER=22,
  PLACE_MARKER=22,
  ESCAPE=23,--tex Not in PlayerPad, own name
  UNKNOWN7=24,--tex triggered with Space/Quick dive, and RS click (which also triggers zoom change, stock, decide,vehicle_change_sight), don't know what it's supposed to indicate
  --
  UNKNOWN8=25,
  UNKNOWN9=26,
  UNKNOWN10=27,
  UNKNOWN11=28,
  UNKNOWN12=29,
  UNKNOWN13=30,
--MAX=2^31,--tex max_int=(2^31)-1, guess at a sane enough limit, though should check bitops to figure out actual.
}
this.NONE=0
this.ALL=-1

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
  button.repeatRate=0.85
  --button.minRate=0.3
  button.decrement=0
  button.repeatStart=0--tex used for repeat
  button.heldStart=0--tex delay between actually being pressed and considered being 'held'
  button.onHoldStart=0--tex as above, but resets
end

function this.DEBUG_PrintPressed()
  if Ivars and Ivars.printPressedButtons:Is(1) then
    for name,buttonMask in pairs(this.buttonMasks) do
      if this.OnButtonDown(buttonMask) then
        --TppUiCommand.AnnounceLogView("scannedButtonsDirect: ".. PlayerVars.scannedButtonsDirect)
        --TppUiCommand.AnnounceLogView("scannedButtons: ".. PlayerVars.scannedButtons)
        --if bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask then--DEBUG: scannedbuttons instead of direct
        InfCore.Log(name.."="..buttonMask,true)
      end
    end
  end
end
function this.UpdateHeld()
  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local scannedButtonsDirect=PlayerVars.scannedButtonsDirect
  local band=bit.band
  for name,buttonMask in pairs(this.buttonMasks) do
    local buttonState=this.buttonStates[buttonMask]
    if buttonState.holdTime~=0 then
      if not buttonState.isPressed and (band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--OnButtonDown
        buttonState.repeatStart=elapsedTime
        buttonState.heldStart=elapsedTime
        buttonState.onHoldStart=elapsedTime
      end
    end
    if not (band(scannedButtonsDirect,buttonMask)==buttonMask) then
      buttonState.repeatStart=0
      buttonState.heldStart=0
      buttonState.onHoldStart=0
    end
  end
end
function this.UpdatePressed()
  this.DEBUG_PrintPressed()
  local scannedButtonsDirect=PlayerVars.scannedButtonsDirect
  local band=bit.band
  for name,buttonMask in pairs(this.buttonMasks) do
    this.buttonStates[buttonMask].isPressed=band(scannedButtonsDirect,buttonMask)==buttonMask--this.ButtonDown(buttonMask)
  end
end
function this.UpdateRepeatReset()
  for name,buttonMask in pairs(this.buttonMasks) do
    if this.buttonStates[buttonMask].decrement~=0 then
      this.ButtonRepeatReset(buttonMask)
    end
  end
end

function this.ButtonDown(buttonMask)
  --  if bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask then
  --    TppUiCommand.AnnounceLogView("ButtonDown:" .. buttonMask)--tex DEBUG
  --  end
  return bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask
end
--tex GOTCHA: OnButton functions will have a gameframe of latency, sorry to dissapoint all the pro gamers
function this.OnButtonDown(buttonMask)
  return not this.buttonStates[buttonMask].isPressed and (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask)
end
function this.OnButtonUp(buttonMask)
  return this.buttonStates[buttonMask].isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask)
end
--tex button has been down for holdTime
function this.ButtonHeld(buttonMask)
  local buttonState=this.buttonStates[buttonMask]
  if buttonState.holdTime~=0 and buttonState.heldStart~=0 then
    if buttonState.isPressed then
      if Time.GetRawElapsedTimeSinceStartUp()>buttonState.heldStart+buttonState.holdTime then
        return true
      end
    end
  end
  return false
end
--tex button has been down for holdTime, only true once per hold
function this.OnButtonHoldTime(buttonMask)
  local buttonState=this.buttonStates[buttonMask]
  if buttonState.holdTime~=0 and buttonState.onHoldStart~=0 then
    if buttonState.isPressed then
      if Time.GetRawElapsedTimeSinceStartUp()>buttonState.onHoldStart+buttonState.holdTime then
        buttonState.onHoldStart=0
        return true
      end
    end
  end
  return false
end
function this.ButtonRepeatReset(buttonMask)
  local buttonState=this.buttonStates[buttonMask]
  if buttonState.decrement~=0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--tex OnButtonUp reset
      currentIncrementMult=defaultIncrementMult
    end
  end
end
function this.OnButtonRepeat(buttonMask)
  local buttonState=this.buttonStates[buttonMask]
  if buttonState.decrement~=0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,buttonMask)==buttonMask) then--tex OnButtonUp reset
      --buttonState.repeatRate=buttonState.holdTime
      currentIncrementMult=defaultIncrementMult
      return false
    end
    --local repeatRate=buttonState.repeatRate
    --if repeatRate~=0 and
    if buttonState.repeatStart~=0 then
      if Time.GetRawElapsedTimeSinceStartUp()-buttonState.repeatStart>buttonState.repeatRate then
        buttonState.repeatStart=Time.GetRawElapsedTimeSinceStartUp()
        --OFF:    if repeatRate > buttonState.minRate then
        --          repeatRate=repeatRate-buttonState.decrement
        --        end
        --        buttonState.repeatRate=repeatRate--]]
        currentIncrementMult=currentIncrementMult*this.incrementMultIncrementMult
        --TppUiCommand.AnnounceLogView("DBG:MNU: currentIncrementMult:".. currentIncrementMult)--tex DEBUG
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

--tex all buttons in combo must be held TODO: some weirdness with trying to check multiple combos
function this.OnComboActive(combo)
  local comboActive=true
  for i,button in ipairs(combo)do
    if not this.ButtonHeld(button) then
      comboActive=false
      break
    end
  end

  if comboActive then
    for i,button in ipairs(combo)do
      this.buttonStates[button].heldStart=0
    end
    return true
  end
  
  return false
end

return this
