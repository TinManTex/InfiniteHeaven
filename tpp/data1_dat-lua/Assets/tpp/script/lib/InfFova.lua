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

this.playerTypesInfo={
  {
    name="SNAKE",
    description="Snake",
    playerType=0,
  },
  {
    name="DD_MALE",
    description="DD Male",
    playerType=1,
  },
  {
    name="DD_FEMALE",
    description="DD Female",
    playerType=2,
  },
  {
    name="AVATAR",
    description="Avatar",
    playerType=3,
  },
}

this.playerTypeGroup={
  VENOM={
    [PlayerType.SNAKE]=true,
    [PlayerType.AVATAR]=true,
  },
  DD={
    [PlayerType.DD_MALE]=true,
    [PlayerType.DD_FEMALE]=true,
  },
}

--tex vars.playerParts drives which plparts fpk is used
--\chunk0_dat\Assets\tpp\pack\player\parts\plparts*.fpk
--corresponding to PlayerPartsType enum
this.playerPartsTypes={
  "NORMAL",--0,
  "NORMAL_SCARF",--1,
  "SNEAKING_SUIT",--2,
  "HOSPITAL",--3,
  "MGS1",--4,
  "NINJA",--5,
  "RAIDEN",--6,
  "NAKED",--7,
  "SNEAKING_SUIT_TPP",--8,
  "BATTLEDRESS",--9
  "PARASITE",--10
  "LEATHER",--11
  "GOLD",--12
  "SILVER",--13
  "AVATAR_EDIT_MAN",--14
  "MGS3",--15
  "MGS3_NAKED",--16
  "MGS3_SNEAKING",--17
  "MGS3_TUXEDO",--18
  "EVA_CLOSE",--19
  "EVA_OPEN",--20
  "BOSS_CLOSE",--21
  "BOSS_OPEN",--22
  "SWIMWEAR",--23
  --tex unknown, see playerPartsTypesInfo, own names
  "NORMAL2",--24
  "NORMAL_SCARF2",--25
  "SNEAKING_SUIT_BB",--26
  "HOSPITAL2",--27
  "MGS12",--27
  "NINJA2",--28
  "RAIDEN2",--29
  "NAKED2",--30
  "SNEAKING_SUIT_TPP2",--31
  "BATTLEDRESS2",--32
  "PARASITE_SUIT2",--33
  "LEATHER_JACKET2",--34
--    35-blank, hang model system
}

--tex replacing engines PlayerPartsType since > 23 not covered
this.PlayerPartsType={}
--tex cant Tpp.Enum since thats indexed from 1
for i,name in ipairs(this.playerPartsTypes) do
  this.PlayerPartsType[name]=i-1
end

--tex table indexed by vars.playerParts/PlayerPartsType enum
--plPartsName doubles for checks to which playertype supports the partstype
--if no camoTypes then try PlayerCamoType[name]

--dlc plparts TODO: which is what?
--plparts_dla0_main0_def_v00
--plparts_dla0_plym0_def_v00
--plparts_dla1_main0_def_v00
--plparts_dla1_plym0_def_v00
--plparts_dlb0_main0_def_v00
--plparts_dlb0_plym0_def_v00
--plparts_dlc0_plyf0_def_v00
--plparts_dlc1_plyf0_def_v00
--plparts_dld0_main0_def_v00
--plparts_dld0_plym0_def_v00
--plparts_dle0_plyf0_def_v00
--plparts_dle1_plyf0_def_v00

