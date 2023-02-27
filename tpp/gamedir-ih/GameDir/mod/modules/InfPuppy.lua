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
--  OnChange=function(self,setting)
--tex DEBUGNOW CULL dont mess with puppy quest DEBUGNOW figure out how to fix the flags if using this has messed with them DEBUGNOW see if DdogGoWithMe and other demos still work and show puppy (dont know how they enable Mtbs_child_dog
--    local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog 
--    if setting==0 then
--      gvars.qst_questRepopFlag[puppyQuestIndex]=false
--      gvars.qst_questOpenFlag[puppyQuestIndex]=false
--    else
--      local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
--      gvars.qst_questRepopFlag[puppyQuestIndex]=true
--      gvars.qst_questOpenFlag[puppyQuestIndex]=true
--    end
--    TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])--MtbsCommand
--    TppQuest.UpdateActiveQuest()
--  end,
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
      mbEnablePuppy="Note: Requires you to actually get and complete the base game ddog puppy sequence.",
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
  
  --tex base game ddog pup is handled by quest system
  if not TppQuest.IsCleard"Mtbs_child_dog" then
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
  
  --tex base game ddog pup is handled by quest system
  if not TppQuest.IsCleard"Mtbs_child_dog" then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

return this
