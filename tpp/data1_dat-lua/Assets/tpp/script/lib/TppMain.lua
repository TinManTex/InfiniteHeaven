local this={}
local e=this--tex CULL: once deminified
local IsFunc=Tpp.IsTypeFunc
this.prevButtons={--tex REFACTOR: better placing
  [bit.tohex(PlayerPad.DECIDE)]=false,
  [bit.tohex(PlayerPad.STANCE)]=false,
  [bit.tohex(PlayerPad.ACTION)]=false,
  [bit.tohex(PlayerPad.RELOAD)]=false,
  [bit.tohex(PlayerPad.STOCK)]=false,
  [bit.tohex(PlayerPad.MB_DEVICE)]=false,
  [bit.tohex(PlayerPad.CALL)]=false,
  [bit.tohex(PlayerPad.UP)]=false,
  [bit.tohex(PlayerPad.DOWN)]=false,
  [bit.tohex(PlayerPad.LEFT)]=false,
  [bit.tohex(PlayerPad.RIGHT)]=false,
  [bit.tohex(PlayerPad.SIDE_ROLL)]=false,
  [bit.tohex(PlayerPad.ZOOM_CHANGE)]=false,
  [bit.tohex(PlayerPad.LIGHT_SWITCH)]=false,
  [bit.tohex(PlayerPad.EVADE)]=false,
  [bit.tohex(PlayerPad.VEHICLE_FIRE)]=false,
  [bit.tohex(PlayerPad.VEHICLE_CALL)]=false,
  [bit.tohex(PlayerPad.VEHICLE_DASH)]=false,
  [bit.tohex(PlayerPad.BUTTON_PLACE_MARKER)]=false,
  [bit.tohex(PlayerPad.PLACE_MARKER)]=false,
  [bit.tohex(PlayerPad.INTERROGATE)]=false,
  [bit.tohex(PlayerPad.RIDE_ON)]=false,
  [bit.tohex(PlayerPad.RIDE_OFF)]=false,
  [bit.tohex(PlayerPad.VEHICLE_CHANGE_SIGHT)]=false,
  [bit.tohex(PlayerPad.VEHICLE_LIGHT_SWITCH)]=false,
  [bit.tohex(PlayerPad.VEHICLE_TOGGLE_WEAPON)]=false,
  [bit.tohex(PlayerPad.JUMP)]=false,
  [bit.tohex(PlayerPad.MOVE_ACTION)]=false,
  [bit.tohex(PlayerPad.PRIMARY_WEAPON)]=false,
  [bit.tohex(PlayerPad.SECONDARY_WEAPON)]=false,
  --[[[bit.tohex(PlayerPad.STICK_L)]=false,
  [bit.tohex(PlayerPad.STICK_R)]=false,
  [bit.tohex(PlayerPad.TRIGGER_L)]=false,
  [bit.tohex(PlayerPad.TRIGGER_R)]=false,
  [bit.tohex(PlayerPad.TRIGGER_ACCEL)]=false,
  [bit.tohex(PlayerPad.TRIGGER_BREAK)]=false,
  --[bit.tohex(PlayerPad.ALL)]=false--]]
}
--tex mod settings setup
this.SETTING_NAMES={
  "SUBSISTENCE",
  "HARD",
  "PLAYER_HEALTH_MULT",
  "ENEMY_HEALTH_MULT",
  "MAX"
}
this.SETTING_TYPE=TppDefine.Enum(this.SETTING_NAMES)

