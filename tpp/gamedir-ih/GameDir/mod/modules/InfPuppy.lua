--InfPuppy.lua
local this={}

--LOCALOPT
local InfMain=InfMain
local SendCommand=GameObject.SendCommand

this.active="mbEnablePuppy"

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_puppy.fpk",
}

this.registerIvars={
  "mbEnablePuppy",
}

this.mbEnablePuppy={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"OFF","MISSING_EYE","NORMAL_EYES"},
  OnChange=function(self,setting)
    local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
    if setting==0 then
      gvars.qst_questRepopFlag[puppyQuestIndex]=false
      gvars.qst_questOpenFlag[puppyQuestIndex]=false
    else
      local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
      gvars.qst_questRepopFlag[puppyQuestIndex]=true
      gvars.qst_questOpenFlag[puppyQuestIndex]=true
    end
    TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])--MtbsCommand
    TppQuest.UpdateActiveQuest()
  end,
  MissionCheck=IvarProc.MissionCheckMb,
}
--<
this.langStrings={
  eng={
    mbEnablePuppy="Puppy DDog",
    mbEnablePuppySettings={"Off","Missing eye","Normal eyes"},
  },
  help={
    eng={
      mbEnablePuppy="Note: The training side-op on the command platform will be disabled while this is active.",
    },
  }
}

function this.Init()
  if not this.active:EnabledForMission() then
    return
  end

  if InfMainTpp.IsMbEvent() then
    return
  end

  local fv2Index=Ivars.mbEnablePuppy:Is()-1
  --fv2Index = 0--missing eye
  --fv2Index = 1--normal eyes

  local gameObjectId={type="TppBuddyPuppy",index=0}
  SendCommand(gameObjectId,{id="SetFova",fv2Index=fv2Index})
  SendCommand(gameObjectId,{id="SetFultonEnabled",enabled=false})
end

function this.AddMissionPacks(missionCode,packPaths)
  if not this.active:EnabledForMission(missionCode) then
    return
  end

  if InfMainTpp.IsMbEvent(missionCode) then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

return this
