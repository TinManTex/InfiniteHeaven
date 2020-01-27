--main.lua
externalLoad=true

projectDataPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/Data1Lua/"

package.path=package.path..";./nonmgscelua/SLAXML/?.lua"

package.path=package.path..";./Data1Lua/Tpp/"
package.path=package.path..";./Data1Lua/Assets/tpp/script/lib/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/afgh/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/mafr/?.lua"
--

--UTIL
Util={}

function Util.Split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

function Util.MergeTable(table1,table2,n)
  local mergedTable=table1
  for k,v in pairs(table2)do
    if table1[k]==nil then
      mergedTable[k]=v
    else
      mergedTable[k]=v
    end
  end
  return mergedTable
end
--
--tex not set up as a coroutine, so yield==nil?
yield=function()
end

dofile("MockFoxEngine.lua")

--local init,err=loadfile("./Data1Lua/init.lua")
--if not err then
--init()
--else
--print(tostring(err))
--end

--Mock modules - would be able to include these too if I mocked every non module variable lol
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

--start.lua
local tppOrMgoPath
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  tppOrMgoPath="/Assets/mgo/"
else
  tppOrMgoPath="/Assets/tpp/"
end
local filePath
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  filePath="/Assets/mgo/level_asset/weapon/ParameterTables/EquipIdTable.lua"
else
  filePath="Tpp/Scripts/Equip/EquipIdTable.lua"
end
Script.LoadLibraryAsync(filePath)
while Script.IsLoadingLibrary(filePath)do
  yield()
end
local filePath=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipParameters.lua"
if TppEquip.IsExistFile(filePath)then
  Script.LoadLibrary(filePath)
else
  Script.LoadLibrary"Tpp/Scripts/Equip/EquipParameters.lua"
end
yield()
local filePath=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipMotionDataForChimera.lua"
if TppEquip.IsExistFile(filePath)then
  Script.LoadLibrary(filePath)
end
Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceId.lua"
Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyBodyId.lua"
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerTables.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerProgression.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/ChimeraPartsPackageTable.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/EquipConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/WeaponParameterTables.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/RulesetConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/SafeSpawnConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/SoundtrackConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/PresetRadioConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/player/Stats/StatTables.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/PointOfInterestConfig.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/damage/ParameterTables/DamageParameterTables.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipMotionData.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/MgoWeaponParameters.lua"
  Script.LoadLibrary"/Assets/mgo/level_asset/config/GearConfig.lua"
else
    yield()
    Script.LoadLibrary"Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/damage/ParameterTables/DamageParameterTables.lua"
    yield()
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2ParameterTables.lua"
  Script.LoadLibrary"Tpp/Scripts/Equip/EquipMotionData.lua"
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroupId.lua"
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroup.lua"
  yield()
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2FaceAndBodyData.lua"
  yield()
end
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
else
  Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
end
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  Script.LoadLibrary"/Assets/mgo/script/lib/Overrides.lua"
end
Script.LoadLibraryAsync"/Assets/tpp/script/lib/Tpp.lua"
--  while Script.IsLoadingLibrary"/Assets/tpp/script/lib/Tpp.lua"do
--    yield()
--  end
--Script.LoadLibrary"/Assets/tpp/script/lib/TppDefine.lua"
Script.LoadLibrary"/Assets/tpp/script/lib/TppVarInit.lua"
--Script.LoadLibrary"/Assets/tpp/script/lib/TppGVars.lua"
--  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
--    Script.LoadLibrary"/Assets/mgo/script/utils/SaveLoad.lua"
--    Script.LoadLibrary"/Assets/mgo/script/lib/PostTppOverrides.lua"
--    Script.LoadLibrary"/Assets/mgo/script/lib/MgoMain.lua"
--    Script.LoadLibrary"Tpp/Scripts/System/Block/Overflow.lua"
--    Script.LoadLibrary"/Assets/mgo/level_asset/config/TppMissionList.lua"
--    Script.LoadLibrary"/Assets/mgo/script/utils/Utils.lua"
--    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterGear.lua"
--    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterConnectPointFiles.lua"
--    Script.LoadLibrary"/Assets/mgo/script/player/PlayerResources.lua"
--    Script.LoadLibrary"/Assets/mgo/script/player/PlayerDefaults.lua"
--    Script.LoadLibrary"/Assets/mgo/script/Matchmaking.lua"
--  else
--Script.LoadLibrary"/Assets/tpp/script/list/TppMissionList.lua"
--Script.LoadLibrary"/Assets/tpp/script/list/TppQuestList.lua"
--  end
--end
yield()
pcall(dofile,"/Assets/tpp/ui/Script/UiRegisterInfo.lua")