this.switchSlider={max=1,min=0,increment=1}
this.subsistenceLoadoutSlider={max=#TppMission.subsistenceLoadouts,min=0,increment=1}
this.healthMultSlider={max=4,min=0,increment=0.2}
function this.SettingInfoHealth()
  return vars.playerLifeMax
end
function this.ChangeSetting(modSetting,value)
  gvars[modSetting.gvar]=gvars[modSetting.gvar]+value
  gvars[modSetting.gvar]=TppMath.Clamp(gvars[modSetting.gvar],modSetting.slider.min,modSetting.slider.max)
end
this.modSettings = {
  [this.SETTING_TYPE.SUBSISTENCE] = {
    gvar="isManualSubsistence",
    default=0,
    slider=this.subsistenceLoadoutSlider,
  },
  [this.SETTING_TYPE.HARD] = {
    gvar="isManualHard",    
    default=0,
    slider=this.switchSlider,
  },
  [this.SETTING_TYPE.PLAYER_HEALTH_MULT] = {
    gvar="playerHealthMult",
    default=1,
    slider=this.healthMultSlider,
    isFloatOption=true,
    infoFunc=this.SettingInfoHealth
  },
  [this.SETTING_TYPE.ENEMY_HEALTH_MULT] = {
    gvar="enemyHealthMult",
    default=1,
    slider=this.healthMultSlider,
    isFloatOption=true,
  }
}
this.currentOption=0--tex lua tables are indexed from 1, but fox enum implementation seems to be 0 indexed
this.modMenuOn=false--tex RETRY: scoured for ways to get menu status, give up for now HAX
--tex button press system
function this.UpdateKeys()
  --tex cant figure out anything with no feedback, 
  -- RETRY: again some day
  -- prevbuttons = PlayerVars.scannedButtonsDirect doesnt work
  -- pb = bit.tohex(PlayerVars.scannedButtonsDirect)
  -- -> (bit.band(tobit(PlayerVars.scannedButtonsDirect),button)==button) doesnt work (pb reads as other buttons pressed)
  -- fuck it, just brute force it, more or less would amount to same anyway, but hash table not good in general for performance, esp vs above
  -- TODO: PERF: cull the table down to those you're going to use
  this.prevButtons[bit.tohex(PlayerPad.DECIDE)] = this.ButtonDown(PlayerPad.DECIDE)
  this.prevButtons[bit.tohex(PlayerPad.STANCE)] = this.ButtonDown(PlayerPad.STANCE)
  this.prevButtons[bit.tohex(PlayerPad.ACTION)] = this.ButtonDown(PlayerPad.ACTION)
  this.prevButtons[bit.tohex(PlayerPad.RELOAD)] = this.ButtonDown(PlayerPad.RELOAD)
  this.prevButtons[bit.tohex(PlayerPad.STOCK)] = this.ButtonDown(PlayerPad.STOCK)
  this.prevButtons[bit.tohex(PlayerPad.MB_DEVICE)] = this.ButtonDown(PlayerPad.MB_DEVICE)
  this.prevButtons[bit.tohex(PlayerPad.CALL)] = this.ButtonDown(PlayerPad.CALL)
  this.prevButtons[bit.tohex(PlayerPad.UP)] = this.ButtonDown(PlayerPad.UP)
  this.prevButtons[bit.tohex(PlayerPad.DOWN)] = this.ButtonDown(PlayerPad.DOWN)
  this.prevButtons[bit.tohex(PlayerPad.LEFT)] = this.ButtonDown(PlayerPad.LEFT)
  this.prevButtons[bit.tohex(PlayerPad.RIGHT)] = this.ButtonDown(PlayerPad.RIGHT)
  this.prevButtons[bit.tohex(PlayerPad.SIDE_ROLL)] = this.ButtonDown(PlayerPad.SIDE_ROLL)
  this.prevButtons[bit.tohex(PlayerPad.ZOOM_CHANGE)] = this.ButtonDown(PlayerPad.ZOOM_CHANGE)
  this.prevButtons[bit.tohex(PlayerPad.LIGHT_SWITCH)] = this.ButtonDown(PlayerPad.LIGHT_SWITCH)
  this.prevButtons[bit.tohex(PlayerPad.EVADE)] = this.ButtonDown(PlayerPad.EVADE)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_FIRE)] = this.ButtonDown(PlayerPad.VEHICLE_FIRE)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_CALL)] = this.ButtonDown(PlayerPad.VEHICLE_CALL)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_DASH)] = this.ButtonDown(PlayerPad.VEHICLE_DASH)
  this.prevButtons[bit.tohex(PlayerPad.BUTTON_PLACE_MARKER)] = this.ButtonDown(PlayerPad.BUTTON_PLACE_MARKER)
  this.prevButtons[bit.tohex(PlayerPad.PLACE_MARKER)] = this.ButtonDown(PlayerPad.PLACE_MARKER)
  this.prevButtons[bit.tohex(PlayerPad.INTERROGATE)] = this.ButtonDown(PlayerPad.INTERROGATE)
  this.prevButtons[bit.tohex(PlayerPad.RIDE_ON)] = this.ButtonDown(PlayerPad.RIDE_ON)
  this.prevButtons[bit.tohex(PlayerPad.RIDE_OFF)] = this.ButtonDown(PlayerPad.RIDE_OFF)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_CHANGE_SIGHT)] = this.ButtonDown(PlayerPad.VEHICLE_CHANGE_SIGHT)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_LIGHT_SWITCH)] = this.ButtonDown(PlayerPad.VEHICLE_LIGHT_SWITCH)
  this.prevButtons[bit.tohex(PlayerPad.VEHICLE_TOGGLE_WEAPON)] = this.ButtonDown(PlayerPad.VEHICLE_TOGGLE_WEAPON)
  this.prevButtons[bit.tohex(PlayerPad.JUMP)] = this.ButtonDown(PlayerPad.JUMP)
  this.prevButtons[bit.tohex(PlayerPad.MOVE_ACTION)] = this.ButtonDown(PlayerPad.MOVE_ACTION)
  this.prevButtons[bit.tohex(PlayerPad.PRIMARY_WEAPON)] = this.ButtonDown(PlayerPad.PRIMARY_WEAPON)
  this.prevButtons[bit.tohex(PlayerPad.SECONDARY_WEAPON)] = this.ButtonDown(PlayerPad.SECONDARY_WEAPON)
  --[[this.prevButtons[bit.tohex(PlayerPad.STICK_L)] = this.ButtonDown(PlayerPad.STICK_L)
  this.prevButtons[bit.tohex(PlayerPad.STICK_R)] = this.ButtonDown(PlayerPad.STICK_R)
  this.prevButtons[bit.tohex(PlayerPad.TRIGGER_L)] = this.ButtonDown(PlayerPad.TRIGGER_L)
  this.prevButtons[bit.tohex(PlayerPad.TRIGGER_R)] = this.ButtonDown(PlayerPad.TRIGGER_R)
  this.prevButtons[bit.tohex(PlayerPad.TRIGGER_ACCEL)] = this.ButtonDown(PlayerPad.TRIGGER_ACCEL)
  this.prevButtons[bit.tohex(PlayerPad.TRIGGER_BREAK)] = this.ButtonDown(PlayerPad.TRIGGER_BREAK)
  --this.prevButtons[bit.tohex(PlayerPad.ALL)] = this.ButtonDown(PlayerPad.ALL)--]]
