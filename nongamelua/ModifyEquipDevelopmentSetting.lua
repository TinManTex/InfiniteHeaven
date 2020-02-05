--ModifyEquipDevelopmentSetting.lua
--tex adaption of BobDoleOwnedUs' EquipDevelopConstSettingTool which builds for his No Development Requirements mod.
--Don't know the actual logic to why stuff is skipped as there are no comments.
--Also as BobDoleOwnedUs' No Development Requirements mod includes an EquipDevelopFlowSetting, 
--but EquipDevelopConstSettingTool doesn't have any code to modify it I'd be reluctant on attempting to use this implementation.

--Currently has to run through mockfox, or include MockModulesGenerated,
--as TppMotherBaseManagementConst is a foxtable and MockModulesGenerated has the converted plain text, number - key, values representation.

local this={}

local specialIds={
  [12043]=true,
  [16007]=true,
  [16008]=true,
  [19024]=true,
  [19060]=true,
  [19073]=true,
  [37002]=true,
}

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

    local bluePrintId=devEntry[dParam.bluePrintId]
    if bluePrintId~=65535 and not skipBlueprints[bluePrintId] then
      bluePrintId=0
    end

    local baseEquipDevelopId=devEntry[dParam.baseEquipDevelopId]
    if baseEquipDevelopId~=0 and bluePrintId==0 then
      bluePrintId=65535
    end

    local equipDevelopID=devEntry[dParam.equipDevelopID]
    if specialIds[equipDevelopID] then
      devEntry[dParam.baseEquipDevelopId]=0
    end

    devEntry[dParam.bluePrintId]=bluePrintId
  end--for equipDevTable
  return equipDevTable
end--ModifyConstSetting

return this
