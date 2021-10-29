-- InfWeaponIdTable.lua
--Implements weaponIdTable addon loading
--see \mod\devmodules\weaponIdTables\example.lua
--Ivar weaponTableGlobal* in InfEquip
--Actual use/return of weaponIdTable in TppEnemy.GetWeaponIdTable which also handled mission addon overriding of weaponIdTable.

--REF IH Feature custom weapon table.txt
--TODO validate addon on load
--validate it has all the base soldiertypes

local this={}

this.debugModule=false

this.addons={}
this.addonsNames={}

this.vanillaTableNames={
  DD=true,
  SOVIET_A=true,
  SOVIET_B=true,
  PF_A=true,
  PF_B=true,
  PF_C=true,
  SKULL=true,
  CHILD=true,
}--vanillaTableNames

function this.PostAllModulesLoad()
  this.addons={}
  this.addonsNames={}
  
  this.addons.DEFAULT={
    description="Default",
    weaponIdTable=TppEnemy.weaponIdTable,--InfUtil.CopyTable(TppEnemy.weaponIdTable),--: would cause issues if reloading scripts, but refencing TppEnemy.weaponIdTable would cause issues if I replace it outright
  }

  this.LoadWeaponIdTables()
  
  table.insert(this.addonsNames, 1, "DEFAULT")
end--PostAllModulesLoad
--Loads \mod\weaponIdTables\*.lua into this.weaponIdTables
function this.LoadWeaponIdTables()
  InfCore.LogFlow("InfWeaponIdTable.LoadWeaponIdTables")
  
  local addonType="weaponIdTables"
  local loadedAddons={}
  
  local files=InfCore.GetFileList(InfCore.files[addonType],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfWeaponIdTable.LoadWeaponIdTables: "..fileName)
    local addonName=InfUtil.StripExt(fileName)
    local addon=InfCore.LoadSimpleModule(InfCore.paths[addonType],fileName)
    if not addon then
      InfCore.Log("ERROR: no addon returned for "..fileName)
    else
      addon.name=fileName
      loadedAddons[addonName]=addon
    end
  end
  
  for addonName,addon in pairs(loadedAddons)do
    --TODO: validate
    if addon.weaponIdTable==nil then
      InfCore.Log("ERROR: InfWeaponIdTable.LoadWeaponIdTables: addon "..addonName.." has no weaponIdTable")
    else
      this.addons[addonName]=addon
    end
  end
  
  for addonName,addon in pairs(this.addons)do
    if addonName=="DEFAULT" then
    else
      table.insert(this.addonsNames,addonName)
    end
  end
  table.sort(this.addonsNames)
end--LoadWeaponIdTables
--GOTCHA: called a lot so logging will spam
--CALLERS: TppEnemy.GetWeaponIdTable, InfEquip.CreateCustomWeaponTable
function this.GetWeaponIdTable()
  if not IvarProc.EnabledForMission("weaponTableGlobal",vars.missionCode) then
    return nil
  end
  local addonIndex=IvarProc.GetForMission("weaponTableGlobal",vars.missionCode)
  if addonIndex==0 then--DEBUGNOW do we need to do EnabledForMission if we're doing this?
    return nil
  end
  local addonName=this.addonsNames[addonIndex+1]
  if addonName==nil then
    InfCore.Log("WARNING: InfWeaponIdTable.GetWeaponIdTable: could not find addonName for weaponTableGlobal:"..tostring(addonIndex))
    return nil
  end 
  --DEBUGNOW cant use till settings inited local addonName=IvarProc.GetSettingNameForMission("weaponTableGlobal",vars.missionCode)
  if this.debugModule then
    InfCore.Log("InfWeaponIdTable.GetWeaponIdTable "..vars.missionCode.." addonName:"..tostring(addonName))
  end
  local addon=this.addons[addonName]
  if this.debugModule then
    InfCore.Log("addon:"..tostring(addon.description))
  end
  return addon.weaponIdTable
end

return this