end
function this.ButtonDown(button)
  if (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then
    return true
  end
  return false
end
--tex GOTCHA: will have a gameframe of latency
function this.OnButtonDown(button)
  if not this.prevButtons[bit.tohex(button)] and (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then
    return true
  end
  return false
end
function this.OnButtonUp(button)
  if this.prevButtons[bit.tohex(button)] and not (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then
    return true
  end
  return false
end
--tex mod settings menu manipulation
function this.NextOption()
  this.currentOption=this.currentOption+1
  if this.currentOption > table.getn(this.modSettings) then
    this.currentOption = 0
  end
end
function this.PreviousOption()
  this.currentOption = this.currentOption-1
  if this.currentOption < 0 then
    this.currentOption = table.getn(this.modSettings)
  end
end
function this.NextSetting()
  local modSetting = this.modSettings[this.currentOption]
  this.ChangeSetting(modSetting,modSetting.slider.increment)
end
function this.PreviousSetting()
  local modSetting = this.modSettings[this.currentOption]
  this.ChangeSetting(modSetting,-modSetting.slider.increment)
end
function this.DisplayCurrentSetting()
  this.DisplaySetting(this.currentOption)
end
function this.DisplaySetting(index)
  local option=gvars[this.modSettings[index].gvar] --tex getting a bit dense to parse lol
  if this.modSettings[index].isFloatOption then
    option=100*option
  end
  local info = 0
  if IsFunc(this.modSettings[index].infoFunc) then
    info = this.modSettings[index].infoFunc()
  end
  --tex RETRY: need custom text output damnit
  TppUiCommand.AnnounceLogViewLangId("announce_trial_time",index,option,info)
end
function this.DisplaySettings()--tex display all
  for i=0,this.SETTING_TYPE.MAX-1 do
    this.DisplaySetting(i)
  end
end
function this.ResetSettings()
  for i=0,(this.SETTING_TYPE.MAX-1) do
    this.DisplaySetting(i)
    gvars[this.modSettings[i].gvar] = this.modSettings[i].default
    this.DisplaySetting(i)
  end
end
--tex soldier2parametertables shiz REFACTOR: find somewhere nicer to put/compartmentalize this, Solider2ParameterTables.lua aparently can't be referenced even though there's a TppSolder2Parameter string in the exe, load hang on trying to do anything with it (and again no debug feedback to know why the fuck anything)
local nightSightDefault={
  discovery={distance=10,verticalAngle=30,horizontalAngle=40},
  indis={distance=15,verticalAngle=60,horizontalAngle=60},
  dim={distance=40,verticalAngle=60,horizontalAngle=60},
  far={distance=0,verticalAngle=0,horizontalAngle=0}
}
local nightSightImproved={
  discovery={distance=10,verticalAngle=30,horizontalAngle=40},
  indis={distance=15,verticalAngle=60,horizontalAngle=60},
  dim={distance=40,verticalAngle=60,horizontalAngle=60},
  far={distance=50,verticalAngle=8,horizontalAngle=6}
}
local nightSightDebug={
  discovery={distance=10,verticalAngle=30,horizontalAngle=40},
  indis={distance=15,verticalAngle=60,horizontalAngle=60},
  dim={distance=40,verticalAngle=60,horizontalAngle=60},
  far={distance=350,verticalAngle=60,horizontalAngle=60} -- debug hax
}
--tex in sightFormParameter
local sandstormSightDefault={distanceRate=.6,angleRate=.8}
local rainSightDefault={distanceRate=1,angleRate=1}
local cloudySightDefault={distanceRate=1,angleRate=1}
local foggySightDefault={distanceRate=.5,angleRate=.6}
--tex BALLANCE: being conservative, could be more agressive if coupled with a bump in the sight dist it modifies, but I like the retail settings in general
local sandstormSightImproved={distanceRate=.6,angleRate=.8}
local rainSightImproved={distanceRate=.9,angleRate=0.95}
local cloudySightImproved={distanceRate=0.95,angleRate=1}
local foggySightImproved={distanceRate=.5,angleRate=.6}

this.lifeParameterTableDefault={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}
this.lifeParameterTableMod={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}--tex modified in-place by enemy health scale
this.soldierParametersDefault = {--tex actually using my slight tweaks rather than true default
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight=nightSightImproved,
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}},
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}},
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}},
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}},
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}},
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}},
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight=sandstormSightImproved,
    rainSight=rainSightImproved,
    cloudySight=cloudySightImproved,
    foggySight=foggySightImproved
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable=this.lifeParameterTableMod,
  zombieParameterTable={highHeroicValue=1e3}
}
this.soldierParametersHard = {--tex: currently no different, don't know if i want to spend time tweaking
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=40,verticalAngle=60,horizontalAngle=60},
      far={distance=50,verticalAngle=8,horizontalAngle=6}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}},
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}},
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}},
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}},
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}},
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}},
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight=sandstormSightImproved,
    rainSight=rainSightImproved,
    cloudySight=cloudySightImproved,
    foggySight=foggySightImproved
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable=this.lifeParameterTableMod,
  zombieParameterTable={highHeroicValue=1e3}
}--tex end
local l=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local f=TppScriptVars.IsSavingOrLoading
local m=ScriptBlock.UpdateScriptsInScriptBlocks
local M=Mission.GetCurrentMessageResendCount
local o={}
local p=0
local T={}
local a=0
local d={}
local u=0
local n={}
local n=0
local S={}
local P={}
local s=0
local c={}
local h={}
local r=0
local function n()
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()
    coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function this.DisableGameStatus()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}