Script.LoadLibrary"/Assets/tpp/level_asset/chara/player/game_object/player2_camouf_param.lua"
-------=====================
this.requires={
  "/Assets/tpp/script/lib/TppDefine.lua",
  "/Assets/tpp/script/lib/TppMath.lua",
  "/Assets/tpp/script/lib/TppSave.lua",
  "/Assets/tpp/script/lib/TppLocation.lua",
  "/Assets/tpp/script/lib/TppSequence.lua",
  "/Assets/tpp/script/lib/TppWeather.lua",
  "/Assets/tpp/script/lib/TppDbgStr32.lua",
  "/Assets/tpp/script/lib/TppDebug.lua",
  "/Assets/tpp/script/lib/TppClock.lua",
  "/Assets/tpp/script/lib/TppUI.lua",
  "/Assets/tpp/script/lib/TppResult.lua",
  "/Assets/tpp/script/lib/TppSound.lua",
  "/Assets/tpp/script/lib/TppTerminal.lua",
  "/Assets/tpp/script/lib/TppMarker.lua",
  "/Assets/tpp/script/lib/TppRadio.lua",
  "/Assets/tpp/script/lib/TppPlayer.lua",
  "/Assets/tpp/script/lib/TppHelicopter.lua",
  "/Assets/tpp/script/lib/TppScriptBlock.lua",
  "/Assets/tpp/script/lib/TppMission.lua",
  "/Assets/tpp/script/lib/TppStory.lua",
  "/Assets/tpp/script/lib/TppDemo.lua",
  "/Assets/tpp/script/lib/TppEnemy.lua",
  "/Assets/tpp/script/lib/TppGeneInter.lua",
  "/Assets/tpp/script/lib/TppInterrogation.lua",
  "/Assets/tpp/script/lib/TppGimmick.lua",
  "/Assets/tpp/script/lib/TppMain.lua",
  "/Assets/tpp/script/lib/TppDemoBlock.lua",
  "/Assets/tpp/script/lib/TppAnimalBlock.lua",
  "/Assets/tpp/script/lib/TppCheckPoint.lua",
  "/Assets/tpp/script/lib/TppPackList.lua",
  "/Assets/tpp/script/lib/TppQuest.lua",
  "/Assets/tpp/script/lib/TppTrap.lua",
  "/Assets/tpp/script/lib/TppReward.lua",
  "/Assets/tpp/script/lib/TppRevenge.lua",
  "/Assets/tpp/script/lib/TppReinforceBlock.lua",
  "/Assets/tpp/script/lib/TppEneFova.lua",
  "/Assets/tpp/script/lib/TppFreeHeliRadio.lua",
  "/Assets/tpp/script/lib/TppHero.lua",
  "/Assets/tpp/script/lib/TppTelop.lua",
  "/Assets/tpp/script/lib/TppRatBird.lua",
  "/Assets/tpp/script/lib/TppMovie.lua",
  "/Assets/tpp/script/lib/TppAnimal.lua",
  "/Assets/tpp/script/lib/TppException.lua",
  "/Assets/tpp/script/lib/TppTutorial.lua",
  "/Assets/tpp/script/lib/TppLandingZone.lua",
  "/Assets/tpp/script/lib/TppCassette.lua",
  "/Assets/tpp/script/lib/TppEmblem.lua",
  "/Assets/tpp/script/lib/TppDevelopFile.lua",
  "/Assets/tpp/script/lib/TppPaz.lua",
  "/Assets/tpp/script/lib/TppRanking.lua",
  "/Assets/tpp/script/lib/TppTrophy.lua",
  "/Assets/tpp/script/lib/TppMbFreeDemo.lua",
  "/Assets/tpp/script/lib/Ivars.lua",--tex>
  "/Assets/tpp/script/lib/InfLang.lua",
  "/Assets/tpp/script/lib/InfButton.lua",
  "/Assets/tpp/script/lib/InfMain.lua",
  "/Assets/tpp/script/lib/InfMenuCommands.lua",
  "/Assets/tpp/script/lib/InfMenuDefs.lua",
  "/Assets/tpp/script/lib/InfQuickMenuDefs.lua",
  "/Assets/tpp/script/lib/InfMenu.lua",
  "/Assets/tpp/script/lib/InfEneFova.lua",
  "/Assets/tpp/script/lib/InfEquip.lua",
  --OFF "/Assets/tpp/script/lib/InfSplash.lua",
  "/Assets/tpp/script/lib/InfVehicle.lua",
  "/Assets/tpp/script/lib/InfRevenge.lua",
  --OFF "/Assets/tpp/script/lib/InfReinforce.lua",
  "/Assets/tpp/script/lib/InfCamera.lua",
  "/Assets/tpp/script/lib/InfUserMarker.lua",
  --CULL"/Assets/tpp/script/lib/InfPatch.lua",
  "/Assets/tpp/script/lib/InfEnemyPhase.lua",
  "/Assets/tpp/script/lib/InfHelicopter.lua",
  "/Assets/tpp/script/lib/InfNPC.lua",
  "/Assets/tpp/script/lib/InfNPCOcelot.lua",
  "/Assets/tpp/script/lib/InfNPCHeli.lua",
  "/Assets/tpp/script/lib/InfWalkerGear.lua",
  "/Assets/tpp/script/lib/InfInterrogation.lua",
  "/Assets/tpp/script/lib/InfSoldierParams.lua",
  "/Assets/tpp/script/lib/InfInspect.lua",
  "/Assets/tpp/script/lib/InfFova.lua",
  "/Assets/tpp/script/lib/InfLZ.lua",
  "/Assets/tpp/script/lib/InfGameEvent.lua",
  "/Assets/tpp/script/lib/InfParasite.lua",
  "/Assets/tpp/script/lib/InfBuddy.lua",
  "/Assets/tpp/script/lib/InfHooks.lua",--<
}
--TODO really do need to module load these since TppDefine is already loaded at this point
---------
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

