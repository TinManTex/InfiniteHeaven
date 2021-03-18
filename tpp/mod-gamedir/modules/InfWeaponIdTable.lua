-- InfWeaponIdTable.lua
--Implements weaponIdTable addon loading
--REF IH Feature custom weapon table.txt
--DEBUGNOW validate addon on load
--validate it has all the base soldiertypes

local this={}

this.debugModule=true--DEBUGNOW

this.addons={}
this.addonsNames={}

function this.PostAllModulesLoad()
  this.addons={}
  this.addonsNames={}
  
  this.addons.DEFAULT={
    description="Default",
    weaponIdTable=TppEnemy.weaponIdTable,
  }
  table.insert(this.addonsNames,"DEFAULT")

  this.LoadWeaponIdTables()
end--PostAllModulesLoad
--Loads \mod\weaponIdTables\*.lua into this.weaponIdTables
function this.LoadWeaponIdTables()
  InfCore.LogFlow("InfWeaponIdTable.LoadWeaponIdTables")
  
  local addonType="weaponIdTables"
  
  local files=InfCore.GetFileList(InfCore.files[addonType],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfWeaponIdTable.LoadWeaponIdTables: "..fileName)
    local addonName=InfUtil.StripExt(fileName)
    local addon=InfCore.LoadSimpleModule(InfCore.paths[addonType],fileName)
    if not addon then
      InfCore.Log("ERROR: no addon returned for "..fileName)
    else
      addon.name=fileName
      this.addons[addonName]=addon
    end
  end
  
  for addonName,addon in pairs(this.addons)do
    if addonName=="DEFAULT" then
    else
      table.insert(this.addonsNames,addonName)
    end
  end
end--LoadWeaponIdTables
--GOTCHA: called a lot so logging will spam
--CALLERS: TppEnemy.GetWeaponIdTable, InfEquip.CreateCustomWeaponTable
function this.GetWeaponIdTable()
  local weaponIdTable=TppEnemy.weaponIdTable
  if not IvarProc.EnabledForMission("weaponTableGlobal",vars.missionCode) then
    return weaponIdTable
  end
  local addonIndex=IvarProc.GetForMission("weaponTableGlobal",vars.missionCode)
  if addonIndex==0 then--DEBUGNOW do we need to do EnabledForMission if we're doing this?
    return weaponIdTable
  end
  local addonName=this.addonsNames[addonIndex+1]
  if addonName==nil then
    InfCore.Log("WARNING: InfWeaponIdTable.GetWeaponIdTable: could not find addonName for weaponTableGlobal:"..tostring(addonIndex))
    return weaponIdTable
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