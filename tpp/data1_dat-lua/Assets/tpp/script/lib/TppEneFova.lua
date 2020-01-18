-- DOBUILD: 1
local this={}
local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT
local n=0
local defaultLang=1
local d=2
local c=3
local i=4
local p=5
local r=6
local defaultPartsAfghan="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts"
local defaultPartsAfrica="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts"
local defaultPartsAfghanFree="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
local defaultPartsAfricaFree="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts"
local dds5_main0_def_v00="/Assets/tpp/parts/chara/dds/dds5_main0_def_v00.parts"
local notRequiredArmorForMission={[10010]=1,[10020]=1,[10030]=1,[10054]=1,[11054]=1,[10070]=1,[10080]=1,[11080]=1,[10100]=1,[10110]=1,[10120]=1,[10130]=1,[11130]=1,[10140]=1,[11140]=1,[10150]=1,[10200]=1,[11200]=1,[10280]=1,[30010]=1,[30020]=1}
local missionArmorType={
  [10081]={TppDefine.AFR_ARMOR.TYPE_RC},
  [10082]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11082]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10085]={TppDefine.AFR_ARMOR.TYPE_RC},
  [11085]={TppDefine.AFR_ARMOR.TYPE_RC},
  [10086]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10090]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11090]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10091]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11091]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10093]={TppDefine.AFR_ARMOR.TYPE_ZRS},
  [10121]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11121]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10171]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11171]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10195]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11195]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10211]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11211]={TppDefine.AFR_ARMOR.TYPE_CFA}
}
local missionHostageInfos={
  [10020]={count=0},
  [10030]={count=0},
  [10033]={count=1,lang=d},
  [11033]={count=1,lang=d},
  [10036]={count=0},
  [11036]={count=0},
  [10040]={count=1,lang=i},
  [10041]={count=2,lang=d},
  [11041]={count=2,lang=d},
  [10043]={count=2,lang=i},
  [11043]={count=2,lang=i},
  [10044]={count=1,lang=d,overlap=true},
  [11044]={count=1,lang=d,overlap=true},
  [10045]={count=2,lang=d},
  [10050]={count=0},
  [11050]={count=0},
  [10052]={count=6,lang=r,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},
  [11052]={count=6,lang=r,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},
  [10054]={count=4,lang=defaultLang,overlap=true},
  [11054]={count=4,lang=defaultLang,overlap=true},
  [10070]={count=0},
  [10080]={count=0},
  [11080]={count=0},
  [10081]={count=0},
  [10082]={count=2,lang=p,overlap=true},
  [11082]={count=2,lang=p,overlap=true},
  [10085]={count=0},
  [11085]={count=0},
  [10086]={count=0},
  [10090]={count=0},
  [11090]={count=0},
  [10091]={count=1,lang=defaultLang,useHair=true,overlap=true},
  [11091]={count=1,lang=defaultLang,useHair=true,overlap=true},
  [10093]={count=0},
  [10100]={count=0},
  [10110]={count=0},
  [10115]={count=0},
  [11115]={count=0},
  [10120]={count=1,lang=defaultLang,overlap=true},
  [10121]={count=0},
  [11121]={count=0},
  [10130]={count=0},
  [11130]={count=0},
  [10140]={count=0},
  [11140]={count=0},
  [10145]={count=0},
  [10150]={count=0},
  [10151]={count=0},
  [11151]={count=0},
  [10171]={count=0},
  [11171]={count=0},
  [10156]={count=1,lang=d,overlap=true},
  [10195]={count=1,lang=p},
  [11195]={count=1,lang=p},
  [10200]={count=1,lang=p},
  [11200]={count=1,lang=p},
  [10240]={count=0},
  [10211]={count=4,lang=c,overlap=true},
  [11211]={count=4,lang=i,overlap=true},
  [10260]={count=0},
  [10280]={count=0}
}
this.S10030_FaceIdList={78,200,283,30,88,124,138,169,213,222,243,264,293,322,343}
this.S10030_useBalaclavaNum=3
this.S10240_FemaleFaceIdList={394,351,373,456,463,455,511,502}
this.S10240_MaleFaceIdList={195,144,214,6,217,83,273,60,87,71,256,201,290,178,102,255,293,165,85,18,228,12,65,134,31,132,161,342,107,274,184,226,153,247,344,242,56,183,54,126,223}
local fovaSetupFuncs={}--tex NMC: TODO: RENAME: index [mission] and [Area]
local function FovaFuncObject(DoShitRENAME)
  function DoShitRENAME:case(a,n)
    local fovaFunc=self[a]or self.default
    if fovaFunc then
      fovaFunc(a,n)
    end
  end
  return DoShitRENAME
end
function this.IsNotRequiredArmorSoldier(missionId)
  if notRequiredArmorForMission[missionId]~=nil then
    return true
  end
  return false
end
function this.CanUseArmorType(missionId,soldierSubType)
  local pfArmorTypes={PF_A=TppDefine.AFR_ARMOR.TYPE_CFA,PF_B=TppDefine.AFR_ARMOR.TYPE_ZRS,PF_C=TppDefine.AFR_ARMOR.TYPE_RC}
  local pfArmorType=pfArmorTypes[soldierSubType]
  if pfArmorType==nil then
    return true
  end
  local armorTypeTable=this.GetArmorTypeTable(missionId)
  for mission,armorType in ipairs(armorTypeTable)do
    if armorType==pfArmorType then
      return true
    end
  end
  return false
end
function this.GetHostageCountAtMissionId(missionCode)
  local default=0
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.count~=nil then
        return hostagesInfo.count
      else
        return default
      end
    else
      return default
    end
  end
  return default
end
function this.GetHostageLangAtMissionId(missionCode)
  local default=defaultLang
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.lang~=nil then
        return hostagesInfo.lang
      end
    end
  end
  return default
end
function this.GetHostageUseHairAtMissionId(missionInfo)
  local default=false
  if missionHostageInfos[missionInfo]~=nil then
    local hostagesInfo=missionHostageInfos[missionInfo]
    if hostagesInfo~=nil then
      if hostagesInfo.useHair~=nil then
        return hostagesInfo.useHair
      end
    end
  end
  return default
