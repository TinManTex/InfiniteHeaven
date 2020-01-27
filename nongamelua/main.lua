--main.lua
externalLoad=true

projectDataPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/Data1Lua/"


package.path=package.path..";./?.lua"

package.path=package.path..";./nonmgscelua/SLAXML/?.lua"

package.cpath=package.cpath..";./MockFox/?.dll"
package.path=package.path..";./Data1Lua/Tpp/?.lua"
package.path=package.path..";./Data1Lua/Assets/tpp/script/lib/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/afgh/?.lua"
package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/mafr/?.lua"

package.path=package.path..";./ExternalLua/?.lua"
package.path=package.path..";./ExternalLua/modules/?.lua"

package.path=package.path..";./nonmgscelua/?.lua"

--

bit=require"bit"

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

loadfile=function(path)
  return loadfile(projectDataPath..path)
end

dofile("MockFox/MockFoxEngine.lua")

print"parse main.lua: MockFoxEngine done"

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

TppQuest={}
--SYNC: TppQuest
TppQuest.QUEST_CATEGORIES={
  "STORY",--11,7,2,2
  "EXTRACT_INTERPRETER",--4,2,2
  "BLUEPRINT",--6,4,2,Secure blueprint
  "EXTRACT_HIGHLY_SKILLED",--16,9,,Extract highly-skilled soldier
  "PRISONER",--20,10,Prisoner extraction
  "CAPTURE_ANIMAL",--4,2,
  "WANDERING_SOLDIER",--10,5,Wandering Mother Base soldier
  "DDOG_PRISONER",--5,Unlucky Dog
  "ELIMINATE_HEAVY_INFANTRY",--16
  "MINE_CLEARING",--10
  "ELIMINATE_ARMOR_VEHICLE",--14,Eliminate the armored vehicle unit
  "EXTRACT_GUNSMITH",--3,Extract the Legendary Gunsmith
  --"EXTRACT_CONTAINERS",--1, #110
  --"INTEL_AGENT_EXTRACTION",--1, #112
  "ELIMINATE_TANK_UNIT",--14
  "ELIMINATE_PUPPETS",--15
  "TARGET_PRACTICE",--7,0,0,7
}

TppTerminal={}
TppTerminal.MBDVCMENU={}
TppUiCommand={}--TODO IMPLEMENT
TppUiCommand.AnnounceLogDelayTime=function()
end
TppUiCommand.AnnounceLogView=function(string)
  print(string)
end

InfCore=require"InfCore"
InfPersistence=require"InfPersistence"

--InfModelProc=require"InfModelProc"--TODO get working


ivars={}--tex GLOBAL
evars={}--tex GLOBAL


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
Script.LoadLibrary"/Assets/tpp/script/lib/TppDefine.lua"
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

yield()

--loadfile"Tpp/Scripts/System/start2nd.lua"
--do
--  local e=coroutine.create(loadfile"Tpp/Scripts/System/start2nd.lua")
--  repeat
--    coroutine.yield()
--    local a,t=coroutine.resume(e)
--    if not a then
--      error(t)
--    end
--  until coroutine.status(e)=="dead"
--end
--if TppSystemUtility.GetCurrentGameMode()=="MGO"then
--  dofile"Tpp/Scripts/System/start3rd.lua"
--end


print"parse: start done"

--TODO really do need to module load these since TppDefine is already loaded at this point
---------
afgh_routeSets=require"afgh_routeSets"
mafr_routeSets=require"mafr_routeSets"
afgh_travelPlans=require"afgh_travelPlans"
mafr_travelPlans=require"mafr_travelPlans"

--TppDefine=require"TppDefine"
InfInspect=require"InfInspect"

IvarProc=require"IvarProc"
InfButton=require"InfButton"

Mock=true--tex indicator to stop InfMain from running loadexternalmodules on its load
InfMain=require"InfMain"
InfLookup=require"InfLookup"

Ivars=require"Ivars"
Ivars.SetupIvars()--tex doesn't run on Ivars.lua load since wrapped in InfCore.PCall
InfLang=require"InfLang"
Ivars.PostAllModulesLoad()

