--main.lua
local this={}

--tex MockFox
dofile('./MockFoxLua/loadLDT.lua')
if not InfCore or not InfCore.allLoaded then
  print"ERROR: MockFox did not complete loading"
  return
end

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



InfAutoDoc=require"InfAutoDoc"





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

--tex take txt file of string lines and "string", them
local function Stringify()
  print"Stringify"

  --  local stringsPath=[[D:\Projects\MGS\Tools\]]
  --  local inFile=stringsPath.."scrapetppxml.txt"
  --  local outFile=stringsPath.."scrapetppxmlstrinified.txt"

  --  local stringsPath=[[D:\Projects\MGS\MGSVTOOLS\FoxEngine.TranslationTool.v0.2.4\]]
  --  local filename="lang_dictionary"

  local stringsPath=[[D:\Projects\MGS\Tools\]]
  local filename="scrapegameobjectnames"


  local inFile=stringsPath..filename..".txt"
  local outFile=stringsPath..filename.."_stringified.txt"

  local file=io.open(inFile,"r")
  if file==nil then
    print("cant find "..inFile)
    return
  end
  local strings = {}
  -- read the lines in table 'lines'

  for line in file:lines() do
    table.insert(strings,line)
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

--tex gets all file extensions and counts
--requires a dir /b /s > somefile.txt of all files
local function ExtensionShit()
  --extensionshit
  local basePath=[[J:\GameData\MGS\]]
  local inFile=basePath.."AllFileList.txt"
  local outFile=basePath.."allextensions.txt"

  local file=io.open(inFile,"r")
  if file==nil then
    print("cant find "..inFile)
    return
  end
  local extensions={}
  -- read the lines in table 'lines'

  for line in file:lines() do
    local last=InfUtil.FindLast(line,".")
    local ext=""
    if last then
      ext=string.sub(line,last,#line)
    end

    print(ext)
    if not extensions[ext] then
      extensions[ext]=0
    end
    extensions[ext]=extensions[ext]+1
  end
  file:close()

  local extensionsList={}
  for ext,count in pairs(extensions)do
    table.insert(extensionsList,ext)
  end

  table.sort(extensionsList)

  local nl='\n'

  local file=io.open(outFile,"w")
  for i,ext in ipairs(extensionsList)do
    file:write(ext..":"..extensions[ext]..nl)
  end
  file:close()
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


local function main()
  print("main()")

  local staffList={ { 2.4651878420237e+015, 3.0502323273419e+015, 6.887474340127e+015, 2.1945920468347e+015, 6.289460035588e+015, 4.5043620936585e+015, 8.6600285422419e+014, 4.5178429343139e+015, 8.0396505816117e+015, 2.4477159433762e+015, 6.3765706147188e+015, 8.2820721226666e+014, 6.3165817873379e+015, 3.4147180871847e+015, 8.5156008758489e+015, 4.4189417052655e+015, 8.9849087142226e+015, 1.6557712815486e+015, 5.5719902650617e+015, 1.790846765728e+015, 2.0009760158282e+015, 5.9443681470221e+015, 3.8806492430429e+015, 6.9885649213197e+015, 3.1002750793987e+015, 6.1979794037813e+015, 4.3885520580939e+015, 7.5745873761411e+015, 2.4012820285279e+015, 9.691295556734e+014, 1.8600990185894e+015, 8.9698127436934e+015, 8.1914444324959e+015, 5.249924322673e+015, 3.9792583901217e+015, 6.696378070729e+015, 3.1241873371395e+015, 8.8607913474252e+015, 3.1092943691543e+015, 3.1798500466527e+015, 4.323025008734e+014, 8.9839979048881e+015, 8.7732739469479e+015, 4.6579739378328e+015, 8.9716843983998e+015, 3.9056844291526e+015, 6.8091048399187e+015, 2.0926669992758e+015, 5.6550481493209e+015, 5.8024204872346e+015, 2.4578339635285e+015, 1.7516275014052e+015, 2.8356667475242e+015, 6.5631836817009e+015, 5.7965674574263e+015, 3.0614248965682e+015, 8.0283677942992e+015, 7.3705721419543e+015, 4.3528938681142e+015, 1.9034051754233e+015, 1.0243068039089e+015, 2.0906183575592e+015, 1.1040342514241e+015, 3.6104723193036e+015, 8.1229342142713e+015, 4.9432937371897e+015, 2.9880572046847e+015, 8.1534887269592e+015, 1.7057207371861e+015, 5.691197015196e+015, 5.4846014211371e+015, 1.3098716781093e+015, 6.2491647452541e+015, 2.6741863445064e+015, 3.2462440178241e+015, 7.8504680017318e+015, 6.9501118222339e+015, 2.0067269896573e+015, 6.5470341847479e+014, 3.1521967859305e+015, 2.8470190402455e+015, 1.0897257891933e+015, 2.2444942609707e+015, 7.5211589184033e+015, 2.2851814106156e+015, 3.3716784112803e+015, 4.6927846346755e+015, 3.0161926756027e+015, 1.0688329658453e+015, 27097178366260, 5.0413855603838e+015, 5.6812723185021e+015, 2.0742634324649e+015, 3.507421797418e+015, 1.4195469498452e+015, 8.6819545479335e+015, 6.9224480731385e+015, 5.3141900047169e+015, 1.375038258291e+015, 5.9293194136538e+015, 3.7443119695871e+015, 1.2910811813899e+015, 1.0220477633017e+015, 44168585433007, 3.0501752338271e+015, 5.5771699567659e+015, 3.3630120202899e+015, 8.5822691879161e+015, 3.9508075243195e+015, 9.9676323909664e+014, 7.9155023200225e+015, 2.4615297001155e+015, 6.4569509371006e+015, 1.8953262618054e+015, 7.7012503007808e+015, 2.2968798764813e+015, 1.8836012086726e+015, 8.5110277370105e+015, 1.3635513724612e+015, 5.1530589945214e+015, 7.0459754576612e+015, 8.2023831694294e+015, 7.0954748250565e+014, 8.7075609778015e+015, 7.0524029943245e+015, 6.1075254522105e+015, 1.3028572329505e+015, 7.7141694878928e+015, 2.1467752741031e+015, 5.7643284174409e+015, 7.5462157859239e+015, 4.9850272983296e+015, 5.4145494066392e+015, 8.5986140540203e+014, 5.3151040400756e+015, 8.6909190013095e+015, 1.5839155758042e+015, 2.6967676453714e+014, 5.121176534394e+015, 1.8776711149785e+015, 5.7979164847007e+014, 5.8247241521531e+015, 6.7849423805839e+015, 4.0642385360341e+015, 2.5134235815857e+015, 3.3130487386033e+015, 7.7102276238544e+015, 4.8670314363711e+015, 8.4309951591222e+015, 1.7565654817836e+015, 2.8108345083165e+015, 1.8852512495381e+015, 1.6982742517108e+015, 3.5208040048643e+015, 3.9551045406068e+015, 5.9281941295353e+015, 5.3776117567747e+015, 5.7124880153409e+015, 3.0666725104286e+014, 3.632150771401e+015, 3.883497774124e+015, 2.5831696488697e+015, 7.6335335079967e+014, 2.3719559529762e+015, 8.0473752810413e+014, 6.638460657992e+015, 6.6519982837607e+015, 7.1133039480146e+014, 3.1049543237977e+015, 5.1829527178475e+014, 4.5856659604172e+015, 7.8006550843567e+015, 2.3280637172289e+015, 5.6243885776571e+015, 6.7303126083915e+015, 7.2350593533963e+015, 6.7855547598769e+015, 4.7809782833073e+015, 3.1874241098059e+015, 6.7691092713721e+015, 7.284707192521e+015, 8.1286725055294e+015, 5.4326612056968e+015, 1.4920352902852e+015, 7.2841960662388e+015, 4.0873110186561e+015, 7.6729627340831e+014, 6.5585236966209e+015, 7.1033960037911e+015, 7.6250841633345e+015, 6.0500885997571e+015, 3.4126624582536e+015, 3.942060592729e+015, 6.6781676517133e+015, 8.3889303259958e+015, 4.8034229031243e+015, 8.8315662434471e+015, 4.1916735621733e+015, 7.4972820448218e+015, 1.1416472912172e+014, 4.8818704624274e+015, 8.074126290846e+015, 1.0840165203339e+015, 2.5347566282018e+015, 1.1017731000264e+015, 7.6494186270486e+015, 5.0384744737836e+015, 7.6609375793483e+015, 6.6503726076753e+014, 8.5144033191939e+015, 4.2366632890207e+015, 7.9717137787549e+015, 3.2898335585101e+015, 7.1504550859092e+015, 1.2139392433123e+015, 7.5146392450674e+015, 4.4842229139295e+015, 7.5999243413835e+015, 7.9987089400303e+015, 1.0005652827754e+015, 3.4815780791132e+015, 7.362042476963e+015, 7.1905057712571e+014, 5.0044316481547e+015, 4.6843492753739e+015, 7.2445267857094e+015, 7.9385727892688e+015, 2.4213104887468e+014, 8.7169480270674e+014, 1.4630120157433e+015, 2.4172980475011e+015, 2.292069676614e+015, 4.0635556751801e+014, 3.9434243529042e+015, 7.6360953804885e+015, 7.8426987143302e+014, 2.782065790078e+014, 1.0585290708094e+015, 6.3123746656927e+015, 6.4812270527542e+015, 7.7697688010784e+014, 4.1416585946074e+015, 5.9623854865544e+015, 6.0809747398096e+015, 6.4621906462105e+015, 9.5085871354707e+014, 8.5128573007957e+015, 5.7532268046749e+015, 7.4963201661914e+015, 6.5300642398293e+015, 8.8903986970654e+015, 1.0276871414173e+015, 5.3525408372585e+015, 3.9255743923162e+015, 1.1053282246168e+015, 21517963460911, 3.0976853986522e+015, 3.5720890124246e+015, 4.4382432380112e+015, 2.4834578610946e+015, 5.9485385268597e+015, 4.4075943802064e+015, 2.1638820743089e+015, 1.8924163359225e+015, 2.2347874891943e+015, 5.6473612661558e+015, 4.533795621447e+015, 8.0379031039589e+015, 8.2561181302549e+015, 2.2179514385707e+015, 1.2563080156868e+015, 4.9954853004332e+015, 6.5902924770847e+015, 2.038968082253e+015, 4.8658092885538e+015, 1.3432383567711e+015, 2.4839944247709e+015, 1.908036035676e+015, 8.093857448281e+015, 1.8742936936123e+015, 2.0564025718961e+015, 7.1912315144441e+015, 1.5773353723825e+015, 6.195740507432e+015, 4.2768771632336e+015, 8.5862946334443e+015, 6.5218480607727e+015, 5.093260014453e+015, 1.2314404181937e+015, 1.2419587532475e+015, 8.2504615306066e+014, 2.379880388936e+015, 8.6168124973469e+015, 6.3777366491476e+015, 6.3040694685627e+015, 4.8171946145968e+015, 6.1116515646928e+015, 4.2069593361043e+015, 8.1890520963514e+015, 8.0115893844963e+015, 8.6304191283695e+015, 1.3313655095043e+014, 6.2039495205366e+015, 4.6191686897012e+015, 3.9551540658671e+015, 4.208029704692e+015, 6.7322067004989e+015, 3.4044576814288e+015, 4.0588173750695e+015, 5.3497976114585e+015, 1.0363587338817e+015, 2.7741946584927e+015, 7.6460210924424e+015, 2.8191738053103e+015, 4.0870158911089e+015, 4.4326771029535e+015, 2.8446865761477e+014, 5.1910049431637e+015, 8.9817301139005e+015, 8.1816315672669e+015, 1.2284755737353e+015, 1.974454631548e+015, 3.651591988055e+015, 8.0099164658497e+015, 8.5798544201905e+015, 8.7964775487413e+015, 3.8703551794413e+015, 8.0959792239169e+015, 1.4008004913642e+015, 8.8764574114779e+015, 5.6339234806009e+015, 5.6654721984932e+015, 4.0982151272861e+015, 7.7199933744345e+015, 7.2246548895428e+015, 6.4280285514151e+015, 2.6822586228903e+015, 2.0634486807023e+015, 3.0483188400786e+015, 1.0289690591202e+015, 2.2194975565418e+015, 6.2926227721542e+014, 5.6862618267897e+015, 8.6786303171546e+015, 7.6024017123495e+015, 3.5903050413592e+015, 3.901290786645e+015, 3.739458485675e+015, 8.0761192741604e+015, 3.2896918895988e+015, 8.4281272125378e+015, 6.8183691430637e+015, 4.2576957826756e+015, 6.6219335923879e+015, 5.4589549801646e+015, 5.2190490174516e+015, 8.4836887724548e+014, 6.7190017822887e+015, 2.1748235686495e+014, 3.0863422327453e+015, 6.1229485973835e+015, 8.4101957692141e+015, 5.9515579190897e+015, 2.7460018394124e+015, 8.439222321096e+015, 8.3053211633596e+015, 2.3451727560715e+015, 3.1370312679427e+015, 8.2619258913519e+015, 8.4116522091346e+014, 2.5830417519096e+015, 6.7713693002141e+015, 5.5750352805072e+015, 3.1385602826007e+015, 4.0027636976274e+015, 4.0546765321195e+014, 1.11557607006e+015, 2.4911500448321e+015, 1.416031398617e+015, 3.2723399355108e+015, 7.8300272551546e+014, 3.5314211163262e+015, 8.1772377622467e+015, 7.0529977491213e+015, 7.0028802767288e+014, 8.2880663126756e+015, 1.6952460893419e+014, 7.2753181915876e+015, 6.0308384714438e+015, 8.1592073930813e+015, 2.84352797811e+014, 4.6285582971731e+014, 8.2199673055504e+015, 7.766109544007e+015, 8.4353373286403e+015, 3.7911549685272e+015, 6.4144995474476e+015, 4.3394825642342e+015, 8.1204035008679e+015, 8.7225633540918e+015, 1.0101775775364e+014, 8.0188248581815e+015, 2.0145179575725e+015, 6.0492147883225e+015, 3.2737498288049e+015, 4.2743710340877e+015, 3.6385503450238e+015, 4.3610980409682e+015, 5.3023864122253e+015, 3.5997326151601e+015, 5.9704191819953e+015, 6.3250711551213e+014, 6.2921756073014e+015, 3.9554825647976e+015, 3.7514735685963e+015, 4.7688828793654e+015, 6.1207633629115e+015, 3.8313256713451e+014, 6.3783701001014e+015, 6.8587805611797e+015, 5.590995447112e+015, 1.0305313172524e+015, 8.0276507087834e+015, 9.8691265016748e+014, 6.6288743780351e+015, 6.5554773138558e+015, 4.6442309527146e+015, 6.7946872968318e+015, 3.3060265834755e+015, 2.5729712101816e+015, 8.3787682362822e+015, 8.9943492269702e+014, 5.0366707117684e+015, 3.7257769134411e+015, 7.4978550461265e+014, 1.1797728833138e+015, 1.6349610702285e+015, 5.1817751371161e+015, 4.6345070974535e+015, 8.6670596018589e+015, 6.3651233776285e+015, 4.5484488686472e+015, 8.6782876099718e+015, 3.1493293867039e+014, 8.1307297665682e+015, 2.8850725097475e+015, 8.9367533574147e+015, 6.8221090744323e+015, 2.4998299094313e+015, 1.3773585441272e+015, 5.5601670888492e+015, 1.544315825308e+015, 1.6184210191076e+015, 4.3813933835986e+014, 1.1348742787812e+015, 6.8276324904472e+015, 7.2019796264398e+015, 5.5245431588165e+014, 8.9720117301506e+015, 5.4143649768328e+015, 2.2142361943422e+015, 6.2262715043351e+015, 6.5655920363609e+015, 5.3772561794092e+015, 6.057150545151e+015, 3.187047206489e+015, 4.9249753707448e+014, 5.5925114258811e+015, 4.9667541136274e+015, 3.4334495338057e+015, 7.0285939704221e+015, 1.0124443967819e+015, 7.5466495136429e+015, 5.0189284934558e+014, 2.5920430864223e+015, 6.9915932524883e+015, 5.8871471428253e+015, 1.724223244018e+015, 5.7337945899666e+015, 1.0693964044701e+015, 6.5956140605934e+015, 1.3838814418709e+015, 2.9669421157047e+015, 7.705128654086e+015, 3.8000111795572e+015, 5.1907483213507e+015, 4.9190269464158e+014, 6.7912056045743e+015, 5.965065341682e+015, 8.5126576351563e+015 }, { 2.2418141029995e+015, 2.082646938092e+015, 3.3447156179942e+015, 2.5820443246187e+015, 5.6657802881246e+015, 6.0468859052077e+014, 6.4094293587203e+015, 8.0661247887938e+015, 2.8292111938207e+015, 1.4092067468754e+015, 2.6506395643509e+015, 6.3553040833349e+015, 3.0471054795423e+015, 6.0602076513981e+015, 7.9266951095925e+015, 8.4623526243619e+015, 4.0372746313826e+015, 3.5915926347819e+014, 7.1057316434006e+015, 3.3342777670538e+015, 6.604179130009e+015, 3.5278498270512e+015, 6.3256290189808e+015, 2.0413681292497e+015, 6.0806452352138e+015, 4.1213489496201e+015, 4.2685150424428e+014, 6.4546626160562e+015, 2.9894433329648e+015, 6.4109529242435e+015, 1.175444625818e+015, 6.0980387257812e+015, 1.5974595743093e+015, 2.6968744106567e+014, 4.1872179876013e+014, 8.5060667960202e+015, 1.6811791925263e+015, 6.2502515758873e+015, 7.1223453627202e+015, 8.0090806252589e+015, 6.9690700375004e+015, 7.9628523108858e+015, 8.7200400027338e+015, 3.4265101722681e+015, 8.1131999042114e+015, 5.0958371048821e+015, 5.2356964147299e+015, 7.4645502387163e+015, 3.3736281141662e+015, 1.1147160837821e+015, 3.3684166732241e+015, 4.402267723792e+014, 5.9306637212647e+015, 8.6764569128801e+015, 2.0079089822969e+014, 8.2760510404203e+015, 5.9712332556866e+015, 6.3317484472406e+015, 6.123263000855e+015, 5.2024253614166e+015, 4.8645144001172e+015, 5.3678813904501e+015, 4.843984685081e+015, 2.8281997499816e+015, 1.0056679575597e+014, 4.3548071500331e+014, 6.4896623587015e+015, 7.4760789866595e+015, 1.6538802553403e+014, 2.3804879864714e+015, 5.8432044160291e+015, 2.1995217758458e+015, 5.5890112224957e+015, 7.7609371888194e+015, 7.1233795324154e+015, 6.3449617706326e+015, 7.3503610631144e+015, 7.339463549338e+015, 4.5338030560559e+015, 3.9675502308653e+015, 2.8227041351637e+015, 8.4118739166991e+015, 1.5114980097492e+015, 4.1564419460551e+015, 1.1990314330128e+015, 7.6035836079149e+015, 7.7074950512737e+015, 2.683895340909e+015, 8.4611555154838e+015, 4.2727419750138e+014, 7.2768183359984e+015, 5.7429041317155e+015, 8.1340647509869e+015, 3.8587716311629e+015, 8.7287877926764e+015, 2.9665651652858e+015, 2.7809582135148e+015, 8.32447793828e+015, 5.303601909146e+015, 5.05719969833e+015, 6.3647487366855e+015, 3.6191501309219e+015, 4.3855871236756e+015, 4.779762008687e+015, 3.5627796293402e+015, 2.3042720951544e+014, 3.1163550898732e+014, 4.971928273262e+015, 2.7678370258129e+015, 6.0464353843782e+014, 1.684342314346e+015, 2.0702603279078e+015, 6.0297187491517e+015, 6.8663954031006e+015, 8.8232469485995e+015, 3.1812066990137e+015, 4.6181346779632e+015, 1.0999606128819e+015, 6.6621987346191e+015, 3.0735969315148e+015, 3.5393323554493e+015, 8.162414482887e+014, 2.1743058038952e+015, 1.3221305642233e+014, 1.8004647837049e+014, 2.823830494234e+015, 5.0694295537433e+015, 1.092579660866e+015, 8.8472301590299e+015, 5.1323809693864e+015, 5.4645014923688e+015, 3.8687059310649e+015, 4.9972740800936e+015, 4.1202501744235e+015, 7.8330004275788e+015, 1.5054442868904e+015, 4.8664241505222e+014, 8.1135551884838e+015, 6.1292329425556e+015, 7.8410143091234e+015, 6.9788720674422e+015, 6.4065278461711e+015, 5.4310765406212e+015, 3.5580841905935e+015, 6.5884458144006e+015, 1.3125916129776e+015, 6.3105279912678e+015, 7.5595290630067e+015, 6.7534218661483e+015, 2.8422601810672e+015, 2.6012856229319e+015, 1.2312507374841e+014, 4.9995355145589e+015, 8.1093547204449e+015, 5.661594320402e+015, 5.5767402907816e+015, 7.2289541261562e+015, 1.8601439471385e+015, 3.8692587365831e+015, 5.0545720255791e+015, 8.6724303537575e+015, 6.0623292771701e+015, 8.2060463426278e+015, 2.0876991945978e+014, 8.2738058369612e+015, 8.3973203668926e+015, 5.8748608092051e+015, 8.0921009966043e+015, 6.3478414432015e+015, 4.1725156928557e+015, 6.2058431479033e+014, 8.0624741727277e+015, 5.3165854107161e+015, 1.5819269075932e+015, 6.200744236737e+015, 4.8198017616011e+015, 2.5931682563281e+015, 5.9756954603688e+015, 2.5960929823052e+015, 8.4731567774274e+015, 2.6587061876986e+015, 4.6115085384422e+015, 7.0477943723596e+015, 7.0559011671741e+015, 5.6136576139934e+015, 5.1771128867035e+015, 8.1926941383929e+014, 5.4961978920309e+015, 7.7915282086925e+015, 2.2649993512883e+015, 4.5915436107138e+015, 8.2909534650946e+015, 6.2005027371586e+015, 4.5282840454845e+015, 1.5671371971518e+015, 5.4144227889658e+015, 5.3101474635513e+014, 7.9572876206944e+014, 5.1148465448473e+015, 3.1936229319807e+015, 2.4148771374425e+015, 4.5737623683076e+015, 2.6738941894182e+015, 7.1831912691634e+015, 4.0323966057018e+014, 4.9701107946715e+015, 5.5747655657898e+015, 6.7322475490104e+015, 8.5071235584987e+015, 4.001043475911e+014, 8.7052566921233e+015, 4.2419943387276e+015, 6.5690850244203e+015, 1.0247900423295e+015, 3.2697554485306e+015, 1.444956053103e+015, 4.4461728491279e+015, 2.217080423188e+015, 7.5508031055478e+015, 3.0773710298413e+015, 5.3634134769423e+015, 5.8736061513251e+015, 2.7614987965731e+015, 6.7266191137182e+015, 4.7738926831715e+015, 8.4655825110225e+015, 6.9089071204735e+015, 8.2429507016884e+015, 1.7434474857845e+015, 4.129267542893e+015, 4.9155569049452e+015, 2.0582396954804e+015, 6.6797374255436e+015, 8.3832146254169e+015, 3.7581481071088e+015, 5.7132310448801e+015, 4.9627844252239e+015, 2.6967261128338e+014, 3.597096384145e+015, 6.4834035573478e+015, 8.305324441453e+015, 2.7849117086662e+014, 7.6661328605119e+015, 1.674810828014e+015, 8.4756111527367e+015, 1.0765164370416e+015, 2.4828304294548e+015, 3.8815552264852e+015, 2.6003237104522e+015, 1.1252300415097e+015, 5.0790587392959e+015, 7.2962003183866e+015, 2.8093083371443e+015, 8.3549613847679e+015, 1.0812647666907e+015, 8.7916376037011e+014, 6.0408296890138e+015, 8.4338042147394e+015, 8.9744328278176e+014, 7.6744216681529e+015, 8.7592524980802e+015, 3.6858314140893e+015, 7.5253176656368e+015, 2.7787859419399e+015, 5.6804700598945e+015, 4.4674844249297e+015, 8.8721796232483e+015, 1.1290751119539e+015, 5.636202060556e+015, 8.0792468955889e+015, 2.9799131281977e+014, 60689029318337, 2.7239327083272e+015, 5.7379283158727e+015, 3.4454239332042e+015, 2.3581110527157e+015, 2.7505423089434e+015, 2.515374619969e+015, 6.4859805199078e+015, 5.0661383597757e+015, 6.2956833542968e+015, 2.2729786153784e+015, 6.5046293763855e+015, 2.5091898041729e+015, 4.0486606640993e+015, 8.1225100873745e+015, 4.4340083847091e+015, 3.4857708730618e+015, 6.9923423463441e+015, 2.3691095294625e+015, 7.7724155251085e+014, 5.8327930409926e+014, 3.6393523871904e+014, 1.3998888855802e+015, 7.5576671849119e+015, 4.3153729154503e+015, 6.3668706474142e+014, 5.0431379239748e+015, 5.2191767729948e+015, 1.5436822109078e+015, 5.1520369537848e+015, 1.8822374822846e+015, 2.6833303918975e+015, 6.6553870520073e+015, 1.7295028311505e+015, 8.1097723081458e+015, 4.5220608503617e+015, 7.0078200379819e+015, 1.9814761749795e+015, 5.0027104192079e+015, 6.8947669325665e+015, 2.7003287504982e+015, 3.4772788917058e+015, 4.2900152890905e+015, 5.8148929480598e+015, 4.3022862023409e+015, 8.5513529943495e+015, 4.5554380088296e+015, 3.9913014031334e+015, 2.6361951493821e+015, 4.4969603757714e+014, 4.4901951623664e+015, 3.4280947748705e+015, 7.4471104883725e+015, 1.2519847598534e+014, 2.6621551503856e+015, 4.818318788249e+015, 3.0794111590077e+015, 5.4275717925442e+015, 8.144374735127e+015, 3.8482102552007e+015, 2.8919433833272e+015, 7.4245093649016e+015, 8.0636863905602e+015, 4.9704627098096e+015, 7.1173622560784e+015, 7.110113295041e+015, 8.048885835499e+015, 3.8889216669331e+014, 4.622163473807e+015, 8.1565834214282e+015, 7.5715979824377e+014, 5.4891916172415e+015, 1.8171751374525e+015, 5.3368095665401e+014, 2.0920109369676e+015, 7.8914020966444e+014, 8.448420195428e+015, 5.8345029109928e+015, 4.8703554969277e+015, 1.0841957746365e+015, 7.3775112729439e+014, 6.0800961214215e+014, 1.8899447150596e+015, 3.490691980739e+015, 7.2967932923089e+015, 5.9500374547174e+015, 7.4631630943441e+015, 4.0028987882378e+015, 7.2890172803654e+014, 1.7290991608235e+015, 2.9884418537926e+014, 3.4249393487098e+014, 6.7870599036277e+015, 5.7229515814179e+015, 2.9006600730465e+015, 4.8887445650736e+015, 1.2049112519316e+015, 6.0846007891491e+015, 2.8101456397603e+015, 4.2253760166384e+015, 3.986165811349e+015, 8.4805890250933e+015, 7.9378771022811e+015, 4.0680664282744e+015, 1.8351880952632e+015, 5.0573466719617e+015, 6.8858851447028e+015, 8.527217511614e+015, 9.8753443915528e+014, 8.2606417317496e+015, 3.6295719270808e+015, 2.7340047180121e+015, 7.0697106575364e+015, 1.3282026331099e+015, 7.6975136258742e+015, 2.7153880099939e+015, 5.1377655683171e+015, 8.3746505012984e+014, 4.7619590966083e+015, 1.463669384808e+015, 8.1330394636332e+014, 4.4240956168114e+015, 8.065669451629e+015, 5.7522551324524e+015, 5.4322019269022e+015, 5.9400537529226e+015, 1.5283062085155e+015, 7.8924459404989e+015, 2.58161473278e+015, 2.3704699102172e+015, 6.8417563660332e+014, 2.0607258496249e+014, 5.9967322885985e+015, 6.7552686083199e+015, 2.5806099408079e+015, 2.1465777655731e+015, 3.6351583423874e+015, 8.0395047316853e+015, 8.9441332258424e+015, 6.1062497007633e+015, 2.2667641997153e+015, 8.7383729729868e+015, 3.7680233224001e+015, 3.4244376094069e+015, 6.6225326653854e+015, 4.9715322806276e+015, 2.8150088282976e+014, 5.9327417029759e+015, 8.6234827222553e+015, 3.8230021071836e+015, 2.7291296005903e+015, 7.5619428385182e+015, 7.1559148449315e+015, 3.9824806696555e+015, 7.3043581780149e+015, 3.4619209812055e+015, 5.1778934498279e+015, 6.6340737359916e+014, 2.7715735419622e+015, 7.4794765179868e+015, 6.2931322443944e+015, 5.6024208922558e+015, 1.9562202474173e+015, 4.7082914437708e+015, 6.9067370231812e+015, 1.0266812842029e+014, 4.5737977401114e+015, 1.6170192134476e+015, 8.6956735769973e+015, 6.2982528866605e+015, 3.7116358858593e+015, 4.1021421496161e+015, 6.7026167080801e+015, 7.6306934011018e+015, 3.921273664967e+014, 4.8381154012697e+015, 8.1695841740559e+015, 8.8886068434457e+015, 6.5263715221519e+015, 3.3804367016854e+015, 1.8786058718101e+015, 7.9276465529328e+015, 5.7471883784536e+015, 8.2329982921292e+015, 4.3978148882355e+015, 4.2668289228313e+015, 3.6862421683449e+014, 7.7480351183672e+015, 4.1559458790538e+015, 6.424218982081e+015, 4.0397142818095e+015, 6.8492405182878e+015, 9.9097463352672e+014, 1.3423040939476e+015, 3.2216991055848e+015, 5.7531690439889e+015, 7.1598353365652e+015, 8.4148868827222e+015, 4.5261536620313e+015, 4.9976035619078e+015, 3.3130778759418e+015, 8.2509373984609e+015, 8.6249843377811e+014, 5.2064304132031e+015, 2.2501720808505e+015, 6.3539288350201e+015, 1.9398619071628e+015, 6.0076222899095e+015, 3.8638311631912e+015, 2.2671254230154e+015, 5.6659295686508e+015, 7.9938039316497e+015, 2.6020543969039e+015, 2.5862328213849e+015, 7.27376817103e+015, 3.6867584569974e+015, 6.2832491228511e+014, 4.273799781819e+015, 2.275495322862e+015, 1.0938812372915e+015, 2.5017080623202e+015, 1.6435004115686e+015, 4.9615173437946e+015, 2.6892621076116e+014, 9.6265799467154e+014, 8.3360056734612e+015, 3.7062158478586e+014, 8.0388175337571e+015, 6.1832121051481e+015 }, { 4.8166347578003e+014, 3.7795046558275e+015, 5.7992548953626e+015, 6.2284510003224e+015, 6.7448177730541e+015, 8.4974018400117e+015, 7.2395067196708e+015, 4.9527804846413e+015, 2.3836425558431e+015, 3.9731042503942e+014, 8.9001386699659e+015, 5.5892827314117e+015, 2.7369530590337e+015, 6.2842303609182e+015, 3.5749611260647e+015, 91448549574970, 8.2305587289954e+015, 3.4316081341585e+015, 8.567086896912e+014, 2.8487025856372e+015, 3.8895718435395e+015, 4.0991683468354e+015, 5.0970633159481e+015, 2.7018588125453e+015, 4.7122663363057e+015, 7.3371710720761e+015, 5.4009665101682e+015, 2.2672747266054e+015, 7.8933392506248e+015, 2.4984149787958e+015, 3.606462794302e+015, 6.736377293587e+015, 2.3983151660915e+015, 7.9075460073396e+015, 2.2381811434785e+015, 7.5004319577132e+014, 5.5533517878125e+014, 5.6790678440515e+015, 1.3089611930671e+015, 5.4473082053616e+015, 5.1267521940035e+015, 2.3736287478585e+015, 6.127288526146e+015, 1.1575163108908e+015, 6.704578180418e+015, 8.1531235430733e+015, 7.9088925435519e+015, 6.9289086812166e+015, 1.4736603392432e+015, 7.8299790332437e+015, 4.0977908975556e+015, 5.9828060616684e+015, 1.8299751602587e+015, 5.6108122405607e+015, 6.7793826453919e+015, 6.0102830488295e+015, 8.073136383724e+015, 6.1736548973942e+015, 7.2220016503691e+015, 6.2512144776339e+015, 7.5246969552902e+015, 5.8811900755993e+015, 7.0611764175198e+015, 3.2796329975503e+015, 3.7498866861348e+015, 2.5639237273524e+015, 8.9118124829923e+015, 1.6492729189195e+015, 7.8533145195996e+015, 7.8588807909237e+015, 6.0348638752005e+014, 6.8581716210669e+015, 2.3507483586746e+015, 6.9288474789887e+015, 8.7859787286452e+015, 3.5971041056528e+015, 8.0870982381738e+015, 6.0515359821666e+015, 6.331848153105e+015, 5.8261361876015e+015, 2.8872663063599e+015, 8.6060117781305e+015, 6.8024906395326e+015, 3.5398349215504e+015, 6.4627070835121e+015, 4.7307992554543e+015, 8.0212897657002e+015, 9.7671887454265e+014, 7.9978574035032e+015, 4.7772816255391e+015, 2.0181032338721e+015, 3.4544261592537e+015, 2.2789012313872e+015, 5.4138515708975e+015, 4.9130455443727e+015, 7.9356360875071e+015, 2.4743447720124e+015, 3.591043861731e+014, 9.7830563322489e+014, 6.3503434215757e+015, 6.8855553673159e+015, 3.9819845073635e+015, 8.0772020683409e+015, 2.6566833293252e+015, 2.9926559637755e+015, 3.7558996178968e+015, 7.5820830692499e+015, 9.0001792345072e+015, 4.4026250877999e+015, 8.6211719531093e+015, 8.7799881741113e+015, 7.2063813135898e+015, 4.3074241691706e+014, 1.8103095295533e+015, 1.1568151632287e+015, 2.6435912561629e+015, 3.7181876045092e+015, 8.432202180199e+015, 2.1104096779966e+015, 6.6863375498123e+015, 1.7832532546361e+015, 4.1413331674896e+015, 2.2186469800024e+015, 2.4278163332815e+015, 4.5592323460962e+015, 2.5034271081109e+015, 1.7293837399513e+015, 5.2688194432261e+014, 2.2025517949343e+015, 7.9421829535504e+015, 8.3898364267075e+015, 4.8256771759824e+015, 6.1695552672259e+015, 5.779411360105e+015, 3.9579498531887e+015, 8.5489480682706e+015, 1.405053584804e+015, 4.0792505408578e+015, 5.4876681090013e+015, 7.3604326794222e+015, 4.1844214039862e+015, 5.8677823075803e+015, 7.6547453275856e+015, 6.1829599314598e+015, 7.6244357354625e+015, 7.2920653061183e+015, 6.0739020138767e+015, 2.9680162063161e+015, 5.6311559241056e+015, 7.6834615349765e+015, 4.9000401621506e+015, 6.5642610384017e+015, 2.1836347484411e+015, 1.3754096629356e+015, 7.4330895066077e+015, 3.4516619283718e+014, 5.7657167954745e+015, 5.9932876273096e+015, 4.2690772520147e+015, 6.3687795891265e+015, 4.7528947388274e+015, 1.9998399665281e+015, 5.1511069245446e+015, 6.3940982252509e+015, 7.7257281497995e+015, 4.7046837283231e+015, 19311279212728, 5.7522583303624e+015, 2.924344581309e+015, 8.0067148251306e+015, 3.5529947579684e+015, 6.9490769500575e+015, 7.5822043402082e+015, 1.1118339870644e+015, 2.3993320734726e+015, 3.5492548491371e+015, 6.5156503201388e+015, 4.303433843688e+015, 93140718535222, 5.7805590421857e+015, 4.877345603193e+015, 4.4582967040989e+015, 4.6902729638057e+015, 8.1092988591169e+015, 8.597189195467e+015, 3.4079924719475e+015, 6.1150045562527e+014, 3.2906108601473e+015, 6.1760557197973e+015, 8.5872161471862e+015, 5.7443782125183e+015, 3.4690196848646e+015, 1.5941051871093e+015, 6.7481990730899e+015, 5.3509798520592e+015, 2.8518551435515e+015, 5.4351911505142e+015, 8.8509152000743e+015, 7.2517304409135e+015, 5.475252354157e+015, 4.3052797541914e+015, 5.5974291119823e+015, 5.9535473797553e+015, 3.8852104793626e+015, 8.9340324379386e+015, 4.494520309777e+015, 7.4183665359263e+015, 5.818405265343e+015, 7.224375542547e+015, 1.3505352968443e+015, 1.1598173558544e+015, 6.2573948803504e+015, 1.7964238945016e+015, 3.7995685966831e+015, 3.1296580191541e+015, 1.8137518320031e+015, 6.3492299402778e+015, 8.9342535951997e+015, 8.2386503341365e+015, 3.7634706107292e+015, 5.9798250512735e+015, 1.6588240207222e+015, 1.4510720957814e+015, 4.7602261368528e+015, 8.8351268305803e+015, 3.3943275393081e+014, 2.9971398540826e+015, 9.2133608084332e+014, 1.2664703727722e+015, 7.6401242925963e+015, 2.3395353975871e+015, 8.1993912807531e+015, 8.4592238033639e+015, 6.59348585351e+015, 4.5175562793313e+015, 4.0793171217782e+015, 374830268988, 6.4439588319401e+015, 3.0213990200138e+015, 7.1561812835129e+015, 2.658779508268e+014, 7.8825857126261e+015, 2.8237221110749e+015, 5.3249560805613e+014, 2.8356943712114e+015, 2.1751518708391e+015, 9.879026998974e+014, 1.1697688150022e+015, 1.1531053191682e+015, 1.8104405118572e+015, 1.7351679551903e+015, 5.4752523567946e+015, 7.3242260726093e+015, 4.4708613366768e+015, 5.8958479318063e+015, 7.3052370450028e+015, 8.1052075932115e+014, 7.188783264957e+015, 8.4637919058387e+014, 1.362626852424e+015, 8.3198466521749e+015, 8.7482440441387e+015, 7.8961111786929e+015, 2.1376181332875e+015, 6.8908498508847e+015, 3.3202870220232e+015, 6.2879889894447e+015, 9.1112857672313e+014, 8.5160409694431e+014, 7.7408379223414e+015, 1.0947251604872e+015, 9.8993635747656e+014, 1.0702040146417e+015, 2.5949827739181e+015, 6.595083445996e+015, 7.5640559842105e+015, 7.6903775511536e+015, 2.6979653941991e+015, 4.1947528649775e+015, 3.5235377377532e+015, 1.6644159737698e+015, 6.7333373774895e+015, 4.5324586447362e+015, 7.9060060549996e+014, 3.8888739585415e+015, 2.9713421844011e+015, 6.4081830133538e+015, 5.209529684855e+015, 8.9152450912606e+015, 7.1762687746398e+015, 2.1956259936589e+015, 7627887086002, 7.8295225126329e+014, 6.7092203113102e+015, 3.4504908587687e+015, 6.9600344324347e+015, 2.1129073283587e+015, 1.5740904878923e+015, 1.1151911210413e+014, 5.2809243337693e+015, 7.9837929983403e+014, 1.1895785349997e+014, 4.2078149977217e+015, 5.6220694735755e+015, 3.551843486534e+015, 4.6926622181318e+015, 4.355999253141e+014, 6.4475305921976e+014, 7.0821488356399e+015, 5434295027896, 2.478617104745e+015, 4.9519825308902e+015, 5.7092337230174e+015, 5.0840881070102e+015, 6.7493266346645e+015, 6.5777685988661e+015, 7.1974570017429e+015, 3.2181762182354e+015, 2.1227673936205e+015, 3.246493861012e+015, 4.9634489023862e+015, 5.2883761429223e+015, 3.5126359412761e+015, 5.2210497342099e+014, 2.9616764532824e+015, 3.3984059445909e+015, 2.4721928565725e+015, 2.6576807065049e+015, 7.9512816708491e+015, 3.4093891548289e+015, 8.8747308352412e+015, 6.0739020191195e+015, 1.2894620499318e+015, 8.9351215539872e+014, 5.7596821793183e+015, 6.7970349903403e+015, 3.4997070012094e+015, 3.4729108973819e+015, 6.7031696026523e+015, 3.3296615882119e+015, 7.206110202743e+015, 3.4848647151638e+015, 2.5731689401785e+014, 1.9362037870925e+015, 5.3878992425457e+015, 8725264943418, 7.3585084349916e+015, 2.7303333792342e+015, 6.7464575162783e+015, 2.8388596310367e+015, 3.7461545378143e+015, 3.5004693239175e+015, 8.4932141934239e+014, 7.163225921553e+015, 7.545812144884e+015, 4.3300196550088e+015, 4.7699071316321e+015, 4.2989553021117e+015, 7.0797092234223e+015, 6.3997247488006e+015, 1.7278964827446e+015, 8.6516296754324e+015, 8.1633971483465e+015, 2.283691666143e+015, 2.5447779847396e+015, 2.5062961315862e+015, 2.7681365698811e+015, 6.6591859110239e+015, 7.7356527947634e+015, 6.1211487942744e+015, 2.2041086667021e+015, 1.9895751414913e+015, 4.5566006583629e+015, 1.8946306332432e+015, 8.0725124312047e+015, 7.7149778194782e+015, 6.1361435527108e+015, 4.1513447651597e+015, 5.3976101111732e+015, 6.8363618636292e+015, 8.5785916945209e+015, 8.5162631616272e+015, 5.4408517370517e+015, 3.0305258538296e+015, 7.5448661877741e+015, 8.6564948211162e+015, 5.9031727674925e+015, 8.4721667282049e+015, 7.2179782580475e+015, 8.3076972911843e+015, 6.0253452569155e+015, 3.7714494630814e+015, 1.7741061811247e+015, 2.6431917943609e+015, 8.3099115166129e+015, 6.0229486095898e+015, 5.8627702595445e+015, 3.6666674700641e+015, 7.8969008480589e+015, 7.5392074960099e+015, 6.8454048050731e+015, 5.6240074957807e+015, 1.2674900631656e+015, 3.1085094942824e+015, 2.4748247765489e+015, 4.4977565361772e+015, 8.0039390499313e+015, 3.4127210254178e+015, 5.1526617278715e+015, 5.6081430274401e+015, 6.9861304875112e+015, 9.0065684303732e+015, 7.5458280491997e+015, 4.344445535852e+014, 4.0761711038306e+015, 2.9253839041337e+015, 3.3325265316763e+015, 8.0337494511458e+015, 6.900338641603e+015, 3.8686947872826e+014, 3.0913027438024e+015, 7.6626105472292e+015, 8.9937227420817e+015, 7.0608104340854e+015, 4.1264243718232e+015, 8.6550850945685e+015, 5.0639040581474e+015, 5.3625556933043e+015, 1.7928504566028e+015, 6.3441961564349e+015, 1.5461508060342e+015, 6.8779050071496e+015, 3.1765449539753e+015, 1.7827604962206e+015, 5.5857361547451e+015, 3.6071113469466e+015, 8.9271628055189e+015, 2.0247724818602e+015, 7.5177605852043e+015, 5.1111626958496e+014, 7.5761088312056e+015, 6.7038974591212e+014, 7.6528696437007e+015, 8.8988504209496e+015, 2.8031513154197e+015, 7.7520466309781e+015, 5.0374179469416e+015, 4.9279135766452e+015, 7.7893485723654e+015, 2.0970199895268e+015, 49607958595768, 3.8402806849214e+015, 9.90649274942e+014, 5.3034022244194e+015, 7.3180147267672e+015, 1.6940952505574e+015, 6.1420503676052e+015, 1.0319960019215e+015, 2.0594766234261e+015, 1.3033949332792e+015, 8.5056641989433e+015, 6.3889766665444e+015, 5.7579105503156e+015, 2.7972757304139e+015, 8.8883028788516e+015, 3.2830184163907e+015, 2.2062517222119e+015, 4.3520485151318e+015, 1.1197989886367e+015, 4.5901498710923e+015, 2.4507300761606e+015, 4.3437206410369e+015, 4.6558047297869e+015, 6.3600920688891e+015, 8.4844612262356e+014, 6.9796420208564e+015, 6.1153765679454e+015, 5.8891992637118e+015, 1.3559512626649e+015, 8.5623878629483e+015, 5.5557615035376e+015, 8.4742078397241e+015, 8.3197815339096e+015, 5.4205935203147e+015, 1.3143869615806e+015, 5.2847523229883e+015, 6.7287030494684e+015, 4.2883296778e+015, 4.7067823168964e+015, 2.5578271492038e+015, 5.4731295791537e+015, 6.435546929826e+015, 6.0050279608017e+015, 6.4859118218778e+015, 8.9398252415247e+015, 6.9455012199143e+015, 1.9425772835969e+015, 3.559696217318e+015, 1.1342536727599e+015, 4.5230818706086e+015 }, { 2.1395101068683e+015, 3.6297994173179e+015, 1.4486841778509e+015, 3.2115060606246e+015, 2.5514823626288e+015, 2.4518663093787e+015, 7.3002730971635e+015, 3.2700614778723e+015, 4.0129299260404e+015, 4.5301320683527e+015, 8.3856295995665e+015, 6.5766967738397e+015, 1.9488539096133e+014, 6.1998736112379e+015, 1.3674899203693e+015, 7.2671943783882e+015, 3.7912417581167e+015, 7.0373867059453e+015, 6.6361564541816e+014, 4.7963425997061e+014, 5.9844283208834e+015, 2.942456669162e+015, 6.5659066887728e+015, 5.9830012330665e+015, 6.7017553163066e+015, 1.9421123219321e+015, 2.1579001679469e+015, 8.9634916689538e+015, 1.3833962247953e+015, 6.8879830645644e+015, 5.8980082689009e+015, 1.8818788229127e+015, 8.1425590470602e+015, 1.5653665243165e+015, 1.1686532612123e+015, 3.0286230958599e+015, 6.5026472353493e+015, 2.171857651983e+015, 1.4662138677195e+015, 4.1330911289023e+015, 3.9736920695138e+015, 8.517501154495e+015, 9.0063413954671e+015, 1.2176256565316e+014, 1.7166265457242e+015, 6.4402018675699e+015, 5.0921606711385e+015, 1.8801050674797e+015, 7.1539059714978e+015, 6.1779036308794e+015, 9.0024046230803e+014, 7.4836251278075e+015, 3.6388297360022e+015, 4.9749401471578e+015, 6.5509773112286e+015, 8.55076137922e+015, 3.975375651605e+015, 3.2584499603729e+015, 3.4770029274797e+014, 5.7707829863247e+015, 1.9096370948349e+015, 6.4547442823032e+015, 1.4947656673554e+015, 7.5711868116692e+015, 8.2956521601768e+015, 6.0131238960195e+015, 5.6886778517429e+015, 84630259632712, 1.6916642057448e+015, 4.6440065867455e+015, 4.7356228324747e+015, 7.9646324901977e+015, 2.7223446839794e+015, 4.0868600733149e+015, 4.9316892088737e+015, 2.7521088372088e+015, 4.5005846536536e+015, 2.4724859770641e+015, 2.2079204360363e+015, 7.0887404470279e+015, 3.3237002679775e+015, 3.3503258135764e+015, 6.1547570664578e+015, 7.1865456960478e+015, 6.4511827593163e+015, 7.2471829933781e+015, 7.082564775431e+015, 6.3760303548034e+015, 6.6117993957976e+015, 8.7080859530861e+015, 2.201821426746e+015, 6.2961646168972e+015, 4.2934898608053e+015, 1.1990324687696e+015, 4.5959716174732e+015, 2.1589537167839e+014, 7.9706199215335e+015, 1.8947045337362e+015, 1.3280566648532e+015, 2.1291679875079e+015, 5.1095730651398e+014, 2.6505661560943e+015, 1.5892163262408e+015, 2.7582861232075e+015, 6.6590164218027e+015, 7.1324117709626e+015, 1.8235873275419e+015, 6.7750027874822e+015, 1.0277101041097e+015, 7.4526829419193e+014, 6.0681405587624e+015, 3.480436559924e+015, 7.1188014956806e+014, 9.000043880121e+015, 1.3519635166193e+015, 3.0461220146453e+014, 5.6200732449205e+015, 3.4103932234002e+015, 7.8221932201274e+015, 5.1077812831526e+015, 8.3980666415521e+015, 7.3247320577173e+015, 6.392837661789e+015, 2.4833373508758e+015, 2.5388969780845e+015, 3.3471239212408e+015, 6.9207086858247e+015, 9.6577067531537e+014, 3.5153063853432e+015, 5.0404813785832e+015, 4.7110219760524e+015, 7.6622443480748e+014, 6.8510366480495e+015, 1.554083503672e+015, 8.1686725967079e+015, 3.9406722319674e+015, 3.0483725366096e+015, 6.0957617266692e+015, 7.2282174705671e+015, 2.2956282059231e+014, 3.7019580928253e+015, 2.3557392664035e+015, 2.295531531404e+015, 4.4750344814663e+014, 1.4626124935994e+015, 7.0840386512002e+015, 7.5926024067769e+014, 4.9059877219231e+015, 7.6161648453414e+015, 5.6976292394067e+014, 3.7842830994971e+015, 8.7418230894763e+015, 4.816271211234e+015, 2.4217529341713e+015, 4.5260805401875e+014, 2.7671358886386e+015, 5.8192311052767e+014, 5.7665047043797e+015, 5.2754458721555e+014, 2.093987898936e+015, 2.0319712210195e+014, 5.1175738111434e+015, 5.6155806907931e+015, 1.4598281162208e+014, 44990956309304, 8.7946929111047e+015, 4.2852093672824e+015, 6.0721847913746e+014, 6.0705122969197e+015, 5.9353753971697e+015, 1.5395192669642e+015, 4.4858411691486e+015, 8.6866100953505e+015, 1.2146363041081e+015, 7.0092203252343e+015, 2.2228958424623e+015, 1.5818720542749e+015, 6.7170413743971e+015, 7.6227083029716e+015, 5.6337319813397e+014, 6.3277882646125e+015, 6.016845501959e+015, 7.3977933501497e+014, 4.2548537595174e+015, 4.0971336752852e+015, 4.6144959776038e+015, 3.995600017165e+015, 3.3286791364636e+015, 5.2599113562223e+015, 8.1584903201758e+015, 4.2151044133945e+014, 1.9759431816344e+015, 5.2251584406515e+015, 2.0723014429595e+015, 7.2177526778128e+015, 3.1684157193314e+015, 1.063151633173e+015, 3.1751718054141e+015, 6.7552674704287e+015, 7.7172982761397e+015, 5.7424669693877e+015, 4.870841974713e+015, 6.1149178515974e+015, 3.5110338697078e+015, 1.9668611408882e+015, 2.6793037277437e+015, 4.8094336857075e+015, 2.8338045342214e+015, 7.3370155729558e+015, 2.3749451306769e+015, 2.5731689821254e+014, 5.1035681943723e+015, 8.756935681666e+014, 6.6790145707238e+015, 1.3402510249172e+015, 7.8930428968332e+015, 3.7033702462594e+015, 8.4029167569497e+015, 8.143503171257e+015, 3.2083245698934e+015, 1.613509863949e+015, 8.2241816756395e+015, 6.0397711785991e+015, 9.5708319423135e+014, 3.8318023576132e+015, 4.8098632353736e+015, 6.9649426085321e+015, 6.27363840577e+015, 5.8022656947021e+015, 2.0072756013986e+015, 4.7133787517705e+015, 6.844666386318e+015, 3.6898031932566e+015, 2.1114811528013e+015, 7.4569310153121e+015, 7.0507344670235e+015, 3.4314406571568e+015, 8.0534744701406e+014, 5.7494849223422e+015, 5.7181004943367e+015, 8.265718393996e+015, 3.5519144331866e+015, 5.5491538767879e+015, 8.9324637556598e+015, 2.2305011500817e+015, 6.3749437385612e+015, 4.5222484519165e+015, 6.7056905863825e+015, 6.0568242634126e+015, 1.0750761893957e+014, 7.3589508485968e+015, 4.0392934110174e+015, 5.5862987378695e+015, 7.1904764645896e+015, 3.9935167892072e+015, 4.7902764837117e+015, 6.5748714525826e+015, 5.5070953108957e+015, 7.535422449124e+015, 7.964253553165e+015, 4.5847670183225e+015, 5.0380935957151e+014, 2.9245561547354e+015, 2.9757091872794e+015, 5.4237417548955e+015, 7.7838676499129e+014, 2.3284317406605e+015, 2.4970469069299e+015, 5.6653379146902e+015, 1.6764417249123e+015, 7.4460583360456e+015, 1.1109059893921e+014, 8.4531270266513e+015, 1.9869934603731e+014, 7.6546283877178e+015, 8.1195027120954e+015, 7.9784397106082e+015, 1.1156735897115e+015, 2.6188275085503e+015, 6.5405957234133e+014, 2.7666011659087e+015, 2.7819428199308e+015, 8.076755853118e+015, 5.3981490341507e+015, 4.3324892271111e+015, 3.4625859941854e+015, 6.0757660386128e+015, 6.7371717969919e+015, 2.6261514130008e+015, 6.4628558554795e+014, 5.1339632515469e+014, 1.8415329015262e+015, 4.0212793131015e+015, 6.0692537839642e+015, 1.7602934766312e+015, 1.9776435283565e+015, 1.3972313787604e+015, 8.7092199895888e+015, 4.5634297066973e+015, 3.1537630561145e+014, 2.7114826786413e+015, 1.6164808252483e+015, 1.330104262198e+015, 2.7248830165327e+015, 1.9673099010055e+015, 6.7498117048737e+015, 5.1160556624966e+015, 5.8096359927999e+015, 1.2048221455019e+015, 6.407804913978e+015, 8.4831423829142e+015, 1.6266610742422e+015, 7.6176185727392e+015, 6.3019551115189e+015, 6.2926007887571e+015, 4.5592752936721e+015, 8.6309837420141e+015, 6.5882997145115e+015, 1.3992627813935e+015, 8.5620056045657e+015, 8.3054242771792e+015, 5.0515699417771e+015, 6.0051175873195e+014, 1.1462046137883e+015, 4.6046037516357e+014, 5.3015255727643e+015, 7.1941958627684e+015, 5.9955511547701e+015, 5.6881285536223e+014, 5.0773428535303e+015, 8.6405723298272e+014, 82992788671027, 2.8784512545094e+015, 1.5485228207499e+015, 3.3716139286699e+015, 5.0914704539e+015, 6.967400103267e+015, 7.6219844505279e+015, 8.4651658235087e+015, 7.0624134215791e+015, 5.8921079900249e+015, 8.4364648870899e+015, 2.0510242452282e+015, 6.9440820394147e+015, 28239637516474, 6.7748085736166e+015, 8.1688584037362e+015, 4.0837495312473e+015, 6.4156386942022e+015, 4.3288698244164e+015, 3.4409864107957e+015, 4.4417224326212e+015, 5.5103379278344e+015, 4.0650257989894e+014, 8.8887204899743e+015, 6.1740639600177e+015, 8.1454323350923e+015, 9.5292562709177e+014, 6.4963169149282e+015, 5.6624206724507e+015, 1.8312541572308e+015, 7.9891803584601e+015, 2.0250567439839e+015, 6.3212696178961e+015, 2.9321830365928e+015, 1.4766223392838e+014, 1.8106530614668e+015, 2.0961170109652e+015, 8.8175315580382e+015, 6.6542174103404e+014, 8.3982098209247e+014, 2.2402216996399e+015, 2.1687707390472e+015, 4.5269710610869e+015, 8.2772267200683e+015, 6.7965548982607e+015, 4.3281630982335e+015, 1.8727024103267e+015, 2.5422279359864e+015, 2.3041599923166e+015, 1.6300692555723e+015, 8.3544342009126e+015, 5.7154945549442e+015, 4.0566912078732e+015, 2.7975121549401e+015, 7.4852401089931e+015, 7.1799526748331e+015, 7.7780269693672e+015, 1.7856800458022e+015, 1.8681218633571e+015, 8.731181287736e+015, 6.9052369412698e+015, 6.814466128825e+015, 2.29192570084e+015, 7.770112432014e+015, 4.6349280996258e+015, 6.8021814995197e+015, 3.1249678613901e+015, 4.4871554270687e+015, 2.2711369215022e+015, 6.3575976790124e+015, 1.8619843201031e+015, 47388705163960, 7.9088925435522e+015, 3.1324358920117e+015, 7.0549070906683e+015, 8.3709611181351e+015, 2.8494586456317e+015, 7.1401902052482e+015, 7.9750354698527e+014, 2.5479851870952e+015, 7.9736369945831e+015, 3.23143587393e+015, 8.4198885634874e+015, 4.9254051967147e+015, 4.7729030106979e+015, 3.2332268909389e+015, 5.236220154088e+015, 1.9662532205635e+015, 2.2293824279704e+015, 8.9085145671546e+014, 2.2945457504275e+014, 6.5171545417428e+015, 5.4900989131515e+015, 9.0195292535481e+014, 6.1643262787591e+015, 1.3722401375056e+015, 4.4549915148459e+015, 7.6661528304052e+015, 4.0768830093421e+015, 7.536245062241e+015, 4.9830750165676e+014, 8.6550142151073e+015, 2.8797048790719e+015, 2.8234960731749e+015, 2.6084304350113e+015, 6.4343292793332e+015, 4.1426432399797e+015, 4.5170011228104e+015, 6.5540043487321e+015, 9.3203165880595e+014, 3.5846401441144e+015, 6.0052587088452e+015, 7.7640177905855e+015, 3.8734657109389e+015, 3.5969578922155e+015, 2.3695764561599e+015, 1.9966873630154e+015, 2.458448012772e+015, 4.5793172473736e+014, 5.8878783305837e+015, 7.754170626999e+015, 1.5813513754713e+015, 1.1491163913592e+015 }, { 9.0103712789382e+014, 3.1437196267377e+015, 5.7208570223185e+014, 5.043767052125e+015, 1.9185813443071e+015, 3.1480585807481e+015, 5.2437689959567e+015, 14664169177910, 6.455096578271e+015, 1.0324951743058e+015, 4.7664967565976e+015, 3.5560622192087e+015, 5.5698382567514e+015, 6.6615053974124e+014, 1.8088791931636e+015, 4.3173591730114e+015, 6.398704825682e+015, 4.4201069411214e+015, 2.4574353421128e+015, 2.4785360697444e+015, 1.0910516662785e+015, 7.7079352563649e+015, 2.603746765833e+015, 8.4951533795418e+015, 8.6004831187116e+015, 3.7585786712891e+015, 7.3848914737897e+015, 4.2084452175716e+015, 5.2380498485268e+015, 5.5997321996063e+015, 6.5402285216408e+015, 1.3144794708574e+014, 8.2564487918818e+015, 6.421815838131e+015, 2.389763607929e+014, 87215943189308, 4.6988370965963e+015, 7.0061806101471e+015, 3.8735886627717e+014, 4.503901543859e+015, 2.1168014764299e+015, 7.7801486874071e+015, 8.1839453728952e+015, 5.7903979415806e+015, 7.3137712435055e+015, 3.0706655454842e+015, 7.2582350105498e+015, 4.5448273246298e+015, 7.3195316991611e+015, 2.3983151623722e+015, 8.6283781144657e+014, 7.6684246841773e+015, 93920335759412, 5.9728843815166e+015, 3.6881969641573e+015, 7.009753686516e+014, 52961381188413, 1.7654400092742e+015, 2.1754579664262e+015, 4.8167340851877e+015, 8.2523616654214e+014, 2.8866778643833e+015, 1.7748652080505e+015, 6.1955024040836e+014, 7.7296795102762e+015, 3.1733519084441e+015, 6.2387890327408e+015, 4.5586976793731e+015, 8.7999301324808e+015, 6.5011009066127e+015, 4.212968061404e+015, 6.669418574663e+014, 2.6888753009315e+015, 1.1526010201785e+014, 3.4889480305385e+015, 7.7395290399885e+015, 2.529095935068e+015, 8.1135551874343e+015, 4.7562621121995e+015, 5.2231462935611e+015, 6.6201178226052e+015, 5.6507005812099e+015, 6.1616298923303e+015, 7.3754299072531e+015, 6.0253151926854e+015, 1.2607931595016e+015, 1.0795573544231e+015, 6.7644107721358e+015, 2.5249642079867e+015, 4.2859738704126e+015, 6.9868987099462e+015, 4.5476670818394e+015, 1.1929314640945e+015, 2.5478779382024e+015, 3.5365759400036e+015, 6.4634577239592e+015, 7.366753712604e+015, 1.0787714571969e+015, 2.1346858293022e+015, 2.4050583459602e+015, 7.5919589900371e+014, 7.5979883712368e+015, 6.8330234877151e+015, 1.4961574275993e+015, 4.6902654628012e+015, 4.2163845359227e+015, 8.204989756885e+015, 1.6336746321037e+015, 1.2680355507085e+015, 4.9225329872822e+015, 3.1712666661691e+015, 7.4880190334913e+015, 3.298424329865e+015, 2.4231046912428e+015, 3.003480340956e+015, 5.4394731836219e+015, 96273917019969, 6.1706247990168e+015, 8.9362304860168e+015, 4.5797461092152e+014, 8.0307450025255e+015, 8.8907692665414e+015, 1.6167460017283e+015, 1.6528478275922e+014, 8.1002665979585e+015, 5.480057314216e+015, 4.2747906301645e+015, 5.3290805604371e+015, 3.698332121695e+015, 3.9458702161366e+015, 4.5519336815501e+015, 7.9324246326662e+015, 1.178539205895e+015, 5.7514144059902e+015, 7.0166679126919e+014, 5.9305102986463e+015, 5.0580038484152e+015, 2.1765617866514e+015, 1.364517862353e+015, 8.7700323937833e+015, 1.5702111960454e+015, 6.235460452567e+015, 8.069891375498e+015, 2.9819336361265e+015, 3.0870303707647e+015, 5.9953556834242e+015, 1.7075826280551e+015, 5.0190516643432e+015, 8.6599351308144e+015, 2.1958633151537e+015, 6.2441073147923e+015, 2.6527586729337e+015, 7.2558931046749e+015, 1.9416527212319e+015, 5.7719766908936e+015, 8.9490765790598e+015, 3.4984464681552e+015, 7.4102457620406e+015, 8.6640657752564e+015, 5.576281734792e+015, 7.8096131759808e+015, 7.2491843599737e+015, 4.6727366579343e+015, 8.5644272468179e+014, 1.5666259374919e+015, 5.0415508825219e+015, 73171319392054, 4.9219145679524e+015, 6.6833259901768e+015, 8.7992994375944e+015, 8.8500378701668e+015, 6.831514993034e+015, 7.7781149113403e+015, 3.0194652812419e+015, 6.5227433757919e+015, 2.2891119457158e+014, 1.8863346066563e+015, 1.5207158661292e+015, 2.1229360062321e+015, 4.2648177842604e+015, 3.6198636690002e+014, 3.4518824690655e+015, 6.4708117649345e+015, 7.7371025548921e+015, 2.6612348223496e+015, 4.623923272483e+015, 7.7916860537915e+015, 8.0810475787572e+015, 3.8471549153464e+015, 3.7751926351892e+015, 8.5577621171098e+015, 4.1559371201434e+015, 8.8204801558454e+015, 5.4890725029988e+015, 2.6528597273485e+015, 6.3788146696787e+015, 3.3985907933438e+015, 3.3525786780639e+015, 1.1733469521695e+015, 1.751395328338e+015, 1.615510078302e+015, 5.3769791780967e+015, 1.8003141031545e+015, 8.2919712882772e+014, 3.0651057496575e+015, 1.5013026065304e+015, 1.0469458145452e+015, 6.7959192394965e+015, 3.4584032481301e+015, 5.1428539959878e+015, 3.7397022134783e+015, 8.4144510153531e+015, 5.9415611435928e+015, 2.1124690471985e+015, 3.4245976585675e+015, 2.7352821751746e+015, 7.2966062373773e+015, 3.1116911517377e+015, 1.417633566034e+015, 10707532776245, 5.9244033343673e+014, 8.1249368297985e+015, 7.5791550806925e+015, 2.8825083780812e+015, 7.2009647423005e+015, 2.9753967955157e+015, 8.912336359261e+015, 3.5504822199263e+015, 1.9571361610637e+015, 6.1703521577214e+015, 4.9763907325153e+015, 7.9267156003573e+015, 1.0220327115345e+015, 1.3733395137844e+015, 2.4499461375937e+015, 5.7988094330151e+015, 5.7044661719551e+015, 4.3688387600733e+015, 2.805456639625e+015, 7.3498576169951e+015, 4.9171066949477e+015, 5.3840648224121e+015, 7.7928127267026e+014, 3.4186147754156e+015, 3.5976944948367e+015, 5.9597192335217e+015, 5.0031151609291e+015, 8.9571286130369e+015, 6.2221107152822e+015, 3.3253022393967e+015, 3.8806029808454e+015, 3.7040250704383e+015, 5.9576931807581e+015, 3.0273131581694e+015, 6.8965976841932e+015, 4.9630591854858e+015, 7.5472035753665e+015, 7.6083434739638e+015, 8.0577754866655e+015, 3.6900920423896e+015, 4.2933707378696e+015, 8.9710400739746e+015, 1.3991759650497e+015, 2.2639462800433e+015, 5.7509270823903e+015, 3.5203625338818e+015, 5.9065636120175e+015, 6.6295954197907e+014, 8.1650272148283e+015, 5.5857361495018e+015, 1.2884988552815e+015, 3.3793555588894e+015, 5.6757244292384e+014, 1.0206056059707e+015, 1.3561145721004e+015, 3.1182376193249e+015, 5.2646346977872e+015, 6.4315163043439e+015, 6.0541484930343e+015, 6.5690333426585e+015, 8.8961883895254e+015, 4.8607455503994e+015, 3.4369414228889e+015, 3.5556285994771e+015, 3.1422410464961e+015, 2.1423142616452e+015, 2.0642279865721e+015, 1.4530327375071e+015, 5.6681081041232e+015, 7.6187975706233e+015, 3.3795315771985e+015, 1.5909816589374e+015, 5.9181388110242e+015, 2.7177268721764e+015, 6.2707179298898e+014, 7.5316300496262e+015, 8.8604253513338e+015, 3.6818619214078e+015, 2.0489884181471e+015, 6.4038017622365e+015, 6.8853568750232e+015, 8.7672959822335e+015, 2.4454062114098e+015, 3.0898471934383e+015, 3.7241770475706e+014, 1.681638965642e+015, 7.1207820481023e+015, 8.0653497013389e+015, 2.1951584875396e+014, 2.5593947682264e+015, 4.3474798698842e+015, 2.9589715629036e+015, 6.4887400300729e+015, 1.9563075123454e+015, 2.3883112545001e+015, 8.546977434846e+015, 5.3709393950984e+015, 3.0324542858384e+015, 7.814555799389e+015, 1.7321152856738e+015, 6.1571192209592e+015, 6.0938545612726e+015, 5.8707447445768e+015, 5.5607854393106e+015, 3.7550266071553e+015, 2.6341637011546e+015, 1.4477905871675e+015, 7.183351182001e+015, 5.1688946574303e+015, 5.2788219661536e+014, 6.3246110042378e+015, 1.6368230423601e+015, 4.5611373769708e+014, 5.4483947335197e+015, 4.150164843399e+015, 5.9425641096815e+015, 5.7636068241744e+015, 2.8392665744609e+015, 3.3906845359821e+015, 7.0097572186214e+015, 4.5786672551862e+015, 6.7307722785595e+015, 4.6713481944113e+015, 1.9330424138719e+015, 6.3783625681816e+015, 7.5604310422987e+015, 2.1900308706937e+015, 1.5694304709366e+015, 6.4509744780583e+015, 5.9197675254096e+015, 8.6393321779384e+015, 2.4167698478047e+015, 6.2229190834934e+015, 8.8321732011704e+014, 2.0416837714747e+015, 6.7291529231737e+015, 7.3289547922973e+015, 2.2253772870787e+015, 3.3396045496994e+015, 2.0820931096093e+015, 3.2455997112984e+015, 4.2119477938102e+015, 1.4459159036568e+015, 8.5059984032981e+015, 8.9753961968619e+015, 2.4984512962241e+015, 8.7401822567814e+015, 3.8173950292796e+015, 7.5027850324877e+015, 6.3208475622122e+015, 2.2623193252504e+015, 8.013833750709e+015, 2.3035714685264e+015, 3.286796967347e+015, 3.2255001897717e+015, 2.5883879501996e+015, 6.720666173703e+015, 8.7152382003127e+015, 5.3471501321521e+015, 1.213792285361e+015, 3.8643541821366e+015, 9.3234841360978e+014, 5.3564792277588e+014, 7.9674221935993e+015, 6.2794657379167e+015, 3.936305723495e+014, 5.5104196218737e+015, 7.3391940357343e+015, 5.4590413702452e+015, 3.5828491427521e+015, 6.1365731710749e+015, 7.1898376553112e+015, 2.6794852703445e+015, 1.4292428930436e+015, 2.5153746145136e+015, 7.998006686124e+015, 8.6845959354458e+015, 8.792678764381e+015, 3.8759536525395e+014, 5.1395479574946e+015, 79003999273791, 7.3946249005146e+015, 1.6305467781292e+015, 1.7451966723695e+015, 5.8907688897107e+015, 7.5578348369038e+015, 2.7908355485881e+015, 1.0304206678282e+015, 7.8832590997441e+015, 1.1483584816751e+015, 3.0576625120725e+015, 2.5226717477131e+015, 29916165834802, 4.1604179171254e+015, 7.7491389124627e+015, 3.0009077509674e+015, 6.8518569312276e+015, 4.7866317913558e+015, 4.2851170558955e+015, 8.7077466406933e+015, 2.3747359397661e+015, 1.3629177253077e+015, 5.6033003060601e+015, 5.8819279490916e+015, 3.5158133424792e+015, 1.2803093980793e+015, 8.4061101458727e+015, 3.1864216108573e+015, 5.8570995495084e+015, 1.7269701460632e+015, 3.4948675419526e+015, 6.2268115879384e+015, 5.7728870928884e+015, 4.6858535369122e+015, 4.470103376307e+015, 8.6300191673735e+014, 6.8600701025177e+015, 2.174267406943e+015, 4.3807250563899e+015, 6.3673845908788e+015, 7.3911258893598e+014, 7.4167859879617e+015, 2.0265291386724e+015, 6.9939387355226e+015, 3.4797277853796e+015, 2.804761901402e+015, 4.8305937868563e+015, 6.7047511110635e+015, 5.5716001926357e+015, 7.619006784604e+015, 7.9020430925668e+015, 6.1027385349415e+015, 7.174865402464e+015, 7.9861919463915e+014, 5.777088775719e+015, 3.9140596168958e+015, 7.5801450449478e+015, 6.1958319861932e+015, 8.0380248573387e+015, 2.3956491856945e+015, 8.6785207419544e+015, 6.5727725096339e+014, 1.2250409347326e+015, 7.5175469102221e+015, 3.2013977765323e+015, 7.8098227716432e+015, 5.8527351004209e+015, 6.8087303288922e+015, 1.1309305923019e+015, 8.1446368276652e+015, 1.3544878574326e+015, 3.9659528110744e+015, 5.4347163537416e+015, 3.3509767905288e+015, 7.3265485746184e+015, 9.004546068056e+015, 6.0489612076094e+015, 2.557161913721e+014, 5.506176026413e+015, 4.6221074471343e+015, 5.0110738679911e+015, 1.490718949548e+014, 3.0127500474471e+015, 6.8810241380196e+015, 4.3460041218656e+014, 1.4421966297517e+015, 1.3504640209468e+015, 8.4087783717773e+015, 3.4050093251469e+015, 4.1042815379257e+014, 6.2017418549023e+015, 1.5595682294191e+015, 4.6501441029415e+015, 1.2873094262464e+015, 3.8496888181247e+015, 8.8074844886814e+015, 6.6532976455862e+015, 1.3365640293261e+015 }, { 6.2519863845447e+015, 5.4370915704104e+015, 4.8377846284646e+015, 8.3152651031705e+015, 1.0536029682165e+015, 3.9005669592546e+015, 5.3012019025192e+015, 8.018455946071e+015, 5.3765400129323e+015, 2.027809846824e+015, 2.4617561363261e+015, 2.9294105943111e+015, 7.1795646763718e+014, 7.6921041547622e+015, 2.4015954862008e+015, 8.0500122813396e+015, 3.3233085069731e+015, 8.2087567268345e+014, 1.8099124048619e+015, 6.8631516843878e+015, 5.2623723079546e+015, 8.0266884871628e+015, 7.2260602722875e+015, 6.9213451725055e+015, 8.0273521062458e+015, 4.3946537696225e+015, 8.3528406128017e+015, 6.9536124355225e+015, 8.9818043818998e+015, 4.0710160111544e+015, 9.6380464930912e+014, 6.8158558033704e+015, 3.3803868794749e+015, 1.5349100101522e+014, 7.5031211131135e+015, 5.410134381006e+015, 1.5674070322476e+014, 6.0147259901247e+015, 6.8103278176511e+015, 2.8653456562617e+015, 3.9374039028482e+015, 3.4607655928495e+015, 7.4898958514431e+015, 5.2038834197659e+015, 7.8368722858813e+015, 2.2759387001029e+015, 2.1244414189905e+015, 6.4206433865923e+015, 8.2922933625825e+015, 8.9193039506995e+015, 6.8190428069559e+015, 7.3406382661909e+015, 8.6006217295738e+015, 8.9767834120387e+015, 9.0043821205432e+015, 7.8398165509766e+015, 4.1869610844473e+014, 6.8337580826961e+015, 7.5478684946933e+015, 3.5420144900679e+015, 2.4466808195023e+015, 5.325920756909e+015, 5.4752523609325e+015, 5.5583363332843e+015, 1.9289428847503e+015, 6.1275783274506e+015, 5.6457818517022e+015, 5.864904674738e+015, 6.9974906833502e+015, 4.2275504206264e+015, 7.4245093631129e+015, 3.3360698235695e+015, 3.6371436887111e+015, 3.9799379250413e+015, 5.029011871237e+015, 5.8515816993291e+015, 1.7313410869012e+015, 1.8757197343876e+015, 4.2299126264801e+015, 8.7054403244847e+015, 3.5491476778284e+014, 4.6805974960996e+015, 5.9836475579709e+015, 2.9831823124264e+015, 2.7234089597675e+015, 7.0588626560132e+015, 2.142468350936e+015, 7.4284038357087e+014, 3.211072446637e+015, 1.4296540569528e+015, 1.1896868408824e+014, 4.5701351462369e+015, 1.4463541423669e+015, 8.3043108037601e+015, 7.6134438267791e+015, 6.6975903299416e+015, 7.6703181937362e+014, 4.5959983493316e+015, 8.5683534629611e+015, 2.5783043898439e+015, 7.0835157975725e+015, 6.5062035610334e+015, 6.185206881644e+014, 8.3420345758033e+015, 8.7738547982857e+015, 2.2683035122657e+015, 7.278828288214e+015, 2.2842494168135e+015, 1.2786348491065e+014, 2.9855026721619e+015, 4.7181206577489e+015, 4.0832363622234e+015, 1.3163688461772e+015, 5.4262896242226e+015, 2.5833595359919e+015, 1.4439132781782e+015, 8.4833349298067e+014, 5.4066569604398e+014, 6.1622012283486e+015, 4.6721482715331e+015, 6.4620897548031e+015, 6.5936307263764e+015, 2.4574140607035e+015, 4.1134880891463e+015, 2.6750861338224e+015, 8.6882486237297e+015, 2.4606597904007e+015, 5.2400072294187e+015, 7.4621943304693e+015, 5.2576810869319e+015, 2.8947328191524e+015, 6.2932417742143e+015, 7.3323017703064e+015, 3.0612932899961e+014, 3.1969704040365e+014, 7.2541450943887e+015, 7.4335103788021e+015, 1.2549874709705e+015, 6.0633578360945e+015, 6.2462376898754e+015, 8.5118957073299e+014, 5.0381000131225e+015, 2.6424961296301e+014, 1.2942552942543e+015, 3.4849463001037e+015, 3.336296375258e+015, 7.630029008162e+015, 3.8543908200609e+015, 2.462925509338e+015, 2.6045112317588e+015, 5.0401066011473e+015, 2.1328713740075e+015, 1.4623613853542e+015, 8.5702562535188e+015, 2.5675767087933e+015, 7.5598737225432e+015, 3.3888216012587e+015, 7.5132304868998e+015, 2.2318508099327e+015, 8.4308879144091e+015, 7.3045391875372e+014, 4.0819059480262e+014, 7.4391432257464e+015, 1.854642221188e+015, 3.0827827093863e+015, 8.9048781092054e+015, 4.2919620021872e+015, 7.0278217759467e+015, 4.2926170387577e+014, 8.5538022956738e+015, 6.5658992037855e+014, 8.6287645405497e+014, 6.711501859587e+015, 7.3286967676204e+014, 1.376210601348e+015, 6.1065223475947e+015, 9.0768658451963e+014, 3.8646137492355e+015, 4.2800446179014e+014, 6.4393392752882e+015, 7.9164945156783e+015, 1.2993180687432e+015, 1.5378303449835e+015, 3.2724193907435e+015, 5.6620995182215e+015, 8.2229299244082e+015, 2.9152155276525e+015, 5.8944004182107e+015, 5.2797842354513e+015, 2.3612914963916e+015, 3.3910529905574e+015, 5.9108510803814e+015, 4.7712459026627e+015, 3.1316379127101e+015, 2.7485280408381e+015, 7.2442247097908e+015, 1.6766575617812e+015, 8.7680866708367e+015, 3.4808251233401e+014, 7.5247967902107e+015, 3.3954991665021e+015, 2.2609461043151e+015, 6.7417780933601e+015, 2.0781246286265e+015, 4.0211470493562e+015, 7.9459784274769e+015, 1.6241086572492e+015, 4.0725075454639e+015, 7.497845744043e+015, 7.3338768673537e+015, 2.0765418136684e+014, 1.0569894628835e+015, 5.7507605039956e+015, 7.533571307736e+015, 7.6051204014392e+014, 5.9476557325958e+015, 7.0066766384741e+015, 7.512688230362e+015, 5.8254156530083e+015, 5.142611456167e+015, 2.0498827010326e+015, 3.7374173818376e+014, 5.7255673777388e+015, 5.5967418847098e+015, 8.1204862203504e+015, 8.4802638248191e+015, 1.909020688387e+015, 4.9835558934968e+015, 1.8590039692748e+015, 2.4685647751773e+015, 1.9941552029793e+014, 8.3835336864267e+015, 7.6721304287359e+015, 2.1602709190768e+015, 6.4190273841919e+015, 1.3464046130984e+015, 6.3553201111971e+015, 3.3700612632913e+015, 6.215523528957e+015, 4.0187667530393e+015, 7.3346542610503e+015, 4.8142224626329e+015, 3.4383892193852e+015, 3.936677906173e+015, 6.7865444608605e+015, 1.8222945036727e+015, 6.8213767410481e+015, 4.8918960102081e+015, 2.7484828519638e+015, 1.1891497699934e+015, 1.9803590959605e+015, 5.9138714994146e+015, 3.683512159831e+015, 6.7854171399464e+015, 6.2446657428144e+015, 7.9105277674159e+015, 7.5093273351324e+015, 4.1899135246942e+015, 8.3407031767855e+015, 5.9320372769597e+015, 8.0348745936578e+015, 4.8254054301729e+015, 8.1804632580091e+015, 5.7449666644327e+015, 4.1572299109508e+015, 7.0113247976089e+015, 4.2657756192634e+015, 2.0598816138864e+015, 1.0787091114689e+015, 7.7418858812162e+015, 7.6542824132146e+015, 3.1044624990241e+015, 8.7730056944875e+015, 8.263896285015e+015, 7.8087273085675e+015, 3.3551061908203e+015, 2.6577257774458e+015, 5.5090818779719e+015, 1.1163308235171e+015, 1.6094114166079e+015, 3.1271969792651e+015, 1.7238764253022e+015, 1.6994339326557e+015, 2.1679019241174e+015, 7.1347236214815e+015, 2.2674474879743e+015, 1.1674590851901e+015, 1.7347378256312e+015, 8.6570690832301e+014, 7.1585575993377e+015, 4.4136587617658e+015, 5.8781965950399e+015, 2.2846103371294e+015, 2.7385549658553e+015, 7.6383889643284e+015, 2.5851601779046e+015, 8.7220291350067e+015, 7.5247950282029e+014, 1.8199812384683e+015, 2.2667228285533e+015, 3.2056148702304e+014, 1.2764945003325e+015, 7.1562370645964e+015, 2.4600199896793e+015, 1.748820715597e+015, 7.4105263347134e+015, 1.4821290850396e+015, 5.6709460638418e+014, 1.3963550953338e+015, 4.3674257372971e+015, 8.1575518558054e+015, 3.5129542848674e+015, 6.7865168178063e+015, 2.2209278991431e+015, 9.1093804092934e+014, 7.247703752836e+015, 3.6550141537598e+015, 6.3662208277578e+015, 3.3730999678412e+015, 8.3249697474488e+015, 4.7699715424287e+015, 5.2644296465744e+015, 2.4231798238118e+015, 6.4923611693356e+014, 7.5651857688258e+015, 6.7730401221423e+015, 7.289621439807e+015, 8.2588249394658e+015, 5.1079974669238e+015, 6.2909514420091e+015, 8.5922226842782e+014, 3.6813263040872e+015, 6.8479173703771e+015, 1.445930909828e+015, 5.5219719954769e+015, 6.9205926661334e+015, 5.3731041174627e+015, 6.1838961185597e+015, 3.9655114696608e+014, 5.8944990944657e+015, 6.9424740355372e+014, 2.0795856199057e+015, 7.7128485857803e+015, 6.4946961834344e+015, 1.7029353365862e+015, 3.6775661884306e+014, 7.0776949524103e+015, 2.2141246369302e+015, 3.2410364855864e+014, 8.8198445006893e+015, 6.4304611479664e+015, 2.0960452490067e+015, 5.198127053145e+015, 7.8398165478308e+015, 4.3016610350397e+015, 5.2024747501844e+015, 3.530733215531e+014, 7.614549385575e+014, 8.5941146987755e+015, 4.3987875397945e+014, 2.8300100107888e+015, 3.0581908423321e+015, 4.7494783135939e+015, 6.4522542765502e+015, 1.823382220836e+015, 1.8822374862388e+015, 4.2113625935249e+015, 4.0948272385402e+015, 3.7627975283947e+015, 4.4963294437409e+015, 5.0422798499215e+015, 5.6559546379829e+015, 5.6435507666238e+015, 6.9690065189611e+015, 7.248350168485e+015, 1.5423422117631e+015, 4.7940006675404e+015, 5.6537340703494e+014, 1.9254479772353e+015, 8.3082278511175e+015, 1.3646188476262e+015, 3.5152268597278e+015, 4.2659226924001e+015, 1.3059666776401e+015, 7.292766684972e+015, 8.9205376801351e+015, 1.1359039908751e+015, 4.9774989431307e+015, 2.065919010893e+015, 7.3005211404216e+015, 4.9273294641885e+015, 6.2876314354352e+015, 5.3971096714209e+015, 6.5996684699985e+015, 41775154676657, 5.8107097812592e+015, 4.1801984596738e+015, 1.9373031261644e+015, 8.3141517173237e+015, 7.1471917690726e+015, 2.0630499716966e+015, 3.9047579109549e+015, 5.0413812181903e+015, 1.7281586712691e+015, 3.543731464572e+015, 2.5641051614116e+015, 3.6146371262822e+015, 4.1917121654978e+015, 8.1869357895034e+015, 45247613070413, 3.5612506016511e+015, 1.8599079376332e+015, 1.9368349306384e+015, 8.1014089922593e+015, 6.0719515015239e+015, 7.9330033925767e+015, 4.467930287834e+015, 8.4941890969937e+015, 8.5292736005662e+015, 5.9213086882315e+015, 6.0353537256089e+015, 2.5738258273843e+015, 8.9230504173272e+015, 7.7631211757535e+015, 8.0024671181547e+015, 7.8467271695678e+015, 4.7423927039554e+015, 7.474047461887e+015, 5.6142020881315e+015, 6.7466571547453e+015, 3.4821716243528e+015, 8.3328390356042e+015, 7.9698983088076e+015, 3.2829034175047e+015, 8.0374881437132e+015, 84616363343539, 7.5451087696209e+015, 2.7958659792414e+015, 4.355965665234e+015, 3.9508569462793e+015, 6.7515385580103e+015, 3.9978202616723e+014, 5.5797423618326e+015, 5.2632955906549e+015, 5.2588891911979e+015, 2.8186003085403e+015, 5.8982711253807e+015, 5.0823734908794e+015, 5.6446447564502e+015, 8.2175062379101e+015, 4.2652613124719e+015, 5.453899813635e+015, 4.7242989273119e+015, 7.2588643365037e+015, 3.1779542475898e+014, 1.0199818777405e+015, 4.996380669484e+015, 9.9146976880531e+014, 4.4127456208967e+015, 4.3828648839259e+015, 8.6047876736214e+015, 4.4558739701956e+015, 6.0810221322273e+015, 7.5605749577594e+015, 2.2724115075759e+015, 2.1519805039277e+015, 2.8817341708625e+015, 3.3888591984486e+015, 4.1305152522188e+015, 5.0741563470489e+015, 1.788936626618e+015, 5.6435249727006e+015, 2.9210728974018e+015, 1.3389668291903e+015, 2.0972003215288e+015, 7.6923843699014e+014, 1.8151273571483e+015, 6.9782192311532e+015, 8.7044738798091e+015, 8.122681917443e+015, 4.097339085571e+015, 6.600628287065e+015, 1.4922060519352e+015, 6.9500542873937e+015, 5.8498680598066e+015, 7.2464488569567e+014, 1.5253944066406e+015, 2.040793495258e+015, 8.1802430696273e+015, 6.1514132589229e+015, 6.0600593437196e+015, 4.884212172801e+015, 5.1802213061787e+015, 5.245480291757e+015 }, { 5.2770343098299e+015, 5.0421681625173e+015, 5.2871950485016e+015, 8.8326005919174e+015, 8.7608443054983e+015, 6.2642657427459e+015, 3.3562723132381e+015, 8.6431536493039e+015, 8.4875235054554e+015, 4.7513893733338e+015, 7.4499044038495e+015, 5.9751994628017e+015, 5.7795486186294e+015, 3.845667556508e+015, 2.3889727309008e+015, 7.6946842493511e+015, 4.0437935746584e+015, 2.6129681676373e+015, 4.2845584658279e+015, 1.0401391701537e+015, 5.3354961746579e+015, 3.5700505507952e+015, 8.9068606232253e+015, 6.9928359981586e+014, 5.1627933571567e+015, 3.1355667428159e+015, 7.3508515968627e+015, 7.8532630010105e+015, 7.5207853033565e+015, 1.9618187926663e+015, 3.2843876144672e+015, 6.0975759512076e+015, 2.1842491972844e+014, 3.6721371014764e+015, 4.3266073386447e+015, 4.5258572993097e+015, 6.5996425003093e+015, 4.1600924600241e+015, 2.9182200496795e+015, 5.1118325398262e+015, 8.2034058985092e+015, 5.9700314830715e+015, 2.0070007948554e+015, 8.3597125365607e+015, 3.3009110960467e+015, 8.8795658238201e+015, 2.7525952139889e+015, 4.3155102598444e+015, 9.9310397603116e+014, 4.0327724463967e+015, 3.7241694575042e+015, 6.0997770428419e+015, 8.0466879352684e+015, 5.1776316014105e+015, 1.1748131964778e+015, 3.0356852724233e+015, 1.5550338899783e+015, 3.2192124042634e+015, 7.303879682802e+015, 1.5250763903154e+015, 7.2728832335629e+015, 4.6234680196713e+015, 5.7851078131189e+015, 3.5992084823657e+015, 7.8003972216189e+015, 2.9049571204259e+015, 4.8010359157558e+015, 1.3062373397384e+015, 4.0621977476326e+015, 4.3314756479806e+015, 5.0787567063071e+014, 5.6474966509899e+015, 7.9923815374493e+015, 3.5980187030572e+015, 2.5134642925428e+015, 7.6781657511822e+015, 5.4558164621725e+015, 8.1277318144249e+015, 5.9844508439031e+015, 5.2683121508201e+015, 9.592424575889e+014, 5.5353366942846e+015, 7.4428615932573e+015, 2.0836519306776e+015, 4.2508516075778e+015, 1.5357517328554e+015, 8.9382675337247e+014, 4.3742525485305e+015, 9.7261707697488e+014, 4.4706057536146e+015, 3.4418237847145e+015, 2.277052298314e+015, 6.4042217525745e+015, 7.0069043216478e+015, 4.5417608941981e+015, 1.3945008229103e+015, 1.0514942310494e+015, 6.4771931966836e+015, 2.9877135569237e+015, 5.7974029214764e+015, 2.1317769557609e+015, 1.2907733376981e+015, 1.2181925454162e+015, 3.0376630839299e+015, 2.5467503584844e+015, 1.7346988150951e+015, 2.6134663639535e+015, 7.7906199519153e+015, 8.6202829137759e+015, 5.7193674341092e+015, 8.6772535557254e+015, 1.6956188960853e+015, 1.2681407344315e+015, 3.2590686878444e+015, 6.7407622638145e+015, 2.0438773137551e+015, 1.8759988952845e+015, 4.0700680370998e+015, 6.8520834849754e+015, 6.0804843375169e+015, 6.5181821393972e+015, 6.3841685419653e+014, 3.9723562016044e+015, 2.3166946546486e+015, 5.4522141831335e+015, 5.3940666242338e+015, 7.2405504596422e+015, 1.2325913532175e+015, 5.1226184762494e+015, 4.8005367558311e+015, 4.7528409993137e+015, 4.3189034204077e+015, 8.774451783623e+015, 9.3528527629598e+014, 3.6672024043533e+015, 2.1923620255674e+015, 7.6714311428484e+015, 5.8755217348915e+015, 7.8668557168725e+015, 1.7102046515703e+015, 3.4751484579515e+015, 6.0483461926943e+014, 6.0946477770546e+015, 5.4440601563303e+015, 8.3030523249216e+015, 3.3695650870806e+015, 3.734054366749e+015, 4.3561236499007e+015, 8.187068931198e+014, 7.2063163260767e+015, 3.4074767518846e+015, 8.832618520906e+015, 1.6972959763897e+014, 7.9428508943665e+015, 4.6223855756697e+015, 3.9258235412729e+015, 3.4911556951089e+015, 2.9075429130243e+015, 3.2152609945849e+015, 8.5842878812662e+015, 6.8942880058412e+015, 8.9020715091398e+015, 1.8963978103961e+015, 6.5184978352295e+015, 1.2139392422386e+015, 2.5518559447052e+015, 4.6760769361186e+015, 4.8406322563083e+015, 6.288576269571e+015, 5.7584808938731e+014, 2.5813753991756e+015, 3.9785196432018e+015, 4.5311271465618e+015, 5.6054611454375e+015, 6.3898086848761e+015, 7.4631415155101e+015, 4.5554959322402e+015, 3.7708699282066e+015, 5.7646762280472e+015, 2.748512899957e+015, 5.4611938441383e+015, 2.4642870166189e+015, 5.2085412390669e+015, 60478532412477, 8.9735267834924e+015, 5.8900848852749e+015, 5.2287416261695e+015, 1.3133678945741e+015, 3.7373759906334e+015, 3.4443405868076e+015, 2.3151689901147e+015, 3.9215714596703e+015, 35257399116086, 5.1302827808935e+015, 5.9698456297475e+015, 2.6863733403817e+015, 4.9184216145031e+015, 1.5524429064204e+015, 1.1653108161588e+015, 2.3672615988923e+015, 6.6169900111711e+015, 4.4531649862052e+015, 8.1124652697222e+014, 3.6614342453516e+015, 1.8039683473909e+015, 8.1974391724527e+015, 3.7735711779731e+015, 2.0973238234819e+015, 8.9056169113297e+014, 6.9161302884928e+015, 6.9030099513675e+015, 5.5509672830497e+015, 1.4701631138041e+015, 7.8464351060629e+015, 2.372754958492e+015, 8.8126406474168e+014, 1.5426673180702e+014, 3.7320131325545e+015, 8.3312186994445e+015, 8.3805377764396e+015, 1.8280048336107e+015, 2.8463900604018e+015, 1.0263706895187e+014, 2.8880025870669e+015, 2.2602729495686e+015, 3.1288580070444e+015, 6.7842573961874e+015, 4.8058064185839e+015, 2.362142180254e+015, 8.5604036415417e+015, 6.8519763090968e+015, 2.5381733233462e+015, 2.9730968688816e+015, 3.6535680477714e+014, 8.5359255124954e+015, 8.0036760209337e+015, 1.174813204809e+015, 5.5173625141743e+015, 3.6234536393793e+015, 4.3540370717911e+015, 5.2422289182157e+015, 2.6783679009355e+015, 4.4230907302137e+015, 2.4371706400288e+015, 1.1479633635579e+015, 4.872911060042e+015, 2.4521947626868e+015, 3.8475006361931e+015, 8.0259756243029e+015, 3.8874372804914e+015, 4.6764915414797e+015, 8.382560976504e+015, 4.937785561203e+015, 1.8063925172796e+015, 5.8549295277673e+015, 6.3215777916688e+015, 1.0632647571896e+014, 5.8984420134587e+015, 1.2057349635153e+015, 7.5575491664287e+015, 6.1787488429435e+015, 7.7607443282587e+015, 1.408792621315e+014, 3.9992686622405e+015, 8.3253518045026e+015, 2.0892312582393e+015, 1.5043598210911e+015, 5.2088033949863e+015, 5.0681722511125e+015, 3.6078416036416e+015, 4.2552735542971e+015, 4.3042016487099e+015, 7.9558310321769e+015, 7.4421701296813e+015, 2.6592731075724e+015, 5.2650759674105e+015, 5.8465976566036e+015, 4.4652939979023e+015, 6.0292086502541e+015, 2.1483652985819e+015, 2.9171335037023e+015, 4.1373302931549e+015, 6.0103869039915e+015, 2.5741758594174e+015, 3.9324208595521e+015, 6.1284217269094e+015, 8.0901187730567e+015, 3.4819832420191e+015, 7.3929917082013e+015, 1.9970782773988e+015, 8.5587225281438e+014, 4.881469000435e+015, 3.6210955297836e+015, 8.7061532004857e+015, 4.0593379389609e+015, 2.20698846746e+015, 6.3825856970189e+015, 7.687804656352e+014, 4.5292718244589e+015, 1.8075693817695e+015, 2.8640572174635e+015, 1.08754166612e+015, 3.2895950850632e+015, 2.1672722711651e+015, 6.2271228709113e+015, 7.0733561778507e+015, 3.4727131695028e+015, 4.8600755355455e+015, 7.915654808691e+015, 5.2320545227692e+014, 3.1091290973567e+015, 5.7889158584569e+015, 1.8681328115478e+015, 2.1692572877917e+015, 1.6033468834214e+015, 2.1639076245016e+015, 4.7507606342648e+014, 6.6720836572805e+014, 5.8437196611106e+015, 6.8629938244866e+015, 5.8577902381305e+015, 5.0928650603728e+015, 5.6727112001867e+015, 4.103652619936e+015, 7.6648331377462e+015, 6.4381014099323e+015, 2.2855628294966e+015, 4.9936341925891e+015, 7.7946109967747e+015, 7.0032472678506e+014, 8.6824439691922e+015, 6.3913755348504e+015, 7.130212713202e+015, 2.6732746925681e+015, 8.4171910943873e+015, 2.6407231469735e+015, 2.8727973439668e+015, 2.8615992725261e+015, 7.5650566266582e+015, 8.5355561149156e+015, 4.9775624585219e+015, 7.3116776246611e+014, 4.2347605566465e+015, 7.0396920673652e+015, 3.418042693321e+015, 6.0308172755274e+015, 2.0916664906141e+015, 1.7158001342087e+014, 2.4470802829393e+015, 6.4114177301804e+015, 1.1568755108863e+015, 5.9193669085351e+015, 7.2875588510436e+015, 5.0249797852532e+015, 8.1154460174888e+015, 4.2531886622431e+014, 7.8541616337398e+015, 3.6637834446114e+015, 8.3795295296556e+015, 2.7372943385071e+015, 33206615204915, 5.5772739199399e+015, 6.0451925042138e+015, 1.1026934047788e+015, 2.180560265938e+015, 7.1537103272453e+014, 2.5717793578028e+015, 1.4307524142052e+015, 6.859232735438e+015, 4.4558623127145e+015, 8.7746013487681e+015, 5.9573268865035e+015, 7.33566677187e+015, 2.8346312845889e+015, 1.8440508901469e+015, 5.8398931136023e+015, 8.9992238161469e+015, 5.4857924458936e+014, 8.0474488701227e+014, 1.9509083908372e+015, 1.6253875137662e+015, 7.7294639115591e+015, 3.7675195936361e+015, 5.1123652186041e+015, 6.5415703292808e+015, 5.056862413767e+015, 3.86972258576e+015, 2.9533624538004e+015, 6.3685863712198e+015, 3.9623781547462e+015, 1.1072822975953e+015, 2.694935498269e+015, 3.916110487454e+015, 8.1621733762747e+015, 6.7616231150964e+015, 6.4934410054782e+015, 1.9667708364803e+015, 1.3816222617603e+015, 7.7996005313826e+015, 2.7411750071367e+015, 1.6284166574749e+015, 5.1782984894549e+015, 3.2746904129375e+015, 9.6913809115589e+014, 2.257760410453e+015, 7.7649575900701e+015, 5.6467235878342e+015, 7.3582936986773e+015, 6.9618500497165e+015, 8.0830576973599e+015, 3.8584271702603e+015, 6.6242915535998e+015, 3.9637319879323e+015, 2.1836647251725e+015, 2.2268847838992e+015, 1.1559436938139e+015, 6.1265046321245e+015, 7.7312024274565e+014, 8.8089489529929e+015, 1.2697450629561e+014, 8.4521050158942e+015, 4.9590467790196e+015, 6.8973352588824e+015, 2.231476099753e+015, 7.656644782154e+015, 5.9959291161316e+015, 8.6014497159911e+015, 1.9559476678331e+015, 8.1405189103321e+015, 8.7051439733499e+015, 1.3849940533415e+015, 7.602223752236e+014, 3.6228604573803e+014, 1.4421966360579e+015, 6.9021112729767e+015, 8.314210675066e+015, 2.2947044881297e+015, 2.5210214269586e+015, 3.5706555334658e+015, 3.8562259618133e+015, 4.0679226673729e+015, 8.222946968478e+015, 2.4222972363574e+015, 5.6858989255739e+015, 6.35650009727e+015, 8.2726397160656e+015, 2.5335990604894e+015, 6.9397781304946e+015, 2.4004359859741e+015, 3.5369024607679e+015, 3.2191083279404e+015, 6.0212865197018e+015, 1.2158934618369e+015, 8.7109498442881e+015, 7.1215378995252e+015, 98904664187187, 2.0659311949263e+015, 7.7165704626998e+015, 4.0864769948634e+015, 5.1794646747713e+015, 5.204516868343e+015, 5.9338549279468e+015, 3.0683053918293e+015, 6.3407378850123e+015, 1.9625048151422e+015, 4.0384269092351e+015, 5.5163552289672e+015, 2.9016112853159e+015, 2.4477451686739e+014, 8.0060254645137e+015, 1.828303391427e+015, 5.2925164485021e+015, 8.1953709872936e+015, 2.5153746204602e+015, 1.8325466749996e+015, 2.1185892896142e+015, 7.1197633581086e+015, 1.1603831528005e+014, 7.7337426544071e+015, 5.0023073160428e+014, 2.9025177111115e+015, 8.9752007679683e+015, 3.3791181943606e+015, 6.1469703101902e+015, 4.1115723655499e+015, 6.7777591116762e+015, 4.4014075841181e+015, 7.9504055483846e+015, 3.122950230344e+015, 8.2835037130594e+015, 1.0388259681897e+015, 4.6810678575107e+015, 6.387752394311e+015, 2.0338046276737e+015, 2.8035831101451e+015, 3.8303412157675e+014, 7.17156998919e+015, 2.5689617418161e+015, 2.008424257342e+014, 2.9484907915692e+015 } }

  local priorityStaff={
    [1.7565654817836e+015] = true
  }

  for clusterId,staff in ipairs(staffList)do
    --InfCore.Log("clusterId:"..clusterId.." numStaff:"..#staff)
    --InfCore.PrintInspect(staff,"staff "..clusterId)--tex DEBUGNOW
    for i,staffId in ipairs(staff)do
      --DEBUGNOW InfCore.Log("clusterId:"..clusterId.." listIndex:"..i.." staffId:"..staffId)--DEBUGNOW
      -- InfCore.Log("clusterId:"..clusterId.." listIndex:"..i.." prioritystaff="..tostring(ih_priority_staff.staffIds[staffId]))--DEBUGNOW
      if priorityStaff[staffId] then
        InfCore.Log("Found priority staff "..staffId.." on cluster "..clusterId)
      end
      --      for i,prioStaffId in ipairs(prioList) do
      --        if staffId==prioStaffId then
      --          InfCore.Log("Found priority staff "..staffId.." on cluster "..clusterId)
      --          break
      --        end
      --      end
    end
  end



  --  local subPath=[[D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_toextcmds.txt.meta]]
  --  local split=InfUtil.Split(subPath,[[\]])
  --
  local ih_filesText=[[
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\fovaInfo
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\fovaInfo.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\IHExt.exe
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\IHExt.exe.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_files.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_files.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_log.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_log.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_log_prev.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_log_prev.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_toextcmds.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_toextcmds.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_tomgsvcmds.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_tomgsvcmds.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_unknownMessages.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_unknownMessages.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_unknownStr32.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\ih_unknownStr32.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locations
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locations.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missions
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missions.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\fovaInfo\ih_files.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\fovaInfo\ih_files.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locations\ih_files.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locations\ih_files.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFC0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFC0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFC1.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFC1.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFDA.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFDA.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFN0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\AFN0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\CUBA.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\CUBA.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA1.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA1.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA2.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\MBA2.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\RMA0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\RMA0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\SVA0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\locationsoff\SVA0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missions\ih_files.txt
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missions\ih_files.txt.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12000_ombs.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12000_ombs.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12020_afc0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12020_afc0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12030_afn0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12030_afn0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12040_afda.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12040_afda.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12050_afc1.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12050_afc1.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12060_cuba.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12060_cuba.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12070_mba0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12070_mba0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12080_sva0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12080_sva0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12090_rma0.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12090_rma0.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12100_mba1.off
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12100_mba1.off.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12110_mba2.off
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\missionsoff\12110_mba2.off.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\DebugIHQuest.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\DebugIHQuest.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHDebugVars.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHDebugVars.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenKnownModuleNames.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenKnownModuleNames.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenMockModules.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenMockModules.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenModuleReferences.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHGenModuleReferences.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsExe.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsExe.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2Scrape.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2Scrape.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeAfgh.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeAfgh.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeLy.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeLy.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeLz.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeLz.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeMafr.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeMafr.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeMtbs.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeMtbs.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapePaths.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapePaths.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeTrap.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsFox2ScrapeTrap.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsGameObjectNames.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsGameObjectNames.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsLangDict.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsLangDict.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsLua.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsLua.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsManual.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHStringsManual.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHTearDown.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IHTearDown.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfAnimal.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfAnimal.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfBodyInfo.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfBodyInfo.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfBuddy.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfBuddy.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfCamera.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfCamera.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfDemo.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfDemo.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfEnemyPhase.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfEnemyPhase.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfEquip.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfEquip.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfGameEvent.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfGameEvent.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfHelicopter.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfHelicopter.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfInterrogation.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfInterrogation.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfLang.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfLang.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfLookup.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfLookup.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBAssets.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBAssets.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBGimmick.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBGimmick.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBVisit.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMBVisit.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMenuCommands.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMenuCommands.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMenuDefs.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMenuDefs.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMission.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfMission.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPC.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPC.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPCHeli.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPCHeli.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPCOcelot.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfNPCOcelot.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfParasite.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfParasite.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfProcessExt.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfProcessExt.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfPuppy.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfPuppy.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuest.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuest.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuickMenuCommands.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuickMenuCommands.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuickMenuDefs.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfQuickMenuDefs.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfResources.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfResources.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfSoldier.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfSoldier.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfSoldierParams.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfSoldierParams.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfUserMarker.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfUserMarker.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfVehicle.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfVehicle.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfWalkerGear.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfWalkerGear.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfWarp.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\InfWarp.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\Ivars.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\Ivars.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IvarsPersist.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\IvarsPersist.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\script_loader.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\modules\script_loader.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\All_Options_Example.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\All_Options_Example.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Max.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Max.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Min.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Min.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Wide.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\CustomPrep_Wide.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Fulton_Heaven.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Fulton_Heaven.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\MotherBase_Heaven.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\MotherBase_Heaven.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Revenge_Heaven.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Revenge_Heaven.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Bounder.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Bounder.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Game.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Game.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Pure.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\profiles\Subsistence_Pure.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30100.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30100.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30101.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30101.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30102.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30102.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30155.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\quests\ih_quest_q30155.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (10).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (10).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (11).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (11).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (12).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (12).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (13).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (13).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (14).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (14).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (15).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (15).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (16).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (16).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (17).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (17).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (18).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (18).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (19).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (19).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (2).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (2).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (20).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (20).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (21).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (21).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (22).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (22).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (23).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (23).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (24).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (24).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (25).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (25).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (26).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (26).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (27).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (27).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (28).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (28).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (29).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (29).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (3).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (3).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (30).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (30).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (4).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (4).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (5).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (5).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (6).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (6).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (7).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (7).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (8).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (8).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (9).lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy (9).lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save - Copy.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save.lua - prisoner wildcard bug
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save.lua - prisoner wildcard bug.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save_prev - Copy.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save_prev - Copy.lua.meta
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save_prev.lua
D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\mod\saves\ih_save_prev.lua.meta
]]

  --local lines=InfUtil.Split(ih_filesText,"\r\n")
  local lines=InfUtil.Split(ih_filesText,"\n")
  InfCore.PrintInspect(lines,"ih lines")

  print"mockfox test shiz"

  --DEBUGNOW
  --tex TEST
  --InfCore.PrintInspect(EntityClassDictionary.GetCategoryList(),"GetCategoryList")
  --InfCore.PrintInspect(EntityClassDictionary.GetClassNameList("Locator"),"GetCategoryList('Locator')")
  --
  --InfCore.PrintInspect(File.GetFileListTable(),"GetFileListTable")
  --InfCore.PrintInspect(File.GetReferenceCount(),"GetReferenceCount")
  --
  --InfCore.PrintInspect(Fox.StrCode32('bleh'),'str32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('bleh'),'path32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('Tpp/start.lua'),'path32 /Tpp/start.lua')

  --DEBUGNOW



  print"Running AutoDoc"
  InfAutoDoc.AutoDoc()


  --afgh_travelPlans=DoFile'D:/Projects/MGS/!InfiniteHeaven/!modlua/FpkdCombinedLua/Assets/tpp/script/location/afgh/afgh_travelPlans.lua'

  --local cpLinkDefineTable=TppEnemy.MakeCpLinkDefineTable(afgh_travelPlans.lrrpNumberDefine,afgh_travelPlans.cpLinkMatrix)
  --InfCore.PrintInspect(cpLinkDefineTable)

  --  print(package.path)
  --
  --  print(os.date("%x %X"))
  --  print(os.time())





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

  -- GenerateLzs()

  --CullExeStrings()

  --

  --BitmapShit()

  --ExtensionShit()

  --MergeFiles()

  --Stringify()

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


  local langId="langId"
  local langId2="langId2"
  local param1=5
  local param2=6

  TppUiCommand.AnnounceLogViewJoinLangId(langId,langId2,param1,param2,0,0,true)


  print"main done"
end


local blah={
  '<?xml version="1.0" encoding="utf-8"?>\n',
  {
    {
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "unit_metre",
          Value = "m"
        }
      },
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "mb_title_gmp",
          Value = "GMP"
        }
      },
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "mb_title_time",
          Value = "TIME"
        }
      },
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "common_new",
          Value = "NEW"
        }
      },
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "tpp_gmp",
          Value = "GMP"
        }
      },
      {
        empty = 1,
        label = "Entry",
        xarg = {
          Color = "1",
          LangId = "tpp_loc_afghan",
          Value = "Northern Kabul, Afghanistan"
        }
      },
      label = "Entries"
    },
    label = "LangFile",
    xarg = {
      Endianess = "BigEndian",
      xsd = "http://www.w3.org/2001/XMLSchema",
      xsi = "http://www.w3.org/2001/XMLSchema-instance"
    }
  }
}


main()
