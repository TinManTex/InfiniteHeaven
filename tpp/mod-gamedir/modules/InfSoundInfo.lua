--InfSoundInfo.lua
--the enemy vox soundbanks used are usually defined in the mission fpks, 
--but with IH custom soldier body/InfBodyInfo system need to load others
--what vox language a soldier uses (and other things) is still defined by the EnemyType somewhere in the exe.
--REF EnemyType is set via SendCommand SetSoldier2Type

local this={}

--tex SoundPackage>sdf>vox_ene_common_* sbp loaders
this.soundPacks={
  ene_en="/Assets/tpp/pack/mission2/ih/snd_ene_en.fpk",
  ene_en_fml="/Assets/tpp/pack/mission2/ih/snd_ene_en_fml.fpk",
  ene_ru="/Assets/tpp/pack/mission2/ih/snd_ene_ru.fpk",
  ene_af="/Assets/tpp/pack/mission2/ih/snd_ene_af.fpk",
}--soundPacks

this.langForEnemyType={
  [EnemyType.TYPE_SOVIET]="ene_ru",    
  [EnemyType.TYPE_PF]="ene_af",
  [EnemyType.TYPE_SKULL]="ene_en",  
  --[EnemyType.TYPE_CHILD]=,--DEBUGNOW TODO build pack
  [EnemyType.TYPE_DD]="ene_en",
}--langForEnemyType

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode < 5 then
    return
  end
  
  local maleBodyInfo=InfEneFova.GetMaleBodyInfo(missionCode)
  local femaleBodyInfo=InfEneFova.GetFemaleBodyInfo(missionCode)
  
  --DEBUGNOW see TppEnemy.GetSoldierSubType defaulting to soldierSubType DD_FOB why?
  local function GetSoldierType(bodyInfo)
    return bodyInfo.soldierSubType and InfMainTpp.soldierTypeForSubtypes[bodyInfo.soldierSubType] or "DD_FOB"
  end

  if maleBodyInfo then
    local soldierType=GetSoldierType(maleBodyInfo)
    local lang=this.langForEnemyType[soldierType]
    table.insert(packPaths,this.soundPacks[lang])
  end
  --GOTCHA: only eng female enemy voices
  if femaleBodyInfo then
    local lang="ene_en_fml"
    table.insert(packPaths,this.soundPacks[lang])
  end
end--AddMissionPacks

return this