InfMenuCommands=require"InfMenuCommands"
InfMenuDefs=require"InfMenuDefs"
InfMenu=require"InfMenu"
InfAutoDoc=require"InfAutoDoc"

InfLZ=require"InfLZ"



InfEquip=require"InfEquip"
InfEneFova=require"InfEneFova"
InfFova=require"InfFova"




--LOCALOPT
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString

--AutoDoc>

--PATCHUP
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

print("parse main.lua: Inf Mock done")

--local ins=InfInspect.Inspect(ivars)--
--print(ins)

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
  local SLAXML=require"slaxml"
  local xmlFile=[[J:\GameData\MGS\demofilesnocam\Assets\tpp\pack\mission2\free\f30050\f30050_d071_fpkd\Assets\tpp\demo\fox_project\p51_010020\fox\p51_010020_demo.fox2.xml]]
  local myxml=io.open(xmlFile):read('*all')
  --SLAXML:parse(myxml)

  --  SLAXML:parser{
  --    startElement = function(name,nsURI,nsPrefix) print("startElement:"..name)      end, -- When "<foo" or <x:foo is seen
  --    attribute    = function(name,value,nsURI,nsPrefix) end, -- attribute found on current element
  --    closeElement = function(name,nsURI)                end, -- When "</foo>" or </x:foo> or "/>" is seen
  --    text         = function(text)                      end, -- text and CDATA nodes
  --    comment      = function(content)                   end, -- comments
  --    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  --  }:parse(myxml)

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


local function WriteDefaultIvarProfile()
  local outPutFile="D:\\Projects\\MGS\\!InfiniteHeaven\\default profile raw.lua"
  local f=io.open(outPutFile,"w")

  local function WriteLine(text)
    f:write(text,"\n")
  end

  WriteLine("local profiles={}")
  WriteLine("profiles.defaults={")

  local ivarNames={}

  local SortFunc=function(a,b) return a < b end

  local optionType="OPTION"
  for name,ivar in pairs(Ivars) do
    if type(ivar)=="table" then
      if ivar.save then
        if ivar.optionType==optionType then
          if not ivar.nonUser and not ivar.nonConfig then
            table.insert(ivarNames,name)
          end
        end
      end
    end
  end
  table.sort(ivarNames,SortFunc)
  --InfInspect.PrintInspect(ivarNames)

  -- TODO add SETTINGS, range as comment
  for i,name in ipairs(ivarNames) do
    local optionName=InfLang.eng[name] or InfLang.help.eng[name] or ""
    local ivar=Ivars[name]
    local line="\t"..name.."="..tostring(ivar.default)..",--"..optionName
    WriteLine(line)
    --WriteLine("  "..name.."="..tostring(ivar.default)..",--"..optionName)
  end


  WriteLine("}")
  WriteLine("return this")
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


