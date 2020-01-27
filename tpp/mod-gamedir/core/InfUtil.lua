-- DOBUILD: 1
-- InfUtil.lua
-- utility function dumping ground
-- should not have any dependancies to Tpp, put that in InfTppUtil
local this={}

function this.ClearTable(_table)
  for k,v in pairs(_table)do
    _table[k]=nil
  end
end
function this.ClearArray(_table)
  for i=0, #_table do
    _table[i]=nil
  end
end

function this.MergeArray(array1,array2)
  for i=0,#array2 do
    array1[#array1+1]=array2[i]
  end 
end

function this.IsTableEmpty(checkTable)--tex TODO: shove in a utility module
  local next=next
  if next(checkTable)==nil then
    return true
  end
  return false
end

--tex removes fillCount number of items from sourceList and adds to fillList
function this.FillList(fillCount,sourceList,fillList)
  local addedItems={}
  while fillCount>0 and #sourceList>0 do
    local item=sourceList[#sourceList]
    if item then
      sourceList[#sourceList]=nil--pop
      fillList[#fillList+1]=item
      addedItems[#addedItems+1]=item
      fillCount=fillCount-1
    end
  end
  return addedItems
end

function this.CopyList(sourceList)
  if #sourceList==0 then
    return
  end

  local newList={}
  for i=1,#sourceList do
    newList[i]=sourceList[i]
  end
  return newList
end

function this.GetRandomPool(pool)
  --DEBUGNOW
  --  if pool==nil or #pool==0 then
  --    return
  --  end
  local rndIndex=math.random(#pool)
  local name=pool[rndIndex]
  table.remove(pool,rndIndex)
  return name
end

function this.GetRandomInList(list)
  return list[math.random(#list)]
end

function this.FindInList(list,findValue)
  for i,value in ipairs(list)do
    if value==findValue then
      return true
    end
  end
  return false
end

--tex object for returning a random item with no repeats till it's returned all items
this.ShuffleBag={
  currentItem=nil,
  currentPosition=-1,
  data={},
  New=function(self,table)
    local newBag={}
    newBag.currentItem=nil
    newBag.currentPosition=-1
    newBag.data={}

    setmetatable(newBag,self)
    self.__index=self

    if table then
      newBag:Fill(table)
    end

    return newBag
  end,
  Fill=function(self,table,amount)
    local tableTypeStr="table"
    for i=1,#table do
      local item=table[i]
      if type(item)==tableTypeStr then
        self:Add(item[1],item[2])
      else
        self:Add(item,amount)
      end
    end
  end,
  Add=function(self,item,amount)
    local amount=amount or 1
    for i=1,amount do
      self.data[#self.data+1]=item

      self.currentPosition=#self.data
    end
  end,
  Next=function(self)
    --run out, start again
    if self.currentPosition<2 then
      self.currentPosition=#self.data
      self.currentItem=self.data[1]
      return self.currentItem
    end
    --picks between start of array and currentposition, which decreases from end of array
    local pos=math.random(self.currentPosition)

    self.currentItem=self.data[pos]
    self.data[pos]=self.data[self.currentPosition]
    self.data[self.currentPosition]=self.currentItem
    self.currentPosition=self.currentPosition-1

    return self.currentItem
  end,
  Count=function(self)
    return #self.data
  end,
}

--string
--tex NMC from lua wiki
function this.Split(self,sep)
  local sep = sep or " "
  local fields = {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

--tex NMC from lua wiki
--MoonSharp doesn't like gmatch with long strings
function this.SplitAlt(str,delim,maxNb)
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


function this.FindLast(searchString,findString)
  --Set the third arg to false to allow pattern matching
  local found=searchString:reverse():find(findString:reverse(),nil,true)
  if found then
    return searchString:len()-findString:len()-found+2
  else
    return found
  end
end

--tex ex returns "cm_f0_h2_v000_eye1.fv2" from "/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h2_v000_eye1.fv2"
function this.GetFileName(path,stripExt)
  local lastPos=this.FindLast(path,"/")
  local fileName=string.sub(path,lastPos+1,#path)
  if stripExt then
    local lastPos=this.FindLast(fileName,[[.]])
    fileName=string.sub(fileName,1,lastPos-1)
  end
  return fileName
end

function this.GetFileExtension(path)
  local lastPos=this.FindLast(path,[[.]])
  if lastPos then
    return string.sub(path,lastPos,string.len(path))
  else
    return ""
  end
end

function this.StripExt(fileName)
  local lastPos=this.FindLast(fileName,[[.]])
  return string.sub(fileName,1,lastPos-1)
end

function this.EnumFrom0(nameTable)
  if nameTable==nil then
    return
  end
  if type(nameTable)~="table"then
    return
  end
  if#nameTable==0 then
    return
  end
  local enumTable={}
  for i=1,#nameTable do
    enumTable[nameTable[i]]=i-1--NMC: lua tables indexed from 1, enums indexed from 0
  end
  return enumTable
end

function this.EnumFrom1(nameTable)
  if nameTable==nil then
    return
  end
  if type(nameTable)~="table"then
    return
  end
  if#nameTable==0 then
    return
  end
  local enumTable={}
  for i=1,#nameTable do
    enumTable[nameTable[i]]=i
  end
  return enumTable
end

function this.GenerateNameList(fmt,num,list)
  local list=list or {}
  for i=0,num-1 do
    local name=string.format(fmt,i)
    table.insert(list,name)
  end
  return list
end

--TODO: shift to InfTppUtil?
--DEBUGNOW TODO: patch in TppLocation.GetLocationName to this.GetLocationName, change all references from this to TppLocation.GetLocationName
--tex is added to by InfMission for addon missions
this.locationIdForName={
  init=1,
  afgh=10,
  mafr=20,
  cypr=30,
  gntn=40,
  mtbs=50,
  mbqf=55,
  ombs=45,
  hlsp=60,
  flyk=70,
  sand_afgh=91,
  sand_mafr=92,
  sand_mtbs=95,
  --ssd
  ssd_afgh=15,
  ssd_ombs=47,--tex ssds TppLocation actually returns ombs for 47
  aftr=16,
  ssd_afgh2=17,
  sbri=18,
  spfc=19,
  ssav=25,
}

this.locationNames={}
for k,v in pairs(this.locationIdForName)do
  this.locationNames[v]=k
end

function this.GetLocationName()
  return this.locationNames[vars.locationCode]
end

return this
