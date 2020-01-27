-- InfBuddy.lua
local this={}

--STATE
this.buddyPosition=nil--tex used by CycleBuddyReturn()
this.buddyType=BuddyType.NONE

local quietWeapons={
  {varType=0,name="Wicked Butterfly",           equipDevelopID=6090},-- RENOV-ICKX - Grade 2
  {varType=1,name="Wicked Butterfly suppressed",equipDevelopID=6091},-- RENOV-ICKX - Grade 4 With supressor
  {varType=2,name="Guilty Butterfly",           equipDevelopID=6092},-- RENOV-ICKX Tranq - Grade 3
  {varType=3,name="Guilty Butterfly suppressed",equipDevelopID=6093},-- RENOV-ICKX Tranq - Grade 5
  {varType=4,name="Sinful Butterfly",           equipDevelopID=6094},-- BRENNAN LRS 46 - Grade 4
}

local dogTypes={
  {varType=0,name="Naked",          equipDevelopID=24001},
  {varType=2,name="Sneaking Stun",  equipDevelopID=24003},
  {varType=4,name="Sneaking Knife", equipDevelopID=24002},
  {varType=3,name="Battle Dress",   equipDevelopID=24004},
  {varType=1,name="Fulton",         equipDevelopID=24005},
}
local horseTypes={
  {varType=0,name="Normal",               equipDevelopID=25001},
  {varType=2,name="Battle Dress Grade 2", equipDevelopID=25002},
  {varType=3,name="Battle Dress Grade 3", equipDevelopID=25003},
  {varType=4,name="Battle Dress Grade 4", equipDevelopID=25004},
--  {varType=1,name="Furicorn",equipDevelopID=25005},
--  {varType=5,name="Parade Tack",equipDevelopID=25007},--DLC
--  {varType=6,name="Western Tack",equipDevelopID=25006},--DLC
}

local walkerMainWeaponTypes={
  --{varType=0,name="NONE",},
  {varType=1,name="Gatling-Gun",},
  {varType=2,name="ATGM",},
  {varType=3,name="H-Discharger",},
  {varType=4,name="Flamethrower",},
  {varType=5,name="F-Balista",},
}

this.quietChangeWeaponVar={
  buddyType=BuddyType.QUIET,
  objectType="TppBuddyQuiet2",
  varName="buddyQuietEquipType",
  varTypeTable=quietWeapons,
  nameLangId="buddy_quiet",
}
this.dogChangeEquipVar={
  buddyType=BuddyType.DOG,
  objectType="TppBuddyDog2",
  varName="buddyDogEquipType",
  varTypeTable=dogTypes,
  nameLangId="buddy_dog",
}
this.horseChangeTypeVar={
  buddyType=BuddyType.HORSE,
  objectType="TppHorse2",
  varName="buddyHorseType",
  varTypeTable=horseTypes,
  nameLangId="buddy_horse",
}
this.walkerGearChangeMainWeaponVar={
  buddyType=BuddyType.WALKER_GEAR,
  objectType="TppWalkerGear2",
  varName="buddyGearMainWPType",
  varTypeTable=walkerMainWeaponTypes,
  nameLangId="buddy_walkergear",
}

function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.Messages()
  return Tpp.StrCode32Table{
    Timer={
      {msg="Finish",sender="Timer_CycleBuddyReturn",func=this.CycleBuddyReturn},
    },
  }
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.GetTableIndexForBuddyVar(var,varTypeTable)
  for i,info in ipairs(varTypeTable) do
    if info.varType==var then
      return i
    end
  end
end

function this.ChangeBuddyVar(commandInfo,setting)
  if vars.buddyType~=commandInfo.buddyType then
    InfMenu.Print(InfMenu.LangString"current_buddy_not"..InfMenu.LangString(commandInfo.nameLangId))
    return
  end

  local varInfo=commandInfo.varTypeTable[setting]

  if vars[commandInfo.varName]==varInfo.varType then
    InfMenu.Print(varInfo.name..InfMenu.LangString"allready_set")
    return
  end

  if Ivars.allowUndevelopedDDEquip:Is(0) then
    local equipDevelopID=varInfo.equipDevelopID
    if equipDevelopID and not TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=equipDevelopID} then
      InfMenu.Print(varInfo.name..InfMenu.LangString"not_developed")
      return
    end
  end

  InfMenu.Print(InfMenu.LangString(commandInfo.nameLangId)..": "..InfMenu.LangString"changing_to"..varInfo.name)

  local buddyGameId=GameObject.GetGameObjectIdByIndex(commandInfo.objectType,0)
  this.buddyPosition=GameObject.SendCommand(buddyGameId,{id="GetPosition"})
  if this.buddyPosition==nil then
    this.buddyPosition=Vector3(vars.playerPosX,vars.playerPosY+0.1,vars.playerPosZ)
  end
  this.buddyType=commandInfo.buddyType

  TppBuddy2BlockController.CallBuddy(BuddyType.NONE,Vector3(0,0,0),0)

  vars[commandInfo.varName]=varInfo.varType
  
  --tex can't change buddy vars on the same frame, so set and have them return
  GkEventTimerManager.Start("Timer_CycleBuddyReturn",0.3)
end
--tex on Timer_CycleBuddyReturn finish
function this.CycleBuddyReturn()
  --InfCore.DebugPrint"CycleBuddyReturn"--DEBUG
  if not this.buddyPosition then
    InfCore.DebugPrint"WARNING: CycleBuddyReturn could not find saved buddyPosition"
  else
    TppBuddy2BlockController.CallBuddy(this.buddyType,this.buddyPosition,vars.playerRotY)
    this.buddyPosition=nil
    this.buddyType=BuddyType.NONE
  end
end

return this