end
function this.DisableGameStatusOnGameOverMenu()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}
end
function this.EnableGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableGameStatusForDemo()
  TppDemo.ReserveEnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableAllGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}
end
function this.EnablePlayerPad()
  TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.DisablePlayerPad()
  TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.EnablePause()
  TppPause.RegisterPause"TppMain.lua"end
function this.DisablePause()
  TppPause.UnregisterPause"TppMain.lua"end
function this.EnableBlackLoading(e)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if e then
    TppUI.StartLoadingTips()
  end
end
function this.DisableBlackLoading()
  TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")
  TppUI.FinishLoadingTips()
end
function this.OnAllocate(n)
  TppWeather.OnEndMissionPrepareFunction()
  this.DisableGameStatus()
  this.EnablePause()
  TppClock.Stop()
  o={}
  p=0
  d={}
  u=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFOBMissionFlag()
    TppGameStatus.Set("Mission","S_IS_ONLINE")
  else
    TppGameStatus.Reset("Mission","S_IS_ONLINE")
  end
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(n)
  TppClock.OnAllocate(n)
  TppTrap.OnAllocate(n)
  TppCheckPoint.OnAllocate(n)
  TppUI.OnAllocate(n)
  TppDemo.OnAllocate(n)
  TppScriptBlock.OnAllocate(n)
  TppSound.OnAllocate(n)
  TppPlayer.OnAllocate(n)
  TppMission.OnAllocate(n)
  TppTerminal.OnAllocate(n)
  TppEnemy.OnAllocate(n)
  TppRadio.OnAllocate(n)
  TppGimmick.OnAllocate(n)
  TppMarker.OnAllocate(n)
  TppRevenge.OnAllocate(n)
  this.ClearStageBlockMessage()
  TppQuest.OnAllocate(n)
  TppAnimal.OnAllocate(n)
  local function o()
    if TppLocation.IsAfghan()then
      if afgh then
        afgh.OnAllocate()
      end
    elseif TppLocation.IsMiddleAfrica()then
      if mafr then
        mafr.OnAllocate()
      end
    elseif TppLocation.IsCyprus()then
      if cypr then
        cypr.OnAllocate()
      end
    elseif TppLocation.IsMotherBase()then
      if mtbs then
        mtbs.OnAllocate()
      end
    end
  end
  o()
  if n.sequence then
    if i(n.sequence.MissionPrepare)then
      n.sequence.MissionPrepare()        
    end
    if i(n.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(n.sequence.OnEndMissionPrepareSequence)
    end
  end
  for n,e in pairs(n)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
  end
  do
    local s={}
    for t,e in ipairs(Tpp._requireList)do
      if _G[e]then
        if _G[e].DeclareSVars then
          l(s,_G[e].DeclareSVars(n))
        end
      end
    end
    local o={}
    for n,e in pairs(n)do
      if i(e.DeclareSVars)then
        l(o,e.DeclareSVars())
      end
      if t(e.saveVarsList)then
        l(o,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    l(s,o)
    TppScriptVars.DeclareSVars(s)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while f()do
      coroutine.yield()
    end    
    TppRadioCommand.SetScriptDeclVars()
    local i=vars.mbLayoutCode
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(n)
        TppPlayer.MissionStartPlayerTypeSetting()
        if not TppMission.IsFOBMission(vars.missionCode)then
          TppSave.VarSave(vars.missionCode,true)
        end
      else
        TppVarInit.InitializeForContinue(n)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    TppStory.SetMissionClearedS10030()
    TppTerminal.StartSyncMbManagementOnMissionStart()
    if TppLocation.IsMotherBase()then
      if i~=vars.mbLayoutCode then
        if vars.missionCode==30050 then
          vars.mbLayoutCode=i
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    this.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}
    if n.sequence then
      local e=n.sequence.DISABLE_BUDDY_TYPE
      if e then
        local n
        if t(e)then
          n=e
        else
          n={e}
        end
        for n,e in ipairs(n)do
          TppBuddyService.SetDisableBuddyType(e)
        end
      end
    end
    --tex changed to issubs check, more robust even without my mod
    --if(vars.missionCode==11043)or(vars.missionCode==11044)then
    if TppMission.IsSubsistenceMission() then
      TppBuddyService.SetDisableAllBuddy()
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if n.sequence and n.sequence.OnBuddyBlockLoad then
        n.sequence.OnBuddyBlockLoad()
      end
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  --tex REF: this.lifeParameterTableDefault={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}
  local healthMult=gvars.enemyHealthMult--tex mod enemy health scale
  this.lifeParameterTableMod.maxLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxLife,healthMult)
  this.lifeParameterTableMod.maxLimbLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxLimbLife,healthMult)
  this.lifeParameterTableMod.maxArmorLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxArmorLife,healthMult)
  this.lifeParameterTableMod.maxHelmetLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxHelmetLife,healthMult)
  if not TppMission.IsManualHardMission() then--tex reloadsoldierparams for difficulty
    TppSoldier2.ReloadSoldier2ParameterTables(this.soldierParametersDefault)
  else
    TppSoldier2.ReloadSoldier2ParameterTables(this.soldierParametersHard)
  end --
  
  if n.enemy then
    if t(n.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(n.enemy.soldierPowerSettings)
    end
  end
  TppRevenge.DecideRevenge(n)
  if TppEquip.CreateEquipMissionBlockGroup then
    if(vars.missionCode>6e4)then
      TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}
    else
      TppPlayer.SetEquipMissionBlockGroupSize()
    end
  end
  if TppEquip.CreateEquipGhostBlockGroups then
    if TppSystemUtility.GetCurrentGameMode()=="MGO"then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=16}
    elseif TppMission.IsFOBMission(vars.missionCode)then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=1}
    end
  end
  TppEquip.StartLoadingToEquipMissionBlock()
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if n.sequence then
    mvars.mis_baseList=n.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
