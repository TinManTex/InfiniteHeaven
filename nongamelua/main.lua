--main.lua
local this={}

--tex MockFox
local LoadLDT=dofile('../MockFoxLua/loadLDT.lua')
LoadLDT.Load{
  gameId="tpp",
  --tex MockFox host stuff
  luaHostType="LDT",

  foxGamePath="c:/Steam/SteamApps/common/MGS_TPP/",--tex used to reconstruct package.path to what it looks like in mgstpp, IH uses this to get the game path so it can load files in game folder\mod

  foxLuaPath="C:/Projects/MGS/InfiniteHeaven/tpp/data1_dat-lua/",--tex path of tpps scripts (qar luas) -- IH
  --foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified

  mockFoxPath="C:/Projects/MGS/InfiniteHeaven/MockFoxLua/",--tex path of MockFox scripts
}

--
----non mock stuff >
--package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/afgh/?.lua"
--package.path=package.path..";./FpkdCombinedLua/Assets/tpp/script/location/mafr/?.lua"

package.path=package.path..";./nonmgscelua/?.lua"--for AutoDoc
--package.path=package.path..";./nonmgscelua/SLAXML/?.lua"


--TODO really do need to module load these since TppDefine is already loaded at this point
---------

--afgh_routeSets=require"afgh_routeSets"
--mafr_routeSets=require"mafr_routeSets"
--afgh_travelPlans=require"afgh_travelPlans"
--mafr_travelPlans=require"mafr_travelPlans"

--LOCALOPT
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString

--AutoDoc>

--PATCHUP
InfEquip.tppEquipTableTest={"<DEBUG IVAR>"}



--local ins=InfInspect.Inspect(ivars)--
--print(ins)

