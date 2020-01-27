--InfSsdDebugStuff.lua --DEBUGNOW
local this={}

local tryEquipTypes={OneHandSwing=true,TwoHandSwing=true}
local countForType={OneHandSwing=1,TwoHandSwing=1,TwoHandHeavy=1,Thrust=1,Bow=1,Arrow=100,Gun=1,Item=4}
local prodInfo={id="PRD_*",tryEquip=true}
function this.DEBUG_ProductAndEquipWithTable(products)
  local tryEquipTypeToggle=false
  for productType,id in pairs(products)do
    prodInfo.id=id
    prodInfo.count=countForType[productType]or 1
    if productType=="Item"then
      prodInfo.toInventory=true
    else
      prodInfo.toInventory=nil
    end
    if tryEquipTypes[productType]then
      if tryEquipTypeToggle then
        prodInfo.tryEquip=nil
        prodInfo.tryEquip2=true
      else
        prodInfo.tryEquip=true
        prodInfo.tryEquip2=nil
      end
      tryEquipTypeToggle=not tryEquipTypeToggle
    else
      prodInfo.tryEquip=true
      prodInfo.tryEquip2=nil
    end
    SsdSbm.AddProduction(prodInfo)
  end
end
function this.DEBUG_GetSkills(skills)
  for a,skillLevel in pairs(skills)do
    if Tpp.IsTypeTable(skillLevel)then
      SsdSbm.SetSkillLevel(skillLevel)
    end
  end
end
local resInfo={id="RES_*",count=1}
function this.DEBUG_GetResource(resources)
  for id,count in pairs(resources)do
    resInfo.id=id
    resInfo.count=count
    SsdSbm.AddResource(resInfo)
  end
end

function this.QARELEASE_DEBUG_AddProductForPacing()
  gvars.DEBUG_reserveAddProductForPacing=false
  local function t(e)
    return SsdStorySequenceList.DEBUG_storySequenceTable[e+1]
  end
  local n=this.GetCurrentStorySequence()
  for i=TppDefine.STORY_SEQUENCE.STORY_START,n do
    local e=t(i)
    if e then
      if e.Equip then
        TppPlayer.DEBUG_ProductAndEquipWithTable(e.Equip)
      end
      if e.Skill then
        TppPlayer.DEBUG_GetSkills(e.Skill)
      end
      if e.Resource then
        TppPlayer.DEBUG_GetResource(e.Resource)
      end
      if e.Exp then
        SsdSbm.AddExperiencePoint(e.Exp)
      end
      if e.FastTravel then
        SsdFastTravel.RegisterFastTravelPoints()
        for n,e in ipairs(e.FastTravel)do
          SsdFastTravel.UnlockFastTravelPoint(e)
          local e=SsdFastTravel.GetQuestName(e)
          if e then
            local n=TppQuest.GetQuestIndex(e)
            if n then
              TppQuest.UpdateClearFlag(n,true)
            end
            Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[e])
          end
        end
      end
      if e.overrideVarsFunction and(i==n)then
        e.overrideVarsFunction()
      end
    end
  end
  local e={"PRD_CURE_Bleeding","PRD_CURE_Sprain","PRD_CURE_Ruptura","PRD_CURE_Tiredness","PRD_CURE_Weakening","PRD_CURE_Poison_Normal","PRD_CURE_Poison_Deadly","PRD_CURE_Poison_Food","PRD_CURE_Poison_Water"}
  for n,e in ipairs(e)do
    local n=SsdSbm.GetCountProduction{id=e,inInventory=true,inWarehoud=false}
    if n<5 then
      SsdSbm.AddProduction{id=e,toInventory=true,count=(5-n)}
    end
  end
end

function this.QARELEASE_DEBUG_afterStoryPacingSetting(e)
  if not Tpp.IsTypeNumber(e)then
    return
  end
  if e<1 then
    return
  end
  for e=1,e do
    local e=SsdStorySequenceList.DEBUG_afterStoryPacingTable[e]
    if e then
      if e.Recipe and next(e.Recipe)then
        for n,e in ipairs(e.Recipe)do
          if not SsdSbm.HasRecipe(e)then
            SsdSbm.AddRecipe{id=e,count=1,toInventory=false}
          end
        end
      end
      if e.Exp then
        SsdSbm.AddExperiencePoint(e.Exp)
      end
      if e.Skill then
        TppPlayer.DEBUG_GetSkills(e.Skill)
      end
      if e.PlayerBaseLevel then
        DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelBasic",(e.PlayerBaseLevel))
      end
      if e.PlayerLevelFighter then
        DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelFighter",(e.PlayerLevelFighter))
      end
      if e.PlayerLevelShooter then
        DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelShooter",(e.PlayerLevelShooter))
      end
      if e.PlayerLevelMedic then
        DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelMedic",(e.PlayerLevelMedic))
      end
      if e.PlayerLevelScout then
        DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelScout",(e.PlayerLevelScout))
      end
      if e.UniqueCrew then
        for n,quest in ipairs(e.UniqueCrew)do
          local handle=SsdCrewSystem.RegisterTempCrew{quest=quest}
          SsdCrewSystem.EmployTempCrew{handle=handle}
        end
      end
    end
  end
end

return this