end
function this.OnInitialize(n)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFobPlayerStartPoint()
  elseif TppMission.IsNeedSetMissionStartPositionToClusterPosition()then
    TppMission.SetMissionStartPositionMtbsClusterPosition()
    e.StageBlockCurrentPosition(true)
  else
    TppCheckPoint.SetCheckPointPosition()
  end
  if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  TppAnimalBlock.InitializeBlockStatus()
  if TppQuestList then
    TppQuest.RegisterQuestList(TppQuestList.questList)
    TppQuest.RegisterQuestPackList(TppQuestList.questPackList)
  end
  TppHelicopter.AdjustBuddyDropPoint()
  if n.sequence then
    local e=n.sequence.NPC_ENTRY_POINT_SETTING
    if t(e)then
      TppEnemy.NPCEntryPointSetting(e)
    end
  end
  TppLandingZone.OverwriteBuddyVehiclePosForALZ()
  if n.enemy then
    if t(n.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if i(n.enemy.SpawnVehicleOnInitialize)then
      n.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for t,e in pairs(n)do
    if i(e.Messages)then
      n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  TppLandingZone.OnInitialize()
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].Init then
      _G[e].Init(n)
    end
  end
  if n.enemy then
    if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
      GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
    end
    if t(n.enemy.soldierDefine)then
      TppEnemy.DefineSoldiers(n.enemy.soldierDefine)
    end
    if n.enemy.InitEnemy and i(n.enemy.InitEnemy)then
      n.enemy.InitEnemy()
    end
    if t(n.enemy.soldierPersonalAbilitySettings)then
      TppEnemy.SetUpPersonalAbilitySettings(n.enemy.soldierPersonalAbilitySettings)
    end
    if t(n.enemy.travelPlans)then
      TppEnemy.SetTravelPlans(n.enemy.travelPlans)
    end
    TppEnemy.SetUpSoldiers()
    if t(n.enemy.soldierDefine)then
      TppEnemy.InitCpGroups()
      TppEnemy.RegistCpGroups(n.enemy.cpGroups)
      TppEnemy.SetCpGroups()
      if mvars.loc_locationGimmickCpConnectTable then
        TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)
      end
    end
    if t(n.enemy.interrogation)then
      TppInterrogation.InitInterrogation(n.enemy.interrogation)
    end
    if t(n.enemy.useGeneInter)then
      TppInterrogation.AddGeneInter(n.enemy.useGeneInter)
    end
    if t(n.enemy.uniqueInterrogation)then
      TppInterrogation.InitUniqueInterrogation(n.enemy.uniqueInterrogation)
    end
    do
      local e
      if t(n.enemy.routeSets)then
        e=n.enemy.routeSets
        for e,n in pairs(e)do
          if not t(mvars.ene_soldierDefine[e])then
          end
        end
      end
      if e then
        TppEnemy.RegisterRouteSet(e)
        TppEnemy.MakeShiftChangeTable()
        TppEnemy.SetUpCommandPost()
        TppEnemy.SetUpSwitchRouteFunc()
      end
    end
    if n.enemy.soldierSubTypes then
      TppEnemy.SetUpSoldierSubTypes(n.enemy.soldierSubTypes)
    end
    TppRevenge.SetUpEnemy()
    TppEnemy.ApplyPowerSettingsOnInitialize()
    TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()
    TppEnemy.SetOccasionalChatList()
    TppEneFova.ApplyUniqueSetting()
    if n.enemy.SetUpEnemy and i(n.enemy.SetUpEnemy)then
      n.enemy.SetUpEnemy()
    end
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  TppPlayer.RestoreSupplyCbox()
  TppPlayer.RestoreSupportAttack()
  TppTerminal.MakeMessage()
  if n.sequence then
    local e=n.sequence.SetUpRoutes
    if e and i(e)then
      e()
    end
    TppEnemy.RegisterRouteAnimation()
    local e=n.sequence.SetUpLocation
    if e and i(e)then
      e()
    end
  end
  for n,e in pairs(n)do
    if e.OnRestoreSVars then
      e.OnRestoreSVars()
    end
  end
  TppMission.RestoreShowMissionObjective()
  TppRevenge.SetUpRevengeMine()
  if TppPickable.StartToCreateFromLocators then
    TppPickable.StartToCreateFromLocators()
  end
  if TppPlaced and TppPlaced.StartToCreateFromLocators then
    TppPlaced.StartToCreateFromLocators()
  end
  if TppMission.IsMissionStart()then
    TppRadioCommand.RestoreRadioState()
  else
    TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()
  end
  TppMission.PostMissionOrderBoxPositionToBuddyDog()
  e.SetUpdateFunction(n)
  e.SetMessageFunction(n)
  TppQuest.UpdateActiveQuest()
  TppDevelopFile.OnMissionCanStart()
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    if TppQuest.IsActiveQuestHeli()then
      TppEnemy.ReserveQuestHeli()
    end
  end
  TppDemo.UpdateNuclearAbolitionFlag()
  TppQuest.AcquireKeyItemOnMissionStart()
