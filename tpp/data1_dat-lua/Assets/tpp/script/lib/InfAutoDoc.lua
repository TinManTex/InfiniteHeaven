-- DOBUILD: 0
-- InfAutoDoc.lua
local this={}

--LOCALOPT
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString

local nl="\n"

local tableStr="table"
local function IsMenu(item)
  if type(item)==tableStr then
    if item.options then
      return true
    end
  end
end

local skipItemsList={
  goBackItem=true,
  resetSettingsItem=true,
  menuOffItem=true,
}

local function CharacterLine(character,length)
  local characterLine=""
  for j=1,length do
    characterLine=characterLine..character
  end
  return characterLine
end

--WORKAROUND redo
local function GetSettingsText(option)
  local settingText=""
  local settingNames=option.settingNames or option.settings
  if settingNames then
    if settingNames=="set_do" then--KLUDGE WORKAROUND
      return "(Command)"
    end
    --tex old style direct non localized table
    if IsTable(settingNames) then
      --tex lua indexed from 1, but settings from 0
      --DEBUGNOW settingText=option.setting..":"..settingNames[option.setting+1]
      for i,settingName in ipairs(settingNames)do
        settingText=settingText..settingName..", "
      end

      settingText=string.sub(settingText,1,#settingText-2)
    else
      local settingTable=InfMenu.GetLangTable(settingNames)
      --settingText=InfInspect.Inspect(settingTable)
      for i,settingName in ipairs(settingTable)do
        settingText=settingText..settingName..", "
      end
      settingText=string.sub(settingText,1,#settingText-2)
      --settingText=InfMenu.LangTableString(settingNames,option.setting+1)
    end
  elseif IsFunc(option.GetSettingText) then
    settingText=tostring(option:GetSettingText())
  elseif option.isPercent then
    if option.range then
      settingText=option.range.min.."-"..option.range.max.."%"
    else
      settingText="Percentage"
    end
    --settingText=option.setting .. "%"
    --  elseif option.options~=nil then--tex menu
    --    settingText=""
    --    optionSeperator=optionSeperators.menu
  else
    if option.range then
      settingText=option.range.min.."-"..option.range.max
    else
      settingText="DEBUGNOW GetSettingsText no decent output found"--DEBUGNOW
    end
  end
  return settingText
end

local function GatherMenus(currentMenu,skipItems,menus,menuNames)
  for i,item in ipairs(currentMenu)do
    if skipItems and skipItemsList[item.name] then
    else
      if IsMenu(item) and not menuNames[item.name] then
        menuNames[item.name]=true
        table.insert(menus,item)
        GatherMenus(item.options,skipItems,menus,menuNames)
      end
    end
  end
end

local function IsForProfile(item,currentMenu,priorMenus,priorItems)
  if priorMenus then
    for i,menu in ipairs(priorMenus) do
      if currentMenu==menu then
        return
      end
    end
  end

  if priorItems[item.name] then
    return false
  end

  if currentMenu.nonConfig
    or item.optionType~="OPTION"
    or item.nonUser
    or item.nonConfig
    or item.OnSubSettingChanged
  then
    return false
  end
  return true
end

local function PrintMenuSingle(priorMenus,menu,priorItems,skipItems,menuCount,textFile,htmlFile,profileFile)
  menuCount=menuCount+1

  local menuDisplayName=InfMenu.LangString(menu.name)

  textFile:write(menuDisplayName,nl)

  htmlFile:write([[<div id="menu">]],nl)
  htmlFile:write([[<div id="menuTitle">]],nl)
  htmlFile:write(string.format([[<div id="%s">%s</div>]],menu.name,menuDisplayName),nl)

  local hasItems=false
  for i,item in ipairs(menu.options)do
    if IsForProfile(item,menu,priorMenus,priorItems) then
      hasItems=true
    end
  end
  if hasItems then
    profileFile:write("\t\t--"..menuDisplayName,nl)
  end

  local menuHelpLangString=InfLang.help.eng[menu.name]
  if menuHelpLangString then
    textFile:write("- "..menuHelpLangString,nl)

    menuHelpLangString=string.gsub(menuHelpLangString,nl,"<br/>")
    htmlFile:write(string.format([[<div id="menuHelp">%s</div>]],menuHelpLangString),nl)

    --profileFile:write("-- "..menuHelpLangString,nl)
  end
  htmlFile:write("</div>",nl)

  local underLineLength=string.len(menuDisplayName)
  local underLine=CharacterLine("-",underLineLength)
  textFile:write(underLine,nl)

  for i,item in ipairs(menu.options)do
    htmlFile:write([[<div id="menuItem">]],nl)

    if skipItems and skipItemsList[item.name] then

    else
      local settingDescription=item.description or InfMenu.LangString(item.name)
      local indexDisplayLine=i..": "

      --htmlFile:write(string.format([[<div id="itemIndex">%s</div>]],indexDisplayLine))

      if IsMenu(item) then
        menuCount=menuCount+1
        textFile:write(indexDisplayLine..settingDescription,nl)
        htmlFile:write(string.format([[<div>%s<a href="#%s">%s</a></div>]],indexDisplayLine,item.name,settingDescription),nl)
      else
        local settingText=GetSettingsText(item)
        textFile:write(indexDisplayLine..settingDescription.." : "..settingText,nl)

        local settingsDisplayText=settingDescription.." : "..settingText
        settingsDisplayText=string.gsub(settingsDisplayText,"<","&lt")
        settingsDisplayText=string.gsub(settingsDisplayText,">","&gt")
        htmlFile:write(string.format([[<div>%s</div>]],indexDisplayLine..settingsDisplayText),nl)
        --htmlFile:write(string.format([[<div id="%s">%s</div>]],item.name,indexDisplayLine..settingDescription),nl)

        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          helpLangString=string.gsub(helpLangString,"<","&lt")
          helpLangString=string.gsub(helpLangString,">","&gt")

          textFile:write(helpLangString,nl)

          helpLangString=string.gsub(helpLangString, nl, "<br/>")
          htmlFile:write(string.format([[<div id="itemHelp">%s</div>]],helpLangString),nl)
        end

        if IsForProfile(item,menu,priorMenus,priorItems) then
          profileFile:write("\t\t"..item.name.."=")
          if item.settings then
            local setting=item.settings[item.default+1]
            if setting~="DEFAULT" and setting~="OFF" then
              profileFile:write("\""..setting.."\"")
            else
              profileFile:write(item.default)
            end
          else
            profileFile:write(item.default)
          end
          profileFile:write(",")

          local optionName=InfLang.eng[item.name] or InfLang.help.eng[item.name] or ""
          profileFile:write("--")
          if item.settings then
            profileFile:write("{ ")
            for i,setting in ipairs(item.settings)do
              profileFile:write(setting)
              if i~=#item.settings then
                profileFile:write(", ")
              end
            end
            profileFile:write(" }")
          else
            profileFile:write("{ ")
            profileFile:write(item.range.min.."-"..item.range.max)
            profileFile:write(" }")
          end
          if not item.save then
            profileFile:write(" -- Non-save")
          end
          profileFile:write(" -- "..optionName)
          if item.isPercent then
            profileFile:write(" (percentage)")
          end
          profileFile:write(nl)

          priorItems[item.name]=true
        end
      end
    end
    htmlFile:write("</div>",nl)
  end
  htmlFile:write("</div>",nl)--id=menu
end

local function EscapeHtml(line)
  line=string.gsub(line,"<","&lt")
  line=string.gsub(line,">","&gt")
  line=string.gsub(line,nl,"<br/>")
  return line
end


local projectFolder="D:\\Projects\\MGS\\!InfiniteHeaven\\"
local featuresOutputName="Features and Options"

FeaturesHeader=require"FeaturesHeader"
function this.AutoDoc()
  local textFilePath=projectFolder..featuresOutputName..".txt"
  local textFile=io.open(textFilePath,"w")

  local htmlFilePath=projectFolder..featuresOutputName..".html"
  local htmlFile=io.open(htmlFilePath,"w")

  local profileFilePath=projectFolder.."!modlua\\ExternalLua\\InfProfiles.lua"
  local profileFile=io.open(profileFilePath,"w")
  
  htmlFile:write("<!DOCTYPE html>",nl)
  htmlFile:write("<html>",nl)
  htmlFile:write("<head>",nl)
  htmlFile:write([[<link rel="stylesheet" type="text/css" href="features.css">]],nl)
  htmlFile:write(string.format([[<title>%s</title>]],featuresOutputName),nl)
  htmlFile:write("</head>",nl)
  htmlFile:write("<body>",nl)

  for i,section in pairs(FeaturesHeader)do
    textFile:write(section.title,nl)
    local underLineLength=string.len(section.title)
    local underLine=CharacterLine("=",underLineLength)
    textFile:write(underLine,nl)
    textFile:write(nl)

    htmlFile:write([[<div id="menu">]],nl)
    htmlFile:write(string.format([[<div id="menuTitle">%s</div>]],section.title),nl)
    for i,line in ipairs(section)do
      if type(line)=="table" then
        if line.link then
          textFile:write(line[1],nl)
          textFile:write("[url="..line.link.."]"..line.link.."[/url]",nl)
        
          htmlFile:write(string.format([[<div id="menuItem"><a href="%s">%s</a></div>]],line.link,line[1]),nl)
        elseif line.featureDescription then
          textFile:write(string.format(line.featureDescription),nl)
          textFile:write(string.format(line.featureHelp),nl)
        
          htmlFile:write(string.format([[<div id="menuItem">%s</div>]],EscapeHtml(line.featureDescription)),nl)
          htmlFile:write(string.format([[<div id="itemHelp">%s</div>]],EscapeHtml(line.featureHelp)),nl)
        end
      else
        textFile:write(line,nl)
      
        line=EscapeHtml(line)
        htmlFile:write(string.format([[<div id="menuItem">%s</div>]],line),nl)
      end
      textFile:write(nl)
    end   
    
    htmlFile:write([[</div>]],nl)
    htmlFile:write("<br/>",nl)
  end

  local headerFilePath=projectFolder.."!modlua\\InfProfiles\\ProfilesHeader.txt"
  local headerFile=io.open(headerFilePath)
  local header=headerFile:read("*all")
  headerFile:close()

  profileFile:write(header)
  profileFile:write(nl)
  profileFile:write("local profiles={}",nl)
  profileFile:write(nl)
  profileFile:write("-- Defaults/example of all profile options for IH r"..InfMain.modVersion,nl)
  profileFile:write("profiles.defaults={",nl)
  profileFile:write("\tdescription=\"Defaults/All disabled\",",nl)
  profileFile:write("\tfirstProfile=false,--puts profile first for the IH menu option, only one profile should have this set.",nl)
  profileFile:write("\tloadOnACCStart=false,",nl)--If set to true profile will be applied on first load of ACC (actual, not just title). Any profile can have this setting, profiles will be applied in same order as listed in IH menu (alphabetical, and firstProfile first)

  profileFile:write("\tprofile={",nl)

  --patchup
  Ivars.playerHeadgear.settingNames="playerHeadgearMaleSettings"
  Ivars.fovaSelection.description="<Character model description>"
  Ivars.fovaSelection.settingNames={"<Fova selection>"}
  Ivars.mbSelectedDemo.settingNames={"<Cutscene ids>"}
  Ivars.playerPartsType.settings={"<Suits for player type>"}--DEBUGNOW
  Ivars.playerCamoType.settings={"<Camos for player type>"}--DEBUGNOW
  Ivars.selectProfile.settingNames={"<Profile type>"}


  local menu=InfMenuDefs.heliSpaceMenu.options
  local skipItems=true
  local heliSpaceMenus={}
  local heliSpaceMenuNames={}

  GatherMenus(menu,skipItems,heliSpaceMenus,heliSpaceMenuNames)
  --InfLog.PrintInspect(heliSpaceMenus)
  table.insert(heliSpaceMenus,1,InfMenuDefs.heliSpaceMenu)

  local priorItems={}

  local menuCount=1
  for i,menu in ipairs(heliSpaceMenus)do
    PrintMenuSingle(nil,menu,priorItems,skipItems,menuCount,textFile,htmlFile,profileFile)
    textFile:write(nl)
    htmlFile:write("<br/>",nl)
  end

  textFile:write("===============",nl)
  textFile:write(nl)
  menu=InfMenuDefs.inMissionMenu.options
  local inMissionMenus={}
  local inMissionMenuNames={}
  GatherMenus(menu,skipItems,inMissionMenus,inMissionMenuNames)
  table.insert(inMissionMenus,1,InfMenuDefs.inMissionMenu)
  --InfLog.PrintInspect(inMissionMenus)
  local menuCount=1
  for i,menu in ipairs(inMissionMenus)do
    PrintMenuSingle(heliSpaceMenus,menu,priorItems,skipItems,menuCount,textFile,htmlFile,profileFile)
    textFile:write(nl)
    htmlFile:write("<br/>",nl)
  end

  htmlFile:write("</body>",nl)
  htmlFile:write("</html>",nl)

  profileFile:write("\t}",nl)
  profileFile:write("}",nl)
  profileFile:write(nl)

  local heavenProfilesPath=projectFolder.."!modlua\\InfProfiles\\InfHeavenProfiles.lua"
  local heavenProfilesFile=io.open(heavenProfilesPath)
  local heavenProfiles=heavenProfilesFile:read("*all")
  heavenProfilesFile:close()

  profileFile:write(heavenProfiles,nl)


  profileFile:write(nl)
  profileFile:write("return profiles",nl)

  textFile:close()
  htmlFile:close()
  profileFile:close()

  print"--autodoc done--"
end

return this
