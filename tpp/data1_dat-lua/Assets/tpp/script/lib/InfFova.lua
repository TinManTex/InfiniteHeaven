-- DOBUILD: 1
--InfFova.lua
local this={}

--tex vars.playerType categorises plparts pack
--corresponding to PlayerType enum
this.playerTypes={
  "SNAKE",--0
  "DD_MALE",--1
  "DD_FEMALE",--2
  "AVATAR",--3
--"LIQUID",--4 In exe, breaks player (invisible, reseting var doesnt fix)
}

--tex vars.playerParts drives which plparts fpk is used
--\chunk0_dat\Assets\tpp\pack\player\parts\plparts*.fpk
--corresponding to PlayerPartsType enum
this.playerPartsTypes={
  --legend: "playerPartsType name",--<enum>, <pl parts file or category>, <notes>
  "NORMAL",--0, PL_REGULAR, uses set camo type
  "NORMAL_SCARF",--1, plparts_normal_scarf, uses set camo type
  "SNEAKING_SUIT",--2, plparts_gz_suit, GZ/MSF, matches PlayerCamoType.SNEAKING_SUIT_GZ (don't know why they didnt keep same name)
  "HOSPITAL",--3, plparts_hospital -- crash on avatar
  "MGS1",--4, plparts_mgs1
  "NINJA",--5, plparts_ninja
  "RAIDEN",--6, plparts_raiden
  "NAKED",--7, plparts_naked, uses set camo type?
  "SNEAKING_SUIT_TPP",--8, PL_SNEAKING
  "BATTLEDRESS",--9
  "PARASITE",--10
  "LEATHER",--11
  "GOLD",--12
  "SILVER",--13
  "AVATAR_EDIT_MAN",--14
  "MGS3",--15
  "MGS3_NAKED",--16 can avatar naked? muddy, normal naked is more sooty?
  "MGS3_SNEAKING",--17
  "MGS3_TUXEDO",--18
  "EVA_CLOSE",--19 fem>
  "EVA_OPEN",--20
  "BOSS_CLOSE",--21
  "BOSS_OPEN",--22<
  --tex following enum names are unknown, currently just named after what appears with vars.playerParts set to the numerical value
  "TIGER_NOHEAD",--? for DD? placeholder? Repeats
  "TIGER_NOHEAD2",--? for DD?
  "SNEAKING_SUIT_GZ2",
  "HOSPITAL2",--
  "MGS12",
  "NINJA2",
  "RAIDEN2",
  "NAKED2",--> no head
  "SNEAKING_SUIT_TPP2",
  "BATTLEDRESS2",--<
  "PARASITE_SUIT2",
  "LEATHER_JACKET2",--the truth leather? has brown glove. no head, no hand
--    35-blank, hang model system
}

--tex table indexed by vars.playerParts/PlayerPartsType enum
--plPartsName doubles for checks to which playertype supports the partstype
this.playerPartsTypesInfo={
  {--0
    name="NORMAL",
    description="Standard fatigues",
    plPartsName={
      SNAKE="plparts_normal",
      AVATAR="plparts_normal",
      DD_MALE="plparts_dd_male",
      DD_FEMALE="plparts_dd_female",
    },
  },-- uses set camo type
  {--1
    name="NORMAL_SCARF",
    description="Fatigues with scarf",
    plPartsName={
      SNAKE="plparts_normal_scarf",
      AVATAR="plparts_normal_scarf",
    }
  },--uses set camo type
  {--2 --GZ/MSF, matches PlayerCamoType.SNEAKING_SUIT_GZ
    name="SNEAKING_SUIT",
    description="SV-Sneaking suit (GZ)",
    plPartsName={
      SNAKE="plparts_gz_suit",
      AVATAR="plparts_gz_suit",
    },
  },
  {--3
    name="HOSPITAL",
    description="Hospital Prolog snake",
    plPartsName={
      SNAKE="plparts_hospital",
    }
  },
  {--4
    name="MGS1",
    description="MGS1 Solid Snake",
    plPartsName={
      ALL="plparts_mgs1",
    },
  },
  {--5
    name="NINJA",
    description="MGS1 Cyborg Ninja",
    plPartsName={
      ALL="plparts_ninja",
    },
  },
  {--6
    name="RAIDEN",
    description="Raiden",
    plPartsName={
      ALL="plparts_raiden",
    },
  },
  {--7
    name="NAKED",
    description="Naked fatigues",
    plPartsName={
      SNAKE="plparts_naked",
      AVATAR="plparts_naked",
    --DD_MALE=--no arm and eyes
    }
  },--uses set camo type?
  {--8
    name="SNEAKING_SUIT_TPP",
    description="Sneaking suit (TPP)",
    plPartsName={
      SNAKE="pl_venom",
      AVATAR="pl_venom",
      DD_MALE="plparts_ddm_venom",
      DD_FEMALE="plparts_ddf_venom",
    },
  },
  {--9
    name="BATTLEDRESS",
    description="Battle dress",
    plPartsName={
      SNAKE="plparts_battledress",
      AVATAR="plparts_battledress",
      DD_MALE="plparts_ddm_battledress",
      DD_FEMALE="plparts_ddf_battledress",
    },
  },
  {--10
    name="PARASITE",
    description="Prasite suit",
    plPartsName={
      SNAKE="plparts_parasite",
      AVATAR="plparts_parasite",
      DD_MALE="plparts_ddm_parasite",
      DD_FEMALE="plparts_ddf_parasite",
    },
  },
  {--11
    name="LEATHER",
    description="Leather jacket",
    plPartsName={
      SNAKE="plparts_leather",
      AVATAR="plparts_leather",
    --DD_MALE=--no arm and eyes
    }
  },
  {--12
    name="GOLD",
    plPartsName={
      SNAKE="plparts_gold",
    --AVATAR= --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
  },
  {--13 when AVATAR, gold body and normal avatar head, neat
    name="SILVER",
    plPartsName={
      SNAKE="plparts_silver",
    --AVATAR= --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
  },
  {--14
    name="AVATAR_EDIT_MAN",
    plPartsName={
      SNAKE="plparts_avatar_man",
    },
  },
  --DLC TODO: find out pack names
  {--15
    name="MGS3",
  --      DD_FEMALE=--invis/hang model syst
  },
  {--16
    name="MGS3_NAKED",
  --      DD_FEMALE=--invis/hang model syst
  },
  {--17
    name="MGS3_SNEAKING",
  --      DD_FEMALE=--invis/hang model syst
  },
  {--18
    name="MGS3_TUXEDO",
  --      DD_FEMALE=--invis/hang model syst
  },
  {--19
    name="EVA_CLOSE",
  --    plPartsName={
  --      DD_MALE=--invis/hang model syst
  --      DD_FEMALE="",
  --    }
  },
  {--20
    name="EVA_OPEN",
  --    plPartsName={
  --      DD_MALE=--invis/hang model syst
  --      DD_FEMALE="",
  --    }
  },
  {--21
    name="BOSS_CLOSE",
  --    plPartsName={
  --      DD_MALE=--invis/hang model syst
  --      DD_FEMALE="",
  --    }
  },
  {--22
    name="BOSS_OPEN",
  --    plPartsName={
  --      DD_MALE=--invis/hang model syst
  --      DD_FEMALE="",
  --    }
  },

  --tex following enum names are unknown, currently just named after what appears with vars.playerParts set to the numerical value
  --23 onward>>
  --appear to be the DD soldier, but most no head even when set to DD_MALE
  --changes depending on playerType
  --SNAKE,AVATAR show male versions (of those models that have them),
  --DD_MALE shows female versions
  --DD_FEMALE crashes game
  --What on earth is the engine doing with these lol.
  --names aren't valid PlayerPartsType

  {--23 does not respond to vars.playerCamoType
    name="NORMAL2",
  },
  {--24 no actual scarf, does not respond to vars.playerCamoType
    name="NORMAL_SCARF2",
  },
  {--25 Shows snakes head reguardless of SNAKE or AVATAR
    name="SNEAKING_SUIT2",
    description="Ground Zeros Big Boss",--tex actual GZ Snake, not Venom in GZ suit
    plPartsName={
      SNAKE="plparts_sneaking_suit",--DEBUGNOW VERIFY
    },
  },
  {--does not crash with AVATAR
    name="HOSPITAL2",
  },--
  {
    name="MGS12",
  },
  {
    name="NINJA2",
  },
  {
    name="RAIDEN2",
  },
  {
    name="NAKED2",
  },
  {
    name="SNEAKING_SUIT_TPP2",
  },
  {
    name="BATTLEDRESS2",
  },--<
  {--dd parasite, no shrapnel bump
    name="PARASITE_SUIT2",
  },
  {--no head, hand when
    name="LEATHER_JACKET2",
  },
--    35> invisible/hang model system
}


--tex vars.playerCamoType drives some fova applications
--\chunk0_dat\Assets\tpp\pack\player\fova\plfova_*.fpk*
--corresponding to PlayerCamoType enum
this.playerCammoTypes={
  "OLIVEDRAB",--0
  "SPLITTER",--1
  "SQUARE",--2
  "TIGERSTRIPE",--3
  "GOLDTIGER",--4
  "FOXTROT",--5
  "WOODLAND",--6
  "WETWORK",--7
  "ARBANGRAY",--8 --OFF----blank/hang model sys on SNAKE,DD_MALE,avatar
  "ARBANBLUE",--9 --OFF
  "SANDSTORM",--10 --OFF--blank/hang model sys
  "REALTREE",--11 --does not set
  "INVISIBLE",--12 --does not set
  "BLACK",--13 --OFF--blank/hang model sys
  "SNEAKING_SUIT_GZ",--14 --avatar
  "SNEAKING_SUIT_TPP",--15
  "BATTLEDRESS",--16
  "PARASITE",--17
  "NAKED",--18 --shows as last set (SNAKE)
  "LEATHER",--19 --avatar
  "SOLIDSNAKE",--20
  "NINJA",--21
  "RAIDEN",--22
  "HOSPITAL",--23
  "GOLD",--24--avatar
  "SILVER",--25 --avatar
  "PANTHER",--26 --shows as last set (SNAKE)
  "AVATAR_EDIT_MAN",--27 --OFF--just part of upper body that fits the zoomed cam, lel
  "MGS3",--28
  "MGS3_NAKED",--29
  "MGS3_SNEAKING",--30
  "MGS3_TUXEDO",--31 --not DD_FEMALE
  "EVA_CLOSE",--32 dd_fem, also works on avatar/snake but they dont have right head lol
  "EVA_OPEN",--33
  "BOSS_CLOSE",--34
  "BOSS_OPEN",--35

  --from 36 shows as last set when snake
  "C23",--36 WOODLAND FLECK
  "C24",--37 AMBUSH
  "C27",--38 ? a muted woodland type
  "C29",--39 DEAD LEAF
  "C30",--40 LICHEN
  "C35",--41 ? some digi camo
  "C38",--42 ? light tan or something
  "C39",--43 OLD ROSE
  "C42",--44 BRICK RED
  "C46",--45 IRON BLUE
  "C49",--46 STEEL GREY
  "C52",--47 TSELINOYARSK
--48 > onward with DD_MALE shows tiger
}

--Camo fovas
--<id> == fova camo id
--00,--drab - also already in plparts_dd_male.fpk
--01,--tiger
--02,--golden tiger
--03,--desert fox
--05,--wetwork
--06,--splitter
--10,--woodland
--12,--square (grey)
--14,--animals (leopard)

--SNAKE/AVATAR NORMAL, NORMAL_SCARF Camo fovas
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_sna0_main1_c<id>.fpk
--fova files="\Assets\tpp\fova\chara\sna\sna0_main1_c<id>.fv2"
--naming matches NORMAL_SCARF

--SNAKE/AVATAR NAKED Camo fovas
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_sna8_main0_c<id>.fpk
--fova files="\Assets\tpp\fova\chara\sna\sna8_main0_c<id>.fv2"

--AVATAR NAKED body fovas -- to match avatar skin color
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_sna8_main0_body0_c<skinId>.fpk
--fova files="\Assets\tpp\fova\chara\sna\sna8_main0_body0_c<skinId>.fv2"

--SNAKE/AVATAR NORMAL_SCARF Camo fovas
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_sna0_main1_c<id>.fpk
--fova files="\Assets\tpp\fova\chara\sna\sna0_main1_c<id>.fv2"

--DD_MALE/DD_FEMALE NORMAL Camo fovas
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_dds<5/6>_main0_ply_v<id>.fpk
--where dds5==dd male, dds6==dd female
-- fova files="/Assets/tpp/fova/chara/sna/dds<5/6>_main0_ply_v<id>.fv2",--drab - also already in plparts_dd_male.fpk

--TODO: where are FOB reward fatigues, still ony hashed/undictionaried I guess


local modelInfoSuffix="_modelInfo"
function this.PrintPlayerBodyVars()
  --  InfMenu.DebugPrint"playerTypes"
  --  for n,name in ipairs(this.playerTypes) do
  --    local enum=PlayerType[name]
  --    InfMenu.DebugPrint(name.."="..tostring(enum))
  --  end

  --  InfMenu.DebugPrint"playerPartsTypes"
  --  for n,name in ipairs(this.playerPartsTypes) do
  --    local enum=PlayerPartsType[name]
  --    InfMenu.DebugPrint(name.."="..tostring(enum))
  --  end

  InfMenu.DebugPrint"playerCammoTypes"
  for n,name in ipairs(this.playerCammoTypes) do
    local enum=PlayerCamoType[name]
    InfMenu.DebugPrint(name.."="..tostring(enum))
  end
end
function this.GetCurrentFovaTable(printInfo)
  local playerTypeName=this.playerTypes[vars.playerType+1]
  if playerTypeName==nil then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable playerTypeName==nil"
    return
  end

  local playerPartsTypeName=this.playerPartsTypes[vars.playerPartsType+1]
  if playerPartsTypeName==nil then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable playerPartsTypeName==nil"
    return
  end

  --InfMenu.DebugPrint(playerTypeName.." "..playerPartsTypeName)--DEBUG

  local playerPartsTypeInfo=this.playerPartsTypesInfo[vars.playerPartsType+1]
  if playerPartsTypeInfo==nil then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable playerPartsTypeInfo==nil"
    return
  end

  if playerPartsTypeInfo.name~=playerPartsTypeName then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable playerPartsTypeInfo.name~=playerPartsTypeName"
    return
  end

  if playerPartsTypeInfo.plPartsName==nil then
    --TODO: warning off till all filled out
    --InfMenu.DebugPrint"WARNING: GetCurrentFovaTable playerPartsTypeInfo.plPartsName==nil"
    return
  end

  local modelDescription=playerPartsTypeInfo.description or playerPartsTypeInfo.name

  local plPartsName=playerPartsTypeInfo.plPartsName.ALL or playerPartsTypeInfo.plPartsName[playerTypeName]
  if plPartsName==nil then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable plPartsName==nil"
    return
  end

  if printInfo then
    InfMenu.DebugPrint("playerType:"..playerTypeName..", playerParts:"..playerPartsTypeName..", plPartName:"..plPartsName)
  end

  local moduleName=plPartsName..modelInfoSuffix
  local modelInfo=_G[moduleName]
  if modelInfo then
  --InfMenu.DebugPrint("modelInfo "..moduleName.." found")--DEBUG
  else
    --InfMenu.DebugPrint("modelInfo "..moduleName.." not found")--DEBUG
    return nil,modelDescription
  end

  local modelInfoDescription=modelInfo.modelDescription
  if modelInfoDescription then
    if type(modelInfoDescription)~="string" then
      InfMenu.DebugPrint("WARNING: GetCurrentFovaTable modelDescription is not a string")
    else
      modelDescription=modelInfoDescription
    end
  end

  local fovaTable=modelInfo.fovaTable
  if fovaTable==nil then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable fovaTable==nil"
    return
  end
  if #fovaTable==0 then
    InfMenu.DebugPrint"WARNING: GetCurrentFovaTable #fovaTable==0"
    return
  end

  local noBlackDiamond=modelInfo.noBlackDiamond

  return fovaTable,modelDescription,noBlackDiamond
end

function this.GetFovaInfo(fovaTable,fovaIndex)
  local currentFovaInfo=fovaTable[fovaIndex]
  if currentFovaInfo==nil then
    InfMenu.DebugPrint"WARNING: GetFovaInfo currentFovaInfo==nil"
    return
  end

  local fovaDescription=currentFovaInfo.fovaDescription

  if fovaDescription then
    if type(fovaDescription)~="string" then
      InfMenu.DebugPrint"WARNING: GetFovaInfo fovaDescription~=string"
      fovaDescription=nil
    end
  end


  local fovaFile=currentFovaInfo.fovaFile
  if fovaFile==nil then
    InfMenu.DebugPrint"WARNING: GetFovaInfo fovaFile==nil"
    return
  end
  if type(fovaFile)~="string" then
    InfMenu.DebugPrint"WARNING: GetFovaInfo fovaFile~=string"
    return
  end

  fovaDescription=fovaDescription or fovaFile

  return fovaDescription,fovaFile
end

function this.FovaInfoChanged(fovaTable,fovaIndex)
  if fovaIndex<1 then
    InfMenu.DebugPrint"WARNING: FovaInfoChanged fovaIndex<1"
    return true
  end

  if fovaIndex>#fovaTable then
    --InfMenu.DebugPrint"FovaInfoChanged fovaIndex>#fovaTable"--DEBUG
    return true
  end

  if Ivars.fovaPlayerType:Get()~=vars.playerType then
    --InfMenu.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end

  if Ivars.fovaPlayerPartsType:Get()~=vars.playerPartsType then
    --InfMenu.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end
end


function this.SetFovaMod(fovaIndex,ignoreChanged)
  --InfMenu.DebugPrint("SetFovaMod fovaIndex="..fovaIndex)--DEBUG

  local fovaTable,fovaDescription,noBlackDiamond=this.GetCurrentFovaTable()
  if fovaTable==nil then
    return
  end

  if not ignoreChanged and this.FovaInfoChanged(fovaTable,fovaIndex) then
    --InfMenu.DebugPrint"SetFovaMod FovaInfoChanged, returning"--DEBUG
    return
  end


  if fovaIndex>#fovaTable then
    InfMenu.DebugPrint"WARNING: SetFovaMod fovaIndex>#fovaTable"
    return
  end

  local fovaDescription,fovaFile=this.GetFovaInfo(fovaTable,fovaIndex)

  --InfMenu.DebugPrint("applyfova "..fovaFile)--DEBUG
  Player.ApplyFormVariationWithFile(fovaFile)

  if Ivars.enableFovaMod:Is(1) then
    Ivars.fovaPlayerType:Set(vars.playerType)
    Ivars.fovaPlayerPartsType:Set(vars.playerPartsType)
  end
end

--CALLER: Ui msg EndSlotSelect
function this.CheckModelChange()
  if Ivars.enableFovaMod:Is(0) then
    return
  end
    local fovaTable=this.GetCurrentFovaTable()
    if fovaTable==nil then
      InfMenu.PrintLangId"disabled_fova"
      Ivars.enableFovaMod:Set(0)
      return
    end

    local fovaIndex=Ivars.fovaSelection:Get()+1
    if this.FovaInfoChanged(fovaTable,fovaIndex) then
      InfMenu.PrintLangId"disabled_fova"
      Ivars.enableFovaMod:Set(0)
      return
    end

    InfFova.SetFovaMod(Ivars.fovaSelection:Get()+1)
end

--CALLER: InfMain.OnFadeInDirect
function this.OnFadeIn()
  if Ivars.enableFovaMod:Is(1) then
    this.SetFovaMod(Ivars.fovaSelection:Get()+1)
  end
end


return this
