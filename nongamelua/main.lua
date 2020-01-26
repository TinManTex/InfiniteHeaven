--main.lua
externalLoad=true

package.path=package.path..";./Data1Lua/Assets/tpp/script/lib/?.lua"

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
TppEquip={}
BuddyType={}

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

--
InfEquip={}
InfEquip.tppEquipTableTest={"<DEBUG IVAR>"}


Tpp=require"Tpp"

--TppDefine=require"TppDefine"

Ivars=require"Ivars"
InfLang=require"InfLang"
InfButton=require"InfButton"
InfMain=require"InfMain"
InfMenuCommands=require"InfMenuCommands"
InfMenuDefs=require"InfMenuDefs"
InfMenu=require"InfMenu"


InfInspect=require"InfInspect"

--LOCALOPT
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString

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

--end mock stuff

--start autodoc stuff
local function Write(...)
  --print(...)
  io.write(...,"\n")
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

local function PrintMenuSingle(menu,skipItems,menuCount)
  local settingName=InfMenu.LangString(menu.name)
  local indexDisplayLine="["..depthToLetter[menuCount].."] "
  local indexDisplayLineLength=string.len(indexDisplayLine)
  local displayLine=settingName

  --if IsMenu(item) then
  menuCount=menuCount+1
  local helpLangString=InfLang.help.eng[menu.name]
  if helpLangString then
    local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
    --print(displayLine.." - "..helpLangString)
    Write(displayLine)
    Write("- "..helpLangString)
  else
    Write(displayLine)
  end

  local underLineLength=string.len(displayLine)
  local underLine=CharacterLine("-",underLineLength)
  Write(underLine)
  --end


  for i,item in ipairs(menu.options)do
    --print(menu.name.." "..i)
    if skipItems and skipItemsList[item.name] then

    else
      local settingName = item.description or InfMenu.LangString(item.name)
      local indexDisplayLine="["..i.."] "
      local indexDisplayLineLength=string.len(indexDisplayLine)
      local displayLine=indexDisplayLine..settingName

      if IsMenu(item) then
        menuCount=menuCount+1
        local helpLangString=InfLang.help.eng[item.name]
        --        if helpLangString then
        --          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
        --          --print(indents..displayLine.." - "..helpLangString)
        --        else
        Write(displayLine)
        --        end

        --local underLineLength=string.len(displayLine)-1
        --local underLine=CharacterLine("-",underLineLength+depth+1)
        --Write(indentsUnderLine..underLine)

      else
        local settingText=GetSettingsText(item)
        Write(displayLine.." : "..settingText)

        local helpLangString=InfLang.help.eng[item.name]
        if helpLangString then
          local indentsIndexDisplay=CharacterLine(" ",indexDisplayLineLength)
          Write(indentsIndexDisplay.."- "..helpLangString)
        end
      end
    end
  end
end

local projectFolder="D:\\Projects\\MGS\\!InfiniteHeaven\\"
local featuresHeader="Features description header.txt"
local featuresOutput="Features and Options.txt"
local function main()
  io.output(projectFolder..featuresOutput)
  
  io.input(projectFolder..featuresHeader)
  local header=io.read("*all")
  Write(header)
  
  --patchup
  Ivars.playerHeadgear.settingNames="playerHeadgearMaleSettings"
  Ivars.fovaSelection.description="<Character model description>"
  Ivars.fovaSelection.settingNames={"<Fova selection>"}
  Ivars.mbSelectedDemo.settingNames={"<Cutscene ids>"}


  local menu=InfMenuDefs.heliSpaceMenu.options
  local skipItems=true

  local heliSpaceMenus={}
  local heliSpaceMenuNames={}
  GatherMenus(menu,skipItems,heliSpaceMenus,heliSpaceMenuNames)
  --InfInspect.PrintInspect(heliSpaceMenus)
  table.insert(heliSpaceMenus,1,InfMenuDefs.heliSpaceMenu)

  local menuCount=1
  for i,menu in ipairs(heliSpaceMenus)do
    PrintMenuSingle(menu,skipItems,menuCount)
    Write"\n"
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
    PrintMenuSingle(menu,skipItems,menuCount)
    Write("\n")
  end

  --PrintMenu(menu,0,menuCount,skipItems)
  --DEBUGNOW

  --InfMenu.DisplaySetting(InfMenu.currentIndex)
  print"--done--"
end
main()
