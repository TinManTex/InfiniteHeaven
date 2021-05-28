-- InfQuestIvars.lua
local this={}

this.registerIvars={
  "unlockSideOps",
  "unlockSideOpNumber",
  "sideOpsSelectionMode",
  "showAllOpenSideopsOnUi",
  "ihSideopsPercentageCount",
  "quest_useAltForceFulton",
}

local function UpdateActiveQuest()
  InfQuest.UpdateActiveQuest()
end

this.unlockSideOps={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"OFF","REPOP","OPEN"},
  OnChange=UpdateActiveQuest,
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

local ivarPrefix="sideops_"
--SYNC TppQuest. TODO: don't like this
this.QUEST_CATEGORIES={
  "STORY",--11,7,2,2
  "EXTRACT_INTERPRETER",--4,2,2
  "BLUEPRINT",--6,4,2,Secure blueprint
  "EXTRACT_HIGHLY_SKILLED",--16,9,,Extract highly-skilled soldier
  "PRISONER",--20,10,Prisoner extraction
  "CAPTURE_ANIMAL",--4,2,
  "WANDERING_SOLDIER",--10,5,Wandering Mother Base soldier
  "DDOG_PRISONER",--5,Unlucky Dog
  "ELIMINATE_HEAVY_INFANTRY",--16
  "MINE_CLEARING",--10
  "ELIMINATE_ARMOR_VEHICLE",--14,Eliminate the armored vehicle unit
  "EXTRACT_GUNSMITH",--3,Extract the Legendary Gunsmith
  --"EXTRACT_CONTAINERS",--1, #110
  --"INTEL_AGENT_EXTRACTION",--1, #112
  "ELIMINATE_TANK_UNIT",--14
  "ELIMINATE_PUPPETS",--15
  "TARGET_PRACTICE",--7,0,0,7
}
for i,categoryName in ipairs(this.QUEST_CATEGORIES)do
  local ivarName=ivarPrefix..categoryName
  local ivar={
    save=IvarProc.CATEGORY_EXTERNAL,
    default=1,
    range=Ivars.switchRange,
    settingNames="set_switch",
    OnChange=UpdateActiveQuest,
  }
  this[ivarName]=ivar
  this.registerIvars[#this.registerIvars+1]=ivarName
end

this.sideOpsSelectionMode={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={
    "OFF",
    "RANDOM",
    "STORY",
    "EXTRACT_INTERPRETER",
    "BLUEPRINT",
    "EXTRACT_HIGHLY_SKILLED",
    "PRISONER",
    "CAPTURE_ANIMAL",
    "WANDERING_SOLDIER",
    "DDOG_PRISONER",
    "ELIMINATE_HEAVY_INFANTRY",
    "MINE_CLEARING",
    "ELIMINATE_ARMOR_VEHICLE",
    "EXTRACT_GUNSMITH",
    --"EXTRACT_CONTAINERS",
    --"INTEL_AGENT_EXTRACTION",
    "ELIMINATE_TANK_UNIT",
    "ELIMINATE_PUPPETS",
    --"TARGET_PRACTICE",
    "ADDON_QUEST",
  },
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
    "Ivars.unlockSideOps",
    "Ivars.sideOpsSelectionMode",
    "InfQuestIvars.sideOpsCategoryMenu",
    "Ivars.showAllOpenSideopsOnUi",
    "Ivars.enableHeliReinforce",
    "Ivars.ihSideopsPercentageCount",
  }
}

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

  local ivarPrefix="sideops_"
  for i,categoryName in ipairs(TppQuest.QUEST_CATEGORIES)do
    if categoryName~="ADDON_QUEST" then--tex only for selection ivar currently
      local ivarName=ivarPrefix..categoryName
      table.insert(this.sideOpsCategoryMenu.options,"Ivars."..ivarName)
    end
  end
end
--<
this.langStrings={
  eng={
    sideOpsMenu="Side ops menu",
    unlockSideOps="Unlock Sideops mode",
    unlockSideOpsSettings={"Off","Force Replayable","Force Open"},
    unlockSideOpNumber="Open specific sideop #",
    sideOpsCategoryMenu="Sideops category filter menu",
    sideops_STORY="Story/unique",
    sideops_EXTRACT_INTERPRETER="Extract interpreter",
    sideops_BLUEPRINT="Secure blueprint",
    sideops_EXTRACT_HIGHLY_SKILLED="Extract highly-skilled soldier",
    sideops_PRISONER="Prisoner extraction",
    sideops_CAPTURE_ANIMAL="Capture animals",
    sideops_WANDERING_SOLDIER="Extract wandering Mother Base soldier",
    sideops_DDOG_PRISONER="Unlucky Dog",
    sideops_ELIMINATE_HEAVY_INFANTRY="Eliminate heavy infantry",
    sideops_MINE_CLEARING="Mine clearing",
    sideops_ELIMINATE_ARMOR_VEHICLE="Eliminate the armored vehicle unit",
    sideops_EXTRACT_GUNSMITH="Extract the Legendary Gunsmith",
    sideops_ELIMINATE_TANK_UNIT="Eliminate tank unit",
    sideops_ELIMINATE_PUPPETS="Eliminate wandering puppets",
    sideops_TARGET_PRACTICE="Target practice",
    sideOpsSelectionMode="Sideop selection mode",
    sideOpsSelectionModeSettings={
      "Default (first found)",
      "Random",
      "Story/unique",
      "Extract interpreter",
      "Secure blueprint",
      "Extract highly-skilled soldier",
      "Prisoner extraction",
      "Capture animals",
      "Extract wandering Mother Base soldier",
      "Unlucky Dog",
      "Eliminate heavy infantry",
      "Mine clearing",
      "Eliminate armored vehicle unit",
      "Extract legendary gunsmith",
      "Eliminate tank unit",
      "Eliminate wandering puppets",
      --"TARGET_PRACTICE",
      "Addon sideop",
    },
    ihSideopsPercentageCount="Include add-on sideops in completion percentage",
    rerollQuestSelection="Reroll sideops selection",
    showAllOpenSideopsOnUi="Show all open sideops",
    forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
    quest_no_best_time="No best time set",
    quest_best_time="Best time",
  },
  help={
    eng={
      unlockSideOps="Lets you force story and one-time sideops to be replayable, and open sideops before the usual progression.",
      sideOpsSelectionMode="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area. Random - picks a random sideop for the sideop area, the other modes choose a random sideop of the specic sideop category. Also see the Sideops category filter menu.",
      sideOpsCategoryMenu="Filters selection of sideops per category, Sideop selection mode will override this.",
      showAllOpenSideopsOnUi="Shows all open sideops in sideop list, this mostly affects open but not yet completed sideops from hiding others. There is however a limit of 192 entries for the sideop list, so some will be randomly dropped from the list.",
    },
  }
}

return this
