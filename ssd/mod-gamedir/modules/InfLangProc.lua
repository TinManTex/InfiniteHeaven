--InfLangProc.lua
--Processing methods for IH Lang strings
local this={}


function this.CpNameString(cpName,location)
  local location=location or InfUtil.GetLocationName()
  local languageCode=this.GetLanguageCode()
  local locationCps=InfLangCpNames.cpNames[location]
  if locationCps==nil then
    InfCore.Log("InfMenu.CpNameString: WARNING No name for "..tostring(cpName).." in "..tostring(location))
    return nil
  end
  local cps=locationCps[languageCode] or locationCps["eng"]
  return cps[cpName]
end

--REF
--this.langStrings={
--  eng={
--    someLangString="Some lang string",
--  },
--  help={
--    eng={
--      someLangString="Some lang string help",
--    },
--  },
--}
function this.PostAllModulesLoad()
  InfCore.LogFlow("Adding module Lang strings")
  --tex add module ivars to this
  --just straight up merging for now so I don't have to change any lang lookup code
  for i,module in ipairs(InfModules) do
    if module.langStrings and module~=InfLang then
      InfCore.LogFlow("Adding LangStrings for "..module.name)
      if this.debugModule then
        InfCore.PrintInspect(module.langStrings,module.name..".langStrings")
      end
      --tex ASSUMPTION, only two levels deep (.help.<lang>)
      --should just do a full table merge function
      for k,v in pairs(module.langStrings)do
        --<lang>, help
        for k2,v2 in pairs(v)do
          --help.<lang>
          if type(v2)=="table" and k=="help" then--tex KLUDGE settings are actually a table
            for k3,v3 in pairs(v2)do
              InfLang[k][k2][k3]=v3
          end
          else
            InfLang[k][k2]=v2
          end
        end
      end
    end

    --tex check to see if theres a settingNames in InfLang
    --has to be postmodules since InfLang is loaded after Ivars
    --GOTCHA this will lock in language till next modules reload (not that there's any actual InfLang translations I'm aware of lol)
    local settingsStr="Settings"
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    local langTable=InfLang[languageCode] or InfLang.eng
    for name,ivar in pairs(Ivars) do
      if Ivars.IsIvar(ivar) then
        local settingNames=name..settingsStr
        if langTable[settingNames] then
          ivar.settingNames=settingNames
        end
        ivar.settingNames=ivar.settingNames or ivar.settings--tex fall back to settings table
      end
    end
  end

  -- if this.debugModule then --DEBUGNOW
  InfCore.PrintInspect(InfLang,"InfLang---------------------------")--DEBUGNOW
  -- end
end

return this