end
function this.GetHostageIsFaceModelOverlap(missionCode)
  local default=false
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.overlap~=nil then
        return hostagesInfo.overlap
      end
    end
  end
  return default
end
function this.GetHostageFaceModelCount(missionCode)
  local default=2
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.modelNum~=nil then
        return hostagesInfo.modelNum
      end
    end
  end
  return default
end
function this.GetHostageIgnoreFaceList(missionCode)
  local default={}
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.ignoreList~=nil then
        return hostagesInfo.ignoreList
      end
    end
  end
  return default
end
function this.GetArmorTypeTable(missionCode)
  if this.IsNotRequiredArmorSoldier(missionCode)then
    return{}
  end
  if not TppLocation.IsMiddleAfrica()then
    return{}
  end
  local default={TppDefine.AFR_ARMOR.TYPE_ZRS}
  if missionArmorType[missionCode]~=nil then
    local armorType=missionArmorType[missionCode]
    if armorType~=nil then
      return armorType
    end
  end
  return default
end
function this.SetHostageFaceTable(missionId)
  local hostageCount=this.GetHostageCountAtMissionId(missionId)
  local hostageLang=this.GetHostageLangAtMissionId(missionId)
  local f=0
  if hostageCount>0 then
    local n={}
    if hostageLang==defaultLang then
      table.insert(n,3)
      local e=bit.rshift(gvars.hosface_groupNumber,8)%100
      if e<40 then
        table.insert(n,0)
      end
    elseif hostageLang==d then
      table.insert(n,0)
    elseif hostageLang==p then
      table.insert(n,2)
      local e=bit.rshift(gvars.hosface_groupNumber,8)%100
      if e<10 then
        table.insert(n,0)
      end
    elseif hostageLang==r then
      table.insert(n,0)table.insert(n,1)f=1
    elseif hostageLang==i then
      table.insert(n,1)
    elseif hostageLang==c then
      table.insert(n,2)
    else
      if TppLocation.IsAfghan()then
        table.insert(n,0)
      elseif TppLocation.IsMiddleAfrica()then
        table.insert(n,2)
      elseif TppLocation.IsMotherBase()then
        table.insert(n,0)
      elseif TppLocation.IsMBQF()then
        table.insert(n,0)
      elseif TppLocation.IsCyprus()then
        table.insert(n,0)
      end
    end
    local hostageIsFaceModelOverlap=this.GetHostageIsFaceModelOverlap(missionId)
    local hostageIgnoreFaceList=this.GetHostageIgnoreFaceList(missionId)
    local hostageFaceModelCount=this.GetHostageFaceModelCount(missionId)
    local faceTable=TppSoldierFace.CreateFaceTable{race=n,needCount=hostageCount,maxUsedFovaCount=hostageFaceModelCount,faceModelOverlap=hostageIsFaceModelOverlap,ignoreFaceList=hostageIgnoreFaceList,raceHalfMode=f}
    if faceTable~=nil then
      local face={}
      local t={}
      local numTableFaces=#faceTable
      local numFaces=MAX_REALIZED_COUNT
      if hostageCount<=numTableFaces then
        numFaces=1
      end
      if(numTableFaces>0)and(numTableFaces<hostageCount)then
        numFaces=math.floor(hostageCount/numTableFaces)+1
      end
      if numFaces<=0 then
        numFaces=MAX_REALIZED_COUNT
      end
      for n,value in ipairs(faceTable)do
        table.insert(face,{value,0,0,numFaces})
        table.insert(t,value)
      end
      local e=#t
      if e>0 then
        local hosface_groupNumber=gvars.hosface_groupNumber
        TppSoldierFace.SetPoolTable{hostageFace=t,randomSeed=hosface_groupNumber}
      end
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    else
      local face={}
      local n=gvars.hosface_groupNumber%9
      if hostageLang==defaultLang then
        table.insert(face,{25+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==d then
        table.insert(face,{100+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==p then
        table.insert(face,{210+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==i then
        table.insert(face,{9+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==c then
        table.insert(face,{260+n,0,0,MAX_REALIZED_COUNT})
      else
        table.insert(face,{55+n,0,0,MAX_REALIZED_COUNT})
      end
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
    local hostageUseHair=this.GetHostageUseHairAtMissionId(missionId)
    if hostageUseHair==true then
      TppSoldierFace.SetHostageUseHairFova(true)
    end
  end
end
function this.GetFaceGroupTableAtGroupType(e)
  local faceGroupTable=TppEnemyFaceGroup.GetFaceGroupTable(e)
  local a={}
  local e=EnemyFova.MAX_REALIZED_COUNT
  for t,n in pairs(faceGroupTable)do
    table.insert(a,{n,e,e,0})
  end
  return a
end
fovaSetupFuncs[10200]=function(d,missionId)
  this.SetHostageFaceTable(missionId)
  local e={{TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT},{TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=e}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
fovaSetupFuncs[11200]=fovaSetupFuncs[10200]
fovaSetupFuncs[10120]=function(d,missionId)this.SetHostageFaceTable(missionId)
  local e={{TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT},{TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=e}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
fovaSetupFuncs[10040]=function(a,e)
  local a=FovaFuncObject(fovaSetupFuncs)
  a:case("Afghan",e)
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[10045]=function(e,a)
  local e=FovaFuncObject(fovaSetupFuncs)
  e:case("Afghan",a)
  local e={}
  for a=0,9 do
    table.insert(e,a)
  end
  for a=20,39 do
    table.insert(e,a)
  end
  for a=50,81 do
    table.insert(e,a)
  end
  for a=93,199 do
    table.insert(e,a)
  end
  local a=#e
  local a=gvars.hosface_groupNumber%a
  local e=e[a]
  local a={{TppEnemyFaceId.svs_balaclava,1,1,0},{e,1,1,0}}
  TppSoldierFace.OverwriteMissionFovaData{face=a,additionalMode=true}
  local a=274
  TppSoldierFace.SetSpecialFovaId{face={e},body={a}}
  local e={{a,1}}
  TppSoldierFace.OverwriteMissionFovaData{body=e,additionalMode=true}
end
fovaSetupFuncs[10052]=function(e,a)
  local e=FovaFuncObject(fovaSetupFuncs)
  e:case("Afghan",a)
  TppSoldierFace.SetSplitRaceForHostageRandomFaceId{enabled=true}
end
fovaSetupFuncs[11052]=fovaSetupFuncs[10052]
fovaSetupFuncs[10090]=function(a,e)
  local a=FovaFuncObject(fovaSetupFuncs)
  a:case("Africa",e)
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11090]=fovaSetupFuncs[10090]
fovaSetupFuncs[10091]=function(e,a)
  local e=FovaFuncObject(fovaSetupFuncs)
  e:case("Africa",a)
  local e={}
  for a=0,9 do
    table.insert(e,a)
  end
  for a=20,39 do
    table.insert(e,a)
  end
  for a=50,81 do
    table.insert(e,a)
  end
  for a=93,199 do
    table.insert(e,a)
  end
  local t=#e
  local d=gvars.solface_groupNumber%t
  local a=gvars.hosface_groupNumber%t
  if d==a then
    a=(a+1)%t
  end
  local d=e[d]
  local t=e[a]
  local e={{TppEnemyFaceId.pfs_balaclava,2,2,0},{d,1,1,0},{t,1,1,0}}
  TppSoldierFace.OverwriteMissionFovaData{face=e,additionalMode=true}
  local a=265
  local e=266
  TppSoldierFace.SetSpecialFovaId{face={d,t},body={a,e}}
  local e={{a,1},{e,1}}
  TppSoldierFace.OverwriteMissionFovaData{body=e,additionalMode=true}
end
fovaSetupFuncs[11091]=fovaSetupFuncs[10091]
fovaSetupFuncs[10080]=function(a,t)
  local a=FovaFuncObject(fovaSetupFuncs)
  a:case("Africa",t)
  if TppPackList.IsMissionPackLabel"afterPumpStopDemo"then
  else
    TppSoldier2.SetExtendPartsInfo{type=2,path="/Assets/tpp/parts/chara/chd/chd0_main0_def_v00.parts"}
    local e={{TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},{TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT}}
    TppSoldierFace.OverwriteMissionFovaData{body=e}
  end
end
fovaSetupFuncs[11080]=fovaSetupFuncs[10080]
fovaSetupFuncs[10115]=function(a,a)
  local faces={}
  for e=0,9 do
    table.insert(faces,e)
  end
  for e=20,39 do
    table.insert(faces,e)
  end
  for e=50,81 do
    table.insert(faces,e)
  end
  for e=93,199 do
    table.insert(faces,e)
  end
  local t=gvars.hosface_groupNumber
  TppSoldierFace.SetPoolTable{face=faces,randomSeed=t}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  local body={{140,MAX_REALIZED_COUNT},{141,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.dds5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=dds5_main0_def_v00,bodyId=TppEnemyBodyId.dds5_main0_v00}
  TppSoldierFace.OverwriteMissionFovaData{body=body}
end
fovaSetupFuncs[11115]=fovaSetupFuncs[10115]
fovaSetupFuncs[10130]=function(a,e)
  local a=FovaFuncObject(fovaSetupFuncs)
  a:case("Africa",e)
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11130]=fovaSetupFuncs[10130]
fovaSetupFuncs[10140]=function(e,a)
  local e=FovaFuncObject(fovaSetupFuncs)
  e:case("Africa",a)
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11140]=fovaSetupFuncs[10140]
fovaSetupFuncs[10150]=function(a,a)
  local a={}
  for e=0,9 do
    table.insert(a,e)
  end
  for e=20,39 do
    table.insert(a,e)
  end
  for e=50,81 do
    table.insert(a,e)
  end
  for e=93,199 do
    table.insert(a,e)
  end
  local t=gvars.hosface_groupNumber
  TppSoldierFace.SetPoolTable{face=a,randomSeed=t}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  local e={{TppEnemyBodyId.wss4_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=e}
end
fovaSetupFuncs[10151]=function(e,e)
end
fovaSetupFuncs[11151]=fovaSetupFuncs[10151]
fovaSetupFuncs[30010]=function(a,t)
  local a=FovaFuncObject(fovaSetupFuncs)
  a:case("Afghan",t)
  TppSoldierFace.SetUseZombieFova{enabled=true}
  local body={{TppEnemyBodyId.prs3_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs3_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfghanFree,bodyId=TppEnemyBodyId.prs3_main0_v00}
end
fovaSetupFuncs[30020]=function(t,a)
  local n=FovaFuncObject(fovaSetupFuncs)
  n:case("Africa",a)
  TppSoldierFace.SetUseZombieFova{enabled=true}
  local body={{TppEnemyBodyId.prs6_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs6_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfricaFree,bodyId=TppEnemyBodyId.prs6_main0_v00}
end
function fovaSetupFuncs.Afghan(n,missionId)
  if missionId==10010 then
    return
  end
  local moreVariationMode=0
  if TppSoldierFace.IsMoreVariationMode~=nil then
    moreVariationMode=TppSoldierFace.IsMoreVariationMode()
  end
  local o=15
  local n=gvars.solface_groupNumber%o
  local l=TppEnemyFaceGroupId.AFGAN_GRP_00+n
  local faceGroupTable=this.GetFaceGroupTableAtGroupType(l)
  TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
  if moreVariationMode>0 then
    for e=1,2 do
      n=n+2
      local e=(n%o)*2
      local e=TppEnemyFaceGroupId.AFGAN_GRP_00+(e)
      local face=this.GetFaceGroupTableAtGroupType(e)
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
  end
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  this.SetHostageFaceTable(missionId)
  local body={
    {0,MAX_REALIZED_COUNT},
    {1,MAX_REALIZED_COUNT},
    {2,MAX_REALIZED_COUNT},
    {5,MAX_REALIZED_COUNT},
    {6,MAX_REALIZED_COUNT},
    {7,MAX_REALIZED_COUNT},
    {10,MAX_REALIZED_COUNT},
    {11,MAX_REALIZED_COUNT},
    {20,MAX_REALIZED_COUNT},
    {21,MAX_REALIZED_COUNT},
    {22,MAX_REALIZED_COUNT},
    {25,MAX_REALIZED_COUNT},
    {26,MAX_REALIZED_COUNT},
    {27,MAX_REALIZED_COUNT},
    {30,MAX_REALIZED_COUNT},
    {31,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}
  }
  if not this.IsNotRequiredArmorSoldier(missionId)then
    local e={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}
    table.insert(body,e)
  end
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs2_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfghan,bodyId=TppEnemyBodyId.prs2_main0_v00}
end
function fovaSetupFuncs.Africa(n,missionId)
  local isMoreVariationMode=0
  if TppSoldierFace.IsMoreVariationMode~=nil then
    isMoreVariationMode=TppSoldierFace.IsMoreVariationMode()
  end
  local t=30
  local solface_groupNumber=gvars.solface_groupNumber
  local faceGroup=(solface_groupNumber%t)*2
  local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_B+(faceGroup)
  local i=this.GetFaceGroupTableAtGroupType(faceGroupType)
  TppSoldierFace.OverwriteMissionFovaData{face=i}
  if isMoreVariationMode>0 then
    for e=1,2 do
      solface_groupNumber=solface_groupNumber+2
      local faceGroup=(solface_groupNumber%t)*2
      local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_B+(faceGroup)
      local face=this.GetFaceGroupTableAtGroupType(faceGroupType)
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
  end
  t=30
  solface_groupNumber=gvars.solface_groupNumber
  faceGroup=(solface_groupNumber%t)*2
  faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_W+(faceGroup)
  local face=this.GetFaceGroupTableAtGroupType(faceGroupType)
  TppSoldierFace.OverwriteMissionFovaData{face=face}
  if isMoreVariationMode>0 then
    for e=1,2 do
      solface_groupNumber=solface_groupNumber+2
      local faceGroup=(solface_groupNumber%t)*2
      local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_W+(faceGroup)
      local face=this.GetFaceGroupTableAtGroupType(faceGroupType)
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
  end
  this.SetHostageFaceTable(missionId)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true,raceSplit=60}
  local body={
    {50,MAX_REALIZED_COUNT},
    {51,MAX_REALIZED_COUNT},
    {55,MAX_REALIZED_COUNT},
    {60,MAX_REALIZED_COUNT},
    {61,MAX_REALIZED_COUNT},
    {70,MAX_REALIZED_COUNT},
    {71,MAX_REALIZED_COUNT},
    {75,MAX_REALIZED_COUNT},
    {80,MAX_REALIZED_COUNT},
    {81,MAX_REALIZED_COUNT},
    {90,MAX_REALIZED_COUNT},
    {91,MAX_REALIZED_COUNT},
    {95,MAX_REALIZED_COUNT},
    {100,MAX_REALIZED_COUNT},
    {101,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}
  }
  local armorTypeTable=this.GetArmorTypeTable(missionId)
  if armorTypeTable~=nil then
    local numArmorTypes=#armorTypeTable
    if numArmorTypes>0 then
      for t,armorType in ipairs(armorTypeTable)do
        if armorType==TppDefine.AFR_ARMOR.TYPE_ZRS then
          table.insert(body,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
        elseif armorType==TppDefine.AFR_ARMOR.TYPE_CFA then
          table.insert(body,{TppEnemyBodyId.pfa0_v00_b,MAX_REALIZED_COUNT})
        elseif armorType==TppDefine.AFR_ARMOR.TYPE_RC then
          table.insert(body,{TppEnemyBodyId.pfa0_v00_c,MAX_REALIZED_COUNT})
        else
          table.insert(body,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
        end
      end
    end
  end
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=defaultPartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
function fovaSetupFuncs.Mbqf(n,n)
  TppSoldierFace.SetSoldierOutsideFaceMode(false)
  TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  local face={}
  local n={}
  if TppStory.GetCurrentStorySequence()<TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    local e,a=TppMotherBaseManagement.GetStaffsS10240()
    for a,staffId in pairs(e)do
      local e=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
      if n[e]==nil then
        n[e]=2
      else
        n[e]=n[e]+1
      end
    end
    for a,e in pairs(a)do
      local e=TppMotherBaseManagement.StaffIdToFaceId{staffId=e}
      if n[e]==nil then
        n[e]=2
      else
        n[e]=n[e]+1
      end
    end
  else
    for e,t in ipairs(this.S10240_MaleFaceIdList)do
      local faceId=this.S10240_MaleFaceIdList[e]
      if n[faceId]==nil then
        n[faceId]=2
      else
        n[faceId]=n[faceId]+1
      end
    end
    for e,t in ipairs(this.S10240_FemaleFaceIdList)do
      local faceId=this.S10240_FemaleFaceIdList[e]
      if n[faceId]==nil then
        n[faceId]=2
      else
        n[faceId]=n[faceId]+1
      end
    end
  end
  for a,e in pairs(n)do
    table.insert(face,{a,e,e,0})
  end
  table.insert(face,{623,1,1,0})
  table.insert(face,{TppEnemyFaceId.dds_balaclava2,10,10,0})
  table.insert(face,{TppEnemyFaceId.dds_balaclava6,2,2,0})
  table.insert(face,{TppEnemyFaceId.dds_balaclava7,2,2,0})
  local body={
  {146,MAX_REALIZED_COUNT},
  {147,MAX_REALIZED_COUNT},
  {148,MAX_REALIZED_COUNT},
  {149,MAX_REALIZED_COUNT},
  {150,MAX_REALIZED_COUNT},
  {151,1},
  {152,MAX_REALIZED_COUNT},
  {153,MAX_REALIZED_COUNT},
  {154,MAX_REALIZED_COUNT},
  {155,MAX_REALIZED_COUNT},
  {156,MAX_REALIZED_COUNT},
  {157,MAX_REALIZED_COUNT},
  {158,MAX_REALIZED_COUNT}
  }
  TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00.parts"}
  TppSoldierFace.OverwriteMissionFovaData{face=face,body=body}
  TppSoldierFace.SetSoldierUseHairFova(true)
end
function fovaSetupFuncs.Mb(n,missionId)
  if TppMission.IsHelicopterSpace(missionId)then
    return
  end
  TppSoldierFace.SetSoldierOutsideFaceMode(false)
  local faces={}
  local ddSuit=TppEnemy.GetDDSuit()
  
  if TppMission.IsFOBMission(missionId) or InfMain.IsMbPlayTime() then--tex broken out from below balaclavas
      if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then--tex break this out from balaclavas -v-
      TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts"
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts"
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts"
    else
      TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts"
    end
  end
  if TppMission.IsFOBMission(missionId) or (InfMain.IsMbPlayTime() and gvars.mbDDBalaclava==0) then--tex added isplay
    local fobStaff=TppMotherBaseManagement.GetStaffsFob()
    if InfMain.IsMbPlayTime() then--tex
      fobStaff=TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=TppMotherBaseManagementConst.SECTION_SECURITY}--tex mbplaytime override
    end
    local FACE_SOLDIER_NUM=36--NAMEGUESS: from mtbs_enemy.lua
    local maxSolNum=100--NAMEGUESS: from mtbs_enemy again
    local faceCountTable={}--RENAME:
    local hasFaceTable={}--NAMEGUESS:
    do
      for i,staffId in pairs(fobStaff)do
        local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
        if faceCountTable[faceId]==nil then
          faceCountTable[faceId]=1
        else
          faceCountTable[faceId]=faceCountTable[faceId]+1
        end
        if i==FACE_SOLDIER_NUM then
          break
        end
      end
      if#fobStaff==0 then
        for i=1,FACE_SOLDIER_NUM do
          faceCountTable[i]=1
        end
      end
      for faceId,numUsed in pairs(faceCountTable)do
        table.insert(faces,{faceId,numUsed,numUsed,0})
      end
    end
    do
      for i=FACE_SOLDIER_NUM+1,FACE_SOLDIER_NUM+maxSolNum do
        local staffId=fobStaff[i]
        if staffId==nil then
          break
        end
        local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
        if faceCountTable[faceId]==nil then
          hasFaceTable[faceId]=1
        end
        if i==maxSolNum then
          break
        end
      end
      for faceId,hasFace in pairs(hasFaceTable)do
        table.insert(faces,{faceId,0,0,0})
      end
    end
    local balaclavas={}
    if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava12,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava12,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
    else
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava5,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end
    if this.IsUseGasMaskInFOB()then
      balaclavas={
        {TppEnemyFaceId.dds_balaclava8,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
        {TppEnemyFaceId.dds_balaclava9,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
        {TppEnemyFaceId.dds_balaclava10,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
        {TppEnemyFaceId.dds_balaclava11,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
        {TppEnemyFaceId.dds_balaclava13,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
        {TppEnemyFaceId.dds_balaclava15,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0}
      }
    end
    for a,e in ipairs(balaclavas)do
      table.insert(faces,e)
    end
  else
    if missionId==30050 then
    elseif missionId==30150 then--NMC: zoo
    elseif missionId==30250 then--NMC: ward
      local securityStaff=TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=TppMotherBaseManagementConst.SECTION_SECURITY}
      --local e=#securityStaff
      local maxStaffFaces = 7--tex shifted constant from below, not 100% sure on name/purpose
      local faceCounts={}
      for n,staffId in pairs(securityStaff)do
        local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
        if faceCounts[faceId]==nil then
          faceCounts[faceId]=1
        else
          faceCounts[faceId]=faceCounts[faceId]+1
        end
        if n==maxStaffFaces then
          break
        end
      end
      for faceId,faceCount in pairs(faceCounts)do
        table.insert(faces,{faceId,faceCount,faceCount,0})
      end
      table.insert(faces,{TppEnemyFaceId.dds_balaclava6,maxStaffFaces,maxStaffFaces,0})
    elseif missionId==10240 then
      faces={
      {1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {5,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {6,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {7,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {8,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {9,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {15,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {16,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {17,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {18,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0}
      }
      table.insert(faces,{TppEnemyFaceId.dds_balaclava6,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    elseif missionId==10030 then--Mission: Diamond Dogs
      for a,e in ipairs(this.S10030_FaceIdList)do
        table.insert(faces,{e,1,1,0})
      end
      table.insert(faces,{TppEnemyFaceId.dds_balaclava0,this.S10030_useBalaclavaNum,this.S10030_useBalaclavaNum,0})
    else
      for a=0,35 do
        table.insert(faces,{a,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      end
      table.insert(faces,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(faces,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(faces,{TppEnemyFaceId.dds_balaclava2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end
  end
  TppSoldierFace.OverwriteMissionFovaData{face=faces}
  local bodies={}
  if TppMission.IsFOBMission(missionId) or InfMain.IsMbPlayTime() then--tex added playtime
    if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
      bodies={{TppEnemyBodyId.dds4_enem0_def,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds4_enef0_def,MAX_REALIZED_COUNT}}
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      bodies={{TppEnemyBodyId.dds5_enem0_def,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds5_enef0_def,MAX_REALIZED_COUNT}}
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      bodies={{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT}}
    else
      bodies={{TppEnemyBodyId.dds5_main0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds6_main0_v00,MAX_REALIZED_COUNT}}
    end
  else
    bodies={{TppEnemyBodyId.dds3_main0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds8_main0_v00,MAX_REALIZED_COUNT}}
  end
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  if not(missionId==10030 or missionId==10240)then--ddogs, shining lights
    if TppMission.IsFOBMission(missionId) or InfMain.IsMbPlayTime() then--tex added playtime
      if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts"}
      elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts"}
      elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      else
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts"}
      end
    elseif missionId~=10115 and missionId~=11115 then
      TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts"}
    end
  end
  TppSoldierFace.SetSoldierUseHairFova(true)
end
function fovaSetupFuncs.Cyprus(a,a)
  local a={}
  for e=0,5 do
    table.insert(a,e)
  end
  TppSoldierFace.SetPoolTable{face=a}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  local e={{TppEnemyBodyId.wss0_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=e}
end
function fovaSetupFuncs.default(n,a)
  TppSoldierFace.SetMissionFovaData{face={},body={}}
  if a>6e4 then
    local e={{30,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT}}
    TppSoldierFace.OverwriteMissionFovaData{face=e}
  end
end
function this.AddTakingOverHostagePack()
  local e={}
  for n,t in ipairs(TppEnemy.TAKING_OVER_HOSTAGE_LIST)do
    local a=n-1
    if a>=gvars.ene_takingOverHostageCount then
      break
    end
    local a={type="hostage",name=t,faceId=gvars.ene_takingOverHostageFaceIds[a]}table.insert(e,a)
  end
  this.AddUniqueSettingPackage(e)
end
function this.PreMissionLoad(missionId,currentMissionId)
  TppSoldier2.SetEnglishVoiceIdTable{voice={}}
  TppSoldierFace.SetMissionFovaData{face={},body={}}
  TppSoldierFace.ResetForPreMissionLoad()
  TppSoldier2.SetDisableMarkerModelEffect{enabled=false}
  TppSoldier2.SetDefaultPartsPath()
  TppSoldier2.SetExtendPartsInfo{}
  TppHostage2.ClearDefaultBodyFovaId()
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    local mbsClusterSecuritySoldierEquipGrade=InfMain.GetMbsClusterSecuritySoldierEquipGrade{}--tex ORIG:TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local mbsClusterSecurityIsNoKillMode=InfMain.GetMbsClusterSecurityIsNoKillMode()--tex ORIG:TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
    TppEnemy.PrepareDDParameter(mbsClusterSecuritySoldierEquipGrade,mbsClusterSecurityIsNoKillMode)
  end
  local a=FovaFuncObject(fovaSetupFuncs)
  if fovaSetupFuncs[missionId]==nil then
    if TppMission.IsHelicopterSpace(missionId)then
      a:case("default",missionId)
    elseif TppLocation.IsAfghan()then
      a:case("Afghan",missionId)
    elseif TppLocation.IsMiddleAfrica()then
      a:case("Africa",missionId)
    elseif TppLocation.IsMBQF()then
      a:case("Mbqf",missionId)
    elseif TppLocation.IsMotherBase()then
      a:case("Mb",missionId)
    elseif TppLocation.IsCyprus()then
      a:case("Cyprus",missionId)
    else
      a:case("default",missionId)
    end
  else
    a:case(missionId,missionId)
  end
end
local c={}
local o={}
local l={}
local t={}
local numDdHostages=0
local i=0
local faceIdS10081=0
local faceIdS10091_0=0
local faceIdS10091_1=0
local m=15
local T=16
local _=32
local defaultStaffId=0
function this.InitializeUniqueSetting()
  c={}
  o={}
  l={}
  t={}
  numDdHostages=0
  i=0
  faceIdS10081=0
  faceIdS10091_0=0
  faceIdS10091_1=0
  local NULL_ID=GameObject.NULL_ID
  local NOT_USED_FOVA_VALUE=EnemyFova.NOT_USED_FOVA_VALUE
  for i=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
    gvars.ene_fovaUniqueTargetIds[i]=NULL_ID
    gvars.ene_fovaUniqueFaceIds[i]=NOT_USED_FOVA_VALUE
    gvars.ene_fovaUniqueBodyIds[i]=NOT_USED_FOVA_VALUE
    gvars.ene_fovaUniqueBodyIds[i]=NOT_USED_FOVA_VALUE
    if gvars.ene_fovaUniqueFlags then
      gvars.ene_fovaUniqueFlags[i]=0
    end
  end
end
function this.GetStaffIdForDD(missionId,n)
  local staffId=defaultStaffId
  if missionId==10081 then
    staffId=TppMotherBaseManagement.GetStaffS10081()
  elseif missionId==10091 or missionId==11091 then
    local setStaffsS10091=TppMotherBaseManagement.GetStaffsS10091()
    if setStaffsS10091 and n<#setStaffsS10091 then
      staffId=setStaffsS10091[n+1]
    end
  elseif missionId==10115 or missionId==11115 then
    local staffsS10115=TppMotherBaseManagement.GetStaffsS10115()
    if staffsS10115 and n<#staffsS10115 then
      staffId=staffsS10115[n+1]
    end
  end
  return staffId
end
function this.GetFaceIdForDdHostage(missionId)
  local num=numDdHostages
  numDdHostages=numDdHostages+1
  local staffId=this.GetStaffIdForDD(missionId,num)
  local bor=bit.bor(T,num)
  if staffId~=defaultStaffId then
    local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
    if missionId==10081 then
      faceIdS10081=faceId
    elseif missionId==10091 or missionId==11091 then
      if num>0 then
        faceIdS10091_1=faceId
      else
        faceIdS10091_0=faceId
      end
    end
    return faceId,bor
  end
  local a=(gvars.hosface_groupNumber+num)%30
  local randomFaceId=50+a
  if TppSoldierFace.GetRandomFaceId~=nil then
    local e=gvars.solface_groupNumber+num
    randomFaceId=TppSoldierFace.GetRandomFaceId{race={0,2,3},gender=0,useIndex=e}
  end
  if missionId==10081 then
    faceIdS10081=randomFaceId
  elseif missionId==10091 or missionId==11091 then
    if num>0 then
      faceIdS10091_1=randomFaceId
    else
      faceIdS10091_0=randomFaceId
    end
  end
  return randomFaceId,bor
end
function this.GetFaceId_s10081()
  return faceIdS10081
end
function this.GetFaceId_s10091_0()
  return faceIdS10091_0
end
function this.GetFaceId_s10091_1()
  return faceIdS10091_1
end
function this.GetFaceIdForFemaleHostage(e)
  local n=_
  if e==10086 then
    return 613,n
  end
  local t=i
  i=i+1
  local race={}
  table.insert(race,0)
  if TppLocation.IsAfghan()then
    table.insert(race,3)
  elseif TppLocation.IsMiddleAfrica()then
    table.insert(race,2)
    table.insert(race,3)
  end
  local useIndex=gvars.solface_groupNumber+t
  local faceId=EnemyFova.INVALID_FOVA_VALUE
  if TppSoldierFace.GetRandomFaceId~=nil then
    faceId=TppSoldierFace.GetRandomFaceId{race=race,gender=1,useIndex=useIndex}
    if faceId~=EnemyFova.INVALID_FOVA_VALUE then
      return faceId,n
    else
      local a=(gvars.hosface_groupNumber+t)%50
      faceId=350+a
    end
  else
    local a=(gvars.hosface_groupNumber+t)%50
    faceId=350+a
  end
  return faceId,n
end
function this.GetFaceIdAndFlag(n,e)
  local t=EnemyFova.NOT_USED_FOVA_VALUE
  if e=="female"then
    if n=="hostage"then
      return this.GetFaceIdForFemaleHostage(vars.missionCode)
    else
      return t,0
    end
  elseif e=="dd"then
    if n=="hostage"then
      return this.GetFaceIdForDdHostage(vars.missionCode)
    else
      return t,0
    end
  end
  return e,0
end
function this.RegisterUniqueSetting(d,i,p,n)
  local e=EnemyFova.NOT_USED_FOVA_VALUE
  local a,p=this.GetFaceIdAndFlag(d,p)
  if a==nil then
    a=e
  end
  if n==nil then
    n=e
  end
  table.insert(c,{name=i,faceId=a,bodyId=n,flag=p})do
    local p=1
    local l=2
    local t=3
    local n=4
    local e=nil
    for t,n in ipairs(o)do
      if n[p]==a then
        e=n
      end
    end
    if not e then
      e={a,0,0,0}table.insert(o,e)
    end
    if d=="enemy"then
      e[l]=e[l]+1
      e[t]=e[t]+1
    elseif d=="hostage"then
      e[n]=e[n]+1
    end
  end
  do
    local p=1
    local o=2
    local e=nil
    for t,a in ipairs(l)do
      if a[p]==n then
        e=a
      end
    end
    if not e then
      e={n,0}
      table.insert(l,e)
    end
    e[o]=e[o]+1
    if d=="hostage"then
      local e=n
      for t,a in ipairs(t)do
        if a==n then
          e=nil
          break
        end
      end
      if e then
        table.insert(t,e)
      end
    end
  end
end
function this.AddUniqueSettingPackage(e)
  if e and type(e)=="table"then
    for n,e in ipairs(e)do
      this.RegisterUniqueSetting(e.type,e.name,e.faceId,e.bodyId,e.missionCode)
    end
  end
  TppSoldierFace.OverwriteMissionFovaData{face=o,body=l,additionalMode=true}if#t>0 then
    TppSoldierFace.SetBodyFovaUserType{hostage=t}
  end
end
function this.AddUniquePackage(e)
  TppSoldierFace.OverwriteMissionFovaData{face=e.face,body=e.body,additionalMode=true}
  if e.body and e.type=="hostage"then
    local a={}
    for n,e in ipairs(e.body)do
      table.insert(a,e[1])
    end
    if#a>0 then
      TppSoldierFace.SetBodyFovaUserType{hostage=a}
    end
  end
end
function this.ApplyUniqueSetting()
  local NULL_ID=GameObject.NULL_ID
  local e=EnemyFova.NOT_USED_FOVA_VALUE
  if gvars.ene_fovaUniqueTargetIds[0]==NULL_ID then
    local e=0
    for n,a in ipairs(c)do
      local n=GameObject.GetGameObjectId(a.name)
      if n~=NULL_ID then
        if e<TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT then
          gvars.ene_fovaUniqueTargetIds[e]=n
          gvars.ene_fovaUniqueFaceIds[e]=a.faceId
          gvars.ene_fovaUniqueBodyIds[e]=a.bodyId
          if gvars.ene_fovaUniqueFlags then
            gvars.ene_fovaUniqueFlags[e]=a.flag
          end
        end
        e=e+1
      end
    end
  end
  local band=bit.band
  for n=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
    local soldierId=gvars.ene_fovaUniqueTargetIds[n]
    if soldierId==NULL_ID then
      break
    end
    local command={id="ChangeFova",faceId=gvars.ene_fovaUniqueFaceIds[n],bodyId=gvars.ene_fovaUniqueBodyIds[n]}
    GameObject.SendCommand(soldierId,command)
    local fovaUniqueFlags=0
    if gvars.ene_fovaUniqueFlags then
      fovaUniqueFlags=gvars.ene_fovaUniqueFlags[n]
    end
    if band(fovaUniqueFlags,T)~=0 then
      local missionId=vars.missionCode
      local t=band(fovaUniqueFlags,m)
      local staffId=this.GetStaffIdForDD(missionId,t)
      if staffId~=defaultStaffId then
        local command={id="SetStaffId",staffId=staffId}
        GameObject.SendCommand(soldierId,command)
      end
      local a={id="SetHostage2Flag",flag="dd",on=true}
      GameObject.SendCommand(soldierId,a)
    elseif band(fovaUniqueFlags,_)~=0 then
      local command={id="SetHostage2Flag",flag="female",on=true}
      GameObject.SendCommand(soldierId,command)
    end
  end
end
function this.ApplyMTBSUniqueSetting(soldierId,faceId,useBalaclava,forceNoBalaclava)
  if InfMain.IsMbPlayTime() then--
    if gvars.mbDDBalaclava==1 then--tex
      forceNoBalaclava=true
    end
  end--

  local bodyId=0
  local balaclavaFaceId=EnemyFova.INVALID_FOVA_VALUE
  local ddSuit=TppEnemy.GetDDSuit()
  local function IsFemale(faceId)
    local isFemale=TppSoldierFace.CheckFemale{face={faceId}}
    return isFemale and isFemale[1]==1
  end
  if TppMission.IsFOBMission(vars.missionCode) or InfMain.IsMbPlayTime() then--tex added playtime
    if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
      if((TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT and TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT>=3)and TppMotherBaseManagement.GetMbsNvgSneakingLevel)and TppMotherBaseManagement.GetMbsNvgSneakingLevel()>0 then
        TppEnemy.AddPowerSetting(soldierId,{"NVG"})
      end
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds4_enef0_def
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava14
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava4
        end
      else
        bodyId=TppEnemyBodyId.dds4_enem0_def
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava12
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava1
        end
      end
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      if((TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS and TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS>=3)and TppMotherBaseManagement.GetMbsNvgBattleLevel)and TppMotherBaseManagement.GetMbsNvgBattleLevel()>0 then
        TppEnemy.AddPowerSetting(soldierId,{"NVG"})
      end
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds5_enef0_def
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava14
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          end
        elseif useBalaclava then
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava4
        end
      else
        bodyId=TppEnemyBodyId.dds5_enem0_def
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava12
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
          end
        elseif useBalaclava then
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava1
        end
      end
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      if not IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.pfa0_v00_a
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        TppEnemy.AddPowerSetting(soldierId,{"ARMOR"})
      end
    else
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds6_main0_v00
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if useBalaclava then
          if TppEnemy.IsHelmet(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava5
          end
        end
      else
        bodyId=TppEnemyBodyId.dds5_main0_v00
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        if useBalaclava then
          if TppEnemy.IsHelmet(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava2
          end
        end
      end
    end
    if this.IsUseGasMaskInFOB()and ddSuit~=TppEnemy.FOB_PF_SUIT_ARMOR then
      if IsFemale(faceId)then
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava15
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava11
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava10
        end
      else
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava13
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava9
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava8
        end
      end
      TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
    end
  else
    if IsFemale(faceId)then
      bodyId=TppEnemyBodyId.dds8_main0_v00
      local command={id="UseExtendParts",enabled=true}
      GameObject.SendCommand(soldierId,command)
      if useBalaclava then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava5
      end
      if this.IsUseGasMaskInMBFree()then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava7
        TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
      end
    else
      bodyId=TppEnemyBodyId.dds3_main0_v00
      local t={id="UseExtendParts",enabled=false}
      GameObject.SendCommand(soldierId,t)
      if useBalaclava then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava2
      end
      if this.IsUseGasMaskInMBFree()then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava6
        TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
      end
    end
  end
  if forceNoBalaclava then
    balaclavaFaceId=EnemyFova.NOT_USED_FOVA_VALUE
  end
  local command={id="ChangeFova",faceId=faceId,bodyId=bodyId,balaclavaFaceId=balaclavaFaceId}
  GameObject.SendCommand(soldierId,command)
end
function this.IsUseGasMaskInMBFree(e)
  local a=TppMotherBaseManagement.IsPandemicEventMode()
  local e=mvars.f30050_currentFovaClusterId~=TppDefine.CLUSTER_DEFINE.Command
  return a and e
end
function this.IsUseGasMaskInFOB()
  local a,a,e=this.GetUavSetting()
  return e
end
function this.GetUavSetting()
  local uavLevel=TppMotherBaseManagement.GetMbsUavLevel{}
  local uavSmokeLevel=TppMotherBaseManagement.GetMbsUavSmokeGrenadeLevel{}
  local uavSleepingGasLevel=TppMotherBaseManagement.GetMbsUavSleepingGusGrenadeLevel{}
  local equipGrade=InfMain.GetMbsClusterSecuritySoldierEquipGrade{}--tex ORIG:TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  local isNoKillMode=InfMain.GetMbsClusterSecurityIsNoKillMode()--tex ORIG: TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
  local l=TppUav.DEVELOP_LEVEL_LMG_0
  local t=false
  local c=false
  local lmgDevLevel=0
  local smokeDevLevel=0
  local sleepDevLevel=0
  local o=100
  local _=7
  local i=4
  local r=3
  local r=3
  local m=3
  if equipGrade<r then
    lmgDevLevel=o
  elseif uavLevel>0 then
    if uavLevel==1 then
      lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_0
    elseif uavLevel==2 then
      if equipGrade>=((uavLevel+r)-1)then
        lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_1
      else
        lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_0
      end
    elseif uavLevel==3 then
      if equipGrade>=((uavLevel+r)-1)then
        lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_2
      elseif equipGrade>=((2+r)-1)then
        lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_1
      else
        lmgDevLevel=TppUav.DEVELOP_LEVEL_LMG_0
      end
    end
  end
  if equipGrade<i then
    smokeDevLevel=o
  elseif uavLevel>0 then
    if uavSmokeLevel==1 then
      smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_0
    elseif uavSmokeLevel==2 then
      if equipGrade>=((uavSmokeLevel+i)-1)then
        smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_1
      else
        smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_0
      end
    elseif uavSmokeLevel==3 then
      if equipGrade>=((uavSmokeLevel+i)-1)then
        smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_2
      elseif equipGrade>=((2+i)-1)then
        smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_1
      else
        smokeDevLevel=TppUav.DEVELOP_LEVEL_SMOKE_0
      end
    end
  end
  if equipGrade<_ then
    sleepDevLevel=o
  else
    if uavSleepingGasLevel==1 then
      sleepDevLevel=TppUav.DEVELOP_LEVEL_SLEEP_0
    end
  end
  if uavLevel==0 then
    t=false
  else
    if isNoKillMode==true then
      if sleepDevLevel~=o then
        l=sleepDevLevel
        t=true
        c=true
      elseif smokeDevLevel~=o then
        l=smokeDevLevel
        t=true
        c=true
      elseif lmgDevLevel~=o then
        l=lmgDevLevel
        t=true
      else
        t=false
      end
    else
      if lmgDevLevel~=o then
        l=lmgDevLevel
        t=true
      else
        t=false
      end
    end
  end
  return t,l,c
end
return this