InfLZ=require"InfLZ"


InfInspect=require"InfInspect"
InfEquip=require"InfEquip"
InfEneFova=require"InfEneFova"
InfFova=require"InfFova"

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
          helpLangString=string.gsub(helpLangString,"<","&lt")
          helpLangString=string.gsub(helpLangString,">","&gt")

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
  Ivars.playerPartsType.settings={"<Suits for player type>"}--DEBUGNOW
  Ivars.playerCamoType.settings={"<Camos for player type>"}--DEBUGNOW


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
--<printgenric routes

--xml parse>
local function XmlTest()

  --example
  --local SLAXML = require 'slaxml'
  --
  --local myxml = io.open('my.xml'):read('*all')
  --
  ---- Specify as many/few of these as you like
  --parser = SLAXML:parser{
  --  startElement = function(name,nsURI,nsPrefix)       end, -- When "<foo" or <x:foo is seen
  --  attribute    = function(name,value,nsURI,nsPrefix) end, -- attribute found on current element
  --  closeElement = function(name,nsURI)                end, -- When "</foo>" or </x:foo> or "/>" is seen
  --  text         = function(text)                      end, -- text and CDATA nodes
  --  comment      = function(content)                   end, -- comments
  --  pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  --}

  -- simple print
  --local SLAXML=require"slaxml"
  local myxml=io.open('D:/Projects/MGS/!InfiniteHeaven/customfpk/Assets/tpp/pack/ih/ih_uav_fpkd/Assets/tpp/level/mission2/common/ih_uav.fox2.xml'):read('*all')
  --SLAXML:parse(myxml)

  --sinple to table
  local SLAXML = require 'slaxdom' -- also requires slaxml.lua; be sure to copy both files
  local doc = SLAXML:dom(myxml)
  local ins=InfInspect.Inspect(doc)
  print(ins)
end

--<end xmlparse

