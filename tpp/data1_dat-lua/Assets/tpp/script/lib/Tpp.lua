local e={}
local i=Fox.StrCode32
local t=type
local L=GameObject.GetGameObjectId
local u=GameObject.GetTypeIndex
local B=TppGameObject.GAME_OBJECT_TYPE_PLAYER2
local M=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local U=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2
local E=TppGameObject.GAME_OBJECT_TYPE_HELI2
local O=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI
local D=TppGameObject.GAME_OBJECT_TYPE_HORSE2
local C=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local m=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2
local b=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2
local g=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2
local _=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR
local P=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local S=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local I=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2
local G=TppGameObject.GAME_OBJECT_TYPE_UAV
local A=TppGameObject.PHASE_ALERT
local p=GameObject.NULL_ID
local n=bit.bnot
local n,n,n=bit.band,bit.bor,bit.bxor
e.requires={
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
"/Assets/tpp/script/lib/TppMbFreeDemo.lua"
}
function e.IsTypeFunc(e)
  return t(e)=="function"end
local f=e.IsTypeFunc
function e.IsTypeTable(e)
  return t(e)=="table"end
local a=e.IsTypeTable
function e.IsTypeString(e)
  return t(e)=="string"end
local n=e.IsTypeString
function e.IsTypeNumber(e)
  return t(e)=="number"end
local n=e.IsTypeNumber
function e.Enum(e)
  if e==nil then
    return
  end
  if#e==0 then
    return e
  end
  for n=1,#e do
    e[e[n]]=n
  end
  return e
end
function e.IsMaster()do
  return true
end
end
function e.IsQARelease()
  return(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)
end
function e.SplitString(e,l)
  local t={}
  local n
  local e=e
  while true do
    n=string.find(e,l)
    if(n==nil)then
      table.insert(t,e)break
    else
      local l=string.sub(e,0,n-1)table.insert(t,l)e=string.sub(e,n+1)
    end
  end
  return t
end
function e.StrCode32Table(n)
  local l={}
  for n,r in pairs(n)do
    local n=n
    if t(n)=="string"then
      n=i(n)
    end
    if t(r)=="table"then
      l[n]=e.StrCode32Table(r)
    else
      l[n]=r
    end
  end
  return l
