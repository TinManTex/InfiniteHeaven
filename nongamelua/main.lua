--main.lua
externalLoad=true

package.path=package.path..";./Data1Lua/Assets/tpp/script/lib/?.lua"
package.path=package.path..";./Data1Lua/Tpp/Scripts/Equip/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/afgh/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/mafr/?.lua"

--MOCK
AssetConfiguration={}
AssetConfiguration.GetDefaultCategory=function()
  return "eng"
end

Fox={}
Fox.StrCode32=function(encodeString)--TODO IMPLEMENT
  return encodeString
end
GameObject={}
Time={}
Time.GetRawElapsedTimeSinceStartUp=function()--TODO IMPLEMENT
  return os.time()
end

TppGameMode={}
TppGameObject={}
TppNetworkUtil={}
TppScriptVars={}
bit={}--TODO IMPLEMENT: add implementation of whatever bit library this was again
--enums and values, TODO: possibly IMPLEMENT
EnemyType={}
PlayerDisableAction={}
PlayerPad={}
PlayerType={}
PlayerCamoType={}
BuddyType={}

TppEquip={}
TppEquip.ReloadEquipIdTable=function(equipIdTable)
  TppEquip.equipIdTable=equipIdTable
end

vars={}
mvars={}
svars={}
gvars={}

--modules - would be able to include these too if I mocked every non module variable lol
TppDefine={}
TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST={}
local numMbDemos=47--SYNC #MB_FREEPLAY_DEMO_PRIORITY_LIST
for i=1,numMbDemos do
  TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST[i]=tostring(i).." TODO IMPLEMENT MB_FREEPLAY_DEMO_PRIORITY_LIST"
end
TppDefine.ENEMY_HELI_COLORING_TYPE={}
TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT=0
TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK=1
TppDefine.ENEMY_HELI_COLORING_TYPE.RED=2
function TppDefine.Enum(enumNames)
  if type(enumNames)~="table"then
    return
  end
  local enumTable={}
  for i,enumName in pairs(enumNames)do
    enumTable[enumName]=i-1--NMC: lua tables indexed from 1, enums indexed from 0
  end
  return enumTable
end

TppMission={}--TODO IMPLEMENT
TppMission.IsFOBMission=function(missionCode)--TODO IMPLEMENT
  return false
end

TppTerminal={}
TppTerminal.MBDVCMENU={}
TppUiCommand={}--TODO IMPLEMENT
TppUiCommand.AnnounceLogDelayTime=function()
end
TppUiCommand.AnnounceLogView=function(string)
  print(string)
end

--end mock stuff

Tpp=require"Tpp"
EquipIdTable=require"EquipIdTable"

afgh_routeSets=require"afgh_routeSets"
mafr_routeSets=require"mafr_routeSets"
afgh_travelPlans=require"afgh_travelPlans"
mafr_travelPlans=require"mafr_travelPlans"



--TppDefine=require"TppDefine"

Ivars=require"Ivars"
InfLang=require"InfLang"
InfButton=require"InfButton"
InfMain=require"InfMain"
InfMenuCommands=require"InfMenuCommands"
InfMenuDefs=require"InfMenuDefs"
InfMenu=require"InfMenu"


InfInspect=require"InfInspect"
InfEquip=require"InfEquip"

--LOCALOPT
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString

--AutoDoc>
local function Write(...)
  --print(...)
  io.write(...,"\n")
end

--PATCHUP
--InfEquip={}
InfEquip.tppEquipTableTest={"<DEBUG IVAR>"}

vars.missionCode=40050

local tableStr="table"
local function IsMenu(item)
  if type(item)==tableStr then
    if item.options then
      return true
    end
  end
end

local function IsMenuCommand(item)

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

--DEBUGNOW TODO: special case playerHeadgear
local function GetSettingsText(option)
  local settingText=""
  local settingNames=option.settingNames or option.settings
  if settingNames then
    if settingNames=="set_do" then--DEBUGNOW KLUDGE WORKAROUND
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