-- end autodoc


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

        local description=InfLangProc.CpNameString(cpName,"afgh") or InfLangProc.CpNameString(cpName,"mafr") or ""

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
        description=InfLangProc.CpNameString(lrrpCpName,"afgh") or InfLangProc.CpNameString(lrrpCpName,"mafr") or ""
      end


      local tids=lrrpNumbers[moduleName][i]


      local numTids=0
      for _lrrpNumber,bool in pairs(tids)do
        local _lrrpCpName=CpNameForLrrpNumber(lrrpNumberDefine,_lrrpNumber)
        local _description=InfLangProc.CpNameString(_lrrpCpName,"afgh") or InfLangProc.CpNameString(_lrrpCpName,"mafr") or ""
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
  --local xmlFile=[[J:\GameData\MGS\demofilesnocam\Assets\tpp\pack\mission2\free\f30050\f30050_d071_fpkd\Assets\tpp\demo\fox_project\p51_010020\fox\p51_010020_demo.fox2.xml]]
  --local xmlFile=[[J:\GameData\MGS\filetypecrushed\fox2\misc\afgn_fort_light.fox2.xml]]
  local xmlFile=[[D:\Projects\MGS\!wip\oldmotherbase\ombs_common_env.fox2.xml]]

  --local xmlFile=[[J:\GameData\MGS\filetypecrushed\lng2\tpp_common.eng.lng2.xml]]
  local myxml=io.open(xmlFile):read('*all')
  --SLAXML:parse(myxml)

  --local lngTable={}

  --  SLAXML:parser{
  --    startElement = function(name,nsURI,nsPrefix) print("startElement:"..name)      end, -- When "<foo" or <x:foo is seen
  --    attribute    = function(name,value,nsURI,nsPrefix)
  --      if name=="LangId" or name=="Key" then
  --        lngTable[name]={}
  --      end
  --    end, -- attribute found on current element
  --    closeElement = function(name,nsURI)                end, -- When "</foo>" or </x:foo> or "/>" is seen
  --    text         = function(text)                      end, -- text and CDATA nodes
  --    comment      = function(content)                   end, -- comments
  --    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  --  }:parse(myxml)

  --simple to table
  local SLAXML = require 'slaxdom' -- also requires slaxml.lua; be sure to copy both files
  local doc = SLAXML:dom(myxml)
  --local ins=InfInspect.Inspect(doc)
  --  print(ins)

  --      local ins=InfInspect.Inspect(doc.root.el)
  --    print(ins)
  local function FindNamedElement(element,findName)
    local foundElement
    for i,childElement in ipairs(element.el)do
      if childElement.name==findName then
        foundElement=childElement
        break
      end
    end
    return foundElement
  end

  local function FindNamedAttributeEquals(element,findName,findEquals)
    local foundElement
    for i,childElement in ipairs(element.el)do
      if childElement.attr[findName]==findEquals then
        foundElement=childElement
        break
      end
    end
    return foundElement
  end

  local function GetText(element)
    local foundText
    for i,node in ipairs(element.kids)do
      if node.type=='text'then
        foundText=node.value
      end
    end
    return foundText
  end

  --tex ASSUMPTION fox2 entity < property name=> <value>text</value></property

  local function GetPropertyValue(property)
    local value
    if property then
      local valueEl=FindNamedElement(property,'value')
      value=GetText(valueEl)
    end
    return value
  end



  local entityElements={}
  local allEntities={}
  local parentage={}
  local ownership={}
  local entityElements={}
  local xEntities=FindNamedElement(doc.root,'entities')

  local dataSetAddr
  local dataList
  for i,xEntity in ipairs(xEntities.el)do
    if xEntity.attr.class=='DataSet' then
      dataSetAddr=xEntity.attr.addr
      local staticProperties=FindNamedElement(xEntity,'staticProperties')

      dataList=FindNamedAttributeEquals(staticProperties,'name','dataList')
      break
    end
  end

  print('dataSetAddr:'..dataSetAddr)


  for i,n in ipairs(dataList.el)do
    local entitiyName=n.attr.key
    local entityAddr=GetText(n)
    entityElements[entitiyName]=entityAddr
    entityElements[entityAddr]=entitiyName
  end




  --  for _,docNode in ipairs(doc.kids) do
  --
  --    local ins=InfInspect.Inspect(docNode)
  --    print(ins)
  --  end

  --
  --REF
  --fox
  --entities
  -- entity
  --  ...

  --for xEntities
  --    check parent
  --    check childred

  for i,xEntity in ipairs(xEntities.el)do
    local class=xEntity.attr.class
    local addr=xEntity.attr.addr
    --print(class)--DEBUG
    --print(addr)--DEBUG
    allEntities[addr]=xEntity


    local staticProperties=FindNamedElement(xEntity,'staticProperties')

    local parent=FindNamedAttributeEquals(staticProperties,'name','parent')
    parent=GetPropertyValue(parent)
    if parent then
      if parent~="0x00000000" then
        --print("parent="..parent)--DEBUG
        local entry=parentage[addr]or{}
        entry.parent=parent
        parentage[addr]=entry
      end
    end
    local children=FindNamedAttributeEquals(staticProperties,'name','children')
    if children then
      for i,n in ipairs(children.el)do--<value>s
        local child=GetText(n)
        if child=="0x00000000" then
          InfCore.Log("WARNING entity "..addr.. " has a child as 0x00000000")--DEBUG
        end

        local entry=parentage[addr]or{}
        entry.children=entry.children or {}
        entry.children[child]=true
        parentage[addr]=entry
      end
    end

    local owner=FindNamedAttributeEquals(staticProperties,'name','owner')
    owner=GetPropertyValue(owner)
    if owner then
      local entry=ownership[addr]or{}
      entry.owner=owner
      ownership[addr]=entry

      local entry=ownership[owner]or{}
      entry.owns=entry.owns or {}
      entry.owns[addr]=true
      ownership[owner]=entry
    end

    --TODO
    --for each property
    -- for each value text
    --if is 0x address
    --add to references (or if preoperty.attr.name==parent or children or owner
  end


  --  InfCore.PrintInspect(entities,"entities")
  InfCore.PrintInspect(parentage,"parentage")

  --  InfCore.PrintInspect(ownership,"ownership")
  for addr,xEntity in pairs(entityElements)do
  --  print(xEntity.attr.class)
  end


  for entityAddr,parentInfo in pairs(parentage)do
    if parentInfo.parent then
      if not allEntities[parentInfo.parent] then
        InfCore.Log("!!"..parentInfo.parent .." has no entity entry")
      end
    end
    if parentInfo.children then
      for childAddr,bool in pairs(parentInfo.children)do
        if not allEntities[childAddr] then
          InfCore.Log("!!"..childAddr .." has no entity entry")
        end
      end
    end
  end


  for entityAddr,parentInfo in pairs(ownership)do
    if parentInfo.owner then
      if not allEntities[parentInfo.owner] then
        InfCore.Log("!!"..parentInfo.owner .." has no entity entry")
      end
    end
    if parentInfo.owns then
      for childAddr,bool in pairs(parentInfo.owns)do
        if not allEntities[childAddr] then
          InfCore.Log("!!"..childAddr .." has no entity entry")
        end
      end
    end
  end

  local function AddChildren(node,children)
    for childAddr,bool in pairs(children)do
      node[childAddr]={}
      if not parentage[childAddr] then
      elseif parentage[childAddr].children then
        AddChildren(node[childAddr],parentage[childAddr].children)
      end
    end
  end

  local parentTree={}
  for entityAddr,parentInfo in pairs(parentage)do
    if parentInfo.children and not parentInfo.parent then
      parentTree[entityAddr]={}
      AddChildren(parentTree[entityAddr],parentInfo.children)
    end
  end

  InfCore.PrintInspect(parentTree)

end

--<end xmlparse

--print ivars
local function PrintIvars()
  local outPutFile="C:\\Projects\\MGS\\InfiniteHeaven\\ivars.lua"
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
  local outPutFile="C:\\Projects\\MGS\\InfiniteHeaven\\default profile raw.lua"
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
      local split=MockUtil.Split(entry[1],"/")
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
    for part,pos in string.gmatch(str,pat) do
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

--tex processes demo .fox2s for the free camera cutscene mods, removes entries within property name="cameraTypes"
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

local function BitmapShit()
  TppDefine=TppDefine or {}
  TppDefine.LOCATION_ID=TppDefine.LOCATION_ID or {}
  TppDefine.LOCATION_ID.AFGH=1
  TppDefine.LOCATION_ID.MAFR=2

  local questAreas={
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="tent",         loadArea={116,134,131,152},activeArea={117,135,130,151},invokeArea={117,135,130,151}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="field",        loadArea={132,138,139,155},activeArea={133,139,138,154},invokeArea={133,139,138,154}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="ruins",        loadArea={140,138,148,154},activeArea={141,139,147,153},invokeArea={141,139,147,153}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="waterway",     loadArea={117,125,131,133},activeArea={118,126,130,132},invokeArea={118,126,130,132}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="cliffTown",    loadArea={132,120,141,137},activeArea={133,121,140,136},invokeArea={133,121,140,136}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="commFacility", loadArea={142,128,153,137},activeArea={143,129,152,136},invokeArea={143,129,152,136}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="sovietBase",   loadArea={112,114,131,124},activeArea={113,115,130,123},invokeArea={113,115,130,123}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="fort",         loadArea={142,116,153,127},activeArea={143,117,152,126},invokeArea={143,117,152,126}},
    {locationId=TppDefine.LOCATION_ID.AFGH,areaName="citadel",      loadArea={118,105,125,113},activeArea={119,106,124,112},invokeArea={119,106,124,112}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="outland",      loadArea={121,124,132,150},activeArea={122,125,131,149},invokeArea={122,125,131,149}},

    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="pfCamp",       loadArea={133,139,148,150},activeArea={134,140,147,149},invokeArea={134,140,147,149}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="savannah",     loadArea={133,129,145,138},activeArea={134,130,144,137},invokeArea={134,130,144,137}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="hill",         loadArea={146,129,159,138},activeArea={147,130,158,137},invokeArea={147,130,158,137}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="banana",       loadArea={133,110,141,128},activeArea={134,111,140,127},invokeArea={134,111,140,127}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="diamond",      loadArea={142,110,149,128},activeArea={143,111,148,127},invokeArea={143,111,148,127}},
    {locationId=TppDefine.LOCATION_ID.MAFR,areaName="lab",          loadArea={150,110,159,128},activeArea={151,111,158,127},invokeArea={151,111,158,127}},
  }

  local colors={
    {r=1,   g=0,    b=0},--tent
    {r=0.5, g=0,    b=0},--field
    {r=0,   g=1,    b=0},--ruins
    {r=0,   g=0.5,  b=0},--waterway
    {r=0,   g=0,    b=1},--cliffTown
    {r=0,   g=0,    b=0.5},--commFacility
    {r=1,   g=1,    b=0},--sovietBase
    {r=0.5, g=0.5,  b=0},--fort
    {r=0,   g=0.5,  b=0.5},--citadel
  }

  local BitMapWriter=require"BitMapWriter"
  local pic=BitMapWriter(200,200)
  for i,questArea in ipairs(questAreas)do
    if questArea.locationId==1 then
      local color=colors[i]

      local minX=questArea.loadArea[1]
      local minY=questArea.loadArea[2]
      local maxX=questArea.loadArea[3]
      local maxY=questArea.loadArea[4]

      local minPixel=pic[minX+1][minY+1]
      local maxPixel=pic[maxX+1][maxY+1]
      for c,v in pairs(color)do
        minPixel[c]=v
        maxPixel[c]=v
      end


    end
  end



  pic:save([[D:\Projects\MGS\plotted.bmp]])