end
function e.ApendArray(e,n)
  for t,n in pairs(n)do
    e[#e+1]=n
  end
end
function e.MergeTable(t,e,n)
  local n=t
  for e,l in pairs(e)do
    if t[e]==nil then
      n[e]=l
    else
      n[e]=l
    end
  end
  return n
end
function e.BfsPairs(r)
  local i,t,l={r},1,1
  local function p(n,e)
    local n,e=e,nil
    while true do
      n,e=next(i[t],n)
      if a(e)then
        l=l+1
        i[l]=e
      end
      if n then
        return n,e
      else
        t=t+1
        if t>l then
          return
        end
      end
    end
  end
  return p,r,nil
end
e._DEBUG_svars={}
e._DEBUG_gvars={}
function e.MakeMessageExecTable(e)
  if e==nil then
    return
  end
  if next(e)==nil then
    return
  end
  local n={}
  local T=i"msg"local u=i"func"local c=i"sender"local h=i"option"for e,l in pairs(e)do
    n[e]=n[e]or{}
    for l,r in pairs(l)do
      local l,s,d,o=l,nil,nil,nil
      if f(r)then
        d=r
      elseif a(r)and f(r[u])then
        l=i(r[T])
        local n={}
        if(t(r[c])=="string")or(t(r[c])=="number")then
          n[1]=r[c]
        elseif a(r[c])then
          n=r[c]
        end
        s={}
        for l,n in pairs(n)do
          if t(n)=="string"then
            if e==i"GameObject"then
              s[l]=L(n)
              if msgSndr==p then
              end
            else
              s[l]=i(n)
            end
          elseif t(n)=="number"then
            s[l]=n
          end
        end
        d=r[u]o=r[h]
      end
      if d then
        n[e][l]=n[e][l]or{}
        if next(s)~=nil then
          for r,t in pairs(s)do
            n[e][l].sender=n[e][l].sender or{}n[e][l].senderOption=n[e][l].senderOption or{}
            if n[e][l].sender[t]then
            end
            n[e][l].sender[t]=d
            if o and a(o)then
              n[e][l].senderOption[t]=o
            end
          end
        else
          if n[e][l].func then
          end
          n[e][l].func=d
          if o and a(o)then
            n[e][l].option=o
          end
        end
      end
    end
  end
  return n
end
function e.DoMessage(n,r,t,o,a,p,i,l,s)
  if not n then
    return
  end
  local n=n[t]
  if not n then
    return
  end
  local n=n[o]
  if not n then
    return
  end
  local t=true
  e.DoMessageAct(n,r,a,p,i,l,s,t)
end
function e.DoMessageAct(n,r,e,l,i,a,t)
  if n.func then
    if r(n.option)then
      n.func(e,l,i,a)
    end
  end
  local t=n.sender
  if t and t[e]then
    if r(n.senderOption[e])then
      t[e](e,l,i,a)
    end
  end
end
function e.GetRotationY(e)
  if not e then
    return
  end
  if(t(e.Rotate)=="function")then
    local e=e:Rotate(Vector3(0,0,1))
    local e=foxmath.Atan2(e:GetX(),e:GetZ())
    return TppMath.RadianToDegree(e)
  end
end
function e.GetLocator(n,t)
  local n,t=e.GetLocatorByTransform(n,t)
  if n~=nil then
    return TppMath.Vector3toTable(n),e.GetRotationY(t)
  else
    return nil
  end
end
function e.GetLocatorByTransform(t,n)
  local e=e.GetDataWithIdentifier(t,n,"TransformData")
  if e==nil then
    return
  end
  local e=e.worldTransform
  return e.translation,e.rotQuat
end
function e.GetDataWithIdentifier(e,n,t)
  local e=DataIdentifier.GetDataWithIdentifier(e,n)
  if e==NULL then
    return
  end
  if(e:IsKindOf(t)==false)then
    return
  end
  return e
end
function e.GetDataBodyWithIdentifier(n,e,t)
  local e=DataIdentifier.GetDataBodyWithIdentifier(n,e)
  if(e.data==nil)then
    return
  end
  if(e.data:IsKindOf(t)==false)then
    return
  end
  return e
end
function e.SetGameStatus(n)
  if not a(n)then
    return
  end
  local l=n.enable
  local t=n.scriptName
  local e=n.target
  local n=n.except
  if l==nil then
    return
  end
  if e=="all"then
    e={}
    for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      e[n]=t
    end
    for t,n in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      e[t]=n
    end
  elseif a(e)then
    e=e
  else
    return
  end
  if a(n)then
    for t,n in pairs(n)do
      e[t]=n
    end
  end
  if l then
    for n,l in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      if e[n]then
        TppGameStatus.Reset(t,n)
      end
    end
    for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local t=e[n]
      local unsetUiSetting=mvars.ui_unsetUiSetting
      if a(unsetUiSetting)and unsetUiSetting[n]then
        TppUiStatusManager.UnsetStatus(n,unsetUiSetting[n])
      else
        if t then
          TppUiStatusManager.ClearStatus(n)
        end
      end
    end
  else
    for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local e=e[n]
      if e then
        TppUiStatusManager.SetStatus(n,e)
      else
        TppUiStatusManager.ClearStatus(n)
      end
    end
    for n,l in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local e=e[n]
      if e then
        TppGameStatus.Set(t,n)
      end
    end
  end
end
function e.GetAllDisableGameStatusTable()
  local e={}
  for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    e[n]=false
  end
  for n,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    e[n]=false
  end
  return e
end
function e.GetHelicopterStartExceptGameStatus()
  local e={}
  e.EquipPanel=false
  e.AnnounceLog=false
  e.HeadMarker=false
  e.WorldMarker=false
  return e
end
local function n(e,n)
  if e==nil then
    return
  end
  if e==p then
    return
  end
  local e=u(e)
  if e==n then
    return true
  else
    return false
  end
end
function e.IsPlayer(e)
  return n(e,B)
end
function e.IsLocalPlayer(e)
  if e==PlayerInfo.GetLocalPlayerIndex()then
    return true
  else
    return false
  end
end
function e.IsSoldier(e)
  return n(e,M)
end
function e.IsCommandPost(e)
  return n(e,U)
end
function e.IsHostage(e)
  if e==nil then
    return
  end
  if e==p then
    return
  end
  local e=u(e)
  return TppDefine.HOSTAGE_GM_TYPE[e]
end
function e.IsVolgin(e)
  return n(e,g)
end
function e.IsHelicopter(e)
  return n(e,E)
end
function e.IsEnemyHelicopter(e)
  return n(e,O)
end
function e.IsHorse(e)
  return n(e,D)
end
function e.IsVehicle(e)
  return n(e,C)
end
function e.IsPlayerWalkerGear(e)
  return n(e,m)
end
function e.IsEnemyWalkerGear(e)
  return n(e,b)
end
function e.IsFultonContainer(e)
  return n(e,TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER)
end
function e.IsFultonableGimmick(e)
  if e==nil then
    return
  end
  if e==p then
    return
  end
  local e=u(e)
  return TppDefine.FULTONABLE_GIMMICK_TYPE[e]
end
function e.GetBuddyTypeFromGameObjectId(e)
  if e==nil then
    return
  end
  if e==p then
    return
  end
  local e=u(e)
  return TppDefine.BUDDY_GM_TYPE_TO_BUDDY_TYPE[e]
end
function e.IsMarkerLocator(e)
  return n(e,_)
end
function e.IsAnimal(e)
  if e==nil then
    return
  end
  if e==p then
    return
  end
  local e=u(e)
  return TppDefine.ANIMAL_GAMEOBJECT_TYPE[e]
end
function e.IsBossQuiet(e)
  return n(e,P)
end
function e.IsParasiteSquad(e)
  return n(e,S)
end
function e.IsSecurityCamera(e)
  return n(e,I)
end
function e.IsGunCamera(n)
  if n==p then
    return false
  end
  local t={id="IsGunCamera"}
  local e=false
  e=GameObject.SendCommand(n,t)
  return e
end
function e.IsUAV(e)
  return n(e,G)
end
function e.IncrementPlayData(e)
  if gvars[e]==nil then
    return
  end
  if gvars[e]<TppDefine.MAX_32BIT_UINT then
    gvars[e]=gvars[e]+1
  end
end
function e.IsNotAlert()
  if vars.playerPhase<A then
    return true
  else
    return false
  end
end
function e.IsPlayerStatusNormal()
  local e=vars
  if e.playerLife>0 and e.playerStamina>0 then
    return true
  else
    return false
  end
end
function e.AreaToIndices(e)
  local l,t,n,r=e[1],e[2],e[3],e[4]
  local e={}
  for n=l,n do
    for t=t,r do
      table.insert(e,{n,t})
    end
  end
  return e
end
function e.CheckBlockArea(e,t,n)
  local l,e,r,i=e[1],e[2],e[3],e[4]
  if(((t>=l)and(t<=r))and(n>=e))and(n<=i)then
    return true
  end
  return false
end
function e.FillBlockArea(n,e,i,t,r,l)
  for e=e,t do
    n[e]=n[e]or{}
    for t=i,r do
      n[e][t]=l
    end
  end
end
function e.GetCurrentStageSmallBlockIndex()
  local e=2
  local n,t=StageBlock.GetCurrentMinimumSmallBlockIndex()
  return(n+e),(t+e)
end
function e.IsLoadedSmallBlock(n,t)
  local l=4
  local e,r=StageBlock.GetCurrentMinimumSmallBlockIndex()
  local i=e+l
  local l=e+l
  return((e<=n and i>=n)and r<=t)and l>=t
end
function e.IsLoadedLargeBlock(e)
  local n=i(e)
  local e=StageBlock.GetLoadedLargeBlocks(0)
  for t,e in pairs(e)do
    if e==n then
      return true
    end
  end
  return false
end
function e.GetLoadedLargeBlock()
  local e=StageBlock.GetLoadedLargeBlocks(0)
  for n,e in pairs(e)do
    return e
  end
  return nil
end
function e.GetChunkIndex(t,n)
  local e
  if n then
    e=Chunk.INDEX_MGO
  else
    e=TppDefine.LOCATION_CHUNK_INDEX_TABLE[t]
    if e==nil then
    end
    return e
  end
  return e
end
function e.StartWaitChunkInstallation(n)Chunk.PrefetchChunk(n)Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  e.ClearChunkInstallPopupUpdateTime()
end
local r=1
local n=0
function e.ShowChunkInstallingPopup(t,l)
  local e=Time.GetFrameTime()n=n-e
  if n>0 then
    return
  end
  n=n+r
  if n<0 then
    n=0
  end
  local n=Fox.GetPlatformName()
  local e=Chunk.GetChunkInstallationEta(t)
  if e and n=="PS4"then
    if e>86400 then
      e=86400
    end
    TppUiCommand.SetErrorPopupParam(e)
  end
  local e=Chunk.GetChunkInstallationRate(t)
  if e and n=="XboxOne"then
    TppUiCommand.SetErrorPopupParam(e*1e4,"None",2)
  end
  local e
  if l then
    e=Popup.TYPE_ONE_CANCEL_BUTTON
  else
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"end
  TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLING,e)
