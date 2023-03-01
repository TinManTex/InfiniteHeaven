-- InfQuestIvars.lua
local this={}

this.registerIvars={
  "quest_forceOpen",
  "quest_forceRepop",
  "quest_forceQuestNumber",
  "quest_updateRepopMode",
  "quest_selectForArea",
  "quest_showOnUiMode",
  "quest_addonsCountForCompletion",
  "quest_useAltForceFulton",
  "quest_setIsOnceToRepop",
}

local function UpdateActiveQuest()
  InfQuest.UpdateActiveQuest()
end

this.quest_forceOpen={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=UpdateActiveQuest,
}
this.quest_forceRepop={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=UpdateActiveQuest,
}

this.quest_updateRepopMode={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={
    "NONE_LEFT",
    "ALLWAYS",
  },
  settingNames="quest_updateRepopModeSettingNames",
  OnChange=UpdateActiveQuest,
}

this.quest_setIsOnceToRepop={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    InfQuest.SetIsOnceOff(setting==1)
    InfQuest.UpdateActiveQuest()
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
  OnChange=UpdateActiveQuest,
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
    OnChange=UpdateActiveQuest,
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
  OnChange=UpdateActiveQuest,
}

this.quest_showOnUiMode={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={
    "ONLY_ACTIVE_OR_CLEARED",--DEFAULT
    "ONLY_ACTIVE",
    "ALL_ACTIVABLE",
    "ALL_OPEN",
  },
  settingNames="quest_showOnUiModeSettingNames",
  OnChange=UpdateActiveQuest,
}

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
    "Ivars.quest_showOnUiMode",
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
end--GenerateMenus
--<
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
    quest_showOnUiMode="Show on UI mode",
    quest_showOnUiModeSettingNames={
      "Only Active or Cleared (Default)",
      "Only Active",
      "All Activable",
      "All Open",
    },
    forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
  },
  help={
    eng={
      quest_forceQuestNumber="WARNING: This allows opening a sideop outside of normal progression. Unlocks the sideop with the quest number that shows in the UI. Since the sideops shown in the UI are limited, try 'Show on UI mode' and other filtering settings to show other sideops.",
      quest_forceOpen="Lets you force sideops open sideops before the usual progression.",
      quest_forceRepop="Lets you force story and one-time sideops to be replayable.",
      quest_updateRepopMode=[[Lets you choose the behaviour of how repeatable sideops are repopulated. The update is run for the sideop area of a quest you just finished, or for all areas when changing many of the IH sideops options or rerolling sideops.
The default 'None left' will only repopulate sideops when there are no other uncompleted sideops, and all other repeatable sideops have been completed.
'Allways' will refresh repeatable quests every time the update is called.
Best use with Select for Area mode set to Random.]],
      quest_setIsOnceToRepop="Lets you force story and one-time sideops to be replayable.",
      quest_selectForArea=[[Sideops are broken into areas to stop overlap, this option lets you control the choice which repop sideop will be selected to be Active for the area.
'Random Addon' will prioritize Addon sideops first. 
All selection is still prioritized by uncompleted story sideops, then other uncompleted sideops, then repop sideops selected by this option.]],
      sideOpsCategoryMenu="Per category selection of which sidops can be Active.",
      quest_showOnUiMode=[[Chooses what sideops are shown on the idroid UI.
"Only Active or Cleared (Default)" - the default behavior. Note it doesn't include all uncleared, so if there's multiple Uncleared but not Active sideops they won't show.
"Only Active" - only the current Active sideops, no Cleared sideops.
"All Activable" - Only shows those sideops in the selection for being Activated (which includes Active).
"All Open" - Will try and show all Open sideops, which is usually every sideop as soon as they are introduced through game progression.
There is however a limit of 192 entries for the sideop list (there's 157 sideops in the base game), which some settings might push over if you have addon sideops, in which case some Cleared entries be randomly dropped from the list.]],
      debugQuestsMenu="WARNING: don't use these unless you know exactly what they do.",
    },
  }
}--langStrings

return this