--local depthToLetter={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local depthToLetter={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
local function PrintMenuFull(menu,depth,menuCount,skipItems)

  for i,item in ipairs(menu)do
    if skipItems and skipItemsList[item.name] then

    else
      local settingName = item.description or InfMenu.LangString(item.name)
      local indents=CharacterLine(" ",depth)
      local indexDisplayLine="["..depthToLetter[menuCount]..i.."] "
      local indexDisplayLineLength=string.len(indexDisplayLine)
      local displayLine=indexDisplayLine..settingName

      if IsMenu(item) then
        menuCount=menuCount+1
        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
          Write(indents..displayLine.." - "..helpLangString)
        else
          Write(indents..displayLine)
        end

        local indentsUnderLine=CharacterLine(" ",depth+1)
        local underLineLength=string.len(displayLine)-1
        local underLine=CharacterLine("-",underLineLength+depth+1)
        Write(indentsUnderLine..underLine)

        PrintMenuFull(item.options,depth+1,menuCount,skipItems)
      else
        local settingText=GetSettingsText(item)
        Write(indents..displayLine.." : "..settingText)

        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
          Write(indents..indentsIndexDisplay.."- "..helpLangString)
        end
      end
    end
  end
end

--tex just print menu
local function PrintMenu(menu,depth,menuCount,skipItems)

  for i,item in ipairs(menu)do
    if skipItems and skipItemsList[item.name] then

    else
      local settingName = item.description or InfMenu.LangString(item.name)
      local indents=CharacterLine(" ",depth)
      local indexDisplayLine="["..depthToLetter[menuCount]..i.."] "
      local indexDisplayLineLength=string.len(indexDisplayLine)
      local displayLine=indexDisplayLine..settingName

      if IsMenu(item) then
        menuCount=menuCount+1
        local helpLangString=InfLang.help.eng[item.name]
        --        if helpLangString then
        --          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
        --          --print(indents..displayLine.." - "..helpLangString)
        --        else
        Write(indents..displayLine)
        --        end

        local indentsUnderLine=CharacterLine(" ",depth+1)
        local underLineLength=string.len(displayLine)-1
        local underLine=CharacterLine("-",underLineLength+depth+1)
        --print(indentsUnderLine..underLine)

        PrintMenu(item.options,depth+1,menuCount,skipItems)
      else
        local settingText=GetSettingsText(item)
        Write(indents..displayLine.." : "..settingText)

        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
          --print(indents..indentsIndexDisplay.."- "..helpLangString)
        end
      end
    end
  end
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

local function PrintMenuSingle(menu,skipItems,menuCount,htmlFile)
  local menuDisplayName=InfMenu.LangString(menu.name)
  local indexDisplayLine="["..depthToLetter[menuCount].."] "
  local indexDisplayLineLength=string.len(indexDisplayLine)

  htmlFile:write([[<div id="menu">]],"\n")
  --if IsMenu(item) then
  menuCount=menuCount+1

  Write(menuDisplayName)

  htmlFile:write([[<div id="menuTitle">]],"\n")

  htmlFile:write(string.format([[<div id="%s">%s</div>]],menu.name,menuDisplayName),"\n")

  local menuHelpLangString=InfLang.help.eng[menu.name]
  if menuHelpLangString then
    local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
    Write("- "..menuHelpLangString)

    menuHelpLangString=string.gsub(menuHelpLangString,"\n","<br/>")
    htmlFile:write(string.format([[<div id="menuHelp">%s</div>]],menuHelpLangString),"\n")
  end
  htmlFile:write("</div>","\n")

  local underLineLength=string.len(menuDisplayName)
  local underLine=CharacterLine("-",underLineLength)
  Write(underLine)
  --end


  for i,item in ipairs(menu.options)do
    htmlFile:write([[<div id="menuItem">]],"\n")

    if skipItems and skipItemsList[item.name] then

    else
      local settingDescription=item.description or InfMenu.LangString(item.name)


      local indexDisplayLine=i..": "

      --htmlFile:write(string.format([[<div id="itemIndex">%s</div>]],indexDisplayLine))


      if IsMenu(item) then
        menuCount=menuCount+1
        Write(indexDisplayLine..settingDescription)
        htmlFile:write(string.format([[<div>%s<a href="#%s">%s</a></div>]],indexDisplayLine,item.name,settingDescription),"\n")
      else
        local settingText=GetSettingsText(item)
        Write(indexDisplayLine..settingDescription.." : "..settingText)

        local settingsDisplayText=settingDescription.." : "..settingText
        settingsDisplayText=string.gsub(settingsDisplayText,"<","&lt")
        settingsDisplayText=string.gsub(settingsDisplayText,">","&gt")
        htmlFile:write(string.format([[<div>%s</div>]],indexDisplayLine..settingsDisplayText),"\n")
        --htmlFile:write(string.format([[<div id="%s">%s</div>]],item.name,indexDisplayLine..settingDescription),"\n")

        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          local indentsIndexDisplay=CharacterLine(" ",string.len(indexDisplayLine))
          --CULL Write(indentsIndexDisplay.."- "..helpLangString)
          Write(helpLangString)

          helpLangString=string.gsub(helpLangString, "\n", "<br/>")
          htmlFile:write(string.format([[<div id="itemHelp">%s</div>]],helpLangString),"\n")
        end
      end
    end
    htmlFile:write("</div>","\n")
  end
  htmlFile:write("</div>","\n")--id=menu
end

local projectFolder="D:\\Projects\\MGS\\!InfiniteHeaven\\"
local featuresHeader="Features description header.txt"
local featuresOutputName="Features and Options"

FeaturesHeader=require"FeaturesHeader"

local function EscapeHtml(line)
  line=string.gsub(line,"<","&lt")
  line=string.gsub(line,">","&gt")
  line=string.gsub(line,"\n","<br/>")
  return line
end

local function AutoDoc()
  io.output(projectFolder..featuresOutputName..".txt")
  io.input(projectFolder..featuresHeader)
  local header=io.read("*all")
  Write(header)

  local htmlOutPutFile=projectFolder..featuresOutputName..".html"
  local htmlFile=io.open(htmlOutPutFile,"w")

  htmlFile:write("<!DOCTYPE html>","\n")
  htmlFile:write("<html>","\n")
  htmlFile:write("<head>","\n")
  htmlFile:write([[<link rel="stylesheet" type="text/css" href="features.css">]],"\n")
  htmlFile:write(string.format([[<title>%s</title>]],featuresOutputName),"\n")
  htmlFile:write("</head>","\n")
  htmlFile:write("<body>","\n")

  for i,section in pairs(FeaturesHeader)do
    htmlFile:write([[<div id="menu">]],"\n")
    htmlFile:write(string.format([[<div id="menuTitle">%s</div>]],section.title),"\n")
    for i,line in ipairs(section)do
      if type(line)=="table" then
        if line.link then
          htmlFile:write(string.format([[<div id="menuItem"><a href="%s">%s</a></div>]],line.link,line[1]),"\n")
        elseif line.featureDescription then
          htmlFile:write(string.format([[<div id="menuItem">%s</div>]],line.featureDescription),"\n")
          htmlFile:write(string.format([[<div id="itemHelp">%s</div>]],line.featureHelp),"\n")
        end
      else
        line=EscapeHtml(line)
        htmlFile:write(string.format([[<div id="menuItem">%s</div>]],line),"\n")
      end
    end
    htmlFile:write([[</div>]],"\n")
    htmlFile:write("<br/>","\n")
  end

  --patchup
  Ivars.playerHeadgear.settingNames="playerHeadgearMaleSettings"
  Ivars.fovaSelection.description="<Character model description>"
  Ivars.fovaSelection.settingNames={"<Fova selection>"}
  Ivars.mbSelectedDemo.settingNames={"<Cutscene ids>"}


  local menu=InfMenuDefs.heliSpaceMenu.options
  local skipItems=true

  local docTable={}

  local heliSpaceMenus={}
  local heliSpaceMenuNames={}
  GatherMenus(menu,skipItems,heliSpaceMenus,heliSpaceMenuNames)
  --InfInspect.PrintInspect(heliSpaceMenus)
  table.insert(heliSpaceMenus,1,InfMenuDefs.heliSpaceMenu)

  local menuCount=1
  for i,menu in ipairs(heliSpaceMenus)do
    PrintMenuSingle(menu,skipItems,menuCount,htmlFile)
    Write"\n"
    htmlFile:write("<br/>","\n")
  end

  Write"==============="
  Write"\n"
  menu=InfMenuDefs.inMissionMenu.options
  local inMissionMenus={}
  local inMissionMenuNames={}
  GatherMenus(menu,skipItems,inMissionMenus,inMissionMenuNames)
  table.insert(inMissionMenus,1,InfMenuDefs.inMissionMenu)
  --InfInspect.PrintInspect(inMissionMenus)
  local menuCount=1
  for i,menu in ipairs(inMissionMenus)do
    PrintMenuSingle(menu,skipItems,menuCount,htmlFile)
    Write("\n")
    htmlFile:write("<br/>","\n")
  end

  --PrintMenu(menu,0,menuCount,skipItems)
  --DEBUGNOW

  --InfMenu.DisplaySetting(InfMenu.currentIndex)


  htmlFile:write("</body>","\n")
  htmlFile:write("</html>","\n")

  htmlFile:close()

  print"--done--"
end

-- end autodoc
-- equipid string out for strcode32 (TODO should add an implementation/library to this project).
local function PrintEquipId()
  local outPutFile="D:\\Projects\\MGS\\equipIdStrings.txt"
  local f=io.open(outPutFile,"w")

  for i,equipId in ipairs(InfEquip.tppEquipTable)do
    f:write(equipId,"\n")
    --print(equipId)
  end
  f:close()
end

--generic travel routes
local function PrintGenericRoutes()
  local modules={
    "afgh_routeSets",
    "mafr_routeSets",
  }



  for i,moduleName in ipairs(modules)do
    local lrrpNumberDefine=afgh_travelPlans.lrrpNumberDefine
    if string.find(moduleName,"mafr")~=nil then--TODO better
      lrrpNumberDefine=mafr_travelPlans.lrrpNumberDefine
    end

    print(moduleName)
    print""
    for cpName, routeSets in pairs(_G[moduleName])do
      --print(cpName)
      if string.find(cpName,"lrrp")==nil then
        local lrrpNumber=lrrpNumberDefine[cpName]
        if lrrpNumber==nil then
          lrrpNumber="NONE"
        end
        
        local description=InfLang.cpNames.afgh.eng[cpName] or InfLang.cpNames.mafr.eng[cpName] or ""

        if routeSets.travel==nil or routeSets.travel==0 then
          print(lrrpNumber..","..cpName..","..description..",no travel routes found")
        else
          for routeSetName,routeSet in pairs(routeSets.travel)do
            print(lrrpNumber..","..cpName..","..description..","..routeSetName)
          end
        end

        print""
      end
    end
  end




end

local function PrintGenericRoutes2()
  print"afgh_travelPlans.lrrpNumberDefine"

  for cpName,enum in pairs(afgh_travelPlans.lrrpNumberDefine)do
    print(cpName..","..enum)
  end

  print"mafr_travelPlans.lrrpNumberDefine"

  for cpName,enum in pairs(mafr_travelPlans.lrrpNumberDefine)do
    print(cpName..","..enum)
  end

  local numLrrpNumbers=50

  local lrrpNumbers={}

  local modules={
    "afgh_routeSets",
    "mafr_routeSets"
  }
  for i,moduleName in ipairs(modules)do
    lrrpNumbers[moduleName]={}
    for i=1,numLrrpNumbers do
      lrrpNumbers[moduleName][i]={}
    end
    --    print(moduleName)
    --    print""
    for cpName, routeSets in pairs(_G[moduleName])do

      if string.find(cpName,"_lrrp")~=nil then
        --print(cpName)
        if routeSets.travel==nil or routeSets.travel==0 then
        --print"no travel routes found"
        else
          for routeSetName,routeSet in pairs(routeSets.travel)do
            --tex parse "lrrp_05to33"
            if string.find(routeSetName,"lrrp")~=nil then

              local toIndexStart,toIndexEnd=string.find(routeSetName,"to")
              if toIndexStart~=nil then
                --print(" "..routeSetName)
                local startLrrpNumber=tonumber(string.sub(routeSetName,toIndexStart-2,toIndexStart-1))
                local endLrrpNumber=tonumber(string.sub(routeSetName,toIndexEnd+1,toIndexEnd+2))
                local ids=lrrpNumbers[moduleName][startLrrpNumber]
                ids[endLrrpNumber]=true
              end
            end
          end
        end
        --print""
      end
    end
  end

  local ins=InfInspect.Inspect(lrrpNumbers)
  --print(ins)

  local function CpNameForLrrpNumber(lrrpNumberDefine,lrrpNumber)
    local lrrpCpName=""
    for cpName,enum in pairs(lrrpNumberDefine)do
      if enum==lrrpNumber then
        lrrpCpName=cpName
      end
    end
    return lrrpCpName
  end

  for i,moduleName in ipairs(modules)do
    print(moduleName)
    print""
    for i=1,numLrrpNumbers do
      local lrrpCpName=""
      local description=""
      local lrrpNumberDefine=afgh_travelPlans.lrrpNumberDefine
      if string.find(moduleName,"mafr")~=nil then--TODO better
        lrrpNumberDefine=mafr_travelPlans.lrrpNumberDefine
      end

      lrrpCpName=CpNameForLrrpNumber(lrrpNumberDefine,i)

      if lrrpCpName~=""then
        description=InfLang.cpNames.afgh.eng[lrrpCpName] or InfLang.cpNames.mafr.eng[lrrpCpName]
      end


      local tids=lrrpNumbers[moduleName][i]


      local numTids=0
      for _lrrpNumber,bool in pairs(tids)do
        local _lrrpCpName=CpNameForLrrpNumber(lrrpNumberDefine,_lrrpNumber)
        local _description=InfLang.cpNames.afgh.eng[_lrrpCpName] or InfLang.cpNames.mafr.eng[_lrrpCpName]
        print(i..","..lrrpCpName..","..description..",".._lrrpNumber..",".._lrrpCpName..",".._description)
        numTids=numTids+1
      end
      if numTids==0 then
        print(i..","..lrrpCpName..","..tostring(description)..",".."NONE")
      end
      print""
    end


  end
end
--

local function main()
  AutoDoc()

  PrintEquipId()

  PrintGenericRoutes()
  --PrintGenericRoutes2()
end

main()