--print ivars
local function PrintIvars()
  local outPutFile="D:\\Projects\\MGS\\!InfiniteHeaven\\ivars.lua"
  local f=io.open(outPutFile,"w")

  local function WriteLine(text)
    f:write(text,"\n")
  end

  WriteLine("local ivars={")

  local ivarNames={}

  local SortFunc=function(a,b) return a < b end

  local optionType="OPTION"
  for name,ivar in pairs(Ivars) do
    if type(ivar)=="table" then
      if ivar.save then
        if ivar.optionType==optionType then
          table.insert(ivarNames,name)
        end
      end
    end
  end
  table.sort(ivarNames,SortFunc)
  --InfInspect.PrintInspect(ivarNames)

  for i,name in ipairs(ivarNames) do
    --print("\""..name.."\",")
    WriteLine("\t".."\""..name.."\",")
    local optionName=InfLang.eng[name] or InfLang.help.eng[name] or ""
    local ivar=Ivars[name]
    --WriteLine("  "..name.."="..tostring(ivar.default)..",--"..optionName)
  end


  WriteLine("}")
  f:close()
end
--
--fova/face id stuff
local faceFovaEntryIndex={
  faceId=1,
  unknown1=2,
  gender=3,
  unknown2=4,
  faceFova=5,
  faceDecoFova=6,
  hairFova=7,
  hairDecoFova=8,
  unknown3=9,
  unknown4=10,
  unknown5=11,
  uiTextureName=12,
  unknown6=13,
  unknown7=14,
  unknown8=15,
  unknown9=16,
  unknown10=17,
}

local GENDER={
  MALE=0,
  FEMALE=1,
}

local function CheckSoldierFova()
  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
    end
  end


end

local function FindMissingFovas()
  print"faceFovas"
  local faceFovas={}
  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
      faceFovas[entry[faceFovaEntryIndex.faceFova]]=true
    end
  end

  for faceFova,bool in pairs(faceFovas)do
    print(faceFova)
  end

  print"faceDecoFovas"
  local faceDecoFovas={}
  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
      faceDecoFovas[entry[faceFovaEntryIndex.faceDecoFova]]=true
    end
  end

  for id,bool in pairs(faceDecoFovas)do
    print(id)
  end

  print"hairFovas"
  local hairFovas={}
  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
      hairFovas[entry[faceFovaEntryIndex.hairFova]]=true
    end
  end

  for id,bool in pairs(hairFovas)do
    print(id)
  end

  print"hairDecoFovas"
  local hairDecoFovas={}
  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
      hairDecoFovas[entry[faceFovaEntryIndex.hairDecoFova]]=true
    end
  end

  for id,bool in pairs(hairDecoFovas)do
    print(id)
  end
end




local function BuildFovaTypesList()
  local function BuildList(tableName,fovaTable)
    print("this."..tableName.."Info={")
    local list={}
    for i,entry in ipairs(fovaTable)do
      local split=Util.Split(entry[1],"/")
      local id=split[#split]
      table.insert(list,id)
      print("{")
      print("\tname=".."\""..id.."\","..tableName.."="..(i-1)..",")
      print("},")
    end
    print("}")
    return list
  end

  local faceFovas=BuildList("faceFova",Soldier2FaceAndBodyData.faceFova)
  print()
  local faceDecos=BuildList("faceDecoFova",Soldier2FaceAndBodyData.faceDecoFova)
  print()
  local hairFovas=BuildList("hairFova",Soldier2FaceAndBodyData.hairFova)
  print()
  local hairDecoFovas=BuildList("hairDecoFova",Soldier2FaceAndBodyData.hairDecoFova)
end


local function FaceDefinitionAnalyse()
local paramNames={
 "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
}

  local analysis={
    MALE={},
    FEMALE={},
  }

  for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
    local index=i-1
    local gender="MALE"
    if entry[faceFovaEntryIndex.gender]==GENDER.FEMALE then
      gender="FEMALE"
    end
    table.insert(analysis[gender],index)
    
    local analyseParamName="faceFova"
    local analyseParam=entry[InfEneFova.faceDefinitionParams[analyseParamName]]
    
    local analyseParamTable=analysis[analyseParam] or {}
    analysis[analyseParam]=analyseParamTable or {}
  end

end
--

local function main()
  AutoDoc()

  --PrintEquipId()

  --PrintGenericRoutes()
  --PrintGenericRoutes2()

  PrintIvars()

  CheckSoldierFova()

  --BuildFovaTypesList()
FaceDefinitionAnalyse()

  --XmlTest()
end

main()
