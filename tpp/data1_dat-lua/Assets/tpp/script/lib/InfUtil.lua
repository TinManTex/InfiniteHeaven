-- DOBUILD: 1
-- InfUtil.lua
local this={}

local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex

function this.ClearTable(_table)
  for i=0, #_table do
    _table[i]=nil
  end
end

function this.IsTableEmpty(checkTable)--tex TODO: shove in a utility module
  local next=next
  if next(checkTable)==nil then
    return true
  end
  return false
end

--tex adds game object names to another table, with a not NULL_ID check
function this.ResetObjectPool(objectType,objectNames)
  local pool={}
  for i=1,#objectNames do
    local objectName=objectNames[i]
    local gameId=GetGameObjectId(objectType,objectName)
    if gameId==NULL_ID then
      InfCore.Log("ResetObjectPool: "..objectName.."==NULL_ID")--DEBUG
    else
      pool[#pool+1]=objectName
    end
  end
  return pool
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

--UTIL TODO shift all util functions somewhere
this.locationIdForName={
  afgh=10,
  mafr=20,
  cypr=30,
  mtbs=50,
  mbqf=55,
}

this.locationNames={
  [10]="afgh",
  [20]="mafr",
  [30]="cypr",
  [50]="mtbs",
  [55]="mbqf",
}
function this.GetLocationName()
  return this.locationNames[vars.locationCode]
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

--tex just from Tpp.IsGameObjectType, don't want to change it from local
function this.IsGameObjectType(gameObject,checkType)
  if gameObject==nil then
    return
  end
  if gameObject==NULL_ID then
    return
  end
  local typeIndex=GetTypeIndex(gameObject)
  if typeIndex==checkType then
    return true
  else
    return false
  end
end

--string
--tex NMC from lua wiki
function this.Split(str,delim,maxNb)
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
  if Mock then--KLUDGE
    if path==nil then return "nil_path" end
  end
  local lastPos=this.FindLast(path,"/")
  local fileName=string.sub(path,lastPos+1,#path)
  if stripExt then
    local lastPos=this.FindLast(fileName,[[.]])
    fileName=string.sub(fileName,1,lastPos-1)
  end
  return fileName
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

return this
