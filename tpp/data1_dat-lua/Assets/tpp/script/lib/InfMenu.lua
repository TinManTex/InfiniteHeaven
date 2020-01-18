-- DOBUILD: 1
--tex SYS: mod menu
local this={}
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle

--LOCALOPT:
local Buttons=InfButton
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local IsDemoPlaying=DemoDaemon.IsDemoPlaying
local GetAssetConfig=AssetConfiguration.GetDefaultCategory

this.switchSlider={max=1,min=0,increment=1}
this.healthMultSlider={max=4,min=0,increment=0.2}

local menuItemMenuOff={
  name="inf_turn_off_menu",--"Turn off menu"
  default=0,
  slider=this.switchSlider,
  settingNames="inf_set_menu_off",
  onChange=function()
    this.MenuOff()
    this.currentOption=1
  end,
}
local menuItemResetSettings={
  name="inf_reset_all_settings",--"Reset all settings"
  default=0,
  slider=this.switchSlider,
  settingNames="inf_set_menu_reset",
  onChange=function()
    this.ResetSettingsDisplay()
    this.MenuOff()
  end,
}
local menuItemGoBack={
  name="inf_menu_back",--"Menu Back"
  default=0,
  slider=this.switchSlider,
  settingNames="inf_set_menu_back",
  onChange=function()
    this.GoBackCurrent()
  end,
}

local clockTimeScaleMenuItem={
  name="inf_clock_time_scale",
  gvarName="clockTimeScale",
  default=20,
  slider={max=1000,min=1,increment=1},
  onChange=function()
    if not IsDemoPlaying() then
      TppClock.Start()  
    end
  end
}