end
function e.ClearChunkInstallPopupUpdateTime()n=0
end
function e.GetFormatedStorageSizePopupParam(t)
  local n=1024
  local e=1024*n
  local l=1024*e
  local l,r,i=t/l,t/e,t/n
  local n=0
  local e=""
  if l>=1 then
    n=l*100
    e="G"
  elseif r>=1 then
    n=r*100
    e="M"
  elseif i>=1 then
    n=i*100
    e="K"
  else
    return t,"",0
  end
  local n=math.ceil(n)
  return n,e,2
end
function e.PatchDlcCheckCoroutine(t,l,r)
  local function e(e)
  end
  local function n()
    if TppUiCommand.IsShowPopup()then
      TppUiCommand.ErasePopup()
      while TppUiCommand.IsShowPopup()do
        e"waiting popup closed..."coroutine.yield()
      end
    end
  end
  local function i()
    while TppSave.IsSaving()do
      e"waiting saving end..."coroutine.yield()
    end
  end
  i()PatchDlc.StartCheckingPatchDlc()
  if PatchDlc.IsCheckingPatchDlc()then
    if not r then
      n()
      TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"TppUiCommand.ShowErrorPopup(5100)
    end
    while PatchDlc.IsCheckingPatchDlc()do
      e"waiting checking PatchDlc end..."coroutine.yield()
      TppUI.ShowAccessIconContinue()
    end
  end
  n()
  if PatchDlc.DoesExistPatchDlc()then
    if t then
      t()
    end
    return true
  else
    if l then
      l()
    end
    return false
  end
