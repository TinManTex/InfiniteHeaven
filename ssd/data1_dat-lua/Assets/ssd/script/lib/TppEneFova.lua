local this={}
if NpcFova==nil then
  NpcFova=EnemyFova
end
local n=NpcFova.MAX_REALIZED_COUNT
local n=0
local o=1
local n=2
local n=3
local n=4
local n=5
local n=6
local n="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts"
local n="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts"
local n="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
local n="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts"
local n="/Assets/tpp/parts/chara/dds/dds5_main0_def_v00.parts"
local l={}
local n={}
local a={}
local function t(n)
  function n:case(n,a)
    local e=self[n]or self.default
    if e then
      e(n,a)
    end
  end
  return n
end
function this.CanUseArmorType(a,n)
  local l={PF_A=TppDefine.AFR_ARMOR.TYPE_CFA,PF_B=TppDefine.AFR_ARMOR.TYPE_ZRS,PF_C=TppDefine.AFR_ARMOR.TYPE_RC}
  local n=l[n]
  if n==nil then
    return true
  end
  local e=this.GetArmorTypeTable(a)
  for a,e in ipairs(e)do
    if e==n then
      return true
    end
  end
  return false
end
function this.GetHostageCountAtMissionId(e)
  local a=1
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.count~=nil then
        return e.count
      end
    end
  end
  return a
end
function this.GetHostageLangAtMissionId(e)
  local a=o
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.lang~=nil then
        return e.lang
      end
    end
  end
  return a
end
function this.GetHostageUseHairAtMissionId(e)
  local a=false
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.useHair~=nil then
        return e.useHair
      end
    end
  end
  return a
end
function this.GetHostageIsFaceModelOverlap(e)
  local a=false
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.overlap~=nil then
        return e.overlap
      end
    end
  end
  return a
end
function this.GetHostageFaceModelCount(e)
  local a=2
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.modelNum~=nil then
        return e.modelNum
      end
    end
  end
  return a
end
function this.GetHostageIgnoreFaceList(e)
  local a={}
  if n[e]~=nil then
    local e=n[e]
    if e~=nil then
      if e.ignoreList~=nil then
        return e.ignoreList
      end
    end
  end
  return a
end
function this.GetArmorTypeTable(e)
  local n={TppDefine.AFR_ARMOR.TYPE_ZRS}
  if l[e]~=nil then
    local e=l[e]
    if e~=nil then
      return e
    end
  end
  return n
end
function this.SetHostageFaceTable(e)
end
function this.GetFaceGroupTableAtGroupType(e)
  local a=TppEnemyFaceGroup.GetFaceGroupTable(e)
  local n={}
  local e=NpcFova.MAX_REALIZED_COUNT
  for l,a in pairs(a)do
    table.insert(n,{a,e,e,0})
  end
  return n
end
function a.Afghan(e,e)
end
function a.Africa(e,e)
end
function a.default(e,e)
end
function this.PreMissionLoad(e,n)
  local n=t(a)
  if a[e]==nil then
    if TppLocation.IsAfghan()then
      n:case("Afghan",e)
    elseif TppLocation.IsMiddleAfrica()then
      n:case("Africa",e)
    else
      n:case("default",e)
    end
  else
    n:case(e,e)
  end
end
local c={}
local o={}
local i={}
local t={}
local n=0
local a=0
local l=0
local r=0
local d=0
local s=15
local f=16
local s=32
local u=0
function this.InitializeUniqueSetting()
  c={}
  o={}
  i={}
  t={}
  n=0
  a=0
  l=0
  r=0
  d=0
  local a=GameObject.NULL_ID
  local n=NpcFova.NOT_USED_FOVA_VALUE
  for e=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
    gvars.ene_fovaUniqueTargetIds[e]=a
    gvars.ene_fovaUniqueFaceIds[e]=n
    gvars.ene_fovaUniqueBodyIds[e]=n
    gvars.ene_fovaUniqueBodyIds[e]=n
    if gvars.ene_fovaUniqueFlags then
      gvars.ene_fovaUniqueFlags[e]=0
    end
  end
end
function this.GetFaceIdForDdHostage(e)
  local e=n
  n=n+1
  local n=bit.bor(f,e)
  local e=(gvars.hosface_groupNumber+e)%30
  local e=50+e
  return e,n
end
function this.GetFaceId_s10081()
  return l
end
function this.GetFaceId_s10091_0()
  return r
end
function this.GetFaceId_s10091_1()
  return d
end
function this.GetFaceIdForFemaleHostage(e)
  local n=s
  if e==10086 then
    return 613,n
  end
  local l=a
  a=a+1
  local e={}
  table.insert(e,0)
  if TppLocation.IsAfghan()then
    table.insert(e,3)
  elseif TppLocation.IsMiddleAfrica()then
    table.insert(e,2)
    table.insert(e,3)
  end
  local e=gvars.solface_groupNumber+l
  local e=NpcFova.INVALID_FOVA_VALUE
  return e,n
end
function this.GetFaceIdAndFlag(a,n)
  local l=NpcFova.NOT_USED_FOVA_VALUE
  if n=="female"then
    if a=="hostage"then
      return this.GetFaceIdForFemaleHostage(vars.missionCode)
    else
      return l,0
    end
  elseif n=="dd"then
    if a=="hostage"then
      return this.GetFaceIdForDdHostage(vars.missionCode)
    else
      return l,0
    end
  end
  return n,0
end
function this.RegisterUniqueSetting(l,d,a,n)
  local r=NpcFova.NOT_USED_FOVA_VALUE
  local a,e=this.GetFaceIdAndFlag(l,a)
  if a==nil then
    a=r
  end
  if n==nil then
    n=r
  end
  table.insert(c,{name=d,faceId=a,bodyId=n,flag=e})do
    local r=1
    local t=2
    local i=3
    local n=4
    local e=nil
    for l,n in ipairs(o)do
      if n[r]==a then
        e=n
      end
    end
    if not e then
      e={a,0,0,0}
      table.insert(o,e)
    end
    if l=="enemy"then
      e[t]=e[t]+1
      e[i]=e[i]+1
    elseif l=="hostage"then
      e[n]=e[n]+1
    end
  end
  do
    local o=1
    local a=2
    local e=nil
    for l,a in ipairs(i)do
      if a[o]==n then
        e=a
      end
    end
    if not e then
      e={n,0}
      table.insert(i,e)
    end
    e[a]=e[a]+1
    if l=="hostage"then
      local e=n
      for l,a in ipairs(t)do
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
end
function this.AddUniquePackage(e)
end
function this.ApplyUniqueSetting()
end
return this
