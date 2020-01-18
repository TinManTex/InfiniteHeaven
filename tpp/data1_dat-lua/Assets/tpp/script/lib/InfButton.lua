-- DOBUILD: 1
local this={}
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
--tex SYS: buttonpress. TODO: work out the duplicate bitmasks/those that don't work, and those that are missing
this.buttonMasks={--tex: SYNC: buttonStates
  PlayerPad.DECIDE,
  PlayerPad.STANCE,
  PlayerPad.ACTION,
  PlayerPad.RELOAD,
  PlayerPad.STOCK,
  PlayerPad.MB_DEVICE,
  PlayerPad.CALL,
  PlayerPad.UP,
  PlayerPad.DOWN,
  PlayerPad.LEFT,
  PlayerPad.RIGHT,
  PlayerPad.SIDE_ROLL,
  PlayerPad.ZOOM_CHANGE,
  PlayerPad.LIGHT_SWITCH,
  PlayerPad.EVADE,
  --PlayerPad.VEHICLE_FIRE,--]]--tex button/bitmask always set for some reason
  PlayerPad.VEHICLE_CALL,
  PlayerPad.VEHICLE_DASH,
  --PlayerPad.BUTTON_PLACE_MARKER,--]]--tex button/bitmask always set for some reason
  --PlayerPad.PLACE_MARKER,--]]--tex button/bitmask always set for some reason
  PlayerPad.INTERROGATE,
  PlayerPad.RIDE_ON,
  PlayerPad.RIDE_OFF,
  PlayerPad.VEHICLE_CHANGE_SIGHT,
  PlayerPad.VEHICLE_LIGHT_SWITCH,
  PlayerPad.VEHICLE_TOGGLE_WEAPON,
  PlayerPad.JUMP,
  PlayerPad.MOVE_ACTION,
  PlayerPad.PRIMARY_WEAPON,
  PlayerPad.SECONDARY_WEAPON,
  --[[PlayerPad.STICK_L,
  PlayerPad.STICK_R,
  PlayerPad.TRIGGER_L,
  PlayerPad.TRIGGER_R,
  PlayerPad.TRIGGER_ACCEL,
  PlayerPad.TRIGGER_BREAK,
  --PlayerPad.ALL--]]
}
this.buttonStates={--tex: for defaults, not specfic button setups. SYNC: buttonmasks
  [PlayerPad.DECIDE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.STANCE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.ACTION]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RELOAD]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.STOCK]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.MB_DEVICE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.CALL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.UP]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.DOWN]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.LEFT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIGHT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.SIDE_ROLL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.ZOOM_CHANGE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.LIGHT_SWITCH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.EVADE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  --[[[PlayerPad.VEHICLE_FIRE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  [PlayerPad.VEHICLE_CALL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_DASH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  --[[[PlayerPad.BUTTON_PLACE_MARKER]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  --[[[PlayerPad.PLACE_MARKER]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  [PlayerPad.INTERROGATE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIDE_ON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIDE_OFF]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_CHANGE_SIGHT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_LIGHT_SWITCH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_TOGGLE_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.JUMP]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.MOVE_ACTION]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.PRIMARY_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.SECONDARY_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
}
function this.UpdatePressedButtons()
  for i, button in pairs(this.buttonMasks) do
    this.buttonStates[button].isPressed = this.ButtonDown(button)
  end
end
function this.UpdateHeldButtons()
  for i, button in pairs(this.buttonMasks) do
    if this.buttonStates[button].holdTime~=0 then
      if this.OnButtonDown(button)then
        this.buttonStates[button].startTime=Time.GetRawElapsedTimeSinceStartUp()
      end
      if not (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then--this.ButtonDown(button)then
        this.buttonStates[button].startTime=0
      end
    end
  end
end
function this.ButtonDown(button)
  --[[if (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then
    TppUiCommand.AnnounceLogView("ButtonPressed:" .. bit.tohex(button))--tex DEBUG: CULL:
  end--]]
  return bit.band(PlayerVars.scannedButtonsDirect,button)==button
end
--tex GOTCHA: OnButton functions will have a gameframe of latency, sorry to dissapoint all the pro gamers
function this.OnButtonDown(button)
  return not this.buttonStates[button].isPressed and (bit.band(PlayerVars.scannedButtonsDirect,button)==button)
end
function this.OnButtonUp(button)
  return this.buttonStates[button].isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,button)==button)
end
function this.OnButtonHoldTime(button)
  local buttonState = this.buttonStates[button]
  if buttonState.holdTime~=0 and buttonState.startTime~=0 then
    if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > buttonState.holdTime then
      buttonState.startTime=0
      return true
    end
  end
  return false
end
function this.OnButtonRepeat(button)
  local buttonState = this.buttonStates[button]
  --tex REF: {isPressed=false,holdTime=0,startTime=0,currentRate=0,minRate=0,decrement=0},
  if buttonState.decrement ~= 0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then--tex OnButtonUp reset
      buttonState.currentRate=buttonState.holdTime
      return false
    end
    local currentRate=buttonState.currentRate
    --if currentRate~=0 and 
    if buttonState.startTime~=0 then
      if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > currentRate then
        buttonState.startTime=Time.GetRawElapsedTimeSinceStartUp()
        if currentRate > buttonState.minRate then
          currentRate=currentRate-buttonState.decrement
        end
        buttonState.currentRate=currentRate
        return true
      end
    end
  end
  return false  
end

return this