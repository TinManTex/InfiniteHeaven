-- ExtensionOrder.lua

--tex it's evident from eyeballing gzstool fpk xml files that files in fpks are grouped by extension in some specific order.
--loading a fpkd with a different order may cause the game to crash (TODO: test with fpks)
--this script pulls together info from gzstool fpk xml files to attempt to reconstruct the order

local basePath=[[J:\GameData\MGS\!!masternew\]]
--local basePath=[[J:\GameData\mgo\chunk0_dat\]]

local dirsFileName="FilesMaster.txt"
--local dirsFileName="FilesMgo.txt"

local packExtenion="fpk"
--local packExtenion="fpkd"

dirsFileName=packExtenion..dirsFileName

local command=string.format([[dir /s /b %s*.%s.xml > %s]],basePath,packExtenion,dirsFileName)
print(command)
os.execute(command)
local xmlFileDirs={}

local dirsFile,error=io.open(dirsFileName,"r")
if dirsFile then
  while true do
    local line=dirsFile:read()
    if line==nil then break end
    table.insert(xmlFileDirs,line)
  end
  dirsFile:close()
end
--local ins=InfInspect.Inspect(xmlFileDirs)
--print(ins)

local extensionOrdersPerFpk={}-- is dictionary fpkFileName,list of extensions
local extensionsInFpk={}
local allExtensions={}

for i,xmlPath in ipairs(xmlFileDirs)do
  print(xmlPath)
  local xmlFile,error=io.open(xmlPath,"r")
  if xmlFile then
    local extensionsOrder={}
    local extensionsInList={}
    extensionOrdersPerFpk[xmlPath]=extensionsOrder
    extensionsInFpk[xmlPath]=extensionsInList
    while true do
      local line=xmlFile:read()
      if line==nil then break end
      --REF     <Entry FilePath="/Assets/tpp/level/location/mtbs/block_layout/mtbs_layout00500_nav.fox2" />
      local s1,e1=string.find(line,[[<Entry FilePath="]])
      if s1 then
        --        local s2,e2=string.find(line,"%.",e1+1)
        --        local s3,e3=string.find(line,[["]],e2+1)
        --        local extension=string.sub(line,e2+1,e3-1)


        local m1,m2 = line:match'(.*%.)(.*)'
        --print("m1:"..m1.."--m2:"..m2)
        local s2,e2=string.find(m2,[["]])
        local extension=string.sub(m2,1,s2-1)

        allExtensions[extension]=allExtensions[extension] or 1
        allExtensions[extension]=allExtensions[extension]+1
        if not extensionsInList[extension] then
          extensionsInList[extension]=true
          table.insert(extensionsOrder,extension)
          print(extension)
        end
      end
    end
    xmlFile:close()
  end
end
--local ins=InfInspect.Inspect(extensionOrdersPerFpk)
--print(ins)
--tex weirdness, what's up with the period in the entry?
--J:\GameData\MGS\!!masternew\chunk3_dat\Assets\tpp\pack\mission2\free\f30150\f30150.fpkd.xml
--<Entry FilePath="/Assets/tpp/effect/vfx_data/blood./fx_tpp_splbrdwng01_s1.vfx" />
--for xmlFilePath,extensionsOrder in pairs(extensionOrdersPerFpk)do
--  for i,extension in ipairs(extensionsOrder)do
--    if (string.len(extension)>5) then
--      print(xmlFilePath.." : "..extension)
--    end
--  end
--end

local condensedLists={}
for xmlFilePath,extensionsOrder in pairs(extensionOrdersPerFpk)do
  if #extensionsOrder>1 then
    local noMatch=true
    for listNum,listExtsOrder in ipairs(condensedLists)do
      if #listExtsOrder==#extensionsOrder then
        local listMatch=true
        for i=1,#listExtsOrder do
          if listExtsOrder[i]~=extensionsOrder[i] then
            listMatch=false
            break
          end
        end
        if listMatch then
          noMatch=false
          break
        end
      end
    end
    if noMatch then
      table.insert(condensedLists,extensionsOrder)
    end
  end
end

local SortFunc=function(a,b)
  if #a<#b then
    return true
  end
  return false
end
table.sort(condensedLists,SortFunc)
--local ins=InfInspect.Inspect(condensedLists)
--print(ins)
for listNum,extensionsOrder in ipairs(condensedLists)do
  local ins=InfInspect.Inspect(extensionsOrder)
  print(listNum..":\t"..#extensionsOrder..":\t"..ins)
end

local numExts=0
for ext,bool in pairs(allExtensions)do
  numExts=numExts+1
end

print("numExts="..numExts)
local ins=InfInspect.Inspect(allExtensions)
print(ins)


--tex all positions reletively solid except for "bnd", analysis from my ExtensionOrder.lua puts it somewhere between veh and tgt. 
--have put it between des and tgt in line with init.lua RegisterPackageExtensionInfo call
-- RegisterPackageExtensionInfo call seems to mostly match my derived order in reverse - however clo doesnt fit the order and lng isn't in its table.
local fpkdExtensionsOrder={ "fox2", "evf", "parts", "vfxlb", "vfx", "vfxlf", "veh", "frld", "des", "bnd", "tgt", "phsd", "ph", "sim", "clo", "fsd", "sdf", "lua", "lng" }


print("ExtensionOrder done")