local function TestGamePath()
  local function Split(str,delim,maxNb)
    -- Eliminate bad cases...
    if string.find(str,delim)==nil then
      return{str}
    end
    if maxNb==nil or maxNb<1 then
      maxNb=0--No limit
    end
    local result={}
    local pat="(.-)"..delim.."()"
    local nb=0
    local lastPos
    for part,pos in string.gfind(str,pat) do
      nb=nb+1
      result[nb]=part
      lastPos=pos
      if nb==maxNb then break end
    end
    -- Handle the last field
    if nb~=maxNb then
      result[nb+1]=string.sub(str,lastPos)
    end
    return result
  end


  -- local pathTest=[[.\?.lua;C:\GamesSD\MGS_TPP\lua\?.lua;C:\GamesSD\MGS_TPP\lua\?\init.lua;C:\GamesSD\MGS_TPP\?.lua;C:\GamesSD\MGS_TPP\?\init.lua]]

  --local pathTest=[[.\?.lua;C:\GamesSD\MGS_TPP\lua\?.lua;C:\GamesSD\MGS_TPP\lua\?\init.lua;C:\GamesSD\MGS_TPP\?.lua;C:\GamesSD\MGS_TPP\?\init.lua]]
  --local pathTest=[[.\?.lua;C:\Program Files (x86)\Steam\steamapps\common\MGS_TPP\lua\?.lua;C:\GamesSD\MGS_TPP\lua\?\init.lua;C:\GamesSD\MGS_TPP\?.lua;C:\GamesSD\MGS_TPP\?\init.lua]]
  local pathTest=[[;.\?.lua;C:\Program Files (x86)\Steam\steamapps\common\MGS_TPP\lua\?.lua;C:\Program Files (x86)\Steam\steamapps\common\MGS_TPP\lua\?\init.lua;C:\Program Files (x86)\Steam\steamapps\common\MGS_TPP\?.lua;C:\Program Files (x86)\Steam\steamapps\common\MGS_TPP\?\init.lua;C:\Program Files (x86)\Lua\5.1\lua\?.luac]]

  local function GetGamePath()
    local gamePath=""
    local paths=Split(package.path,";")
    local paths=Split(pathTest,";")--DEBUG
    for i,path in ipairs(paths) do
      if string.find(path,"MGS_TPP") then
        gamePath=path
        break
      end
    end
    local stripLength=10--tex length "\lua\?.lua"
    gamePath=gamePath:gsub("\\","/")--tex because escaping sucks
    gamePath=gamePath:sub(1,-stripLength)
    return gamePath
  end
  print(GetGamePath())
end