end
function this.SetUpdateFunction(e)
  o={}
  p=0
  T={}
  a=0
  d={}
  u=0
  o={TppMission.Update,TppSequence.Update,TppSave.Update,TppDemo.Update,TppPlayer.Update,TppMission.UpdateForMissionLoad}
  p=#o
  for n,e in pairs(e)do
    if i(e.OnUpdate)then
      a=a+1
      T[a]=e.OnUpdate
    end
  end
end
function this.OnEnterMissionPrepare()
  if TppMission.IsMissionStart()then
    TppScriptBlock.PreloadSettingOnMissionStart()
  end
  TppScriptBlock.ReloadScriptBlock()
end
function this.OnTextureLoadingWaitStart()
  if not TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  gvars.canExceptionHandling=true
end
function this.OnMissionStartSaving()
end
function this.OnMissionCanStart()
  if TppMission.IsMissionStart()then
    TppWeather.SetDefaultWeatherProbabilities()
    TppWeather.SetDefaultWeatherDurations()
    if(not gvars.ini_isTitleMode)and(not TppMission.IsFOBMission(vars.missionCode))then
      TppSave.VarSave(nil,true)
    end
  end
  TppLocation.ActivateBlock()
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  TppMission.OnMissionStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  TppLandingZone.OnMissionCanStart()
  TppOutOfMissionRangeEffect.Disable(0)
  if TppLocation.IsMiddleAfrica()then
    TppGimmick.MafrRiverPrimSetting()
  end
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  if vars.missionCode==10240 and TppLocation.IsMBQF()then
    Player.AttachGasMask()
  end
