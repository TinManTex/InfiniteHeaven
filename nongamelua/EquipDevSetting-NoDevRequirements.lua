--EquipDevSetting-NoDevRequirements.lua
--tex adaption of BobDoleOwnedUs' EquipDevelopConstSettingTool which builds for his No Development Requirements mod.

--Comments tagged BobDoleOwnedU were from discord.
--Also see the deminified version of EquipDevelopmentConstSetting for many more comments about different parameters.

--Currently has to run through mockfox, or include MockModulesGenerated,
--as TppMotherBaseManagementConst is a foxtable and MockModulesGenerated has the converted plain text, number - key, values representation.

--TODO: Should probably go over the logic one more time, and compare output to No Development Requirements mod.

local this={}

-- BobDoleOwnedU: The specialIds are things like the Raiden suit, infinity bandana, stealth camo, etc... where they're unique items; but they have a parent (p03) id. 
--The one exception is the first grade of the parasite suit is also included. It won't unlock early unless its p05 is changed to 0 as well.
local specialIds={
  [12043]=true,
  [16007]=true,
  [16008]=true,
  [19024]=true,
  [19060]=true,
  [19073]=true,
  [37002]=true,
}

--BobDoleOwnedU: The items with EXTRA in their requirement are excluded because they're DLC items and removing the requirement breaks them. 
--EXTRA_4010 is for the parasite abilities though. So it gets included.
local skipBlueprints={}
for k,v in pairs(TppMotherBaseManagementConst)do
  if k:find("EXTRA") and not k:find("EXTRA_4000") then
    skipBlueprints[v]=true
  end
end

--ASSUMPTION: passing in the deminified version of EquipDevelopmentConstSetting that does not have equipDevTable nilled
--SIDE: equipDevTable = EquipDevelopmentConstSetting.equipDevTable
--dParam = EquipDevelopmentConstSetting.descriptiveParamToParamName
function this.ModifyConstSetting(equipDevTable,dParam)
  for i,devEntry in ipairs(equipDevTable)do
    devEntry[dParam.skill]=0

    --BobDoleOwnedU: The p05=65535 items are excluded from being 0 because they don't have any blueprint requirement. 
    local bluePrintId=devEntry[dParam.bluePrintId]
    if bluePrintId~=65535 and not skipBlueprints[bluePrintId] then
      bluePrintId=0
    end

    --BobDoleOwnedU: Items that have a parent and have a 0 as their blueprint requirement break and can't be developed. So those ones have to be set to 65535 instead.
    local baseEquipDevelopId=devEntry[dParam.baseEquipDevelopId]
    if baseEquipDevelopId~=0 and bluePrintId==0 then
      bluePrintId=65535
    end

    --BobDoleOwnedUs: Then the special items all have their blueprint id set to 0, even if they have a parent. Otherwise, they don't show up for development
    local equipDevelopID=devEntry[dParam.equipDevelopID]
    if specialIds[equipDevelopID] then
      devEntry[dParam.baseEquipDevelopId]=0
    end

    devEntry[dParam.bluePrintId]=bluePrintId
  end--for equipDevTable
  return equipDevTable
end--ModifyConstSetting

--ASSUMPTION: passing in the deminified version of EquipDevelopmentFlowSetting that does not have equipDevTable nilled
--SIDE: equipDevTable = EquipDevelopmentFlowSetting.equipDevTable
--dParam = EquipDevelopmentFlowSetting.descriptiveParamToParamName
function this.ModifyFlowSetting(equipDevTable,dParam)
  for i,devEntry in ipairs(equipDevTable)do
    devEntry[dParam.developGmpCost]=0
    devEntry[dParam.usageGmpCost]=0
    --BobDoleOwnedU: Setting p55 to 0 for items where it's not 0 by default breaks the announce log and causes the game to hang post-missions
    if devEntry[dParam.sectionLvForDevelop]~=0 then
      devEntry[dParam.sectionLvForDevelop]=1
    end
    devEntry[dParam.sectionID2ForDevelop]=0
    devEntry[dParam.sectionLv2ForDevelop]=0
    
    devEntry[dParam.resourceType1]=""
    devEntry[dParam.resourceType1Count]=0
    devEntry[dParam.resourceType2]=""
    devEntry[dParam.resourceType2Count]=0
    devEntry[dParam.resourceUsageType1]=""
    devEntry[dParam.resourceUsageType1Count]=0
    devEntry[dParam.resourceUsageType2]=""
    devEntry[dParam.resourceUsageType2Count]=0
    devEntry[dParam.developTimeMinute]=0
    devEntry[dParam.intimacyPoint]=0

    --BobDoleOwnedU: Setting p72 (online flag) to 0 for online items breaks the announce log and causes the game to hang post-missions
  end--for equipDevTable
end--ModifyFlowSetting

return this