local parametersMenu={
  name="inf_parameters_menu",
  parent=nil,
  default=0,
  options={
    {
      name="inf_general_enemy_parameters",--"General Enemy Parameters"
      gvarName="enemyParameters",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_enemy_parameters",
    },
    {
      name="inf_enemy_life_scale",--"Enemy life scale (Requires Tweaked Enemy Parameters)"
      gvarName="enemyHealthMult",
      default=1,
      slider=this.healthMultSlider,
      isFloatSetting=true,
    },
    {
      name="inf_player_life_scale",--"Player life scale"
      gvarName="playerHealthMult",
      default=1,
      slider=this.healthMultSlider,
      isFloatSetting=true,
    },
    menuItemResetSettings,
    menuItemGoBack,
  }
}
local motherBaseMenu={
  name="inf_mother_base_menu",
  parent=nil,
  default=0,
  options={
    {
      name="inf_dd_equip_grade",--"DD Equip Grade",
      gvarName="mbSoldierEquipGrade",
      default=0,
      slider={max=InfMain.SETTING_MB_EQUIPGRADE.MAX-1,min=0,increment=1},
      settingNames="inf_set_dd_equip_grade",--SYNC: SETTING_MB_EQUIPGRADE
      onChange=function()--DEPENDENCY: mbPlayTime
        if gvars.mbSoldierEquipGrade==0 then
          gvars.mbPlayTime=0
        elseif gvars.mbSoldierEquipGrade>0 then
          gvars.mbPlayTime=1
        end
      end
    },
    {
      name="inf_dd_equip_range",--"DD Equip Range",
      gvarName="mbSoldierEquipRange",
      default=0,
      slider={max=InfMain.SETTING_MB_EQUIPRANGE.MAX-1,min=0,increment=1},
      settingNames="inf_set_dd_equip_range",--SYNC: SETTING_MB_EQUIPRANGE
    },
    {
      name="inf_dd_suit",--"DD Suit (Requires Equip Grade On)",
      gvarName="mbDDSuit",
      default=0,
      slider={max=InfMain.SETTING_MB_DD_SUITS.MAX-1,min=0,increment=1},
      settingNames="inf_set_dd_suit",
    },
    --[[{
      name="DD Balaclava",
      gvarName="mbDDBalaclava",
      default=0,
      slider=this.switchSlider,
      settingNames={"Use Equip Grade", "Force Off"},
    },--]]
    {
      name="inf_mother_base_war_games",--"Mother Base War Games",
      gvarName="mbWarGames",
      default=0,
      slider={max=2,min=0,increment=1},
      settingNames="inf_set_mb_wargames",
    },
    menuItemResetSettings,
    menuItemGoBack,
  }
}
local demosMenu={
  name="inf_demos_menu",
  parent=nil,
  default=0,
  options={
    {
      name="inf_use_soldier_for_demos",
      gvarName="useSoldierForDemos",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_switch",
    },
    {
      name="inf_mb_demo_selection",--"MB return demo play mode",
      helpText="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",--ADDLANG:
      gvarName="mbDemoSelection",
      default=0,
      slider={max=2,min=0,increment=1},
      settingNames="inf_set_mb_demo_selection",
    },
    {
      name="inf_mb_select_demo",--"Select MB return demo (REQ: Play selected above)",
      gvarName="mbSelectedDemo",
      default=0,
      slider={max=(#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1),min=0,increment=1},--tex #Enumtable doesn't seem to work, have a look how .
      settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,
    },
    menuItemResetSettings,    
    menuItemGoBack,
  }
}

local patchupMenu={
  name="inf_patchup_menu",
  parent=nil,
  default=0,
  options={
    {
      name="inf_unlock_avatar",
      gvarName="unlockPlayableAvatar",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_switch",
      onChange=function()
        local currentStorySequence=TppStory.GetCurrentStorySequence()
        if gvars.unlockPlayableAvatar==0 then
          if currentStorySequence<=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
            vars.isAvatarPlayerEnable=0
          end
        else
          vars.isAvatarPlayerEnable=1
        end
      end,
    },
    {
      name="inf_return_quiet",--"Return Quiet (not reversable)",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_quiet_return",
      onChange=function()
        if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
          this.AnnounceLogLangId"inf_quiet_already_returned"--"Quiet has already returned."
        else
          InfPatch.QuietReturn()
        end
      end,
    },
    {
      name="inf_show_game_lang_code",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_do",
      onChange=function()
        local languageCode=GetAssetConfig"Language"
        TppUiCommand.AnnounceLogView("Language Code: " .. languageCode)
      end,
    },
    menuItemGoBack,
  }
}

this.heliSpaceMenu={
  name="inf_main_menu",
  parent=nil,
  options={
    {
      name="inf_subsistence_mode",--"Subsistence Mode",
      gvarName="isManualSubsistence",
      default=0,
      slider={max=2,min=0,increment=1},
      settingNames="inf_set_subsistence",
      onChange=function()--DEPENDENCY: isManualSubsistence, subsistenceLoadout. noCentralLzs
        if gvars.isManualSubsistence==0 then
          gvars.subsistenceLoadout=0
          gvars.noCentralLzs=0
        else
          gvars.noCentralLzs=1
          if gvars.subsistenceLoadout==0 then
            gvars.subsistenceLoadout=1
          end
        end
      end,
    },
    {
      name="inf_osp_weapon_loadout",--"OSP Weapon Loadout",
      gvarName="subsistenceLoadout",
      default=0,
      slider={max=#InfMain.subsistenceLoadouts,min=0,increment=1},
      settingNames="inf_set_osp",
      helpText="Start with no primary and secondary weapons, can be used seperately from subsistence mode",
    },
    {
      name="inf_enemy_preparedness",--"Enemy Preparedness",
      gvarName="revengeMode",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_revenge",
    },
    {
      name="inf_start_missions_on_foot",
      gvarName="startOnFoot",
      default=0,
      slider=this.switchSlider,
      settingNames="inf_set_switch",
    },
    clockTimeScaleMenuItem,
    --[[{
      name="inf_force_enemy_subtype",
      gvarName="forceSoldierSubType",
      default=0,
      slider={max=(#InfMain.enemySubTypes-1),min=0,increment=1},
      settingNames=InfMain.enemySubTypes,
      onChange=function()
        if gvars.forceSoldierSubType==0 then
          InfMain.ResetCpTableToDefault()
        end
      end,
    },--]]
    --[[{--not inteded as user setting, only in menu for debug/view
      name="inf_no_central_lzs",
      gvarName="noCentralLzs",
      default=0,
      slider=this.switchSlider,
    },--]]
    --[[{
      name="LZ Waveoff (periodically disable random landing zones)",--ADDLANG
      gvarName="landingZoneWaveOff",
      default=1,
      slider={max=1,min=0,increment=0.2},
      isFloatSetting=true,
    },--]]
    {
      name="inf_unlock_random_sideops",--"Unlock random Sideops for areas",
      gvarName="unlockSideOps",
      default=0,
      slider={max=(InfMain.SETTING_UNLOCK_SIDEOPS.MAX-1),min=0,increment=1},
      settingNames="inf_set_unlock_sideops",--SYNC: SETTING_UNLOCK_SIDEOPS enum
      helpText="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
      onChange=function()
        TppQuest.UpdateActiveQuest()
      end,
    },
    {
      name="inf_open_specific_sideop",--"Open specific sideop #",
      gvarName="unlockSideOpNumber",
      default=0,
      slider={max=InfMain.numQuests,min=0,increment=1},
      skipValues=InfMain.disallowSideOps,
      onChange=function()
        TppQuest.UpdateActiveQuest()
      end,
    },
    parametersMenu,
    motherBaseMenu,
    demosMenu,
    patchupMenu,
    --[[{--tex cant get gvar startoffline to read in init sequence, yet isnewgame seems to be fine?
      name="Start Offline",
      gvarName="startOffline",
      default=0,
      slider=this.switchSlider,
      settingNames={"False","True"},
    },--]]
    menuItemResetSettings,
    menuItemMenuOff
  }
}

this.inMissionMenu={
  name="inf_main_menu",
  parent=nil,
  options={
    clockTimeScaleMenuItem,  
    menuItemResetSettings,
    menuItemMenuOff
  }
}

this.allMenus={--SYNC: currently used for resetall
  this.heliSpaceMenu,
  parametersMenu,
  motherBaseMenu,
  demosMenu, 
  patchupMenu,
  this.inMissionMenu,
}

--tex REFACTOR: most of these can be local
this.currentMenu=this.heliSpaceMenu
this.currentMenuOptions=this.heliSpaceMenu.options
this.topMenu=this.currentMenu
this.currentOption=1--tex lua tables are indexed from 1
this.previousMenuOption=1
this.currentSetting=0--tex settings from 0, to better fit variables
this.lastDisplay=0
this.autoDisplayDefault=2.8
this.autoRateHeld=0.85
this.autoDisplayRate=this.autoDisplayDefault
this.menuOn=false
this.toggleMenuButton=PlayerPad.RELOAD
this.toggleMenuHoldTime=1
this.menuRightButton=PlayerPad.RIGHT
this.menuLeftButton=PlayerPad.LEFT
this.menuUpButton=PlayerPad.UP
this.menuDownButton=PlayerPad.DOWN
this.resetSettingButton=PlayerPad.CALL
this.menuBackButton=PlayerPad.STANCE

--tex mod settings menu manipulation
function this.NextOption()
  this.currentOption=this.currentOption+1
  if this.currentOption > #this.currentMenuOptions then
    this.currentOption = 1
  end
  this.GetSetting()
end
function this.PreviousOption()
  this.currentOption = this.currentOption-1
  if this.currentOption < 1 then
    this.currentOption = #this.currentMenuOptions
  end
  this.GetSetting()
end
function this.GetSetting()
  local modSetting=this.currentMenuOptions[this.currentOption]
  this.currentSetting=modSetting.default
  if modSetting.gvarName ~= nil then
    local gvar=gvars[modSetting.gvarName]
    if gvar ~= nil then
      this.currentSetting=gvar
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -"..modSetting.gvarName.."- not found")
    end
  end
end
function this.IsCurrentOptionMenu()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.options~=nil then
    return true
  end
  return false  
end
function this.IncrementSetting(current, increment, min, max)
  local newSetting=current+increment

  if increment > 0 then
    if newSetting > max then
      newSetting = min
    end
  elseif increment < 0 then
    if newSetting < min then
      newSetting = max
    end
  end
  return newSetting
end
function this.ChangeSetting(modSetting,value,incrementMult)
  incrementMult = incrementMult or 1
  --TppUiCommand.AnnounceLogView("DBG:MNU: changesetting increment:"..value)--tex DEBUG: CULL:
  local newSetting=this.currentSetting

  local value=value*incrementMult
  if modSetting.isFloatSetting==nil then
    if value > 0 then
      value=math.ceil(value)
    else
      value=math.floor(value)
    end
    --TppUiCommand.AnnounceLogView("DBG:MNU: newValue round:"..value)
  end
  
  if modSetting.gvarName~=nil then
    --TppUiCommand.AnnounceLogView("DBG:MNU: found gvarName:" .. modSetting.gvarName)--tex DEBUG: CULL:
    local gvar=gvars[modSetting.gvarName]
    if gvar ~= nil then
      --TppUiCommand.AnnounceLogView("DBG:MNU: gvar:" .. modSetting.gvarName .. "=" .. gvar)--tex DEBUG: CULL:
      newSetting=this.IncrementSetting(gvar,value,modSetting.slider.min,modSetting.slider.max)
      if modSetting.skipValues ~= nil then
        while modSetting.skipValues[newSetting] do
          TppUiCommand.AnnounceLogView(newSetting .. " " .. this.LangString"inf_setting_disallowed")--" is currently disallowed"
          newSetting=this.IncrementSetting(newSetting,value,modSetting.slider.min,modSetting.slider.max)
        end
      end
      --TppUiCommand.AnnounceLogView("DBG:MNU: newsetting:"..newSetting)--tex DEBUG: CULL:
      newSetting=TppMath.Clamp(newSetting,modSetting.slider.min,modSetting.slider.max)
      --TppUiCommand.AnnounceLogView("DBG:MNU: newsetting clamped:"..newSetting)--tex DEBUG: CULL:
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -" .. modSetting.gvarName .. "- not found")
    end
    gvars[modSetting.gvarName]=newSetting
    --TppUiCommand.AnnounceLogView("DBG:MNU: gvar set:" .. modSetting.gvarName .. "=" .. gvar)--tex DEBUG: CULL:
    if IsFunc(modSetting.onChange) then
      modSetting.onChange()
    end
  else--gvar nil
    if modSetting.slider~=nil then
      newSetting=this.currentSetting+value
      if value > 0 then
        if newSetting > modSetting.slider.max then
          newSetting = modSetting.slider.min
        end
      elseif value < 0 then
        if newSetting < modSetting.slider.min then
          newSetting = modSetting.slider.max
        end
      end
      --newSetting=TppMath.Clamp(newSetting,modSetting.slider.min,modSetting.slider.max)
    end
    if IsFunc(modSetting.onChange) then
      modSetting.onChange()
    end
  end
  --TppUiCommand.AnnounceLogView("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
  return newSetting
end
function this.SetCurrent()
  this.SetSetting(this.currentMenuOptions[this.currentOption],this.currentSetting)
end
function this.SetSetting(modSetting,value)
  if modSetting.gvarName~=nil then
    local gvar=gvars[modSetting.gvarName]
    if gvar ~= nil then
      gvars[modSetting.gvarName]=value
      if IsFunc(modSetting.onChange) then
        modSetting.onChange()
      end
    end
  end
end
function this.NextSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.options~=nil then--tex menu
    this.GoMenu(modSetting)
  else
    this.currentSetting=this.ChangeSetting(modSetting,modSetting.slider.increment,incrementMult)
  end
end
function this.PreviousSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  this.currentSetting=this.ChangeSetting(modSetting,-modSetting.slider.increment,incrementMult)
end

function this.GoMenu(menu)
  menu.parent=this.currentMenu
  this.previousMenuOption=this.currentOption
  this.currentMenu=menu
  this.currentMenuOptions=menu.options
  this.currentOption=1
  this.GetSetting()
  if menu.name and this.menuOn then
    this.AnnounceLogLangId(menu.name)
  end
  if menu.parent==nil then
    TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
  end
end
--[[function this.GoBack(menu)
  if menu.parent==nil then
    TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    return
  end
  this.GoMenu(menu.parent)
  this.currentOption=this.previousMenuOption
end--]]
function this.GoBackCurrent()
  if this.currentMenu.parent==nil then
    if this.currentMenu~=this.topMenu then
      TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    end
    return
  end
  this.GoMenu(this.currentMenu.parent)
  this.currentOption=this.previousMenuOption
end

--tex display settings
function this.DisplayCurrentSetting()
  if this.menuOn then
    this.DisplaySetting(this.currentOption)
  end
end  

local optionSeperators={
  equals=" = ",
  menu=" >>",
}
function this.DisplaySetting(optionIndex)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
  local modSetting=this.currentMenuOptions[optionIndex]
  local settingText=""
  local optionSeperator=optionSeperators.equals
  if modSetting.settingNames ~= nil then
    if this.currentSetting < 0 or this.currentSetting > #modSetting.settingNames-1 then
      settingText="CURRENTSETTING OUT OF BOUNDS"
    elseif IsTable(modSetting.settingNames) then--old style direct non localized table
      settingText=modSetting.settingNames[this.currentSetting+1]--tex lua indexed from 1, but settings from 0
    else
      settingText=this.LangTableString(modSetting.settingNames,this.currentSetting+1)--tex lua indexed from 1, but settings from 0
    end
  elseif modSetting.isFloatSetting then
    settingText=math.floor(100*this.currentSetting) .. "%"
  elseif modSetting.options~=nil then--tex menu
    settingText=""
    optionSeperator=optionSeperators.menu
  else
    settingText=tostring(this.currentSetting)
  end
  TppUiCommand.AnnounceLogDelayTime(0)
  local settingName = this.LangString(modSetting.name)
  TppUiCommand.AnnounceLogView(optionIndex..":"..settingName..optionSeperator..settingText)
end
function this.DisplaySettings()--tex display all
  for i=1,#this.currentMenuOptions do
    this.DisplaySetting(i)
  end
end
function this.AutoDisplay()
  if this.autoDisplayRate > 0 then
    if Time.GetRawElapsedTimeSinceStartUp() - this.lastDisplay > this.autoDisplayRate then
      this.DisplayCurrentSetting()
    end
  end
end
function this.DisplayHelpText()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.helpText ~= nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(modSetting.helpText)--ADDLANG:
  end
end
function this.ResetSetting()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.gvarName~=nil then
    gvars[modSetting.gvarName]=modSetting.default
    this.currentSetting=modSetting.default
    if IsFunc(modSetting.onChange) then
      modSetting.onChange()
    end
  end
end
function this.ResetSettings()
  for n,menu in ipairs(this.allMenus) do
    for m,modSetting in ipairs(menu.options) do
      if modSetting.gvarName~=nil then
        gvars[modSetting.gvarName]=modSetting.default      
        if IsFunc(modSetting.onChange) then
        modSetting.onChange()
      end
      end
    end
  end
end
function this.ResetSettingsDisplay()
  this.AnnounceLogLangId"inf_setting_defaults"--"Setting mod options to defaults..."
  for i=1,#this.currentMenuOptions do
    local modSetting=this.currentMenuOptions[i]
    if modSetting.gvarName~=nil then
      gvars[modSetting.gvarName]=modSetting.default
      this.currentSetting=modSetting.default
      this.DisplaySetting(i)
    end
  end
  this.GetSetting()
end

function this.MenuOff()
  this.menuOn=false
  this.AnnounceLogLangId"inf_menu_off"--"Menu Off"
end

--tex my own shizzy langid stuff since games is too limitied
function this.LangString(langId)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"AnnounceLogLangId langId empty"
    return ""
  end
  --[[if AssetConfiguration then  
  else
    TppUiCommand.AnnounceLogView"no AssetConfiguration"
  end--]]
  local languageCode=GetAssetConfig"Language"
  if InfLang[languageCode]==nil then
    --TppUiCommand.AnnounceLogView("no lang in inflang")
    languageCode="eng"
  end
  local langString=InfLang[languageCode][langId]
  if (langString==nil or langString=="") and languageCode~="eng" then
    --TppUiCommand.AnnounceLogView("no langstring for " .. languageCode)
    langString=InfLang.eng[langId]
  end
  
  if langString==nil or langString=="" then
    --TppUiCommand.AnnounceLogView"AnnounceLogLangId langString empty"
    return langId
  end

  return langString
end

function this.LangTableString(langId,index)--remember lua tables from 1
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"AnnounceLogLangId langId empty"
    return ""
  end
  local languageCode=GetAssetConfig"Language"
  if InfLang[languageCode]==nil then
    --TppUiCommand.AnnounceLogView("no lang in inflang")
    languageCode="eng"
  end
  local langTable=InfLang[languageCode][langId]
  if (langTable==nil or langTable=="" or not IsTable(langTable)) and languageCode~="eng" then
    --TppUiCommand.AnnounceLogView("no langTable for " .. languageCode)
    langTable=InfLang.eng[langId]
  end
  
  if langTable==nil or langTable=="" or not IsTable(langTable) then
    --TppUiCommand.AnnounceLogView"AnnounceLogLangId langTable empty"
    return langId .. ":" .. index
  end
  
  if index < 1 or index > #langTable then
    --TppUiCommand.AnnounceLogView("LangTableString - index for " .. langId " out of bounds")
    return langId .. " OUTOFBOUNDS:" .. index
  end

  return langTable[index]
end

function this.AnnounceLogLangId(langId)
   TppUiCommand.AnnounceLogView(this.LangString(langId))
end

function this.Update()
  --local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
  --SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
  this.ModStart()--tex: TODO: move to actual run once on startup init thing, make sure to check ModStart itself to see affected code
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end
  InfButton.UpdateHeld()
  if not mvars.mis_missionStateIsNotInGame then--tex actually loaded game, ie at least 'continued' from title screen
    if TppMission.IsHelicopterSpace(vars.missionCode)then
      if this.topMenu~=this.heliSpaceMenu then
        this.topMenu=this.heliSpaceMenu
        this.GoMenu(this.topMenu)
      end
    else--!ishelispace
      if this.topMenu~=this.inMissionMenu then
        this.topMenu=this.inMissionMenu
        this.GoMenu(this.topMenu)
      end
    --[[if InfMain.DEBUGMODE then
        if InfButton.OnButtonDown(PlayerPad.LIGHT_SWITCH) then
          TppUiCommand.AnnounceLogView("")
        end
      end--]]
    end--game space check
    
    --tex RETRY: still not happy, want to read menu status but cant find a way
    if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
      this.menuOn = not this.menuOn
      if this.menuOn then
        this.GetSetting()
        TppUiCommand.AnnounceLogView(InfMain.modName.." "..InfMain.modVersion.." ".. this.LangString"inf_menu_open_help")--(Press Up/Down,Left/Right to navigate menu)
        --CULL: TppUiCommand.AnnounceLogViewJoinLangId("inf_modname_version_help", "inf_menu_open_help", InfMain.modVersion)--"Infinite Heaven r%d %s" --"(Press Up/Down,Left/Right to navigate menu)"
        --TppUiCommand.AnnounceLogViewLangId("inf_modname_version_help",InfMain.modVersion,"inf_menu_open_help")--RETAILBUG: or rather, poor implementation, AnnounceLogViewLangId will only accept the string, number, or number, number as it's paramaters, other combinations lock the game up. Evidence from other localization strings in lng2 files suggest other functions are less restricted.
      else
        this.MenuOff()
      end
    end--togglemenu
    
    if this.menuOn then
      if InfButton.OnButtonDown(PlayerPad.MB_DEVICE) then
        this.MenuOff()
      end
      
      if InfButton.OnButtonDown(this.toggleMenuButton) then
        this.SetCurrent()
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(PlayerPad.UP) then
        this.PreviousOption()
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(PlayerPad.DOWN) then
        this.NextOption()
        this.DisplayCurrentSetting()
      end
      
      InfButton.ButtonRepeatReset(this.menuRightButton)
      if InfButton.OnButtonDown(this.menuRightButton) then
        this.NextSetting()
        this.DisplayCurrentSetting()
      elseif InfButton.OnButtonUp(this.menuRightButton) then
        this.autoDisplayRate=this.autoDisplayDefault
      elseif InfButton.OnButtonRepeat(this.menuRightButton) then
        this.autoDisplayRate=this.autoRateHeld
        this.NextSetting(InfButton.GetRepeatMult())
      end

      InfButton.ButtonRepeatReset(this.menuLeftButton)
      if InfButton.OnButtonDown(this.menuLeftButton) then
        this.PreviousSetting()
        this.DisplayCurrentSetting()
      elseif InfButton.OnButtonUp(this.menuLeftButton) then
        this.autoDisplayRate=this.autoDisplayDefault
      elseif InfButton.OnButtonRepeat(this.menuLeftButton) then
        this.autoDisplayRate=this.autoRateHeld
        this.PreviousSetting(InfButton.GetRepeatMult())
      end

      if InfButton.OnButtonDown(this.resetSettingButton) then
        this.ResetSetting()
        this.AnnounceLogLangId"inf_setting_default"--"Setting to default.."
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(this.menuBackButton) then
        this.GoBackCurrent()
      end
      
      this.AutoDisplay()
    end--!menuOn
  else--!ingame
    this.menuOn = false
  end
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
  --local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
  --SplashScreen.Show(debugSplash,0,0.3,0)--tex dog
end
function this.ModStart()--tex currently called from UpdateModMenu, RETRY: find an actual place for on start/run once init.
  gvars.isManualHard = false--tex PATCHUP: not currently exposed to mod menu, force off to patch those that might have saves from prior mod with it on
  InfButton.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime--tex set up hold buttons
  InfButton.buttonStates[this.menuRightButton].decrement=0.1
  InfButton.buttonStates[this.menuLeftButton].decrement=0.1
end
function this.ModWelcome()
  TppUiCommand.AnnounceLogView(InfMain.modName .. " r" .. InfMain.modVersion)--ADDLANG:
  TppUiCommand.AnnounceLogView("Hold X key or Dpad Right for 1 second to enable menu")--ADDLANG:
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--ADDLANG
end

return this