this.playerPartsTypesInfo={
  {--0 -- uses set camo type
    name="NORMAL",
    description="Standard fatigues",
    playerParts=0,
    --developId=--Common
    plPartsName={
      SNAKE="plparts_normal",
      AVATAR="plparts_normal",
      DD_MALE="plparts_dd_male",
      DD_FEMALE="plparts_dd_female",
    },
    camoTypes={
      COMMON=true,
    },
  },
  {--1--uses set camo type
    name="NORMAL_SCARF",
    description="Fatigues with scarf",
    playerParts=1,
    --developId=--Common
    plPartsName={
      SNAKE="plparts_normal_scarf",
      AVATAR="plparts_normal_scarf",
    },
    camoTypes={
      COMMON=true,
    },
  },
  {--2,--gz unlock, --GZ/MSF, matches PlayerCamoType.SNEAKING_SUIT_GZ
    name="SNEAKING_SUIT",
    description="SV-Sneaking suit (GZ)",
    playerParts=2,
    developId=19040,
    plPartsName={
      SNAKE="plparts_gz_suit",
      AVATAR="plparts_gz_suit",
    },
    camoTypes={
      "SNEAKING_SUIT_GZ",
    }
  },
  {--3-- crash on avatar
    name="HOSPITAL",
    description="Hospital Prolog snake",
    playerParts=3,
    plPartsName={
      SNAKE="plparts_hospital",
    },
  },
  {--4,--gz unlock
    name="MGS1",
    description="MGS1 Solid Snake",
    playerParts=4,
    developId=19071,
    plPartsName={
      ALL="plparts_mgs1",
    },
    camoTypes={
      "SOLIDSNAKE",
    }
  },
  {--5,--unlock
    name="NINJA",
    description="MGS1 Cyborg Ninja",
    playerParts=5,
    developId=19071,
    plPartsName={
      ALL="plparts_ninja",
    },
  },
  {--6
    name="RAIDEN",
    description="Raiden",
    playerParts=6,
    developId=19073,
    plPartsName={
      ALL="plparts_raiden",
    },
  },
  {--7--uses set camo type?
    name="NAKED",
    description="Naked fatigues",
    playerParts=7,
    --developId=--Common
    plPartsName={
      SNAKE="plparts_naked",
      AVATAR="plparts_naked",
    --DD_MALE=--no arm and eyes
    },
    camoTypes={
      COMMON=true,
    },
  },
  {--8
    name="SNEAKING_SUIT_TPP",
    description="Sneaking suit (TPP)",
    playerParts=8,
    developId=19050,
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
    playerParts=9,
    developId=19053,
    plPartsName={
      SNAKE="plparts_battledress",
      AVATAR="plparts_battledress",
      DD_MALE="plparts_ddm_battledress",
      DD_FEMALE="plparts_ddf_battledress",
    },
  },
  {--10
    name="PARASITE",
    description="Parasite suit",
    playerParts=10,
    developId=19060,
    plPartsName={
      SNAKE="plparts_parasite",
      AVATAR="plparts_parasite",
      DD_MALE="plparts_ddm_parasite",
      DD_FEMALE="plparts_ddf_parasite",
    },
  },
  {--11,--unlock
    name="LEATHER",
    description="Leather jacket",
    playerParts=11,
    developId=19070,
    plPartsName={
      SNAKE="plparts_leather",
      AVATAR="plparts_leather",
    --DD_MALE=--no arm and eyes
    }
  },
  {--12,--unlock
    name="GOLD",
    description="Naked Gold",
    playerParts=12,
    developId=19024,
    plPartsName={
      SNAKE="plparts_gold",
    --AVATAR= --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
  },
  {--13,--unlock, when AVATAR, gold body and normal avatar head, neat
    name="SILVER",
    description="Naked Silver",
    playerParts=13,
    developId=19023,
    plPartsName={
      SNAKE="plparts_silver",
    --AVATAR= --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
  },
  {--14
    name="AVATAR_EDIT_MAN",
    playerParts=14,
    plPartsName={
      SNAKE="plparts_avatar_man",
    },
  },
  --DLC TODO: find out pack names, find a have-this check
  {--15
    name="MGS3",
    description="Fatigues (NS)",
    playerParts=15,
    developId=19080,
    plPartsName={
      SNAKE="UNKNOWN",--TODO:
      AVATAR="UNKNOWN",
      DD_MALE="UNKNOWN",
    },
  },
  {--16
    name="MGS3_NAKED",
    description="Fatigues Naked (NS)",
    playerParts=16,
    developId=19080,--tex as above
    plPartsName={
      SNAKE="UNKNOWN",--TODO:
      AVATAR="UNKNOWN",
      DD_MALE="UNKNOWN",
    },
  },
  {--17
    name="MGS3_SNEAKING",
    description="Sneaking Suit (NS)",
    playerParts=17,
    developId=19081,
    plPartsName={
      SNAKE="UNKNOWN",--TODO:
      AVATAR="UNKNOWN",
      DD_MALE="UNKNOWN",
    },
  },
  {--18
    name="MGS3_TUXEDO",
    description="Tuxedo",
    playerParts=18,
    developId=19084,
    plPartsName={
      SNAKE="UNKNOWN",--TODO:
      AVATAR="UNKNOWN",
      DD_MALE="UNKNOWN",
    },
  },
  {--19
    name="EVA_CLOSE",
    description="Jumpsuit (EVA)",
    playerParts=19,
    developId=19086,
    plPartsName={
      DD_FEMALE="UNKNOWN",--TODO:
    },
  },
  {--20
    name="EVA_OPEN",
    description="Jumpsuit open (EVA)",
    playerParts=20,
    developId=19086,--tex as above
    plPartsName={
      DD_FEMALE="UNKNOWN",--TODO:
    },
  },
  {--21
    name="BOSS_CLOSE",
    description="Sneaking Suit (TB)",
    playerParts=21,
    developId=19085,
    plPartsName={
      DD_FEMALE="UNKNOWN",--TODO:
    },
  },
  {--22
    name="BOSS_OPEN",
    description="Sneaking Suit open (TB)",
    playerParts=22,
    developId=19085,--tex as above
    plPartsName={
      DD_FEMALE="UNKNOWN",--TODO:
    },
  },
  {--23
    name="SWIMWEAR",
    description="Swimsuit",
    playerParts=23,
    --developId=,--Common, kinda, requires at least one type to show up, but unless I want to iterate through the the developids of all the camos just leave it
    plPartsName={
      DD_MALE="plparts_ddm_swimwear",
      DD_FEMALE="plparts_ddf_swimwear",
    },
    camoTypes={
      "SWIMWEAR_C00",--79,
      "SWIMWEAR_C01",--80,
      "SWIMWEAR_C02",--81,
      "SWIMWEAR_C03",--82,
      "SWIMWEAR_C05",--83,
      "SWIMWEAR_C06",--84,
      "SWIMWEAR_C38",--85,
      "SWIMWEAR_C39",--86,
      "SWIMWEAR_C44",--87,
      "SWIMWEAR_C46",--88,
      "SWIMWEAR_C48",--89,
      "SWIMWEAR_C53",--90,
    },
  },
  --tex following enum names are unknown, currently just named after what appears with vars.playerParts set to the numerical value
  --24 onward>>
  --appear to be the DD soldier, but most no head even when set to DD_MALE
  --changes depending on playerType
  --SNAKE,AVATAR show male versions (of those models that have them),
  --DD_MALE shows female versions
  --DD_FEMALE crashes game
  --What on earth is the engine doing with these lol.
  --names aren't valid PlayerPartsType
  {--24 no actual scarf, does not respond to vars.playerCamoType
    name="NORMAL2",
  },
  {--25 no actual scarf, does not respond to vars.playerCamoType
    name="NORMAL_SCARF2",
  },
  {--26 Shows snakes head reguardless of SNAKE or AVATAR
    name="SNEAKING_SUIT_BB",--tex own name
    description="Big Boss SV-Sneaking suit",--tex actual GZ Snake, not Venom in GZ suit
    playerParts=26,
    plPartsName={
      SNAKE="plparts_sneaking_suit",
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
  },
  {--dd parasite, no shrapnel bump
    name="PARASITE_SUIT2",
  },
  {--no head, hand when
    name="LEATHER_JACKET2",
  },
--    35> invisible/hang model system
}

--tex currently reference only
--info on plparts fpk / model id
--searching for first section of modelid (ex sna1) will get more hits
this.plPartsInfo={
  plparts_avatar_man={modelId="avm0_body0"},--tex for avatar cusomization
  plparts_dd_female={modelId="dds6_main0"},
  plparts_dd_male={modelId="dds5_main0"},
  plparts_ninja={modelId="nin0_main0"},
  plparts_raiden={modelId="rai0_main0"},
  plparts_normal={modelId="sna0_main0"},
  plparts_normal_scarf={modelId="sna0_main1"},
  plparts_hospital={modelId="sna1_main0"},
  plparts_sneaking_suit={modelId="sna2_main0"},
  plparts_gz_suit={modelId="sna2_main1"},
  plparts_leather={modelId="sna3_main1"},
  plparts_venom={modelId="sna4_main0"},
  plparts_ddf_venom={modelId="sna4_plyf0"},
  plparts_ddm_venom={modelId="sna4_plym0"},
  plparts_battledress={modelId="sna5_main0"},
  plparts_ddf_battledress={modelId="sna5_plyf0"},
  plparts_ddm_battledress={modelId="sna5_plym0"},
  plparts_mgs1={modelId="sna6_main0"},
  plparts_parasite={modelId="sna7_main0"},
  plparts_ddf_parasite={modelId="sna7_plyf0"},
  plparts_ddm_parasite={modelId="sna7_plym0"},
  plparts_naked={modelId="sna8_plym0"},
  plparts_gold={modelId="sna9_plym0"},
  plparts_silver={modelId="sna9_plym1"},
  plparts_ddf_swimwear={modelId="dlf0_main0"},--tex the fmdl for this breaks the naming convention of <modelid>_def (of all others in this table) and is named dlf0_main0_def_f.fmdl
  plparts_ddm_swimwear={modelId="dlf1_main0"},
  plparts_dla0_main0_def_v00={modelId="dla0_main0"},
  plparts_dla0_plym0_def_v00={modelId="dla0_plym0"},
  plparts_dla1_main0_def_v00={modelId="dla1_main0"},
  plparts_dla1_plym0_def_v00={modelId="dla1_plym0"},
  plparts_dlb0_main0_def_v00={modelId="dlb0_main0"},
  plparts_dlb0_plym0_def_v00={modelId="dlb0_plym0"},
  plparts_dlc0_plyf0_def_v00={modelId="dlc0_plyf0"},
  plparts_dlc1_plyf0_def_v00={modelId="dlc1_plyf0"},
  plparts_dld0_main0_def_v00={modelId="dld0_main0"},
  plparts_dld0_plym0_def_v00={modelId="dld0_plym0"},
  plparts_dle0_plyf0_def_v00={modelId="dle0_plyf0"},
  plparts_dle1_plyf0_def_v00={modelId="dle1_plyf0"},
}

--tex TODO: build reverse lookup table if nessesary


--tex vars.playerCamoType drives some fova applications
--\chunk0_dat\Assets\tpp\pack\player\fova\plfova_*.fpk*
--corresponding to PlayerCamoType enum
--TODO where is animals/leopard camo?
this.playerCamoTypes={
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

  --from 36 shows as last set when snake if not set to a playerPartType that supports it
  "C23",--36,WOODLAND FLECK
  "C24",--37,AMBUSH
  "C27",--38,SOLUM
  "C29",--39,DEAD LEAF
  "C30",--40,LICHEN
  "C35",--41,STONE
  "C38",--42,PARASITE MIST
  "C39",--43,OLD ROSE
  "C42",--44,BRICK RED
  "C46",--45,IRON BLUE
  "C49",--46,STEEL GREY
  "C52",--47,TSELINOYARSK
  "C16",--48,NIGHT SPLITTER
  "C17",--49,RAIN
  "C18",--50,GREEN TIGER STRIPE
  "C19",--51,BIRCH LEAF
  "C20",--52,DESERT AMBUSH
  "C22",--53,DARK LEAF FLECK
  "C25",--54,NIGHT BUSH
  "C26",--55,GRASS
  "C28",--56,RIPPLE
  "C31",--57,CITRULLUS
  "C32",--58,DIGITAL BUSH
  "C33",--59,ZEBRA
  "C36",--60,DESERT SAND
  "C37",--61,STEEL KHAKI
  "C40",--62,DARK RUBBER
  "C41",--63,GRAY
  "C43",--64,CAMOFLAGE YELLOW
  "C44",--65,CAMOFLAGE GREEN
  "C45",--66,IRON GREEN
  "C47",--67,LIGHT RUBBER
  "C48",--68,RED RUST
  "C50",--69,STEEL GREEN
  "C51",--70,STEEL ORANGE
  "C53",--71,MUD
  "C54",--72,STEEL BLUE
  "C55",--73,DARK RUST
  "C56",--74,CITRULLUS TWO-TONE
  "C57",--75,GOLD TIGER STRIPE TWO-TONE
  "C58",--76,BIRCH LEAF TWO-TONE
  "C59",--77,STONE TWO-TONE
  "C60",--78,KHAKI URBAN TWO-TONE

  "SWIMWEAR_C00",--79,OLIVEDRAB
  "SWIMWEAR_C01",--80,TIGERSTRIPE
  "SWIMWEAR_C02",--81,GOLDTIGER
  "SWIMWEAR_C03",--82,DESERTFOX
  "SWIMWEAR_C05",--83,WETWORK
  "SWIMWEAR_C06",--84,SPLITTER
  "SWIMWEAR_C38",--85,PARASITE MIST
  "SWIMWEAR_C39",--86,OLD ROSE
  "SWIMWEAR_C44",--87,CAMOFLAGE GREEN
  "SWIMWEAR_C46",--88,IRON BLUE
  "SWIMWEAR_C48",--89,RED RUST
  "SWIMWEAR_C53",--90,MUD
}

--tex camos that apply to partsType NORMAL,NORMAL_SCARF,NAKED
this.playerCamoTypesCommon={
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
  --  "REALTREE",--11 --does not set
  --  "INVISIBLE",--12 --does not set
  "BLACK",--13 --OFF--blank/hang model sys
  --
  "C23",--36,WOODLAND FLECK
  "C24",--37,AMBUSH
  "C27",--38,SOLUM
  "C29",--39,DEAD LEAF
  "C30",--40,LICHEN
  "C35",--41,STONE
  "C38",--42,PARASITE MIST
  "C39",--43,OLD ROSE
  "C42",--44,BRICK RED
  "C46",--45,IRON BLUE
  "C49",--46,STEEL GREY
  "C52",--47,TSELINOYARSK

  "C16",--48,NIGHT SPLITTER
  "C17",--49,RAIN
  "C18",--50,GREEN TIGER STRIPE
  "C19",--51,BIRCH LEAF
  "C20",--52,DESERT AMBUSH
  "C22",--53,DARK LEAF FLECK
  "C25",--54,NIGHT BUSH
  "C26",--55,GRASS
  "C28",--56,RIPPLE
  "C31",--57,CITRULLUS
  "C32",--58,DIGITAL BUSH
  "C33",--59,ZEBRA
  "C36",--60,DESERT SAND
  "C37",--61,STEEL KHAKI
  "C40",--62,DARK RUBBER
  "C41",--63,GRAY
  "C43",--64,CAMOFLAGE YELLOW
  "C44",--65,CAMOFLAGE GREEN
  "C45",--66,IRON GREEN
  "C47",--67,LIGHT RUBBER
  "C48",--68,RED RUST
  "C50",--69,STEEL GREEN
  "C51",--70,STEEL ORANGE
  "C53",--71,MUD
  "C54",--72,STEEL BLUE
  "C55",--73,DARK RUST
  "C56",--74,CITRULLUS TWO-TONE
  "C57",--75,GOLD TIGER STRIPE TWO-TONE
  "C58",--76,BIRCH LEAF TWO-TONE
  "C59",--77,STONE TWO-TONE
  "C60",--78,KHAKI URBAN TWO-TONE
}

--tex ASSUMPTION currently if no playerTypes assume all
--see 'Camo fovas' below for explanation of fovaCamoId
this.playerCamoTypesInfo={
  {
    name="OLIVEDRAB",
    description="Olive Drab",
    playerCamoType=0,
    developId=19001,
    fovaCamoId=00,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="SPLITTER",
    description="Splitter",
    playerCamoType=1,
    developId=19002,
    fovaId=06,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="SQUARE",
    description="Square",
    playerCamoType=2,
    developId=19003,
    fovaCamoId=12,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="TIGERSTRIPE",
    description="Tiger Stripe",
    playerCamoType=3,
    developId=19010,
    fovaCamoId=01,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="GOLDTIGER",
    description="Gold Tiger",
    playerCamoType=4,
    developId=19011,
    fovaCamoId=02,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="FOXTROT",
    description="Desert Fox",
    playerCamoType=5,
    developId=19020,
    fovaCamoId=03,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="WOODLAND",
    description="Woodland",
    playerCamoType=6,
    developId=19021,
    fovaCamoId=10,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="WETWORK",
    description="Wetwork",
    playerCamoType=7,
    developId=19022,
    fovaCamoId=05,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  --Console special edition
  {
    name="ARBANGRAY",
    description="Gray Urban",
    playerCamoType=8,
    developId=19030,
    fovaCamoId=08,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="ARBANBLUE",
    description="Blue Urban",
    playerCamoType=9,
    developId=19031,
    fovaCamoId=07,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="SANDSTORM",
    description="APD (Pixelated Desert)",
    playerCamoType=10,
    developId=19032,
    fovaCamoId=11,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="REALTREE", --OFF --does not set
    playerCamoType=11,
  --    playerParts={
  --      NORMAL=true,
  --      NORMAL_SCARF=true,
  --      NAKED=true,
  --    },
  },
  {
    name="INVISIBLE", --OFF --does not set
    playerCamoType=12,
  --    playerParts={
  --      NORMAL=true,
  --      NORMAL_SCARF=true,
  --      NAKED=true,
  --    },
  },
  {
    name="BLACK",
    description="Black Ocelot",
    playerCamoType=13,
    developId=19033,
    fovaCamoId=13,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  --
  {
    name="SNEAKING_SUIT_GZ",
    description="SV-Sneaking suit (GZ)",
    playerCamoType=14,
    developId=19040,
    playerParts={
      SNEAKING_SUIT=true,
    },
    playerTypes={
      SNAKE=true,
      AVATAR=true,
    }
  },
  {
    name="SNEAKING_SUIT_TPP",
    description="Sneaking suit (TPP)",
    playerCamoType=15,
    developId=19050,
    playerParts={
      SNEAKING_SUIT_TPP=true,
    },
    playerTypes={
      SNAKE=true,
      AVATAR=true,
    }
  },
  {
    name="BATTLEDRESS",
    desciprion="Battle Dress",
    playerCamoType=16,
    developId=19053,
    playerParts={
      BATTLEDRESS=true,
    },
  },
  {
    name="PARASITE",
    description="Parasite Suit",
    playerCamoType=17,
    developId=19060,
    playerParts={
      PARASITE=true,
    },
  },
  {
    name="NAKED",
    description="Naked",
    playerCamoType=18,
    --developId=,--
    playerParts={
      SNAKE=true,
      AVATAR=true,
    },
  },
  {
    name="LEATHER",
    description="Leather Jacket",
    playerCamoType=19,
    developId=19070,
    playerParts={
      SNEAKING_SUIT_TPP=true,
    },
    playerTypes={
      SNAKE=true,
      AVATAR=true,
    }
  },
  {
    name="SOLIDSNAKE",
    description="MGS1 Solid Snake",
    playerCamoType=20,
    developId=19071,
    playerParts={
      MGS1=true,
    },
  },
  {
    name="NINJA",
    description="MGS1 Cyborg Ninja",
    playerCamoType=21,
    developId=19072,
    playerParts={
      NINJA=true,
    },
  },
  {
    name="RAIDEN",
    description="Raiden",
    playerCamoType=22,
    developId=19073,
    playerParts={
      RAIDEN=true,
    },
  },
  {
    name="HOSPITAL",
    description="Hospital V",
    playerCamoType=23,
    playerParts={
      HOSPITAL=true,
    },
  },
  {
    name="GOLD",
    playerCamoType=24,
    developId=19024,
    playerParts={
      GOLD=true,
    },
    playerTypes={
      SNAKE=true,
    --AVATAR=true,
    }
  },
  {
    name="SILVER",
    playerCamoType=25,
    developId=19023,
    playerParts={
      SILVER=true,
    },
    playerTypes={
      SNAKE=true,
    --AVATAR=true,
    }
  },
  {
    name="PANTHER",--shows as last set (SNAKE)
    playerCamoType=26,
  },
  {
    name="AVATAR_EDIT_MAN",--OFF--just part of upper body that fits the zoomed cam, lel
    playerCamoType=27,
  },
  {
    name="MGS3",
    description="Fatigues (NS)",
    playerCamoType=28,
    developId=19080,
    playerTypes={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
    },
  },
  {
    name="MGS3_NAKED",
    description="Fatigues Naked (NS)",
    playerCamoType=29,
    developId=19080,--tex as above
    playerTypes={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
    },
  },
  {
    name="MGS3_SNEAKING",
    description="Sneaking Suit (NS)",
    playerCamoType=30,
    developId=19081,
    playerTypes={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
    },
  },
  {
    name="MGS3_TUXEDO",
    description="Tuxedo",
    playerCamoType=31,
    developId=19084,
    playerTypes={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
    },
  },
  {
    name="EVA_CLOSE",-- dd_fem, also works on avatar/snake but they dont have right head lol
    description="Jumpsuit (EVA)",
    playerCamoType=32,
    developId=19086,
    playerTypes={
      DD_FEMALE=true,
    },
  },
  {
    name="EVA_OPEN",
    description="Jumpsuit open (EVA)",
    playerCamoType=33,
    developId=19086,--tex as above
    playerTypes={
      DD_FEMALE=true,
    },
  },
  {
    name="BOSS_CLOSE",
    description="Sneaking Suit (TB)",
    playerCamoType=34,
    developId=19085,
    playerTypes={
      DD_FEMALE=true,
    },
  },
  {
    name="BOSS_OPEN",
    description="Sneaking Suit open (TB)",
    playerCamoType=35,
    developId=19085,--tex as above
    playerTypes={
      DD_FEMALE=true,
    },
  },
  --from 36 shows as last set when snake
  {
    name="C23",
    description="Woodland Fleck",
    developId=19090,
    playerCamoType=36,
    fovaCamoId=23,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C24",
    description="Ambush",
    developId=19091,
    playerCamoType=37,
    fovaCamoId=24,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C27",
    description="Solum",
    developId=19092,
    playerCamoType=38,
    fovaCamoId=27,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C29",
    description="Dead Leaf",
    developId=19093,
    playerCamoType=39,
    fovaCamoId=29,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C30",
    description="Lichen",
    developId=19094,
    playerCamoType=40,
    fovaCamoId=30,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C35",
    description="Stone",
    developId=19095,
    playerCamoType=41,
    fovaCamoId=35,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C38",
    description="Parasite Mist",
    developId=19096,
    playerCamoType=42,
    fovaCamoId=38,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C39",
    description="Old Rose",
    developId=19097,
    playerCamoType=43,
    fovaCamoId=39,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C42",
    description="Brick Red",
    developId=19098,
    playerCamoType=44,
    fovaCamoId=42,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C46",
    description="Iron Blue",
    developId=19099,
    playerCamoType=45,
    fovaCamoId=46,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C49",
    description="Steel Grey",
    developId=19100,
    playerCamoType=46,
    fovaCamoId=49,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C52",
    description="Tselinoyarsk",
    developId=19101,
    playerCamoType=47,
    fovaCamoId=52,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  -------------
  {
    name="C16",
    description="Night Splitter",
    developId=19120,
    playerCamoType=48,
    fovaCamoId=16,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C17",
    description="Rain",
    developId=19121,
    playerCamoType=49,
    fovaCamoId=17,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C18",
    description="Green Tiger Stripe",
    developId=19122,
    playerCamoType=50,
    fovaCamoId=18,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C19",
    description="Birch Leaf",
    developId=19123,
    playerCamoType=51,
    fovaCamoId=19,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C20",
    description="Desert Ambush",
    developId=19124,
    playerCamoType=52,
    fovaCamoId=20,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C22",
    description="Dark Leaf Fleck",
    developId=19125,
    playerCamoType=53,
    fovaCamoId=22,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C25",
    description="Night Bush",
    developId=19126,
    playerCamoType=54,
    fovaCamoId=25,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C26",
    description="Grass",
    developId=19127,
    playerCamoType=55,
    fovaCamoId=26,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C28",
    description="Ripple",
    developId=19128,
    playerCamoType=56,
    fovaCamoId=28,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C31",
    description="Citrullus",
    developId=19129,
    playerCamoType=57,
    fovaCamoId=31,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C32",
    description="Digital Bush",
    developId=19130,
    playerCamoType=58,
    fovaCamoId=32,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C33",
    description="Zebra",
    developId=19131,
    playerCamoType=59,
    fovaCamoId=33,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C36",
    description="Desert Sand",
    developId=19132,
    playerCamoType=60,
    fovaCamoId=36,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C37",
    description="Steel Khaki",
    developId=19133,
    playerCamoType=61,
    fovaCamoId=37,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C40",
    description="Dark Rubber",
    developId=19134,
    playerCamoType=62,
    fovaCamoId=40,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C41",
    description="Gray",
    developId=19135,
    playerCamoType=63,
    fovaCamoId=41,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C43",
    description="Camoflage Yellow",
    developId=19136,
    playerCamoType=64,
    fovaCamoId=43,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C44",
    description="Camoflage Green",
    developId=19137,
    playerCamoType=65,
    fovaCamoId=44,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C45",
    description="Iron Green",
    developId=19138,
    playerCamoType=66,
    fovaCamoId=45,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C47",
    description="Light Rubber",
    developId=19139,
    playerCamoType=67,
    fovaCamoId=47,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C48",
    description="Red Rust",
    developId=19140,
    playerCamoType=68,
    fovaCamoId=48,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C50",
    description="Steel Green",
    developId=19141,
    playerCamoType=69,
    fovaCamoId=50,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C51",
    description="Steel Orange",
    developId=19142,
    playerCamoType=70,
    fovaCamoId=51,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C53",
    description="Mud",
    developId=19143,
    playerCamoType=71,
    fovaCamoId=53,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C54",
    description="Steel Blue",
    developId=19144,
    playerCamoType=72,
    fovaCamoId=54,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C55",
    description="Dark Rust",
    developId=19145,
    playerCamoType=73,
    fovaCamoId=55,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C56",
    description="Citrullus two-tone",
    developId=19146,
    playerCamoType=74,
    fovaCamoId=56,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C57",
    description="Gold Tiger Stripe Two-tone",
    developId=19147,
    playerCamoType=75,
    fovaCamoId=57,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C58",
    description="Birch Leaf Two-tone",
    developId=19148,
    playerCamoType=76,
    fovaCamoId=58,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C59",
    description="Stone Two-tone",
    developId=19149,
    playerCamoType=77,
    fovaCamoId=59,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  {
    name="C60",
    description="Khaki Two-tone",
    developId=19150,
    playerCamoType=78,
    fovaCamoId=60,
    playerParts={
      NORMAL=true,
      NORMAL_SCARF=true,
      NAKED=true,
    },
  },
  ---------------------

  {
    name="SWIMWEAR_C00",
    description="Olive Drab",
    developId=19151,
    playerCamoType=79,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C01",
    description="Tiger Stripe",
    developId=19152,
    playerCamoType=80,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C02",
    description="Gold Tiger",
    developId=19153,
    playerCamoType=81,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C03",
    description="Desert Fox",
    developId=19154,
    playerCamoType=82,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C05",
    description="Wet Work",
    developId=19155,
    playerCamoType=83,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C06",
    description="Splitter",
    developId=19156,
    playerCamoType=84,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C38",
    description="Parasite Mist",
    developId=19157,
    playerCamoType=85,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C39",
    description="Old Rose",
    developId=19158,
    playerCamoType=86,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C44",
    description="Camoflage Green",
    developId=19159,
    playerCamoType=87,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C46",
    description="Iron Blue",
    developId=19160,
    playerCamoType=88,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C48",
    description="Red Rust",
    developId=19161,
    playerCamoType=89,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
  {
    name="SWIMWEAR_C53",
    description="Mud",
    developId=19162,
    playerCamoType=90,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE=true,
      DD_FEMALE=true,
    }
  },
}

--Camo fovas
--<id> == two digit fova common camo id (see playerCamoTypesInfo .fovaCamoId and plPartsInfo .modelId above)
--swimsuits have their own ids

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

--DD_MALE/DD_FEMALE NORMAL Camo fovas
--in \chunk0_dat\Assets\tpp\pack\player\fova\plfova_dds<5/6>_main0_ply_v<id>.fpk
--where dds5==dd male, dds6==dd female
-- fova files="/Assets/tpp/fova/chara/sna/dds<5/6>_main0_ply_v<id>.fv2",--drab - also already in plparts_dd_male.fpk

--FOB reward fatigues
--in /1/MGSVTUPDATE0100/00.dat

--/Assets/tpp/pack/player/fova/plfova_<modelid>_<camoid>
--ex /Assets/tpp/pack/player/fova/plfova_sna0_main1_c23
--/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v23


--retail 1.10 swimwear camos
--in /0/00.dat /Assets/tpp/pack/player/fova
--plfova_cmf0_main0_def_v<swimsuit camoId>.fpk/d
--ex-plfova_cmf0_main0_def_v46.fpk
--fova files \Assets\tpp\fova\chara\dlf\cmf0_main0_def_v<swimsuit camo id>.fv2

--still ony hashed/undictionaried in emooses dictionary, are in secaproject fork, and bipbops update


--tex there doesn't seem to be any enum for this
this.playerFaceEquipId={
  "NONE",--0
  "BANDANA",--1
  "INFINITY_BANDANA",--2
  "BALACLAVA",--3
  "SP_HEADGEAR",--4
  "HP_HEADGEAR",--5
}

this.playerFaceEquipIdInfo={
  {
    name="NONE",
    description="None",
    playerFaceEquipId=0,
  },
  {
    name="BANDANA",--1--snake,normal,scarf,naked,leather jacket
    description="Bandana",
    playerFaceEquipId=1,
    playerTypes={
      [PlayerType.SNAKE]=true,
      [PlayerType.AVATAR]=true,
    },
  },
  {
    name="INFINITY_BANDANA",
    description="Infinity Bandana",
    playerFaceEquipId=2,
    playerTypes={
      [PlayerType.SNAKE]=true,
      [PlayerType.AVATAR]=true,
    },
  },
  {
    name="BALACLAVA",--normal,swimsuit
    description="Balaclava",
    playerFaceEquipId=3,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  },
  {
    name="SP_HEADGEAR",--Blacktop,sneaking suits,battledress,swimsuit
    description="SP-Headgear",
    playerFaceEquipId=4,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  },
  {
    name="HP_HEADGEAR",--Greentop,sneaking suits,battledress
    description="HP-Headgear",
    playerFaceEquipId=5,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  },
}


local modelInfoSuffix="_modelInfo"
function this.PrintPlayerBodyVars()
  --  InfLog.DebugPrint"playerTypes"
  --  for n,name in ipairs(this.playerTypes) do
  --    local enum=PlayerType[name]
  --    InfLog.DebugPrint(name.."="..tostring(enum))
  --  end

  --  InfLog.DebugPrint"playerPartsTypes"
  --  for n,name in ipairs(this.playerPartsTypes) do
  --    local enum=PlayerPartsType[name]
  --    InfLog.DebugPrint(name.."="..tostring(enum))
  --  end

  InfLog.DebugPrint"playerCamoTypes"
  for n,name in ipairs(this.playerCamoTypes) do
    local enum=PlayerCamoType[name]
    InfLog.DebugPrint(name.."="..tostring(enum))
  end
end

function this.GetPlayerPartsTypes(playerPartsTypeSettings,playerType)
  local InfFova=this
  
  local checkDeveloped=Ivars.skipDevelopChecks:Is(0)

  local playerPartsTypes={}
  for i,partsTypeName in ipairs(playerPartsTypeSettings) do
    local partsType=InfFova.PlayerPartsType[partsTypeName]
    local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]
    if not partsTypeInfo then
      InfLog.DebugPrint("WARNING: could not find partsTypeInfo for "..partsTypeName)
    else
      local plPartsName=partsTypeInfo.plPartsName
      if not plPartsName then
        InfLog.DebugPrint("WARNING: could not find plPartsName for "..partsTypeName)
      else
        local playerTypeName=InfFova.playerTypes[playerType+1]
        if plPartsName.ALL or plPartsName[playerTypeName] then
          if partsTypeInfo.developId and checkDeveloped then
            if TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=partsTypeInfo.developId} then
              table.insert(playerPartsTypes,partsTypeName)
            end
          else
            table.insert(playerPartsTypes,partsTypeName)
          end
        end
      end
    end
  end
  return playerPartsTypes
end


function this.GetCamoTypes(partsTypeName)
  local InfFova=this
  local partsType=InfFova.PlayerPartsType[partsTypeName]
  local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]
  if not partsTypeInfo then
    InfLog.DebugPrint("WARNING: could not find partsTypeInfo for "..partsTypeName)
    return
  end

  local playerTypeName=InfFova.playerTypes[vars.playerType+1]
  --InfLog.DebugPrint(playerTypeName)--DEBUG

  local plPartsName=partsTypeInfo.plPartsName
  if not plPartsName then
    InfLog.DebugPrint("WARNING: could not find plPartsName on "..partsTypeName)--DEBUG
    return
  end

  if plPartsName and not plPartsName.ALL and not plPartsName[playerTypeName] then
    InfLog.DebugPrint("WARNING: "..tostring(plPartsName).." not supported for player type "..tostring(playerTypeName))--DEBUG
    return
  end

  local playerCamoTypes={}

  if partsTypeInfo.camoTypes==nil then
    local camoType=PlayerCamoType[partsTypeName]
    if camoType~=nil then
      table.insert(playerCamoTypes,partsTypeName)
    else
      InfLog.Add("WARNING: cannot find camo type for "..partsTypeName)--DEBUG
      table.insert(playerCamoTypes,"OLIVEDRAB")--PlayerCamoType 0
    end
  else
    if partsTypeInfo.camoTypes.COMMON then
      playerCamoTypes=InfFova.playerCamoTypesCommon
    elseif partsTypeInfo.camoTypes[1] then--tex ASSUMPTION list of camotype names
      playerCamoTypes=partsTypeInfo.camoTypes
    else
      InfLog.Add("WARNING: cannot find camo type for "..partsTypeName)--DEBUG
      table.insert(playerCamoTypes,"OLIVEDRAB")--PlayerCamoType 0
    end
  end

  local checkedCamoTypes={}
  if Ivars.skipDevelopChecks:Is(1) then
    checkedCamoTypes=playerCamoTypes
  else
    for i,camoName in ipairs(playerCamoTypes)do
      local camoType=PlayerCamoType[camoName]
      if camoType then
        local camoInfo=InfFova.playerCamoTypesInfo[camoType+1]
        if camoInfo then
          if camoInfo.developId then
            if TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=camoInfo.developId} then
              table.insert(checkedCamoTypes,camoName)
            end
          else
            table.insert(checkedCamoTypes,camoName)
          end
        end
      end
    end
  end

  return checkedCamoTypes
end

function this.GetCurrentFovaTable(printInfo)
  local playerTypeName=this.playerTypes[vars.playerType+1]
  local playerPartsTypeName=this.playerPartsTypes[vars.playerPartsType+1]
  return this.GetFovaTable(playerTypeName,playerPartsTypeName,printInfo)
end
function this.GetFovaTable(playerTypeName,playerPartsTypeName,printInfo)
  if playerTypeName==nil then
    InfLog.DebugPrint"WARNING: GetFovaTable playerTypeName==nil"
    return
  end
  if playerPartsTypeName==nil then
    InfLog.DebugPrint"WARNING: GetFovaTable playerPartsTypeName==nil"
    return
  end
  --InfLog.DebugPrint(playerTypeName.." "..playerPartsTypeName)--DEBUG

  local playerPartsType=this.PlayerPartsType[playerPartsTypeName]
  if playerPartsType==nil then
    InfLog.DebugPrint"WARNING: GetFovaTable playerPartsType==nil"
    return
  end

  local playerPartsTypeInfo=this.playerPartsTypesInfo[playerPartsType+1]
  if playerPartsTypeInfo==nil then
    InfLog.DebugPrint"WARNING: GetFovaTable playerPartsTypeInfo==nil"
    return
  end

  if playerPartsTypeInfo.name~=playerPartsTypeName then
    InfLog.DebugPrint"WARNING: GetFovaTable playerPartsTypeInfo.name~=playerPartsTypeName"
    return
  end

  if playerPartsTypeInfo.plPartsName==nil then
    --TODO: warning off till all filled out
    --InfLog.Add"WARNING: GetFovaTable playerPartsTypeInfo.plPartsName==nil"
    return
  end

  local modelDescription=playerPartsTypeInfo.description or playerPartsTypeInfo.name

  local plPartsName=playerPartsTypeInfo.plPartsName.ALL or playerPartsTypeInfo.plPartsName[playerTypeName]
  if plPartsName==nil then
    InfLog.DebugPrint"WARNING: GetFovaTable plPartsName==nil"
    return
  end

  if printInfo then
    InfLog.DebugPrint("playerType:"..playerTypeName..", playerParts:"..playerPartsTypeName..", plPartName:"..plPartsName)
  end

  local moduleName=plPartsName..modelInfoSuffix
  local modelInfo=_G[moduleName]
  if modelInfo then
  --InfLog.DebugPrint("modelInfo "..moduleName.." found")--DEBUG
  else
    --InfLog.DebugPrint("modelInfo "..moduleName.." not found")--DEBUG
    return nil,modelDescription
  end

  local modelInfoDescription=modelInfo.modelDescription
  if modelInfoDescription then
    if type(modelInfoDescription)~="string" then
      InfLog.DebugPrint("WARNING: GetFovaTable modelDescription is not a string")
    else
      modelDescription=modelInfoDescription
    end
  end

  local noBlackDiamond=modelInfo.noBlackDiamond

  local fovaTable=modelInfo.fovaTable
  if fovaTable==nil then
    --OFF InfLog.DebugPrint"WARNING: GetFovaTable fovaTable==nil"
    return fovaTable,modelDescription,noBlackDiamond
  end
  if #fovaTable==0 then
    InfLog.DebugPrint"WARNING: GetFovaTable #fovaTable==0"
    return
  end

  return fovaTable,modelDescription,noBlackDiamond
end

function this.GetFovaInfo(fovaTable,fovaIndex)
  local currentFovaInfo=fovaTable[fovaIndex]
  if currentFovaInfo==nil then
    InfLog.DebugPrint"WARNING: GetFovaInfo currentFovaInfo==nil"
    return
  end

  local fovaDescription=currentFovaInfo.fovaDescription

  if fovaDescription then
    if type(fovaDescription)~="string" then
      InfLog.DebugPrint"WARNING: GetFovaInfo fovaDescription~=string"
      fovaDescription=nil
    end
  end


  local fovaFile=currentFovaInfo.fovaFile
  if fovaFile==nil then
    InfLog.DebugPrint"WARNING: GetFovaInfo fovaFile==nil"
    return
  end
  if type(fovaFile)~="string" then
    InfLog.DebugPrint"WARNING: GetFovaInfo fovaFile~=string"
    return
  end

  fovaDescription=fovaDescription or fovaFile

  return fovaDescription,fovaFile
end

function this.FovaInfoChanged(fovaTable,fovaIndex)
  if fovaIndex<1 then
    InfLog.DebugPrint"WARNING: FovaInfoChanged fovaIndex<1"
    return true
  end

  if fovaIndex>#fovaTable then
    --InfLog.DebugPrint"FovaInfoChanged fovaIndex>#fovaTable"--DEBUG
    return true
  end

  if Ivars.fovaPlayerType:Get()~=vars.playerType then
    --InfLog.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end

  if Ivars.fovaPlayerPartsType:Get()~=vars.playerPartsType then
    --InfLog.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end
end


function this.SetFovaMod(fovaIndex,ignoreChanged)
  --InfLog.DebugPrint("SetFovaMod fovaIndex="..fovaIndex)--DEBUG

  local fovaTable,fovaDescription,noBlackDiamond=this.GetCurrentFovaTable()
  if fovaTable==nil then
    return
  end

  if not ignoreChanged and this.FovaInfoChanged(fovaTable,fovaIndex) then
    --InfLog.DebugPrint"SetFovaMod FovaInfoChanged, returning"--DEBUG
    return
  end


  if fovaIndex>#fovaTable then
    InfLog.DebugPrint"WARNING: SetFovaMod fovaIndex>#fovaTable"
    return
  end

  local fovaDescription,fovaFile=this.GetFovaInfo(fovaTable,fovaIndex)

  --InfLog.DebugPrint("applyfova "..fovaFile)--DEBUG
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

  this.SetFovaMod(Ivars.fovaSelection:Get()+1)
end

--CALLER: InfMain.OnFadeInDirect
function this.OnFadeIn()
  if Ivars.enableFovaMod:Is(1) then
    this.SetFovaMod(Ivars.fovaSelection:Get()+1)
  end
end


return this
