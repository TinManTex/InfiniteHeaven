-- DOBUILD: 0 
local this={}
local StrCode32=Fox.StrCode32
local type=type
local I=GameObject.GetGameObjectId
local d=GameObject.GetTypeIndex
local S=TppGameObject.GAME_OBJECT_TYPE_PLAYER2
local b=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local m=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2
local G=TppGameObject.GAME_OBJECT_TYPE_HELI2
local h=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI
local A=TppGameObject.GAME_OBJECT_TYPE_HORSE2
local E=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local P=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2
local C=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2
local O=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2
local D=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR
local B=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local GAME_OBJECT_TYPE_SECURITYCAMERA2=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2
local GAME_OBJECT_TYPE_UAV=TppGameObject.GAME_OBJECT_TYPE_UAV
local PHASE_ALERT=TppGameObject.PHASE_ALERT
local zz=GameObject.NULL_ID
local n=bit.bnot
local band,n,n=bit.band,bit.bor,bit.bxor
this.requires={
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
function this.IsTypeFunc(e)
  return type(e)=="function"
end
local T=this.IsTypeFunc
function this.IsTypeTable(e)
  return type(e)=="table"
end
local a=this.IsTypeTable
function this.IsTypeString(e)
  return type(e)=="string"
end
local n=this.IsTypeString
function this.IsTypeNumber(e)
  return type(e)=="number"
end
local n=this.IsTypeNumber
function this.Enum(e)
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
function this.IsMaster()do
  return true
end
end
function this.IsQARelease()
  return(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)
end
function this.SplitString(e,l)
  local t={}
  local n
  local e=e
  while true do
    n=string.find(e,l)
    if(n==nil)then
      table.insert(t,e)break
    else
      local l=string.sub(e,0,n-1)
      table.insert(t,l)
      e=string.sub(e,n+1)
    end
  end
  return t
end
function this.StrCode32Table(n)
  local r={}
  for n,l in pairs(n)do
    local n=n
    if type(n)=="string"then
      n=StrCode32(n)
    end
    if type(l)=="table"then
      r[n]=this.StrCode32Table(l)
    else
      r[n]=l
    end
  end
  return r
end
function this.ApendArray(e,n)
  for t,n in pairs(n)do
    e[#e+1]=n
  end
end
function this.MergeTable(t,e,n)
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
function this.BfsPairs(r)
  local i,n,t={r},1,1
  local function o(l,e)
    local l,e=e,nil
    while true do
      l,e=next(i[n],l)
      if a(e)then
        t=t+1
        i[t]=e
      end
      if l then
        return l,e
      else
        n=n+1
        if n>t then
          return
        end
      end
    end
  end
  return o,r,nil
end
this._DEBUG_svars={}
this._DEBUG_gvars={}
function this.MakeMessageExecTable(n)
  if n==nil then
    return
  end
  if next(n)==nil then
    return
  end
  local e={}
  local f=StrCode32"msg"local d=StrCode32"func"local u=StrCode32"sender"local _=StrCode32"option"for n,l in pairs(n)do
    e[n]=e[n]or{}
    for l,r in pairs(l)do
      local l,s,c,o=l,nil,nil,nil
      if T(r)then
        c=r
      elseif a(r)and T(r[d])then
        l=StrCode32(r[f])
        local e={}
        if(type(r[u])=="string")or(type(r[u])=="number")then
          e[1]=r[u]
        elseif a(r[u])then
          e=r[u]
        end
        s={}
        for l,e in pairs(e)do
          if type(e)=="string"then
            if n==StrCode32"GameObject"then
              s[l]=I(e)
              if msgSndr==zz then
              end
            else
              s[l]=StrCode32(e)
            end
          elseif type(e)=="number"then
            s[l]=e
          end
        end
        c=r[d]o=r[_]
      end
      if c then
        e[n][l]=e[n][l]or{}
        if next(s)~=nil then
          for r,t in pairs(s)do
            e[n][l].sender=e[n][l].sender or{}e[n][l].senderOption=e[n][l].senderOption or{}
            if e[n][l].sender[t]then
            end
            e[n][l].sender[t]=c
            if o and a(o)then
              e[n][l].senderOption[t]=o
            end
          end
        else
          if e[n][l].func then
          end
          e[n][l].func=c
          if o and a(o)then
            e[n][l].option=o
          end
        end
      end
    end
  end
  return e
end
function this.DoMessage(n,t,r,l,s,p,a,o,i)
  if not n then
    return
  end
  local n=n[r]
  if not n then
    return
  end
  local n=n[l]
  if not n then
    return
  end
  local l=true
  this.DoMessageAct(n,t,s,p,a,o,i,l)
end
function this.DoMessageAct(n,r,e,l,a,i,t)
  if n.func then
    if r(n.option)then
      n.func(e,l,a,i)
    end
  end
  local t=n.sender
  if t and t[e]then
    if r(n.senderOption[e])then
      t[e](e,l,a,i)
    end
  end
end
function this.GetRotationY(e)
  if not e then
    return
  end
  if(type(e.Rotate)=="function")then
    local e=e:Rotate(Vector3(0,0,1))
    local e=foxmath.Atan2(e:GetX(),e:GetZ())
    return TppMath.RadianToDegree(e)
  end
end
function this.GetLocator(n,t)
  local n,t=this.GetLocatorByTransform(n,t)
  if n~=nil then
    return TppMath.Vector3toTable(n),this.GetRotationY(t)
  else
    return nil
  end
end
function this.GetLocatorByTransform(n,t)
  local e=this.GetDataWithIdentifier(n,t,"TransformData")
  if e==nil then
    return
  end
  local e=e.worldTransform
  return e.translation,e.rotQuat
end
function this.GetDataWithIdentifier(t,e,n)
  local e=DataIdentifier.GetDataWithIdentifier(t,e)
  if e==NULL then
    return
  end
  if(e:IsKindOf(n)==false)then
    return
  end
  return e
end
function this.GetDataBodyWithIdentifier(e,n,t)
  local e=DataIdentifier.GetDataBodyWithIdentifier(e,n)
  if(e.data==nil)then
    return
  end
  if(e.data:IsKindOf(t)==false)then
    return
  end
  return e
end
function this.SetGameStatus(n)
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
      local e=mvars.ui_unsetUiSetting
      if a(e)and e[n]then
        TppUiStatusManager.UnsetStatus(n,e[n])
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
function this.GetAllDisableGameStatusTable()
  local e={}
  for n,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    e[n]=false
  end
  for n,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    e[n]=false
  end
  return e
end
function this.GetHelicopterStartExceptGameStatus()
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
  if e==zz then
    return
  end
  local e=d(e)
  if e==n then
    return true
  else
    return false
  end
end
function this.IsPlayer(e)
  return n(e,S)
end
function this.IsLocalPlayer(e)
  if e==PlayerInfo.GetLocalPlayerIndex()then
    return true
  else
    return false
  end
end
function this.IsSoldier(e)
  return n(e,b)
end
function this.IsCommandPost(e)
  return n(e,m)
end
function this.IsHostage(e)
  if e==nil then
    return
  end
  if e==zz then
    return
  end
  local e=d(e)
  return TppDefine.HOSTAGE_GM_TYPE[e]
end
function this.IsVolgin(e)
  return n(e,O)
end
function this.IsHelicopter(e)
  return n(e,G)
end
function this.IsEnemyHelicopter(e)
  return n(e,h)
end
function this.IsHorse(e)
  return n(e,A)
end
function this.IsVehicle(e)
  return n(e,E)
end
function this.IsPlayerWalkerGear(e)
  return n(e,P)
end
function this.IsEnemyWalkerGear(e)
  return n(e,C)
end
function this.IsUav(e)
  return n(e,GAME_OBJECT_TYPE_UAV)
end
function this.IsFultonContainer(e)
  return n(e,TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER)
end
function this.IsMortar(e)
  return n(e,TppGameObject.GAME_OBJECT_TYPE_MORTAR)
end
function this.IsGatlingGun(e)
  return n(e,TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN)
end
function this.IsMachineGun(e)
  return n(e,TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN)
end
function this.IsFultonableGimmick(e)
  if e==nil then
    return
  end
  if e==zz then
    return
  end
  local e=d(e)
  return TppDefine.FULTONABLE_GIMMICK_TYPE[e]
end
function this.GetBuddyTypeFromGameObjectId(e)
  if e==nil then
    return
  end
  if e==zz then
    return
  end
  local e=d(e)
  return TppDefine.BUDDY_GM_TYPE_TO_BUDDY_TYPE[e]
end
function this.IsMarkerLocator(e)
  return n(e,D)
end
function this.IsAnimal(e)
  if e==nil then
    return
  end
  if e==zz then
    return
  end
  local e=d(e)
  return TppDefine.ANIMAL_GAMEOBJECT_TYPE[e]
end
function this.IsBossQuiet(e)
  return n(e,B)
end
function this.IsParasiteSquad(e)
  return n(e,GAME_OBJECT_TYPE_PARASITE2)
end
function this.IsSecurityCamera(e)
  return n(e,GAME_OBJECT_TYPE_SECURITYCAMERA2)
end
function this.IsGunCamera(e)
  if e==zz then
    return false
  end
  local t={id="IsGunCamera"}
  local n=false
  n=GameObject.SendCommand(e,t)
  return n
end
function this.IsUAV(e)
  return n(e,GAME_OBJECT_TYPE_UAV)
end
function this.IncrementPlayData(e)
  if gvars[e]==nil then
    return
  end
  if gvars[e]<TppDefine.MAX_32BIT_UINT then
    gvars[e]=gvars[e]+1
  end
end
function this.IsNotAlert()
  if vars.playerPhase<PHASE_ALERT then
    return true
  else
    return false
  end
end
function this.IsPlayerStatusNormal()
  local e=vars
  if e.playerLife>0 and e.playerStamina>0 then
    return true
  else
    return false
  end
end
function this.AreaToIndices(e)
  local r,l,n,t=e[1],e[2],e[3],e[4]
  local e={}
  for n=r,n do
    for t=l,t do
      table.insert(e,{n,t})
    end
  end
  return e
end
function this.CheckBlockArea(e,t,n)
  local l,e,i,r=e[1],e[2],e[3],e[4]
  if(((t>=l)and(t<=i))and(n>=e))and(n<=r)then
    return true
  end
  return false
end
function this.FillBlockArea(e,n,l,r,t,i)
  for n=n,r do
    e[n]=e[n]or{}
    for t=l,t do
      e[n][t]=i
    end
  end
end
function this.GetCurrentStageSmallBlockIndex()
  local e=2
  local t,n=StageBlock.GetCurrentMinimumSmallBlockIndex()
  return(t+e),(n+e)
end
function this.IsLoadedSmallBlock(n,l)
  local t=4
  local e,r=StageBlock.GetCurrentMinimumSmallBlockIndex()
  local i=e+t
  local t=e+t
  return((e<=n and i>=n)and r<=l)and t>=l
end
function this.IsLoadedLargeBlock(e)
  local e=StrCode32(e)
  local n=StageBlock.GetLoadedLargeBlocks(0)
  for t,n in pairs(n)do
    if n==e then
      return true
    end
  end
  return false
end
function this.GetLoadedLargeBlock()
  local e=StageBlock.GetLoadedLargeBlocks(0)
  for n,e in pairs(e)do
    return e
  end
  return nil
end
function this.GetChunkIndex(n,t)
  local e
  if t then
    e=Chunk.INDEX_MGO
  else
    e=TppDefine.LOCATION_CHUNK_INDEX_TABLE[n]
    if e==nil then
    end
    return e
  end
  return e
end
function this.StartWaitChunkInstallation(n)Chunk.PrefetchChunk(n)Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  this.ClearChunkInstallPopupUpdateTime()
end
local r=1
local n=0
function this.ShowChunkInstallingPopup(t,l)
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
function this.ClearChunkInstallPopupUpdateTime()n=0
end
function this.GetFormatedStorageSizePopupParam(t)
  local n=1024
  local e=1024*n
  local l=1024*e
  local i,r,l=t/l,t/e,t/n
  local n=0
  local e=""if i>=1 then
    n=i*100
    e="G"elseif r>=1 then
    n=r*100
    e="M"elseif l>=1 then
    n=l*100
    e="K"else
    return t,"",0
  end
  local n=math.ceil(n)
  return n,e,2
end
function this.PatchDlcCheckCoroutine(t,l,i,e)
  if e==nil then
    e=PatchDlc.PATCH_DLC_TYPE_MGO_DATA
  end
  local n={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=true,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=true}
  if not n[e]then
    Fox.Hungup"Invalid dlc type."return false
  end
  local function n(e)
  end
  local function r()
    if TppUiCommand.IsShowPopup()then
      TppUiCommand.ErasePopup()
      while TppUiCommand.IsShowPopup()do
        n"waiting popup closed..."coroutine.yield()
      end
    end
  end
  local function a()
    while TppSave.IsSaving()do
      n"waiting saving end..."coroutine.yield()
    end
  end
  a()PatchDlc.StartCheckingPatchDlc(e)
  if PatchDlc.IsCheckingPatchDlc()then
    if not i then
      r()
      local n={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=5100,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=5150}
      local e=n[e]
      TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"TppUiCommand.ShowErrorPopup(e)
    end
    while PatchDlc.IsCheckingPatchDlc()do
      n"waiting checking PatchDlc end..."coroutine.yield()
      TppUI.ShowAccessIconContinue()
    end
  end
  r()
  if PatchDlc.DoesExistPatchDlc(e)then
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
function this.IsPatchDlcValidPlatform(n)
  local e={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]={PS3=true,PS4=true},[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]={Xbox360=true,PS3=true,PS4=true}}
  local e=e[n]
  if not e then
    Fox.Hungup"Invalid dlc type."return false
  end
  local n=Fox.GetPlatformName()
  if e[n]then
    return true
  else
    return false
  end
end
function this.ClearDidCancelPatchDlcDownloadRequest()
  if(vars.didCancelPatchDlcDownloadRequest==1)then
    vars.didCancelPatchDlcDownloadRequest=0
    vars.isPersonalDirty=1
    TppSave.CheckAndSavePersonalData()
  end
end
function this.DEBUG_DunmpBlockArea(l,t,e)
  local n="       "for e=1,e do
    n=n..string.format("%02d,",e)
  end
  for t=1,t do
    local n=""for e=1,e do
      n=n..string.format("%02d,",l[t][e])
    end
  end
end
function this.DEBUG_DumpTable(r,n)
  if n==nil then
  end
  if(type(r)~="table")then
    return
  end
  local l=""if n then
    for e=0,n do
      l=l.." "end
  end
  for r,l in pairs(r)do
    if type(l)=="table"then
      local n=n or 0
      n=n+1
      this.DEBUG_DumpTable(l,n)
    else
      if type(l)=="number"then
      end
    end
  end
end
function this.DEBUG_Where(e)
  local e=debug.getinfo(e+1)
  if e then
    return e.short_src..(":"..e.currentline)
  end
  return"(unknown)"end
function this.DEBUG_StrCode32ToString(e)
  if e~=nil then
    local n
    if(TppDbgStr32)then
      n=TppDbgStr32.DEBUG_StrCode32ToString(e)
    end
    if n then
      return n
    else
      if type(e)=="string"then
      end
      return tostring(e)
    end
  else
    return"nil"end
end
function this.DEBUG_Fatal(e,e)
end
function this.DEBUG_SetPreference(n,t,l)
  local n=Preference.GetPreferenceEntity(n)
  if(n==nil)then
    return
  end
  if(n[t]==nil)then
    return
  end
  Command.SetProperty{entity=n,property=t,value=l}
end
this._requireList={}do
  for t,n in ipairs(this.requires)do
    local n=this.SplitString(n,"/")
    local n=string.sub(n[#n],1,#n[#n]-4)
    local t={TppMain=true,TppDemoBlock=true,mafr_luxury_block_list=true}
    if not t[n]then
      this._requireList[#this._requireList+1]=n
    end
  end
end
return this
