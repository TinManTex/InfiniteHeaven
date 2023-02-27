-- InfQuestIvars.lua
local this={}

this.registerIvars={
  "quest_forceOpen",
  "quest_forceRepop",
  "unlockSideOpNumber",
  "quest_selectForArea",
  "showAllOpenSideopsOnUi",
  "ihSideopsPercentageCount",
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

this.unlockSideOpNumber={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=157},--DYNAMIC, DEBUGNOW: AutoDoc won't pull an accurate count, also this wont update till actually selected meaning profile wont be able to set to new sideops.
  GetSettingText=function(self,setting)
    local questName=TppQuest.QUESTTABLE_INDEX[setting] or "OFF"
    return questName
  end,
  SkipValues=function(self,newSetting)
    local questName=TppQuest.QUESTTABLE_INDEX[newSetting]
    --InfCore.DebugPrint(questName)--DEBUG
    return InfQuest.BlockQuest(questName)
  end,
  OnSelect=function(self,setting)
    --range 0==OFF - #questInfoTable
    local indexFrom1=true
    IvarProc.SetMaxToList(self,TppQuest.GetQuestInfoTable(),indexFrom1)
  end,
  OnChange=UpdateActiveQuest,
}--unlockSideOpNumber

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

this.showAllOpenSideopsOnUi={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.ihSideopsPercentageCount={
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
}

this.sideOpsMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "InfQuest.RerollQuestSelection",
    "Ivars.unlockSideOpNumber",
    "Ivars.quest_forceOpen",
    "Ivars.quest_forceRepop",
    "Ivars.quest_setIsOnceToRepop",
    "Ivars.quest_selectForArea",
    "InfQuestIvars.sideOpsCategoryMenu",
    "Ivars.showAllOpenSideopsOnUi",
    "Ivars.enableHeliReinforce",
    "Ivars.ihSideopsPercentageCount",
    "Ivars.quest_enableShootingPracticeRetry",
    "Ivars.quest_setShootingPracticeCautionTimeToBestTime",
    --"Ivars.quest_setShootingPracticeTimeLimitToBestTime",--OFF UpdateShootingPracticeClearTime not working out
  }
}--sideOpsMenu

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
    quest_setIsOnceToRepop="Repop one-time sideops",
    unlockSideOpNumber="Open specific sideop #",
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
    ihSideopsPercentageCount="Include add-on sideops in completion percentage",
    rerollQuestSelection="Reroll sideops selection",
    showAllOpenSideopsOnUi="Show all open sideops",
    forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
  },
  help={
    eng={
      unlockSideOpNumber="WARNING: This can override important story or hidden progression sideops.",
      quest_forceOpen="Lets you force sideops open sideops before the usual progression.",
      quest_forceRepop="Lets you force story and one-time sideops to be replayable.",
      quest_setIsOnceToRepop="Lets you force story and one-time sideops to be replayable.",
      quest_selectForArea="Sideops are broken into areas to stop overlap, this setting lets you control the choice which sideop will be selected to be Active for the area. 'Random Addon' will prioritize Addon sideops first. All selection is still prioritized by uncompleted story sideops, then other uncompleted sideops, then repeat sideops.",
      sideOpsCategoryMenu="Per category selection of which sidops can be Active.",
      showAllOpenSideopsOnUi="Shows all open sideops in sideop list, this mostly affects open but not yet completed sideops from hiding others. There is however a limit of 192 entries for the sideop list, so some will be randomly dropped from the list.",
    },
  }
}--langStrings

return this
