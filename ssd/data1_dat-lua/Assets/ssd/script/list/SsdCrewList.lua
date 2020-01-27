local this={}
this.FLAG_MISSION_CREW_LIST={[10010]={locatorName="npc_s10010_0000",id="k40020",life=1e4},[40020]={locatorName="npc_k40020_0000",id="k40130",life=12e3},[40080]={locatorName="npc_k40080_0000",id="k40080",life=3500},[40130]={locatorName="npc_k40130_0000",id="k40180",life=3500},[40180]={locatorName="npc_k40180_0000",id="k40020_2",life=3500},[40220]={locatorName="npc_k40220_0000",id="k40220",life=1e4},[40320]={locatorName="npc_k40320_0000",id="k40320_2",life=6e3}}
function this.GetRescueCrewInfoForFlagMission(_)
  return this.FLAG_MISSION_CREW_LIST[_]
end
this.QUEST_CREW_LIST={field_q33010={locatorName="npc_field_q33010_0000",id="field_q33010",life=2400},field_q33020={locatorName="npc_field_q33020_0000",id="field_q33020",life=6e3},field_q33030={locatorName="npc_field_q33030_0000",id="field_q33030",life=6e3},village_q33040={locatorName="npc_village_q33040_0000",id="village_q33040",life=6e3},village_q33050={locatorName="npc_village_q33050_0000",id="village_q33050",life=9600},village_q33060={locatorName="npc_village_q33060_0000",id="village_q33060",life=3500},village_q33070={locatorName="npc_village_q33070_0000",id="village_q33070",life=9600},village_q33071={locatorName="npc_village_q33071_0000",id="village_q33071",life=9600},factory_q33080={locatorName="npc_factory_q33080_0000",id="factory_q33080",life=3500},factory_q33090={locatorName="npc_factory_q33090_0000",id="factory_q33090",life=3500},factory_q33100={locatorName="npc_factory_q33100_0000",id="factory_q33100",life=9600},factory_q33220={locatorName="npc_factory_q33220_0000",id="factory_q33220",life=6e3},factory_q33230={locatorName="npc_factory_q33230_0000",id="factory_q33230",life=6e3},factory_q33240={locatorName="npc_factory_q33240_0000",id="factory_q33240",life=9600},factory_q33250={locatorName="npc_factory_q33250_0000",id="factory_q33250",life=18e3},diamond_q33260={locatorName="npc_diamond_q33260_0000",id="diamond_q33260",life=6e3},diamond_q33270={locatorName="npc_diamond_q33270_0000",id="diamond_q33270",life=6e3},lab_q33280={locatorName="npc_lab_q33280_0000",id="lab_q33280",life=18e3},lab_q33290={locatorName="npc_lab_q33290_0000",id="lab_q33290",life=18e3},lab_q33300={locatorName="npc_lab_q33300_0000",id="lab_q33300",life=18e3}}
function this.GetRescueCrewInfoForQuest(_)
  return this.QUEST_CREW_LIST[_]
end
this.FORCE_BASE_CAMP_CREW_LIST={[10035]={TppDefine.CREW_TYPE.UNIQUE_MLT,TppDefine.CREW_TYPE.UNIQUE_BOY},[10060]={},[30020]=function(e)
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST then
    return{}
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARED_s10050 then
    return nil
  end
  local e={}
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.BEFORE_s10050 then
    table.insert(e,TppDefine.CREW_TYPE.UNIQUE_MLT)
    table.insert(e,TppDefine.CREW_TYPE.UNIQUE_BOY)
  end
  table.insert(e,TppDefine.CREW_TYPE.UNIQUE_NRS)
  table.insert(e,TppDefine.CREW_TYPE.UNIQUE_PLC)
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40180 and gvars.str_storySequence<TppDefine.STORY_SEQUENCE.BEFORE_s10050 then
    table.insert(e,TppDefine.CREW_TYPE.UNIQUE_SETH)
  end
  return e
end}
function this.GetForceBaseCampCrewList(a)
  local _=this.FORCE_BASE_CAMP_CREW_LIST[a]
  if Tpp.IsTypeFunc(_)then
    return _(a)
  else
    return _
  end
end
this.ROLE_INFO={[CrewRole.REEVE_10010]={},[CrewRole.REEVE_INJURY]={position={-452,288,2248},rotY=180},[CrewRole.BOY_NO_CHAIR]={position={-450.9,287.297,2248.3},rotY=180}}Crew.SetRoleInfo(this.ROLE_INFO)
return this