end
function this.OnMissionGameStart(n)
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"end
  TppQuest.InitializeQuestActiveStatus()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    e.EnableGameStatusForDemo()
  else
    e.EnableGameStatus()
  end
  if Player.RequestChickenHeadSound~=nil then
    Player.RequestChickenHeadSound()
  end
  TppTerminal.OnMissionGameStart()
  if TppSequence.IsLandContinue()then
    TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  end
  TppSoundDaemon.ResetMute"Telop"
end
function this.ClearStageBlockMessage()
  StageBlock.ClearLargeBlockNameForMessage()
  StageBlock.ClearSmallBlockIndexForMessage()
end
--tex REF: working some better var names out
-- called from tppmission:VarSaveForMissionAbort && Executemissionfinalize
--(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,o=ishelispace,s=isfreemission,t=isheli(mvars.mis_nextMissionCodeForAbort),i=IsFreeMission(mvars.mis_nextMissionCodeForAbort),a=mvars.mis_isAbortWithSave|nil,p=vars.missioncode changed)
function this.ReservePlayerLoadingPosition(loadType,isMissionHeliSpace,isMissionFreeMission,isAbortMissionHeliSpace,isAbortMissionFreeMission,isAbortWithSave,isMissionCodeChanged)
  this.DisableGameStatus()
  if loadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if isAbortMissionHeliSpace then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif isMissionHeliSpace then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
        end
      else
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        local e=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if e then
          TppPlayer.SetInitialPosition(e,0)
          TppPlayer.SetMissionStartPosition(e,0)
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
        end
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif isAbortMissionFreeMission then
      if TppLocation.IsMotherBase()then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
      TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
    elseif(isMissionFreeMission and TppLocation.IsMotherBase())then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    else
      if isMissionFreeMission then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
          TppPlayer.ResetNoOrderBoxMissionStartPosition()
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
          local e={
          [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
          [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
          [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
          [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
          [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
          [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
          [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
          }
          e[11050]=e[10050]
          e[11080]=e[10080]
          e[11140]=e[10140]
          e[10151]=e[10150]
          e[11151]=e[10150]
          local e=e[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and e then
            TppPlayer.SetNoOrderBoxMissionStartPosition(e,e[4])
          else
            TppPlayer.ResetNoOrderBoxMissionStartPosition()
          end
        end
        local e=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if e then--tex added issub check
          TppPlayer.SetStartStatusRideOnHelicopter()
          TppMission.SetIsStartFromHelispace()
          TppMission.ResetIsStartFromFreePlay()
        else
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
          TppHelicopter.ResetMissionStartHelicopterRoute()
          TppMission.ResetIsStartFromHelispace()
          TppMission.SetIsStartFromFreePlay()
        end
        local e=TppMission.GetMissionClearType()
        TppQuest.SpecialMissionStartSetting(e)
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromHelispace()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif loadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if isAbortWithSave then
      if isAbortMissionFreeMission then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif isAbortMissionHeliSpace then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if isAbortMissionHeliSpace then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif isAbortMissionFreeMission then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif loadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif loadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if isMissionHeliSpace and isMissionCodeChanged then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(e)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.DisablePosition()
    if e then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function this.OnReload(n)
  for t,e in pairs(n)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
    if i(e.Messages)then
      n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if n.enemy then
    if t(n.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"
      TppClock.UnregisterClockMessage"ShiftChangeAtMorning"
      TppEnemy.RegisterRouteSet(n.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].OnReload then
      _G[e].OnReload(n)
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if n.sequence then
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
  this.SetUpdateFunction(n)
  this.SetMessageFunction(n)
end
function this.OnUpdate(e)
  local e
  local n=o
  local t=T
  local e=d
  for e=1,p do
    n[e]()
  end
  for e=1,a do
    t[e]()
  end
  m()
end
function this.OnChangeSVars(e,n,t)
  for i,e in ipairs(Tpp._requireList)do
    if _G[e].OnChangeSVars then
      _G[e].OnChangeSVars(n,t)
    end
  end
end
function this.SetMessageFunction(e)
  S={}
  s=0
  c={}
  r=0
  for n,e in ipairs(Tpp._requireList)do
    if _G[e].OnMessage then
      s=s+1
      S[s]=_G[e].OnMessage
    end
  end
  for n,t in pairs(e)do
    if e[n]._messageExecTable then
      r=r+1
      c[r]=e[n]._messageExecTable
    end
  end
end
function this.OnMessage(e,n,t,i,l,a,p)
  local e=mvars
  local o=""
  local T
  local m=Tpp.DoMessage
  local d=TppMission.CheckMessageOption
  local T=TppDebug
  local T=P
  local T=h
  local T=TppDefine.MESSAGE_GENERATION[n]and TppDefine.MESSAGE_GENERATION[n][t]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local u=M()
  if u<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for e=1,s do
    local o=o
    S[e](n,t,i,l,a,p,o)
  end
  for e=1,r do
    local o=o
    m(c[e],d,n,t,i,l,a,p,o)
  end
  if e.loc_locationCommonTable then
    e.loc_locationCommonTable.OnMessage(n,t,i,l,a,p,o)
  end
  if e.order_box_script then
    e.order_box_script.OnMessage(n,t,i,l,a,p,o)
  end
  if e.animalBlockScript and e.animalBlockScript.OnMessage then
    e.animalBlockScript.OnMessage(n,t,i,l,a,p,o)
  end
end
function this.OnTerminate(e)
  if e.sequence then
    if i(e.sequence.OnTerminate)then
      e.sequence.OnTerminate()
    end
  end
end
return this
