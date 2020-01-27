  index1Max=#InfNPCOcelot.ptnBodyIds-- 3

    local hostageObject=GetGameObjectId("hos_quest_0000")
    -- GameObject.SendCommand( hostageObject, { id = "SetHostage2Flag", flag = "commonNpc", on = true, } )


    local faceId=636+index1
    local bodyId=InfNPCOcelot.ptnBodyIds[index1]--334--333
    --GameObject.SendCommand(hostageObject,{id="ChangeFova",faceId=faceId,bodyId=bodyId,})
    GameObject.SendCommand(hostageObject,{id="ChangeFova",bodyId=bodyId})
    InfLog.Add("bodyid:"..bodyId,true)


    GameObject.SendCommand(hostageObject,{id="SetHostage2Flag",flag="unlocked",on=true,})

    --GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "unlocked", on = true, updateModel = true } )
    --  local command = { id="SetHostage2Flag", flag="disableVoice", on=false }
    --GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "disableDamageReaction", on = true, } )
    --local command = { id = "SetHostage2Flag", flag = "silent", on = true }
    --local command = { id="SetHostage2Flag", flag="forceRealize", on=true }

    --          local command={id="SetHostage2Flag",flag="dd",on=true}
    --      GameObject.SendCommand(soldierId,command)
    --    elseif band(fovaUniqueFlag,femaleHostageFlag)~=0 then
    --      local command={id="SetHostage2Flag",flag="female",on=true}
    --      GameObject.SendCommand(soldierId,command)
    --        GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag="demoUnlock", on=false } )
    --  GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag= "disableMarker", on=true } )
    --  local command = { id="SetHostage2Flag", flag="disableVoice", on=false }
    --  local command = { id = "SetHostage2Flag", flag = "disableFulton",  on = true, }
    --local command = { id="SetHostage2Flag", flag="forceNoUseHair", on=true }
    --    local DashCommand   = { id = "SetHostage2Flag", flag = "childDash", on = true, }
    --  local scaredProhibition = { id = "SetHostage2Flag", flag = "disableScared", on = true, }
    --  local ScaredMessage_ON = { id = "SetHostage2Flag", flag = "enableScaredMessage", on = true, }
    --  local CarryNG     = { id = "SetHostage2Flag", flag = "disableUnlock", on = true, }
    --  local command = { id = "SetHostage2Flag", flag = "disableAdjustMoving", on = isDisable }
    --    local questPositions=InfQuest.GetQuestPositions()
    --    InfLog.PrintInspect(questPositions)


function this.PreMissionLoad(missionId,currentMissionId)
  if missionId~=30050 then
    return
  end
  this.mobFovaTable = {
    --  dct_p21_010410_0000 = { bodyId = 348, },
    --  dct_p21_010410_0001 = { bodyId = 349, },
    --  nrs_p21_010360_0000 = { bodyId = 340, },
    --  nrs_p21_010410_0000 = { bodyId = 341, },
    --  nrs_p21_010410_0001 = { bodyId = 342, },
    --  nrs_p21_010410_0002 = { bodyId = 344, },
    ptn_p21_010340_0000 = { bodyId = 333, faceId = 636, },
    ptn_p21_010340_0001 = { bodyId = 334, },
    ptn_p21_010360_0000 = { bodyId = 303, },
    ptn_p21_010370_0000 = { bodyId = 304, },
    ptn_p21_010380_0000 = { bodyId = 307, },
    ptn_p21_010410_0000 = { bodyId = 305, },

    ptn_p21_010410_0001 = { bodyId = 306, },
    ptn_p21_010410_0002 = { bodyId = 318, },
    ptn_p21_010410_0003 = { bodyId = 309, },
    ptn_p21_010410_0004 = { bodyId = 323, },

  --  ptn_p21_010410_0005 = { bodyId = 311, },
  --  ptn_p21_010410_0006 = { bodyId = 312, },
  --  ptn_p21_010410_0007 = { bodyId = 313, },
  --  ptn_p21_010410_0008 = { bodyId = 314, },
  --  ptn_p21_010410_0009 = { bodyId = 315, },
  --  ptn_p21_010410_0010 = { bodyId = 316, },
  --  ptn_p21_010410_0011 = { bodyId = 317, },
  --  ptn_p21_010410_0012 = { bodyId = 326, },
  --  ptn_p21_010420_0000 = { bodyId = 310, },
  --  ptn_p21_010420_0001 = { bodyId = 325, },
  --  ptn_p21_010420_0002 = { bodyId = 308, },
  --  ptn_p21_010420_0003 = { bodyId = 322, },
  --  ptn_p21_010420_0004 = { bodyId = 324, },
  --  ptn_p21_010500_0000 = { bodyId = 319, },
  --  ptn_p21_010500_0001 = { bodyId = 320, },
  --  ptn_p21_010500_0002 = { bodyId = 321, },
  --  ptn_p21_010500_0003 = { bodyId = 327, },
  }

  this.ptnBodyIds={}
  for locator,fovaInfo in pairs(this.mobFovaTable)do
    table.insert(this.ptnBodyIds,fovaInfo.bodyId)
  end

  local count=1
  local allBodies={}

  --tex TODO MB theres some kind of limit on number of bodies set? beyond that the faces start defaulting to balaclava (to the correct gear (gasmask etc) settings too?)

  --InfEneFova.SetupBodies(this.ptnBodyIds,allBodies,count)
  --  TppSoldierFace.OverwriteMissionFovaData{body=allBodies}
  --  TppSoldierFace.SetBodyFovaUserType{hostage={ptnBodyIds[1]}}
  --  TppHostage2.SetDefaultBodyFovaId{parts="/Assets/tpp/parts/chara/ptn/ptn0_main0_def_v00.parts",bodyId=ptnBodyIds[1]}

end

function this.AddMissionPacks(missionCode,packPaths)
  --
  if missionCode==30010 then--
  
--  local locationName=InfUtil.GetLocationName()
--  for i,packpath in ipairs(this.packages[locationName])do
--    packPaths[#packPaths+1]=packpath
--  end
  
--    packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostage_female_afgh.fpk"
--    packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostageuniq_loc.fpk"    

  packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk"
  packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostage_prs6_def.fpk"
  packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostage_loc.fpk"
    
    local settings={
      {type="hostage",name="ih_hostage_0000",faceId="female"},
      {type="hostage",name="ih_hostage_0001",faceId="female"},
      {type="hostage",name="ih_hostage_0002",faceId="female"},
      {type="hostage",name="ih_hostage_0003",faceId="female"},
    }
    TppEneFova.AddUniqueSettingPackage(settings)



  ----------

  --    AFGH_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_afgh_hostage.fpk",
  --  MAFR_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk",
  --  MAFR_HOSTAGE_WOMAN="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
  --    packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_npc_ptn.fpk"
  --    packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/mis_com_mafr_hostage.fpk"

  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/common/mis_com_fob_hostage.fpk"
  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk"
  -- packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk"
  --
  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/mis_com_fob_hostage.fpk"

  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostage_pdd5.fpk"
  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_hostage_pdd5_def.fpk"



  --    --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk"
  --
  --    TppHostage2.SetUniquePartsPath{gameObjectType="TppHostage2",locatorName="hos_quest_0000",parts="/Assets/tpp/parts/chara/ptn/ptn0_main0_def_v00.parts"}

  --packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"
  -- TppHostage2.SetUniquePartsPath{gameObjectType="TppHostage2",locatorName="hos_quest_0000",parts="/Assets/tpp/parts/chara/paz/paz1_main0_def_v00.parts"}