end



--tex unique merge of files
local function MergeFiles()

  local basePath=[[D:\Projects\MGS\MGSVTOOLS\GzsTool\]]
  local fileOne=basePath.."qar_dictionary.txt"
  local fileTwo=basePath.."qar_dictionary_pauls.txt"
  local outFile=basePath.."qar_dictionary_merged.txt"

  local uniqueLines={}

  local function AddToUnique(filePath)
    local file=io.open(filePath,"r")
    if file==nil then
      print("cant find "..filePath)
      return
    end
    for line in file:lines() do
      uniqueLines[line]=true
    end
    file:close()
  end

  AddToUnique(fileOne)
  AddToUnique(fileTwo)


  local linesList={}
  for line,bool in pairs(uniqueLines)do
    table.insert(linesList,line)
  end

  table.sort(linesList)

  local nl='\n'

  local file=io.open(outFile,"w")
  for i,line in ipairs(linesList)do
    file:write(line..nl)
  end
  file:close()
end

--XML parse, from http://lua-users.org/wiki/LuaXml
--tex tweaked a bit
function this.ParseArgs(s)
  local hasArgs=false
  local arg = {}
  string.gsub(s, "([%-%w]+)=([\"'])(.-)%2", function (w, _, a)
    if a then
      hasArgs=true
      arg[w] = a
    end
  end)
  if hasArgs then
    return arg
  else
    return nil
  end