end
function e.ClearDidCancelPatchDlcDownloadRequest()
  if(vars.didCancelPatchDlcDownloadRequest==1)then
    vars.didCancelPatchDlcDownloadRequest=0
    vars.isPersonalDirty=1
    TppSave.CheckAndSavePersonalData()
  end
end
function e.DEBUG_DunmpBlockArea(t,l,n)
  local e="       "for n=1,n do
    e=e..string.format("%02d,",n)
  end
  for l=1,l do
    local e=""for n=1,n do
      e=e..string.format("%02d,",t[l][n])
    end
  end
end
function e.DEBUG_DumpTable(l,n)
  if n==nil then
  end
  if(t(l)~="table")then
    return
  end
  local r=""if n then
    for e=0,n do
      r=r.." "end
  end
  for r,l in pairs(l)do
    if t(l)=="table"then
      local n=n or 0
      n=n+1
      e.DEBUG_DumpTable(l,n)
    else
      if t(l)=="number"then
      end
    end
  end
end
function e.DEBUG_Where(e)
  local e=debug.getinfo(e+1)
  if e then
    return e.short_src..(":"..e.currentline)
  end
  return"(unknown)"
end
function e.DEBUG_StrCode32ToString(e)
  if e~=nil then
    local n
    if(TppDbgStr32)then
      n=TppDbgStr32.DEBUG_StrCode32ToString(e)
    end
    if n then
      return n
    else
      if t(e)=="string"then
      end
      return tostring(e)
    end
  else
    return"nil"
  end
end
function e.DEBUG_Fatal(e,e)
end
function e.DEBUG_SetPreference(n,t,l)
  local n=Preference.GetPreferenceEntity(n)
  if(n==nil)then
    return
  end
  if(n[t]==nil)then
    return
  end
  Command.SetProperty{entity=n,property=t,value=l}
end
e._requireList={}
do
  for t,n in ipairs(e.requires)do
    local n=e.SplitString(n,"/")
    local n=string.sub(n[#n],1,#n[#n]-4)
    local t={TppMain=true,TppDemoBlock=true,mafr_luxury_block_list=true}
    if not t[n]then
      e._requireList[#e._requireList+1]=n
    end
  end
end
return e