local function GenerateLzs()
  local lzNamesPure={
    afgh={
      "lz_cliffTown_I0000|lz_cliffTown_I_0000",
      "lz_commFacility_I0000|lz_commFacility_I_0000",
      "lz_enemyBase_I0000|lz_enemyBase_I_0000",
      "lz_field_I0000|lz_field_I_0000",
      "lz_fort_I0000|lz_fort_I_0000",
      "lz_powerPlant_E0000|lz_powerPlant_E_0000",
      "lz_remnants_I0000|lz_remnants_I_0000",
      "lz_slopedTown_I0000|lz_slopedTown_I_0000",
      "lz_sovietBase_E0000|lz_sovietBase_E_0000",
      "lz_tent_I0000|lz_tent_I_0000",
      "lz_bridge_S0000|lz_bridge_S_0000",
      "lz_citadelSouth_S0000|lz_citadelSouth_S_0000",
      "lz_cliffTown_N0000|lz_cliffTown_N_0000",
      "lz_cliffTown_S0000|lz_cliffTown_S_0000",
      "lz_cliffTownWest_S0000|lz_clifftownWest_S_0000",
      "lz_commFacility_N0000|lz_commFacility_N_0000",
      "lz_commFacility_S0000|lz_commFacility_S_0000",
      "lz_commFacility_W0000|lz_commFacility_W_0000",
      "lz_enemyBase_N0000|lz_enemyBase_N_0000",
      "lz_enemyBase_S0000|lz_enemyBase_S_0000",
      "lz_field_N0000|lz_field_N_0000",
      "lz_field_W0000|lz_field_W_0000",
      "lz_fieldWest_S0000|lz_fieldWest_S_0000",
      "lz_fort_E0000|lz_fort_E_0000",
      "lz_fort_W0000|lz_fort_W_0000",
      "lz_powerPlant_S0000|lz_powerPlant_S_0000",
      "lz_remnants_S0000|lz_remnants_S_0000",
      "lz_remnantsNorth_N0000|lz_remnantsNorth_N_0000",
      "lz_remnantsNorth_S0000|lz_remnantsNorth_S_0000",
      "lz_ruins_S0000|lz_ruins_S_0000",
      "lz_ruinsNorth_S0000|lz_ruinsNorth_S_0000",
      "lz_slopedTown_E0000|lz_slopedTown_E_0000",
      "lz_slopedTown_W0000|lz_slopedTown_W_0000",
      "lz_slopedTownEast_E0000|lz_slopedTownEast_E_0000",
      "lz_sovietBase_N0000|lz_sovietBase_N_0000",
      "lz_sovietBase_S0000|lz_sovietBase_S_0000",
      "lz_sovietSouth_S0000|lz_sovietSouth_S_0000",
      "lz_tent_E0000|lz_tent_E_0000",
      "lz_tent_N0000|lz_tent_N_0000",
      "lz_village_N0000|lz_village_N_0000",
      "lz_village_W0000|lz_village_W_0000",
      "lz_waterway_I0000|lz_waterway_I_0000",
    },
    mafr={
      "lz_banana_I0000|lz_banana_I_0000",
      "lz_diamond_I0000|lz_diamond_I_0000",
      "lz_flowStation_I0000|lz_flowStation_I_0000",
      "lz_hill_I0000|lz_hill_I_0000",
      "lz_pfCamp_I0000|lz_pfCamp_I_0000",
      "lz_savannah_I0000|lz_savannah_I_0000",
      "lz_swamp_I0000|lz_swamp_I_0000",
      "lz_bananaSouth_N0000|lz_bananaSouth_N",
      "lz_diamond_N0000|lz_diamond_N_0000",
      "lz_diamondSouth_S0000|lz_diamondSouth_S_0000",
      "lz_diamondSouth_W0000|lz_diamondSouth_W_0000",
      "lz_diamondWest_S0000|lz_diamondWest_S_0000",
      "lz_factory_N0000|lz_factory_N_0000",
      "lz_factoryWest_S0000|lz_factoryWest_S_0000",
      "lz_flowStation_E0000|lz_flowStation_E_0000",
      "lz_hill_E0000|lz_hill_E_0000",
      "lz_hill_N0000|lz_hill_N_0000",
      "lz_hillNorth_N0000|lz_hillNorth_N_0000",
      "lz_hillNorth_W0000|lz_hillNorth_W_0000",
      "lz_hillSouth_W0000|lz_hillSouth_W_0000",
      "lz_hillWest_S0000|lz_hillWest_S_0000",
      "lz_lab_S0000|lz_lab_S_0000",
      "lz_lab_W0000|lz_lab_W_0000",
      "lz_labWest_W0000|lz_labWest_W_0000",
      "lz_outland_N0000|lz_outland_N_0000",
      "lz_outland_S0000|lz_outland_S_0000",
      "lz_pfCamp_N0000|lz_pfCamp_N_0000",
      "lz_pfCamp_S0000|lz_pfCamp_S_0000",
      "lz_pfCampNorth_S0000|lz_pfCampNorth_S_0000",
      "lz_savannahEast_N0000|lz_savannahEast_N_0000",
      "lz_savannahEast_S0000|lz_savannahEast_S_0000",
      "lz_savannahWest_N0000|lz_savannahWest_N_0000",
      "lz_swamp_N0000|lz_swamp_N_0000",
      "lz_swamp_S0000|lz_swamp_S_0000",
      "lz_swamp_W0000|lz_swamp_W_0000",
      "lz_swampEast_N0000|lz_swampEast_N_0000",
    },
  }

  local generatedLzs={
    afgh={},
    mafr={},
  }

  local function InsertTag(insString,find,tag)
    local insStart,insEnd=string.find(insString,find)
    if insStart==nil then
      return nil
    end
    return string.sub(insString,1,insEnd)..tag..string.sub(insString,insEnd+1,string.len(insString))
  end

  for loc,lzs in pairs(lzNamesPure)do
    local locLzs=generatedLzs[loc]
    for i,lz in ipairs(lzs)do
      local lzInfo={}
      --ASSUMPTIONS world not mbts lzs
      local rt=string.gsub(lz,"|lz_","|rt_")
      lzInfo.approachRoute=InsertTag(rt,"|rt_","apr_")
      lzInfo.returnRoute=InsertTag(rt,"|rt_","rtn_")
      lzInfo.dropRoute=InsertTag(rt,"|rt_","drp_")
      lzInfo.dropRoute=InsertTag(lzInfo.dropRoute,"lz_","drp_")
      if string.find(rt,"_I_") then
        lzInfo.isAssault=true
      end
      locLzs[lz]=lzInfo
    end
  end

  local insp=InfInspect.Inspect(generatedLzs)
  print(insp)
