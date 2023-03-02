-- InfQuestIvars.lua
local this={}

this.registerIvars={
  "quest_forceOpen",
  "quest_forceRepop",
  "quest_forceQuestNumber",
  "quest_updateRepopMode",
  "quest_selectForArea",
  "quest_addonsCountForCompletion",
  "quest_useAltForceFulton",
  "quest_setIsOnceToRepop",
}

local function RerollQuestSelection()
  InfQuest.RerollQuestSelection()
end

this.quest_forceOpen={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=RerollQuestSelection,
}
this.quest_forceRepop={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=RerollQuestSelection,
}

this.quest_updateRepopMode={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={
    "NONE_LEFT",
    "ALLWAYS",
  },
  settingNames="quest_updateRepopModeSettingNames",
  OnChange=RerollQuestSelection,
}

this.quest_setIsOnceToRepop={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    InfQuest.SetIsOnceOff(setting==1)
    InfQuest.RerollQuestSelection()
  end,
}

this.quest_useAltForceFulton={--DEBUGNOW
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--tex works off questInfoTable so it's only player playable quests.
--but ignores Open, and any other selection criteria
--See InfQuest.GetForced < TppQuest.UpdateActiveQuest
this.quest_forceQuestNumber={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=157},--DYNAMIC, DEBUGNOW: AutoDoc won't pull an accurate count, also this wont update till actually selected meaning profile wont be able to set to new sideops.
  GetSettingText=function(self,setting)
    local questName=TppQuest.QUESTTABLE_INDEX[setting] or "OFF"
    return questName
  end,
--  SkipValues=function(self,newSetting)
--    local questName=TppQuest.QUESTTABLE_INDEX[newSetting]
--    --InfCore.DebugPrint(questName)--DEBUG
--    return InfQuest.BlockQuest(questName)
--  end,
  OnSelect=function(self,setting)
    --range 0==OFF - #questInfoTable
    local indexFrom1=true
    IvarProc.SetMaxToList(self,TppQuest.GetQuestInfoTable(),indexFrom1)
  end,
  OnChange=RerollQuestSelection,
}--quest_forceQuestNumber

