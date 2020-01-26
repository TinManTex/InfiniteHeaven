local this={}

this.ShuffleBag={
  currentItem=nil,
  currentPosition=-1,
  data={},
  New=function(self,o)
    o=o or {}
    o.currentItem=nil
    o.currentPosition=-1
    o.data={}

    setmetatable(o,self)
    self.__index=self
    return o
  end,
  Add=function(self,item,amount)
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
}

local function ShuffleBagTest()
  local chance=25

  local bagSize=100

  this.shuffleBag=this.ShuffleBag:New()

  for i=1,bagSize do
    local amount=1
    this.shuffleBag:Add(i,amount)
  end

  --  for k,v in ipairs(this.shuffleBag.data)do
  --    print(v)
  --  end
  --  print"--"

  math.randomseed(os.time())

  local rndMin=100
  local bagMin=100
  local rndMax=0
  local bagMax=0
  local loopCount=0
  local rndChanceHitTotal=0
  local bagChanceHitTotal=0

  local loopTestCount=1
  for n=1,loopTestCount do
    loopCount=loopCount+1
    local rndChanceHitCount=0
    local bagChanceHitCount=0


    --print("rnd")
    for i=1,bagSize do
      local rnd=math.random(100)
      --print(rnd)
      if rnd<chance then
        rndChanceHitCount=rndChanceHitCount+1
      end
    end
    --print("bag")
    for i=1,bagSize do
      local bag=this.shuffleBag:Next()
      print(bag)
      if bag<chance then
        bagChanceHitCount=bagChanceHitCount+1
      end
    end

    rndMin=math.min(rndMin,rndChanceHitCount)
    bagMin=math.min(bagMin,bagChanceHitCount)
    rndMax=math.max(rndMax,rndChanceHitCount)
    bagMax=math.max(bagMax,bagChanceHitCount)


    rndChanceHitTotal=rndChanceHitTotal+rndChanceHitCount
    bagChanceHitTotal=bagChanceHitTotal+bagChanceHitCount

    print("rndhitCount:"..rndChanceHitCount .. " rndMin:"..rndMin.." rndMax:"..rndMax.." rndAvg:"..rndChanceHitTotal/loopCount)
    print("baghitCount:"..bagChanceHitCount .. " bagMin:"..bagMin.." bagMax:"..bagMax.." bagAvg:"..bagChanceHitTotal/loopCount)
    --print()
    --    for i=1,bagSize do
    --      local bag=this.shuffleBag:Next()
    --      print(bag)
    --      if bag<chance then
    --        bagChanceHitCount=bagChanceHitCount+1
    --      end
    --    end

  end
end


local function ShuffleBagTest2()
  local chance=25

  local bagSize=100
  
  local itemInfo={
    {name="SUPPORT_ITEMS",prob=8},--nades mags and bait
    {name="HANDGUN",prob=1},
    {name="DRUGS",prob=1},
    --{name="SUPPORT_HELI",prob=1},--not if support disabled
  }

  this.shuffleBag=this.ShuffleBag:New()

  for i=1,bagSize do
    local amount=1
    this.shuffleBag:Add(i,amount)
  end

  --  for k,v in ipairs(this.shuffleBag.data)do
  --    print(v)
  --  end
  --  print"--"

  math.randomseed(os.time())

  local rndMin=100
  local bagMin=100
  local rndMax=0
  local bagMax=0
  local loopCount=0
  local rndChanceHitTotal=0
  local bagChanceHitTotal=0

  local loopTestCount=1
  for n=1,loopTestCount do
    loopCount=loopCount+1
    local rndChanceHitCount=0
    local bagChanceHitCount=0


    --print("rnd")
    for i=1,bagSize do
      local rnd=math.random(100)
      --print(rnd)
      if rnd<chance then
        rndChanceHitCount=rndChanceHitCount+1
      end
    end
    --print("bag")
    for i=1,bagSize do
      local bag=this.shuffleBag:Next()
      print(bag)
      if bag<chance then
        bagChanceHitCount=bagChanceHitCount+1
      end
    end

    rndMin=math.min(rndMin,rndChanceHitCount)
    bagMin=math.min(bagMin,bagChanceHitCount)
    rndMax=math.max(rndMax,rndChanceHitCount)
    bagMax=math.max(bagMax,bagChanceHitCount)


    rndChanceHitTotal=rndChanceHitTotal+rndChanceHitCount
    bagChanceHitTotal=bagChanceHitTotal+bagChanceHitCount

    print("rndhitCount:"..rndChanceHitCount .. " rndMin:"..rndMin.." rndMax:"..rndMax.." rndAvg:"..rndChanceHitTotal/loopCount)
    print("baghitCount:"..bagChanceHitCount .. " bagMin:"..bagMin.." bagMax:"..bagMax.." bagAvg:"..bagChanceHitTotal/loopCount)
    --print()
    --    for i=1,bagSize do
    --      local bag=this.shuffleBag:Next()
    --      print(bag)
    --      if bag<chance then
    --        bagChanceHitCount=bagChanceHitCount+1
    --      end
    --    end

  end
end

---
function this.Choose(probs)
  local total=0
  for i,probInfo in ipairs(probs) do
    total=total+probInfo.prob
  end

  local randomIndex=math.random(total)
  --DEBUG print("randomIndex:"..randomIndex)
  for i=1,#probs do
    if randomIndex<probs[i].prob then
      return i
    else
      randomIndex=randomIndex-probs[i].prob
    end
  end
  return #probs
end

local function main()
  --print"test"

--  math.randomseed(os.time())
--  math.random()
--  math.random()
--  math.random()
--
--  local probs={
--    {prob=10,name="Item1"},
--    {prob=20,name="Item2"},
--    {prob=1,name="Item3"},
--  }
--  
--  local total=0
--  for i,probInfo in ipairs(probs) do
--    total=total+probInfo.prob
--  end
--  if total<100 then
--    local nonePercent=100-total
--    --probs[#probs+1]={prob=nonePercent,"NONE"}
--    --print("nonePercent:"..nonePercent)
--  end
--
--  --while true do
--    print(probs[this.Choose(probs)].name)
  --end
  ShuffleBagTest()
end
main()