end

local function PatchDemos()
  print"PatchDemos"
  --TODO doesnt cover more than one demodata in a file
  local demosPath=[[J:\GameData\MGS\demofilesnocam\]]
  local outFile=demosPath.."demoFileNames.txt"
  local cmd=[[dir /b /s "]]..demosPath..[[*.xml" > "]]..outFile
  print(cmd)
  os.execute(cmd)

  local file=io.open(outFile,"r")
  local demoFiles = {}
  -- read the lines in table 'lines'
  for line in file:lines() do
    table.insert(demoFiles, line)
  end
  file:close()


  local nl='\n'

  for i,fileName in ipairs(demoFiles)do
    local newDoc=""

    --
    local propertyLocations={}

    --local fileName=[[J:\GameData\MGS\demofilesnocam\Assets\tpp\pack\mission2\free\f30050\f30050_d071_fpkd\Assets\tpp\demo\fox_project\p51_010020\fox\p51_010020_demo.fox2.xml]]
    print(fileName)
    local file=io.open(fileName,"r")
    local fileLines={}
    -- read the lines in table 'lines'
    for line in file:lines()do
      table.insert(fileLines,line)
    end
    file:close()

    --tex find cameratypes and mark start/end of lines in that property
    for lineNumber,line in ipairs(fileLines)do
      if string.find(line,[[<property name="cameraTypes"]]) then
        if not string.find(line,[[/>]]) then--tex skip empty
          if not string.find(fileLines[lineNumber+1],[[</property>]]) then--tex also skip empty
            propertyLocations[#propertyLocations+1]={}
            propertyLocations[#propertyLocations][1]=lineNumber+1
            --tex find closing
            for ln=lineNumber+1,#fileLines do
              if string.find(fileLines[ln],[[</property>]]) then
                propertyLocations[#propertyLocations][2]=ln-1
                break
              end
            end
        end
        end
      end
    end

    --tex build lookup for simplicity
    local skipLines={}
    for i,propertyLineInfo in ipairs(propertyLocations) do
      for i=propertyLineInfo[1],propertyLineInfo[2]do
        skipLines[i]=true
      end
    end

    local newDoc={}
    for lineNumber,line in ipairs(fileLines)do
      if not skipLines[lineNumber]then
        newDoc[#newDoc+1]=line
      end
    end

    local ins=InfInspect.Inspect(propertyLocations)
    print(ins)

    local ins=InfInspect.Inspect(skipLines)
    print(ins)


    --local ins=InfInspect.Inspect(newDoc)
    --print(ins)
    --DEBUGlocal fileName=[[J:\GameData\MGS\demofilesnocam\Assets\tpp\pack\mission2\free\f30050\f30050_d071_fpkd\Assets\tpp\demo\fox_project\p51_010020\fox\p51_010020_demoP.fox2.xml]]
    local file=io.open(fileName,"w")
    file:write(table.concat(newDoc,nl))
    file:close()

  end

end

local function CullExeStrings()
  print"CullExeStrings"

  --TODO doesnt cover more than one demodata in a file
  local stringsPath=[[D:\Projects\MGS\tools-other\Strings\]]
  local inFile=stringsPath.."mgsvtppstrings.txt"
  local outFile=stringsPath.."mgsvtppstringsculled.txt"

  local file=io.open(inFile,"r")
  if file==nil then
    print("cant find "..inFile)
    return
  end
  local strings = {}
  -- read the lines in table 'lines'
  local skipList={
    --   [[.]],
    " ",
    --    "\t",
    "!",
    [[\%]],

    "@",
  --    "<",
  --    ">",
  --    "(",
  --    ")",
  --    "=",
  --    [[,]],
  --    [[\]],
  --    [[/]],
  --    [[:]],
  }
  for line in file:lines() do
--print(line)
    local ok=true
--    --for i,char in ipairs(skipList) do
      if string.find(line,"%W")  or
string.find(line,"%A") or
 string.find(line," ")then
        ok=false
      end
--    --end
    if ok then
      print(line)
      table.insert(strings,line)
    end
  end
  file:close()


  local nl='\n'

  local file=io.open(outFile,"w")
  for i,line in ipairs(strings)do
  file:write([["]]..line..[[",]]..nl)
  end
  file:close()



end

local function main()
  print("main()")

  print(package.path)

  print(os.date("%x %X"))
  print(os.time())

  print"Running AutoDoc"
  InfAutoDoc.AutoDoc()
  --WriteDefaultIvarProfile()

  --PrintEquipId()

  --PrintGenericRoutes()
  --PrintGenericRoutes2()

  --PrintIvars()

  --CheckSoldierFova()

  --BuildFovaTypesList()
  -- FaceDefinitionAnalyse()








  --  LangDictionaryAttack=require"LangDictionaryAttack"
  --  LangDictionaryAttack.Run()
  --Data=require"Data"
  -- XmlTest()
  --PatchDemos()

  --local ExtensionOrder=require"ExtensionOrder"


  --
  --GetFilesOfType("mtar")

  --create string table
  local function readAll(file)
    local f = io.open(file, "r")
    local content = f:read("*all")
    f:close()
    return content
  end

  local strcodetxt=[[D:\Projects\MGS\Tools\lang_dictionary.txt]]
  local strcodetxtout=[[D:\Projects\MGS\Tools\lang_dictionary_txttable.txt]]
  local allTxt=readAll(strcodetxt)
  local outTxt={
    }
  local file,error=io.open(strcodetxt,"r")
  if file then
    while true do
      local line=file:read()
      if line==nil then break end
      local line='\"'..line..'\",'
      table.insert(outTxt,line)
    end
    file:close()
  end

  local f=io.open(strcodetxtout,"w")

  f:write(table.concat(outTxt,"\n"))
  --print(equipId)
  f:close()

  --
  --for i=406,458 do
  --  print(i..",")
  --end


  --  for i=459,511 do
  --    print(i..",")
  --  end
  -- GenerateLzs()

  --CullExeStrings()

  print"main done"
end

--function e.cboxCamoType(boxId)
--  local boxTypes={
--    desert={TppEquip.EQP_IT_CBox_DSR,TppEquip.EQP_IT_CBox_DSR_G01,TppEquip.EQP_IT_CBox_DSR_G02},
--    green={TppEquip.EQP_IT_CBox_FRST,TppEquip.EQP_IT_CBox_FRST_G01},
--    red={TppEquip.EQP_IT_CBox_BOLE,TppEquip.EQP_IT_CBox_BOLE_G01},
--    urban={TppEquip.EQP_IT_CBox_CITY,TppEquip.EQP_IT_CBox_CITY_G01},
--    mix={TppEquip.EQP_IT_CBox_CLB_A,TppEquip.EQP_IT_CBox_CLB_A_G01},
--    rock={TppEquip.EQP_IT_CBox_CLB_B,TppEquip.EQP_IT_CBox_CLB_B_G01},
--    wet={TppEquip.EQP_IT_CBox_CLB_C,TppEquip.EQP_IT_CBox_CLB_C_G01}
--  }
--
--  for camoType,equipIds in pairs(boxTypes) do
--    for i,equipId in ipairs(equipIds)do
--      if boxId==equipId then
--        return camoType
--      end
--    end
--  end
--
--  return false
--end
--
--local stealthItems={
--  [TppEquip.EQP_IT_InstantStealth]="limited",
--  [TppEquip.EQP_IT_Stealth]="battery",
--  [TppEquip.EQP_IT_ParasiteCamouf]="parasite",
--}
--
--function e.isStealthItem(item)
--  return stealthItems[item] or false
--end
--
--function e.stealthItemType(item)
--  return stealthItems[item]
--end



main()