--tex create sideOpsCategoryMenu / quest category selection ivars see UpdateActiveQuest  
this.categoryIvarPrefix="quest_categorySelection_"
for i,categoryName in ipairs(TppQuest.QUEST_CATEGORIES)do
  local ivarName=this.categoryIvarPrefix..categoryName
  local ivar={
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={"ALL","NONE","ADDON_ONLY"},
    settingNames="quest_categorySelectionSettingNames",
    categoryName=categoryName,
    OnChange=RerollQuestSelection,
  }
  this[ivarName]=ivar
  this.registerIvars[#this.registerIvars+1]=ivarName
end

this.quest_selectForArea={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={
    "FIRST_FOUND",
    "RANDOM",
    "RANDOM_ADDON",
  },
  settingNames="quest_selectForAreaSettingNames",
  OnChange=RerollQuestSelection,
}

--quest_showOnUi
this.showOnUiFlags={
  "Active",--tex cant imagine why you would not want to show active, but here for completion
  "Cleared",
  "Uncleared",
  "Activable",
  --"Addon",
  --"Repop",--tex OFF not interesting in of itself, Activable is better
  --category stuff is better in actual quest_categorySelection than just in the ui
  "Open",
}--showOnUiFlags

--tex generate showOnUiMenu / show on ui flags ivars see TppQuest.GetSideOpsListTable 
this.showOnUiIvarPrefix="quest_showOnUi_"
for i,name in ipairs(this.showOnUiFlags)do
  local ivarName=this.showOnUiIvarPrefix..name
  local ivar={
    save=IvarProc.CATEGORY_EXTERNAL,
    --DEBUGNOW
    --settings={"Hide","Show"},
    --settingNames="quest_showOnUiFlagSettingNames",
    range=Ivars.switchRange,
    settingNames="set_switch",
    flagName=name,
    --tex OnChange=RerollQuestSelection--OFF doesnt change quest selection, ui updates when idroid opened
  }
  this[ivarName]=ivar
  this.registerIvars[#this.registerIvars+1]=ivarName
end--for showOnUiFlags

--tex vanilla defaults
this.quest_showOnUi_Active.default=1
this.quest_showOnUi_Cleared.default=1

this.quest_addonsCountForCompletion={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function()
    TppMission.SetPlayRecordClearInfo()
    --DEBIGNOW
    --    local clearCount,allCount=TppQuest.CalcQuestClearedCount()
    --    TppUiCommand.SetPlayRecordClearInfo{recordId="SideOpsClear",clearCount=clearCount,allCount=allCount}
  end,
}

this.quest_useAltForceFulton={--DEBUGNOW
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--< ivar defs

this.registerMenus={
  "sideOpsMenu",
  "sideOpsCategoryMenu",
  "showOnUiMenu",
  "debugQuestsMenu",
}

this.sideOpsMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "InfQuest.RerollQuestSelection",
    "Ivars.quest_forceQuestNumber",
    "Ivars.quest_setIsOnceToRepop",
    "Ivars.quest_selectForArea",
    "Ivars.quest_updateRepopMode",
    "InfQuestIvars.sideOpsCategoryMenu",
    "InfQuestIvars.showOnUiMenu",
    "Ivars.enableHeliReinforce",
    "Ivars.quest_addonsCountForCompletion",
    "Ivars.quest_enableShootingPracticeRetry",
    "Ivars.quest_setShootingPracticeCautionTimeToBestTime",
    --"Ivars.quest_setShootingPracticeTimeLimitToBestTime",--OFF UpdateShootingPracticeClearTime not working out
  }
}--sideOpsMenu

this.debugQuestsMenu={
  parentRefs={"InfMenuDefs.debugMenu"},
  options={
    "Ivars.quest_forceOpen",
    "Ivars.quest_forceRepop",
    "InfQuest.PrintCurrentFlags",
  }
}--debugQuestsMenu

--GENERATED
this.sideOpsCategoryMenu={
  options={
  }
}

function this.GenerateMenus()
  if not TppQuest then
    return
  end

  this.sideOpsCategoryMenu={
    options={
    }
  }

  for i,categoryName in ipairs(TppQuest.QUEST_CATEGORIES)do
    local ivarName=this.categoryIvarPrefix..categoryName
    table.insert(this.sideOpsCategoryMenu.options,"Ivars."..ivarName)
  end
  --
  this.showOnUiMenu={
    options={
    }
  }

  for i,name in ipairs(this.showOnUiFlags)do
    local ivarName=this.showOnUiIvarPrefix..name
    table.insert(this.showOnUiMenu.options,"Ivars."..ivarName)
  end
  
end--GenerateMenus
--<
--IN: showOnUi Ivars
function this.GetShowOnUiSettings()
  local showOnUiSettings={}
  for i,name in ipairs(this.showOnUiFlags)do
    local ivarName=this.showOnUiIvarPrefix..name
    local ivar=Ivars[ivarName]
    showOnUiSettings[name]=ivar:Get()==1
  end--for showOnUiFlags
  if this.debugModule then
    InfCore.PrintInspect(showOnUiSettings,"InfQuestIvars.GetShowOnUiSettings")
  end
  return showOnUiSettings
end--GetShowOnUiSettings

this.langStrings={
  eng={
    sideOpsMenu="Side ops menu",
    quest_forceOpen="Force Open",
    quest_forceRepop="Force Repop",
    quest_updateRepopMode="Repop mode",
    quest_updateRepopModeSettingNames={
      "On none left",
      "Allways",
    },
    quest_setIsOnceToRepop="Repop one-time sideops",
    quest_forceQuestNumber="Force specific sideop #",
    sideOpsCategoryMenu="Sideops category selection menu",
    quest_categorySelection_STORY="Story/unique",
    quest_categorySelection_EXTRACT_INTERPRETER="Extract interpreter",
    quest_categorySelection_BLUEPRINT="Secure blueprint",
    quest_categorySelection_EXTRACT_HIGHLY_SKILLED="Extract highly-skilled soldier",
    quest_categorySelection_PRISONER="Prisoner extraction",
    quest_categorySelection_CAPTURE_ANIMAL="Capture animals",
    quest_categorySelection_WANDERING_SOLDIER="Extract wandering Mother Base soldier",
    quest_categorySelection_DDOG_PRISONER="Unlucky Dog",
    quest_categorySelection_ELIMINATE_HEAVY_INFANTRY="Eliminate heavy infantry",
    quest_categorySelection_MINE_CLEARING="Mine clearing",
    quest_categorySelection_ELIMINATE_ARMOR_VEHICLE="Eliminate the armored vehicle unit",
    quest_categorySelection_EXTRACT_GUNSMITH="Extract the Legendary Gunsmith",
    quest_categorySelection_ELIMINATE_TANK_UNIT="Eliminate tank unit",
    quest_categorySelection_ELIMINATE_PUPPETS="Eliminate wandering puppets",
    quest_categorySelection_TARGET_PRACTICE="Target practice",
    quest_categorySelectionSettingNames={
      "All",
      "None",
      "Addon only"
    },
    quest_selectForArea="Selection for Area mode",
    quest_selectForAreaSettingNames={
      "First found (default)",
      "Random",
      "Random Addon",
    },
    quest_addonsCountForCompletion="Include add-on sideops in completion percentage",
    rerollQuestSelection="Reroll sideops selection",
    showOnUiMenu="Show on UI menu",
    quest_showOnUi_Active="Active",
    quest_showOnUi_Cleared="Cleared",
    quest_showOnUi_Uncleared="Uncleared",
    quest_showOnUi_Activable="Activable",
    quest_showOnUi_Open="Open",
    forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
  },
  help={
    eng={
      rerollQuestSelection="Note: You may not see any change unless you use 'Selection for Area mode' set to Random. Many of the other IH sideop options allready run this after you change them.",
      quest_forceQuestNumber="WARNING: This allows opening a sideop outside of normal progression. Unlocks the sideop with the quest number that shows in the UI. Since the sideops shown in the UI are limited, try 'Show on UI mode' and other filtering settings to show other sideops.",
      quest_forceOpen="Lets you force sideops open sideops before the usual progression.",
      quest_forceRepop="Lets you force story and one-time sideops to be replayable.",
      quest_updateRepopMode=[[Lets you choose the behaviour of how repeatable sideops are repopulated. The update is run for the sideop area of a sideop you just finished, or for all areas when changing many of the IH sideops options or rerolling sideops.
The default 'None left' will only repopulate sideops when there are no other uncompleted sideops, and all other repeatable sideops have been completed.
'Allways' will refresh repeatable sideops every time the update is called.
Best use with Select for Area mode set to Random.]],
      quest_setIsOnceToRepop="Lets you force story and one-time sideops to be replayable.",
      quest_selectForArea=[[Sideops are broken into areas to stop overlap, this option lets you control the choice which repop sideop will be selected to be Active for the area.
'Random Addon' will prioritize Addon sideops first. 
All selection is still prioritized by uncompleted story sideops, then other uncompleted sideops, then repop sideops selected by this option.]],
      sideOpsCategoryMenu="Per category selection of which sidops can be Active.",
      showOnUiMenu=[[Settings for what sideops to show on the idroid sideops list.
The vanilla behavior just shows current Active and Cleared sideops, which lets you see past progression/completion,
Though since uncleared sideops do have priority, one will be selected for Active.
So if there's multiple uncleared for an area they will not be shown, which gives you less of an idea of future progression.
These option give you individual control for showing sideops depending on their conditions.
For a given sideop multiple of the underlying conditions may be true at one time and either depend on your progress through the game, or from other IH settings.
There is however a limit of 192 entries for the sideop list (there's 157 sideops in the base game), which some settings might push over if you have addon sideops, in which case some Cleared entries be randomly dropped from the list.
See the notes for each option for more info.]],
      quest_showOnUi_Active="Default is Show. Sideops that are Active are the ones actually currently in play and start when you arrive in the sideop area. Independent of Cleared. You normally wouldn't set this setting to Hide.",
      quest_showOnUi_Cleared="Default is Show. Quests that have been completed.",
      quest_showOnUi_Uncleared="Quests that have not been completed.",
      quest_showOnUi_Activable="Only shows those sideops in the selection for being Activated (which includes Active). Usually the best setting to show what sideops are being considered depending on all the underlying conditions and IH settings.",
      quest_showOnUi_Open="Will try and show all Open sideops, which is usually every sideop as soon as they are introduced through game progression. Most likely to hit the UI limit entries when a lot of addon sideops are installed.",
      debugQuestsMenu="WARNING: don't use these unless you know exactly what they do.",
    },
  }
}--langStrings

return this
