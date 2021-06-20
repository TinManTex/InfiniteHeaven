--InfSoundInfo.lua
--the enemy vox soundbanks used are usually defined in the mission fpks, 
--but with IH custom soldier body/InfBodyInfo system need to load others
--what vox language a soldier uses (and other things) is still defined by the EnemyType somewhere in the exe.
--REF EnemyType is set via SendCommand SetSoldier2Type

local this={}

--tex SoundPackage>sdf>vox_ene_common_* sbp loaders
--the vox_ene_common* soundbanks include both soldier and CP vox for the respective language
this.soundPacks={
  ene_en="/Assets/tpp/pack/mission2/ih/snd_ene_en.fpk",--vox_ene_common.sbp
  ene_en_fml="/Assets/tpp/pack/mission2/ih/snd_ene_en_fml.fpk",--vox_ene_common_fml.sbp
  ene_ru="/Assets/tpp/pack/mission2/ih/snd_ene_ru.fpk",--vox_ene_common_ru.sbp
  ene_af="/Assets/tpp/pack/mission2/ih/snd_ene_af.fpk",--vox_ene_common_af.sbp
}--soundPacks

this.langForEnemyType={
  [EnemyType.TYPE_SOVIET]="ene_ru",    
  [EnemyType.TYPE_PF]="ene_af",
  [EnemyType.TYPE_SKULL]="ene_en",  
  --[EnemyType.TYPE_CHILD]=,--TODO build pack
  [EnemyType.TYPE_DD]="ene_en",
}--langForEnemyType

this.langForCpType={    
  [CpType.TYPE_SOVIET]="ene_ru",   
  [CpType.TYPE_AMERICA]="ene_en",
  [CpType.TYPE_AFRIKAANS]="ene_af",
}--langForCpType

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode < 5 then
    return
  end
  
  local maleBodyInfo=InfEneFova.GetMaleBodyInfo(missionCode)
  local femaleBodyInfo=InfEneFova.GetFemaleBodyInfo(missionCode)
  
  if maleBodyInfo then
    local soldierSubType=maleBodyInfo.soldierSubType and maleBodyInfo.soldierSubType or "DD_FOB" --TODO see TppEnemy.GetSoldierSubType defaulting to soldierSubType DD_FOB why?
    local soldierType=InfMainTpp.soldierTypeForSubtypes[soldierSubType]
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