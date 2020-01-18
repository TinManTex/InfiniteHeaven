local e={}
local i=Tpp.IsTypeTable
local a=Tpp.IsTypeString
local t=3
local n=6
local s=1
local s={CAST_MODE={LEFT_START={"LeftCenter","RightCenter","LeftUp","RightUp"},RIGHT_START={"RightCenter","LeftCenter","RightUp","LeftUp"}},STAFF_MODE={LEFT_START={"LeftCenter","LeftUp","RightCenter","RightUp"},RIGHT_START={"RightCenter","RightUp","LeftCenter","LeftUp"}}}
function e.GetRandomStartSide()
  if mvars.tlp_startSide then
    return mvars.tlp_startSide
  end
  if(os.time()%2)==0 then
    return"LEFT_START"
  else
    return"RIGHT_START"
  end
end
function e.GetTelopPosition(e,a,t)
  local e=s[e][a]local t=t%4+1
  return e[t]end
function e.GetFirstLangId(t,e)
  if t==1 then
    return e
  else
    return""
  end
end
function e.GetLangIdTable(e)
  if i(e)then
    return e
  elseif a(e)then
    return{e}
  else
    return{}
  end
end
function e.StartCastTelop(t)
  if TppSequence.GetContinueCount()>0 then
    return
  end
  if t then
    mvars.tlp_startSide=t
  end
  e.PostMainCharacters(mvars.tlp_mainCharacters)e.PostEnemyCombatants(mvars.tlp_enemyCombatants)e.PostGuestCharacters(mvars.tlp_guestCharacters)e.PostSpecialMechanics(mvars.tlp_specialMechanics)e.PostLevelDesign(mvars.tlp_levelDesigners)e.PostWrittenBy(mvars.tlp_writers)e.PostCreativeProducers()e.PostDirectedBy()e.PostMissionObjective(vars.locationCode,vars.missionCode)
  TppUiCommand.StartTelopCast()
end
function e.StartMissionObjective()
  if TppSequence.GetContinueCount()>0 then
    return
  end
  e.PostMissionObjective(vars.locationCode,vars.missionCode)
  TppUiCommand.StartTelopCast()
end
function e.PostMainCharacters(a)
  if not next(a)then
    return
  end
  local s=e.GetRandomStartSide()
  for a,n in ipairs(a)do
    local i=e.GetFirstLangId(a,"post_starring")
    local a=e.GetTelopPosition("CAST_MODE",s,a-1)
    local e=e.GetLangIdTable(n)
    TppUiCommand.RegistTelopCast(a,t,i,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function e.PostGuestCharacters(a)
  if not next(a)then
    return
  end
  local s=e.GetRandomStartSide()
  for a,i in ipairs(a)do
    local n=e.GetFirstLangId(a,"post_guest_characters")
    local a=e.GetTelopPosition("CAST_MODE",s,a-1)
    local e=e.GetLangIdTable(i)
    TppUiCommand.RegistTelopCast(a,t,n,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function e.PostEnemyCombatants(a)
  if not next(a)then
    return
  end
  local s=e.GetRandomStartSide()
  for a,i in ipairs(a)do
    local n=e.GetFirstLangId(a,"post_Enemy_Combatants")
    local a=e.GetTelopPosition("CAST_MODE",s,a-1)
    local e=e.GetLangIdTable(i)
    TppUiCommand.RegistTelopCast(a,t,n,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function e.PostSpecialMechanics(a)
  if not next(a)then
    return
  end
  local s=e.GetRandomStartSide()
  for a,n in ipairs(a)do
    local i=e.GetFirstLangId(a,"post_special_mechanic")
    local a=e.GetTelopPosition("CAST_MODE",s,a-1)
    local e=e.GetLangIdTable(n)
    TppUiCommand.RegistTelopCast(a,t,i,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function e.PostLevelDesign(a)
  if not next(a)then
    return
  end
  local n=e.GetRandomStartSide()
  local e=e.GetTelopPosition("STAFF_MODE",n,1)
  TppUiCommand.RegistTelopCast(e,t,"post_level_design",a[1],a[2])
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function e.PostWrittenBy(e)
  if not next(e)then
    return
  end
  TppUiCommand.RegistTelopCast("LeftUp",t,"post_wrriten_by",e[1],e[2])
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function e.PostCreativeProducers()
  TppUiCommand.RegistTelopCast("RightUp",t,"post_Creative_Producers","staff_yoshikazu_matsuhana","staff_yuji_korekado")
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function e.PostDirectedBy()
  TppUiCommand.RegistTelopCast("RightCenter",t,"post_Created_and_Directed_by","staff_hideo_kojima")
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function e.PostMissionObjective(a,e)
  if(e>=11e3)and(e<12e3)then
    e=e-1e3
  end
  local t=string.format("obj_mission_%2d_%5d_00",a,e)
  local e=string.format("obj_mission_en_%2d_%5d_00",a,e)
  if AssetConfiguration.GetDefaultCategory"Language"=="jpn"then
    TppUiCommand.RegistTelopCast("CenterLarge",n,t,e)
  else
    TppUiCommand.RegistTelopCast("CenterLarge",n,t)
  end
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function e.Init(e)
  TppUiCommand.AllResetTelopCast()
  mvars.tlp_mainCharacters={"cast_venom_snake","cast_sharashka_ocelot","cast_kazuhira_miller"}
  mvars.tlp_guestCharacters={}
  mvars.tlp_enemyCombatants={}
  mvars.tlp_specialMechanics={}
  mvars.tlp_levelDesigners={"staff_tsuyoshi_osada","staff_satoshi_matsuno"}
  mvars.tlp_writers={"staff_shuyo_murata"}
  if not e.telop then
    return
  end
  local e=e.telop
  mvars.tlp_mainCharacters=e.mainCharacterLangList
  if e.cfaLangList then
    mvars.tlp_cfa=e.cfaLangList
  end
  if e.guestCharacterLangList then
    mvars.tlp_guestCharacters=e.guestCharacterLangList
  end
  if e.enemyCombatantsLangList then
    mvars.tlp_enemyCombatants=e.enemyCombatantsLangList
  end
  if e.specialMechanicLangList then
    mvars.tlp_specialMechanics=e.specialMechanicLangList
  end
  mvars.tlp_levelDesigners=e.missionLevelDesigner
  mvars.tlp_writers=e.missionWriter
end
return e