end

function this.Collect(xmlString)
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,label,xarg, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,xarg, empty = string.find(xmlString, "<(%/?)([%w:_-]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(xmlString, i, ni-1)
    if not string.find(text, "^%s*$") then
      table.insert(top, text)
    end
    if empty == "/" then  -- empty element tag
      table.insert(top, {label=label, xarg=this.ParseArgs(xarg), empty=1})
    elseif c == "" then   -- start tag
      top = {label=label, xarg=this.ParseArgs(xarg)}
      table.insert(stack, top)   -- new level
    else  -- end tag
      local toclose = table.remove(stack)  -- remove top
      top = stack[#stack]
      if #stack < 1 then
        error("nothing to close with "..label)
      end
      if toclose.label ~= label then
        error("trying to close "..toclose.label.." with "..label)
      end
      table.insert(top, toclose)
    end
    i = j+1
  end
  local text = string.sub(xmlString, i)
  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error("unclosed "..stack[#stack].label)
  end
  return stack[1]
end

--xml util
function this.FindNodeByLabelName(rootNode,labelName)
  for k,v in ipairs(rootNode)do
    if v.label==labelName then
      return v
    end
  end
end

-- xml collect table > own format transform
function this.XMLToLngTable(fileName)
  local xmlString=io.open(fileName):read('*all')
  local xmlTable=this.Collect(xmlString)

  InfCore.PrintInspect(xmlTable)

  local lngTable={}

  local langFileNode=this.FindNodeByLabelName(xmlTable,"LangFile")
  local entriesNode=this.FindNodeByLabelName(langFileNode,"Entries")
  --  InfCore.PrintInspect(langFileNode,"langFileNode")
  --  InfCore.PrintInspect(entriesNode,"entriesNode")

  if entriesNode then
    for i,entry in ipairs(entriesNode)do
      if entry.label=="Entry" then
        if entry.xarg then
          local key=entry.xarg.Key or entry.xarg.LangId
          lngTable[key]=entry.xarg.Value
          if entry.xarg.Color~="1" then
            lngTable[key]=entry.xarg.Color
          end
        end
      end
    end
  end
  InfCore.PrintInspect(lngTable)
  return lngTable
end


function this.XMLToEntityTable(fileName)
  local xmlString=io.open(fileName):read('*all')
  local xmlTable=this.Collect(xmlString)

  InfCore.PrintInspect(xmlTable)

  local entityTable={}

  local langFileNode=this.FindNodeByLabelName(xmlTable,"LangFile")
  local entriesNode=this.FindNodeByLabelName(langFileNode,"Entries")
  --  InfCore.PrintInspect(langFileNode,"langFileNode")
  --  InfCore.PrintInspect(entriesNode,"entriesNode")

  if entriesNode then
    for i,entry in ipairs(entriesNode)do
      if entry.label=="Entry" then
        if entry.xarg then
          local key=entry.xarg.Key or entry.xarg.LangId
          entityTable[key]=entry.xarg.Value
          if entry.xarg.Color~="1" then
            entityTable[key]=entry.xarg.Color
          end
        end
      end
    end
  end
  InfCore.PrintInspect(entityTable)
  return entityTable
end

-- equipid string out for strcode32 (TODO should add an implementation/library to this project).
--DEBUGNOW TODO
local function PrintEquipId()
  local outPutFile="D:\\Projects\\MGS\\equipIdStrings.txt"
  local f=io.open(outPutFile,"w")

  for i,equipId in ipairs(InfEquip.tppEquipTable)do
    f:write(equipId,"\n")
    --print(equipId)
  end
  f:close()
end


local function GetLinesUnique(path)
  print(path)
  local file=io.open(path,"r")
  local lines = {}
  -- read the lines in table 'lines'
  for line in file:lines() do
    lines[line]=true
  end
  file:close()
  return lines
end

local function GetLines(path)
  print(path)
  local file=io.open(path,"r")
  local lines = {}
  -- read the lines in table 'lines'
  for line in file:lines() do
    table.insert(lines,line)
  end
  file:close()
  return lines
end

local function FindUnacounterHashes()


  local tppDict=GetLinesUnique([[D:\GitHub\mgsv-lookup-strings\FmdlTool\fmdl_dictionary_tpp.txt]])

  local supTypes={
    "bones",
    "materials",
    "meshGroups",
    "texturetype",
    "unknown",
  }

  for i,subType in ipairs(supTypes)do
    local path = [[D:\GitHub\mgsv-lookup-strings\FmdlTool\Dictionaries\]] .. subType..".txt"
    local lines=GetLinesUnique(path)
    for line,bool in pairs(lines)do
      tppDict[line]=nil
    end
  end

  local culled={}
  for line,bool in pairs(tppDict)do
    table.insert(culled,line)
  end
  table.sort(culled)
  local nl="\r"
  local fileName=[[D:\GitHub\mgsv-lookup-strings\FmdlTool\Dictionaries\unaccounted.txt]]
  local file=io.open(fileName,"w")
  file:write(table.concat(culled,nl))
  file:close()
end

--tex input gz fmdl strings (from fmdltool fork)
--and attempt to reconstruct paths
local function ReconstructGZPaths()

  local gzFmdlStringsPath=[[D:\GitHub\mgsv-lookup-strings\FmdlTool\Strings\]]
  local outFile=[[D:\Projects\MGS\!ToolOutput\]].."dir.txt"
  local cmd=[[dir /b /s "]]..gzFmdlStringsPath..[[*.txt" > "]]..outFile
  print(cmd)
  os.execute(cmd)

  local dirs=GetLines(outFile)
  --InfCore.PrintInspect(dirs)--DEBUG

  local completeUnique={}

  for i,dir in ipairs(dirs)do
    print(dir)
    local lines=GetLines(dir)
    local paths={}
    local fileNames={}
    for i,line in ipairs(lines)do
      if string.find(line,'/') then
        table.insert(paths,line)
      elseif string.find(line,'%.') then
        table.insert(fileNames,line)
      end
    end
    --InfCore.PrintInspect(paths,"paths")--DEBUGNOW
    --InfCore.PrintInspect(fileNames,"fileNames")--DEBUGNOW
    for i,path in ipairs(paths)do
      for j,fileName in ipairs(fileNames)do
        completeUnique[path..fileName]=true
      end
    end
  end

  print("sorting and writing")
  local complete={}
  for path,bool in pairs(completeUnique)do
    table.insert(complete,path)
  end
  table.sort(complete)


  local nl="\r"
  local fileName=[[D:\Projects\MGS\!ToolOutput\gzFmdlTexturePaths.txt]]
  local file=io.open(fileName,"w")
  file:write(table.concat(complete,nl))
  file:close()


  for i,path in ipairs(complete)do
    complete[i]=InfUtil.StripExt(path)
  end
  table.sort(complete)

  local fileName=[[D:\Projects\MGS\!ToolOutput\gzFmdlTexturePathsNoExt.txt]]
  local file=io.open(fileName,"w")
  file:write(table.concat(complete,nl))
  file:close()
end

local filterChars={
  '~',
  '!',
  '@',
  '#',
  '%$',
  '%',
  '%^',
  '&',
  '*',
  '%(',
  '%)',
  '%+',
  '=',
  '{',
  '}',
  '%?',
  '<',
  '>',
  '%[',
  ']',
  '%*',

  [[']],
  [["]],


-- /
-- \
--
-- %.
--
--
--
-- %-
-- _
}

local function GetPathsFromStrings()

  local stringsPath=[[D:\GitHub\mgsv-lookup-strings\Strings\]]
  local outFile=[[D:\Projects\MGS\!ToolOutput\]].."dir.txt"
  local cmd=[[dir /b /s "]]..stringsPath..[[*.txt" > "]]..outFile
  print(cmd)
  os.execute(cmd)

  local dirs=GetLines(outFile)
  --InfCore.PrintInspect(dirs)--DEBUG

  local completeUnique={}

  for i,dir in ipairs(dirs)do
    print(dir)
    local lines=GetLines(dir)
    local fileNames={}
    for i,line in ipairs(lines)do
      if string.find(line,'[^a-z^A-Z^0-9^_^%.^/]') then
      elseif string.find(line,'/')==1 then--tex leaves out some gz paths like Z:/  and ./Tpp/
        if string.find(line,'%.') then--DEBUGNOW should actually fix stripext instead
          line=InfUtil.StripExt(line)
      end
      completeUnique[line]=true
      end
    end
  end

  print("sorting and writing")
  local complete={}
  for path,bool in pairs(completeUnique)do
    table.insert(complete,path)
  end
  table.sort(complete)


  local nl="\r"
  --  local fileName=[[D:\Projects\MGS\!ToolOutput\gzFmdlTexturePaths.txt]]
  --  local file=io.open(fileName,"w")
  --  file:write(table.concat(complete,nl))
  --  file:close()


  --  for i,path in ipairs(complete)do
  --    complete[i]=InfUtil.StripExt(path)
  --  end
  --  table.sort(complete)

  local fileName=[[D:\Projects\MGS\!ToolOutput\stringsPaths.txt]]
  local file=io.open(fileName,"w")
  file:write(table.concat(complete,nl))
  file:close()
end

local function GetCombinedObjectNamesFromStrings()

  local stringsPath=[[D:\GitHub\mgsv-lookup-strings\Strings\]]
  local outFile=[[D:\Projects\MGS\!ToolOutput\]].."dir.txt"
  local cmd=[[dir /b /s "]]..stringsPath..[[*.txt" > "]]..outFile
  print(cmd)
  os.execute(cmd)

  local dirs=GetLines(outFile)
  --InfCore.PrintInspect(dirs)--DEBUG

  local completeUnique={}

  for i,dir in ipairs(dirs)do
    print(dir)
    local lines=GetLines(dir)
    local fileNames={}
    for i,line in ipairs(lines)do
      if string.find(line,'[^a-z^A-Z^0-9^_^|]') then
      elseif string.find(line,'[|]')then
        completeUnique[line]=true
      end
    end
  end

  print("sorting and writing")
  local complete={}
  for path,bool in pairs(completeUnique)do
    table.insert(complete,path)
  end
  table.sort(complete)


  local nl="\r"
  --  local fileName=[[D:\Projects\MGS\!ToolOutput\gzFmdlTexturePaths.txt]]
  --  local file=io.open(fileName,"w")
  --  file:write(table.concat(complete,nl))
  --  file:close()


  --  for i,path in ipairs(complete)do
  --    complete[i]=InfUtil.StripExt(path)
  --  end
  --  table.sort(complete)

  local fileName=[[D:\Projects\MGS\!ToolOutput\multiObjectNames.txt]]
  local file=io.open(fileName,"w")
  file:write(table.concat(complete,nl))
  file:close()
end

local function AnalyseTapes()
  --files in J:\GameData\MGS\!master\chunk1_dat\Assets\tpp\sound\external\tape\
  local tapeFiles={
    "tp_bgm_01_01",
    "tp_bgm_02_01",
    "tp_bgm_02_02",
    "tp_bgm_02_03",
    "tp_bgm_02_04",
    "tp_bgm_03_01",
    "tp_bgm_04_01",
    "tp_bgm_04_02",
    "tp_bgm_05_01",
    "tp_bgm_05_02",
    "tp_bgm_10_01",
    "tp_bgm_10_02",
    "tp_bgm_10_03",
    "tp_bgm_10_04",
    "tp_bgm_10_05",
    "tp_bgm_10_06",
    "tp_bgm_10_07",
    "tp_bgm_11_01",
    "tp_bgm_11_02",
    "tp_bgm_11_03",
    "tp_bgm_11_04",
    "tp_bgm_11_05",
    "tp_bgm_11_06",
    "tp_bgm_11_07",
    "tp_bgm_11_08",
    "tp_bgm_11_09",
    "tp_bgm_11_10",
    "tp_bgm_11_11",
    "tp_bgm_11_12",
    "tp_bgm_11_13",
    "tp_bgm_11_14",
    "tp_bgm_11_15",
    "tp_bgm_11_16",
    "tp_bgm_11_17",
    "tp_bgm_11_18",
    "tp_bgm_11_19",
    "tp_bgm_11_20",
    "tp_bgm_11_21",
    "tp_bgm_11_22",
    "tp_bgm_11_23",
    "tp_bgm_11_24",
    "tp_bgm_11_25",
    "tp_bgm_11_26",
    "tp_bgm_11_27",
    "tp_bgm_11_28",
    "tp_bgm_11_29",
    "tp_bgm_11_30",
    "tp_bgm_11_31",
    "tp_bgm_11_32",
    "tp_bgm_11_33",
    "tp_bgm_11_34",
    "tp_c_00000_01",
    "tp_c_00000_02",
    "tp_c_00000_03",
    "tp_c_00000_04",
    "tp_c_00000_05",
    "tp_c_00000_06",
    "tp_c_00000_07",
    "tp_c_00000_08",
    "tp_c_00000_09",
    "tp_c_00000_10",
    "tp_c_00000_11",
    "tp_c_00000_12",
    "tp_c_00000_13",
    "tp_c_00000_14",
    "tp_c_00000_16",
    "tp_c_00000_17",
    "tp_c_00000_18",
    "tp_c_00001_01",
    "tp_c_00001_02",
    "tp_c_00001_03",
    "tp_c_00001_04",
    "tp_m_10010_01",
    "tp_m_10010_02",
    "tp_m_10010_03",
    "tp_m_10010_04",
    "tp_m_10010_05",
    "tp_m_10010_06",
    "tp_m_10010_07",
    "tp_m_10010_08",
    "tp_m_10010_09",
    "tp_m_10010_10",
    "tp_m_10020_00",
    "tp_m_10020_01",
    "tp_m_10020_02",
    "tp_m_10020_03",
    "tp_m_10020_04",
    "tp_m_10020_05",
    "tp_m_10020_06",
    "tp_m_10020_07",
    "tp_m_10020_08",
    "tp_m_10020_09",
    "tp_m_10020_10",
    "tp_m_10020_11",
    "tp_m_10020_12",
    "tp_m_10030_00",
    "tp_m_10033_00",
    "tp_m_10036_00",
    "tp_m_10040_00",
    "tp_m_10040_01",
    "tp_m_10040_02",
    "tp_m_10040_03",
    "tp_m_10041_00",
    "tp_m_10043_00",
    "tp_m_10044_00",
    "tp_m_10045_00",
    "tp_m_10050_00",
    "tp_m_10050_01",
    "tp_m_10050_02",
    "tp_m_10050_03",
    "tp_m_10052_00",
    "tp_m_10054_00",
    "tp_m_10070_00",
    "tp_m_10070_01",
    "tp_m_10070_02",
    "tp_m_10070_03",
    "tp_m_10070_04",
    "tp_m_10070_05",
    "tp_m_10070_06",
    "tp_m_10070_07",
    "tp_m_10070_08",
    "tp_m_10080_00",
    "tp_m_10081_00",
    "tp_m_10082_00",
    "tp_m_10085_00",
    "tp_m_10086_00",
    "tp_m_10090_00",
    "tp_m_10090_01",
    "tp_m_10090_02",
    "tp_m_10090_03",
    "tp_m_10091_00",
    "tp_m_10093_00",
    "tp_m_10093_01",
    "tp_m_10093_02",
    "tp_m_10093_03",
    "tp_m_10093_04",
    "tp_m_10093_05",
    "tp_m_10100_00",
    "tp_m_10100_01",
    "tp_m_10100_02",
    "tp_m_10100_03",
    "tp_m_10110_00",
    "tp_m_10110_01",
    "tp_m_10110_02",
    "tp_m_10110_03",
    "tp_m_10115_00",
    "tp_m_10115_0a",
    "tp_m_10120_00",
    "tp_m_10120_01",
    "tp_m_10120_02",
    "tp_m_10120_03",
    "tp_m_10121_00",
    "tp_m_10130_00",
    "tp_m_10140_00",
    "tp_m_10140_01",
    "tp_m_10140_02",
    "tp_m_10140_03",
    "tp_m_10140_04",
    "tp_m_10140_05",
    "tp_m_10140_06",
    "tp_m_10140_07",
    "tp_m_10150_00",
    "tp_m_10150_01",
    "tp_m_10150_02",
    "tp_m_10150_03",
    "tp_m_10150_04",
    "tp_m_10150_05",
    "tp_m_10150_06",
    "tp_m_10150_07",
    "tp_m_10150_08",
    "tp_m_10150_10",
    "tp_m_10150_11",
    "tp_m_10150_12",
    "tp_m_10150_13",
    "tp_m_10150_14",
    "tp_m_10150_15",
    "tp_m_10150_16",
    "tp_m_10150_17",
    "tp_m_10150_18",
    "tp_m_10150_19",
    "tp_m_10150_20",
    "tp_m_10150_21",
    "tp_m_10150_22",
    "tp_m_10150_23",
    "tp_m_10150_24",
    "tp_m_10150_25",
    "tp_m_10150_26",
    "tp_m_10150_27",
    "tp_m_10150_28",
    "tp_m_10150_29",
    "tp_m_10150_30",
    "tp_m_10150_31",
    "tp_m_10151_00",
    "tp_m_10156_00",
    "tp_m_10156_01",
    "tp_m_10156_02",
    "tp_m_10156_03",
    "tp_m_10160_03",
    "tp_m_10160_04",
    "tp_m_10160_05",
    "tp_m_10160_06",
    "tp_m_10160_07",
    "tp_m_10160_08",
    "tp_m_10160_09",
    "tp_m_10160_10",
    "tp_m_10160_11",
    "tp_m_10171_00",
    "tp_m_10190_01",
    "tp_m_10190_02",
    "tp_m_10190_03",
    "tp_m_10190_04",
    "tp_m_10190_05",
    "tp_m_10190_06",
    "tp_m_10195_00",
    "tp_m_10200_00",
    "tp_m_10211_00",
    "tp_m_10240_00",
    "tp_m_10240_01",
    "tp_m_10240_02",
    "tp_m_10240_03",
    "tp_m_10240_04",
    "tp_m_10240_05",
    "tp_m_10260_00",
    "tp_m_10260_01",
    "tp_m_10260_02",
    "tp_m_10260_03",
    "tp_m_10280_02",
    "tp_m_10280_03",
    "tp_m_10280_08",
    "tp_m_10280_09",
    "tp_m_10280_10",
    "tp_m_10280_11",
    "tp_m_10280_12",
    "tp_m_10280_13",
    "tp_m_10280_14",
    "tp_m_10280_15",
    "tp_m_10280_16",
    "tp_m_10280_17",
    "tp_m_99060_01",
    "tp_m_99060_02",
    "tp_m_99060_03",
    "tp_m_99060_04",
    "tp_m_99060_05",
    "tp_sp_01_01",
    "tp_sp_01_02",
    "tp_sp_01_03",
    "tp_sp_01_04",
    "tp_sp_01_05",
    "tp_sp_01_06",
    "tp_sp_01_07",
    "tp_sp_01_08",
    "tp_sp_01_09",
    "tp_sp_01_10",
    "tp_sp_01_11",
    "tp_sp_01_12",
  }


  local tapeFilesExist={}
  for i,tapeName in ipairs(tapeFiles)do
    tapeFilesExist[tapeName]=true
  end

  --
  zoop=require"./PreinstallTape"

  local tapeInfo=PreinstallTape.GetTapeInfo()
  local saveIndices={}
  for i,tapeInfo in ipairs(tapeInfo.tracks)do
    table.insert(saveIndices,tapeInfo.saveIndex)
  end
  --InfCore.PrintInspect(saveIndices)
  local max=-99999999
  for i,index in ipairs(saveIndices)do
    if index>max then
      max=index
    end
  end

  local missingIndexes={}
  for i=0,max do
    local hasIndex=false
    for j,index in ipairs(saveIndices)do
      if index==i then
        hasIndex=true
        break
      end
    end
    if not hasIndex then
      table.insert(missingIndexes,i)
    end
  end
  InfCore.PrintInspect(missingIndexes,"missingIndexes")

  local tapeInfoExist={}
  for i,tapeInfo in ipairs(tapeInfo.tracks)do
    tapeInfoExist[tapeInfo.fileName]=true
  end

  local noRefsForFile={}
  for i,tapeName in ipairs(tapeFiles)do
    if not tapeInfoExist[tapeName]then
      table.insert(noRefsForFile,tapeName)
    end
  end
  InfCore.PrintInspect(noRefsForFile,"noRefsForFile")
end



local function main()

  --tex figure out unnacounted hashes
  --FindUnacountedHashes()

  --ReconstructGZPaths()

  --GetPathsFromStrings()
  --GetCombinedObjectNamesFromStrings()

  print"-///////---------"

  print("main()")

  local bit=require'bit'



  print"Running AutoDoc"
  local projectFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\]]
  local outputFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\external\docs\]]
  local featuresOutputName="Features and Options"

  local FeaturesHeader=require"FeaturesHeader"

  local InfAutoDoc=require"InfAutoDoc"
  InfAutoDoc.AutoDoc(projectFolder,outputFolder,FeaturesHeader,featuresOutputName)

  print"BLEHHHHHHHHHHHHHHH"
  print(InfUtil.GetLocationName())



  --TESTSHIZ
  --WriteDefaultIvarProfile()

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

  -- GenerateLzs()

  --CullExeStrings()

  --

  --BitmapShit()

  --MergeFiles()



  --XmlTest()-



  --
  --  local  x = collect[[
  --     <methodCall kind="xuxu">
  --      <methodName>examples.getStateName</methodName>
  --      <params>
  --         <param>
  --            <value><i4>41</i4></value>
  --            </param>
  --         </params>
  --      </methodCall>
  --]]

  --  local xmlTable=this.Collect[[
  --<?xml version="1.0" encoding="utf-8"?>
  --<LangFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Endianess="BigEndian">
  --  <Entries>
  --    <Entry LangId="unit_metre" Color="1" Value="m" />
  --    <Entry LangId="mb_title_gmp" Color="1" Value="GMP" />
  --    <Entry LangId="mb_title_time" Color="1" Value="TIME" />
  --    <Entry LangId="common_new" Color="1" Value="NEW" />
  --    <Entry LangId="tpp_gmp" Color="1" Value="GMP" />
  --    <Entry LangId="tpp_loc_afghan" Color="1" Value="Northern Kabul, Afghanistan" />
  --  </Entries>
  --</LangFile>
  --]]

  --local lngTable=this.XMLToLngTable(fileName)

  --  local fileName=[[D:\Projects\MGS\!wip\oldmotherbase\Assets\tpp\pack\location\ombs\pack_common\ombs_common_fpkd\Assets\tpp\level\location\ombs\block_common\ombs_common_env.fox2.xml]]
  --  local xmlString=io.open(fileName):read('*all')
  --  local xmlTable=this.Collect(xmlString)
  --
  --  --InfCore.PrintInspect(xmlTable)
  --  local entitiesNode=this.FindNodeByLabelName(xmlTable,"entities")
  --
  --
  --  local entityNamesToAddr={}
  --  local addrToEntityNames={}


  --XmlTest()


  --AnalyseTapes()

  print"main done"
end

main()
