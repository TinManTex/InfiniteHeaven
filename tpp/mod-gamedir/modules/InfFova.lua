--InfFova.lua
--tex mostly describing player model system
local this={}

local InfCore=InfCore
local DoMessage=Tpp.DoMessage

--tex vars.playerType categorises plparts pack
--corresponding to PlayerType enum
this.playerTypes={
  "SNAKE",--0
  "DD_MALE",--1
  "DD_FEMALE",--2
  "AVATAR",--3
  "LIQUID",--4 In exe, breaks player (invisible, reseting var doesnt fix)
  "OCELOT",--5
  "QUIET",--6
--"MAX",--255--sinces underlying variable is a byte
}

this.fobLocked={
  OCELOT=true,
  QUIET=true,
}

--tex indexed by vars.playerType
--LoadPlayerFacialMotion* vanilla handles DD_MALE,DD_FEMALE,OCELOT,QUIET
--and the rest default to player2_facial_snake.fpk/TppPlayer2Facial.mtar
--LoadPlayerFacialMotion*s only param is playerType
--TODO: facialhelispace
this.playerTypesInfo={
  {
    name="SNAKE",
    description="Snake",
    playerType=0,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_snake.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar",
    },
  },
  {
    name="DD_MALE",
    description="DD Male",
    playerType=1,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_dd_male.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/player2_ddm_facial.mtar",
    },
  },
  {
    name="DD_FEMALE",
    description="DD Female",
    playerType=2,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_dd_female.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/player2_ddf_facial.mtar",
    },
  },
  {
    name="AVATAR",
    description="Avatar",
    playerType=3,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_snake.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar",
    },
  },
  {
    name="LIQUID",
    description="LIQUID",
    playerType=4,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_snake.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar",
    },
  },
  {
    name="OCELOT",
    description="Ocelot",
    playerType=5,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_ocelot.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/player2_ocelot_facial.mtar",
    },
  },
  {
    name="QUIET",
    description="Quiet",
    playerType=6,
    facialMotion={
      fpk="/Assets/tpp/pack/player/motion/player2_facial_quiet.fpk",
      mtar="/Assets/tpp/motion/mtar/player2/player2_quiet_facial.mtar",
    },
  },
}--playerTypesInfo

--tex vars.playerParts drives which plparts fpk is used
--\chunk0_dat\Assets\tpp\pack\player\parts\plparts*.fpk
--corresponding to PlayerPartsType enum, which isn't actually filled out beyond the first few entries,
--so cribbing names from PlayerCamoType
--tex indexed by vars.playerPartsType
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
  "SWIMWEAR_G",--24
  "SWIMWEAR_H",--25
  "OCELOT",--26
  "QUIET",--27
  --tex var can overflow and repeat for a bit before hanging. since array exe side is playertype/playerparts, basically will overflow from one playertype to start of next, except for DD_FEM which overflows to snake camo array
  "NORMAL2",--28
  "NORMAL_SCARF2",--29
  "SNEAKING_SUIT_BB",--30 --TODO and see how this is coming about, I guess snake head interacting with the parts type overflow
  "HOSPITAL2",
  "MGS12",
  "NINJA2",
  "RAIDEN2",
  "NAKED2",
  "SNEAKING_SUIT_TPP2",
  "BATTLEDRESS2",
  "PARASITE_SUIT2",
  "LEATHER_JACKET2",
--"MAX",--255--sinces underlying variable is a byte, exe might actually be using this as non value
}--playerPartsTypes

--tex replacing engines PlayerPartsType since > 23 not covered
this.PlayerPartsType=InfUtil.EnumFrom0(this.playerPartsTypes)

--tex table indexed by vars.playerParts/PlayerPartsType enum
--plPartsName doubles for checks to which playertype supports the partstype
--if no camoTypes then try PlayerCamoType[name]


--tex MUSING while in theory I could really break things up in respect to playerType, playerPartsType, playerCammoType
--the vanilla system does have relationships between them, and the following table is an attempt to recreate them
--mainly that playerPartsType is the driver, even though there are seperate partstype arrays for each playerType,
--they are indexed by playerPartsType across the playerType playerPartsType arrays
--(with 0 values for in the playerType arrays of those that dont support that playerPartsType)
--plPartsName: fpk name from \chunk0_dat\Assets\tpp\pack\player\parts\
--NOTE: even though I'm including AVATAR for plParts, vanilla exe side it just changes playerType to 0(SNAKE) for the .parts and .fpk within the func
--so I'm just duplicating here rather than having it fallback in code
this.playerPartsTypesInfo={
  {--0 -- uses set camo type
    name="NORMAL",
    description="Standard fatigues",
    playerParts=0,
    --developId=--Common
    plPartsName={--tex DEBUGNOW shift to using playerPartsFpk instead
      SNAKE="plparts_normal",
      AVATAR="plparts_normal",
      DD_MALE="plparts_dd_male",
      DD_FEMALE="plparts_dd_female",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dd_male.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dd_female.fpk",
      --tex in the exe for LoadPlayerPartsParts, LoadPlayerPartsFpk it doesnt even look up the playerParts/playerType array,
      --it just returns the singular value by playerType for LIQUID/OCELOT/QUIET
      --which is kind of weird given that OCELOT and QUIET do have their own playerPartsType enum
      --but then that kind of goes against the array per playerType that SNAKE/DD_M/F has
      --DEBUGNOW give it its own fake entry/OCELOT/QUIET equivalent at the end?
      LIQUID=   "/Assets/tpp/pack/player/parts/plparts_liquid.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts",
      LIQUID=   "/Assets/tpp/parts/chara/lqd/lqd0_main0_ply_v00.parts",
    },
    --tex see exe/IHHook LoadPlayerPartsSkinToneFv2
    skinToneFv2={
      --tex  in vanilla this is applied to all DD_M (if CheckPlayerPartsIfShouldApplySkinToneFv2) except those with their own specific fv2s
      --rather than handle in function I'll fill out all values, and make the assumption if it has a value then it should be applied (ie CheckPlayerPartsIfShouldApplySkinToneFv2 isn't nessesary)
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    camoTypes={
      COMMON=true,--WORKAROUND: table filled out after common is defined in playerCamoTypesCommon
    },
    --tex from exe/IHHook LoadPlayerBionicArm*, see also playerHandType below
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    --tex from exe IsHeadNeeded* . needHead false/nil = model includes head, true = load the head for that playerType
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dd_male.fpk",--NORMAL
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dd_female.fpk",--NORMAL
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts",--NORMAL
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts",--NORMAL
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    camoTypes={
      COMMON=true,
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    camoTypes={
      "SNEAKING_SUIT_GZ",
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
  },
  {--3-- crash on avatar, probably because IsHeadNeededForPartsTypeAndAvatar has an extra return true for needHead for some reason
    name="HOSPITAL",
    description="Hospital Prolog snake",
    playerParts=3,
    plPartsName={
      SNAKE="plparts_hospital",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_hospital.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_hospital.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_hospital.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_hospital.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
    },
    needHead={
      AVATAR=true,--VANILLA, has a seperate clause return true in IsHeadNeededForPartsTypeAndAvatar for some reason. VERIFY by running the orig func
    },
    camoTypes={
      "HOSPITAL",
    },
  },
  {--4,--gz unlock
    name="MGS1",
    description="MGS1 Solid Snake",
    playerParts=4,
    developId=19071,
    plPartsName={
      SNAKE="plparts_mgs1",
      AVATAR="plparts_mgs1",
      DD_MALE="plparts_mgs1",
      DD_FEMALE="plparts_mgs1",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_mgs1.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_mgs1.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_mgs1.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_mgs1.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
    },
    camoTypes={
      "SOLIDSNAKE",
    },
  },
  {--5,--unlock
    name="NINJA",
    description="MGS1 Cyborg Ninja",
    playerParts=5,
    developId=19071,
    plPartsName={
      SNAKE="plparts_ninja",
      AVATAR="plparts_ninja",
      DD_MALE="plparts_ninja",
      DD_FEMALE="plparts_ninja",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_ninja.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_ninja.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ninja.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ninja.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
    },
    camoTypes={
      "NINJA",
    },
  },
  {--6
    name="RAIDEN",
    description="Raiden",
    playerParts=6,
    developId=19073,
    plPartsName={
      SNAKE="plparts_raiden",
      AVATAR="plparts_raiden",
      DD_MALE="plparts_raiden",
      DD_FEMALE="plparts_raiden",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_raiden.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_raiden.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_raiden.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_raiden.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
    },
    camoTypes={
      "RAIDEN",
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_naked.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_naked.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_naked.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_naked.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    camoTypes={
      COMMON=true,
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_venom.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_venom.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_venom.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_venom.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna4_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna4_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna4_plym0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna4_plyf0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "SNEAKING_SUIT_TPP",
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_battledress.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_battledress.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_battledress.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_battledress.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna5_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna5_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna5_plym0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna5_plyf0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "BATTLEDRESS",
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_parasite.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_parasite.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_parasite.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_parasite.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna7_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna7_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna7_plym0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna7_plyf0_def_v00.parts",
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    camoTypes={
      "PARASITE",
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
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_leather.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_leather.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_leather.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_leather.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "LEATHER",
    },
  },
  {--12,--unlock
    name="GOLD",
    description="Naked Gold",
    playerParts=12,
    developId=19024,
    plPartsName={
      SNAKE="plparts_gold",
      AVATAR="plparts_gold", --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_gold.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_gold.fpk",
      DD_MALE=  0,
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna9_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna9_main0_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE=0,
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "GOLD",
    },
  },
  {--13,--unlock, when AVATAR, gold body and normal avatar head, neat
    name="SILVER",
    description="Naked Silver",
    playerParts=13,
    developId=19023,
    plPartsName={
      SNAKE="plparts_silver",
      AVATAR="plparts_silver", --gold body and normal avatar head, neat
    --DD_MALE=--invis/hang model sys
    --DD_FEMALE=--invis/hang model sys
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_silver.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_silver.fpk",
      DD_MALE=  0,
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna9_main1_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna9_main1_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE=0,
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "SILVER",
    },
  },
  {--14
    name="AVATAR_EDIT_MAN",
    playerParts=14,
    plPartsName={
      SNAKE="plparts_avatar_man",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "AVATAR_EDIT_MAN",
    },
  },
  --DLC TODO: find out pack names, find a have-this check
  {--15
    name="MGS3",
    description="Fatigues (NS)",
    playerParts=15,
    developId=19080,
    plPartsName={
      SNAKE="plparts_dla0_main0_def_v00",
      AVATAR="plparts_dla0_main0_def_v00",
      DD_MALE="plparts_dla0_plym0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dla0_main0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dla0_main0_def_v00.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dla0_plym0_def_v00.fpk",
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dla0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dla0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dla0_plym0_def_v00.parts",
      DD_FEMALE=0,
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/dla/dla0_plym0_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT TODO: no DD_FEM parts
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "MGS3",
    },
  },
  {--16
    name="MGS3_NAKED",
    description="Fatigues Naked (NS)",
    playerParts=16,
    developId=19080,--tex as above
    plPartsName={
      SNAKE="plparts_dla1_main0_def_v00",
      AVATAR="plparts_dla1_main0_def_v00",
      DD_MALE="plparts_dla1_plym0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dla1_main0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dla1_main0_def_v00.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dla1_plym0_def_v00.fpk",
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dla1_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dla1_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dla1_plym0_def_v00.parts",
      DD_FEMALE=0,
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/dla/dla1_plym0_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT TODO no DD_FEM parts
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "MGS3_NAKED",
    },
  },
  {--17
    name="MGS3_SNEAKING",
    description="Sneaking Suit (NS)",
    playerParts=17,
    developId=19081,
    plPartsName={
      SNAKE="plparts_dlb0_main0_def_v00",
      AVATAR="plparts_dlb0_main0_def_v00",
      DD_MALE="plparts_dlb0_plym0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dlb0_main0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dlb0_main0_def_v00.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dlb0_plym0_def_v00.fpk",
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dlb0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dlb0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dlb0_plym0_def_v00.parts",
      DD_FEMALE=0,
    },
    skinToneFv2={
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT TODO no DD_FEM parts
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "MGS3_SNEAKING",
    },
  },
  {--18
    name="MGS3_TUXEDO",
    description="Tuxedo",
    playerParts=18,
    developId=19084,
    plPartsName={
      SNAKE="plparts_dld0_main0_def_v00",
      AVATAR="plparts_dld0_main0_def_v00",
      DD_MALE="plparts_dld0_plym0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dld0_plym0_def_v00.fpk",
      DD_FEMALE=0,
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dld0_main0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dld0_main0_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dld0_plym0_def_v00.parts",
      DD_FEMALE=0,
    },
    skinToneFv2={
      SNAKE="/Assets/tpp/fova/chara/dld/dld0_main0_sna.fv2",
      DD_MALE="/Assets/tpp/fova/chara/dld/dld0_plym0_v00.fv2",
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "MGS3_TUXEDO",
    },
  },
  {--19
    name="EVA_CLOSE",
    description="Jumpsuit (EVA)",
    playerParts=19,
    developId=19086,
    plPartsName={
      DD_FEMALE="plparts_dle0_plyf0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts",
    },
    skinToneFv2={
      DD_FEMALE="/Assets/tpp/fova/chara/dle/dle0_plyf0_v00.fv2",
    },
    needHead={
      SNAKE=true,
      AVATAR=true,--TODO uhh?
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "EVA_CLOSE",
    },
  },
  {--20
    name="EVA_OPEN",
    description="Jumpsuit open (EVA)",
    playerParts=20,
    developId=19086,--tex as above
    plPartsName={
      DD_FEMALE="plparts_dle1_plyf0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dle1_plyf0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dle1_plyf0_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dle1_plyf0_def_v00.parts",
    },
    skinToneFv2={
      DD_FEMALE="/Assets/tpp/fova/chara/dle/dle1_plyf0_v00.fv2",
    },
    needHead={
      SNAKE=true,
      AVATAR=true,--TODO uhh?
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "MGS3_OPEN",
    },
  },
  {--21
    name="BOSS_CLOSE",
    description="Sneaking Suit (TB)",
    playerParts=21,
    developId=19085,
    plPartsName={
      DD_FEMALE="plparts_dlc0_plyf0_def_v00",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts",
    },
    --tex DEBUGNOW why no skintone?
    needHead={
      SNAKE=true,
      AVATAR=true,--TODO uhh?
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "BOSS_CLOSE",
    },
  },
  {--22
    name="BOSS_OPEN",
    description="Sneaking Suit open (TB)",
    playerParts=22,
    developId=19085,--tex as above
    plPartsName={
      DD_FEMALE="plparts_dle1_plyf0_def_v00",--TODO:
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts",
      DD_MALE=  0,
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts",
    },
    skinToneFv2={
      DD_FEMALE="/Assets/tpp/fova/chara/dlc/dlc1_plyf0_v00.fv2",
    },
    needHead={
      SNAKE=true,
      AVATAR=true,--TODO uhh?
      DD_MALE=true,
      DD_FEMALE=true,
    },
    camoTypes={
      "BOSS_OPEN",
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
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_swimwear.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      DD_MALE=  "/Assets/tpp/parts/chara/dlf/dlf1_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/dlf/dlf0_main0_def_f_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/dlf/dlf1_main0_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/dlf/dlf1_main0_f_v00.fv2",
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
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
  },
  {--24
    name="SWIMWEAR_G",
    description="Goblin Swimsuit",
    playerParts=24,
    --developId=,--Common, kinda, requires at least one type to show up, but unless I want to iterate through the the developids of all the camos just leave it
    plPartsName={
      DD_MALE="plparts_ddm_swimwear_g",
      DD_FEMALE="plparts_ddf_swimwear_g",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_g.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_g.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      DD_MALE=  "/Assets/tpp/parts/chara/dlg/dlg1_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/dlg/dlg0_main0_def_f_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/dlg/dlg1_main0_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/dlg/dlg1_main0_f_v00.fv2",
    },
    camoTypes={
      "SWIMWEAR_G_C00",--91
      "SWIMWEAR_G_C01",--
      "SWIMWEAR_G_C02",--
      "SWIMWEAR_G_C03",--
      "SWIMWEAR_G_C05",--
      "SWIMWEAR_G_C06",--
      "SWIMWEAR_G_C38",--
      "SWIMWEAR_G_C39",--
      "SWIMWEAR_G_C44",--
      "SWIMWEAR_G_C46",--
      "SWIMWEAR_G_C48",--
      "SWIMWEAR_G_C53",--102
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
  },
  {--25
    name="SWIMWEAR_H",
    description="Megalodon Swimsuit",
    playerParts=25,
    --developId=,--Common, kinda, requires at least one type to show up, but unless I want to iterate through the the developids of all the camos just leave it
    plPartsName={
      DD_MALE="plparts_ddm_swimwear_h",
      DD_FEMALE="plparts_ddf_swimwear_h",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_h.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_h.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      DD_MALE=  "/Assets/tpp/parts/chara/dlh/dlh1_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/dlh/dlh0_main0_def_f_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/dlh/dlh1_main0_v00.fv2",
      DD_FEMALE="/Assets/tpp/fova/chara/dlh/dlh1_main0_f_v00.fv2",
    },
    camoTypes={
      "SWIMWEAR_H_C00",--103
      "SWIMWEAR_H_C01",--
      "SWIMWEAR_H_C02",--
      "SWIMWEAR_H_C03",--
      "SWIMWEAR_H_C05",--
      "SWIMWEAR_H_C06",--
      "SWIMWEAR_H_C38",--
      "SWIMWEAR_H_C39",--
      "SWIMWEAR_H_C44",--
      "SWIMWEAR_H_C46",--
      "SWIMWEAR_H_C48",--
      "SWIMWEAR_H_C53",--114
    },
    needBionicHand={
      SNAKE=true,
      AVATAR=true,
    },
    needHead={
      SNAKE=true,
      AVATAR=true,
      DD_MALE=true,
      DD_FEMALE=true,
    },
  },
  {--26
    --tex while exe does fill out other player types to be their defaults,
    --it doesnt include the actual ocelot parts paths since it just returns them directly
    --on playerType rather than using the playerPartsType[playerType] array
    name="OCELOT",
    description="Ocelot",
    playerParts=26,
    --developId=--Common
    plPartsName={
      OCELOT="plparts_ocelot",
    },
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_normal.fpk",--NORMAL
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_dd_male.fpk",--NORMAL
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_dd_female.fpk",--NORMAL
      OCELOT=   "/Assets/tpp/pack/player/parts/plparts_ocelot.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",--NORMAL
      DD_MALE=  "/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts",--NORMAL
      DD_FEMALE="/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts",--NORMAL
      OCELOT=   "/Assets/tpp/parts/chara/ooc/ooc0_main1_def_v00.parts",
    },
    camoTypes={
      "OCELOT",
    },
  },
  {--27
    --tex same deal as ocelot
    name="QUIET",
    description="Quiet",
    playerParts=27,
    --developId=--Common
    plPartsName={
      QUIET="plparts_quiet",
    },
    playerPartsFpk={
      SNAKE=    0,
      AVATAR=   0,
      DD_MALE=  0,
      DD_FEMALE=0,
      QUIET=    "/Assets/tpp/pack/player/parts/plparts_quiet.fpk",
    },
    playerPartsParts={
      SNAKE=    0,
      AVATAR=   0,
      DD_MALE=  0,
      DD_FEMALE=0,
      QUIET=    "/Assets/tpp/parts/chara/qui/quip_main0_def_v00.parts",
    },
    camoTypes={
      "QUIET",
    },
  },

  --tex following are actually playerParts overflow, currently just named after what appears with vars.playerParts set to the numerical value
  --28 onward>>
  --appear to be the DD soldier, but most no head even when set to DD_MALE
  --changes depending on playerType
  --SNAKE,AVATAR show male versions (of those models that have them),
  --DD_MALE shows female versions
  --DD_FEMALE crashes game
  --What on earth is the engine doing with these lol.
  --names aren't valid PlayerPartsType
  {--28 no actual scarf, does not respond to vars.playerCamoType
    name="NORMAL2",
  },
  {--29 no actual scarf, does not respond to vars.playerCamoType
    name="NORMAL_SCARF2",
  },
  {--30 Shows snakes head reguardless of SNAKE or AVATAR
    name="SNEAKING_SUIT_BB",--tex own name
    description="Big Boss SV-Sneaking suit",--tex actual GZ Snake, not Venom in GZ suit
    playerParts=26,
    plPartsName={
      SNAKE="plparts_sneaking_suit",
    },
    --tex just copying SNEAKING_SUIT, this is not quite correct since this is overflow
    playerPartsFpk={
      SNAKE=    "/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk",
      AVATAR=   "/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk",
      DD_MALE=  "/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
      DD_FEMALE="/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
    },
    playerPartsParts={
      SNAKE=    "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      AVATAR=   "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
      DD_MALE=  "/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
      DD_FEMALE="/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
    },
    skinToneFv2={
      DD_MALE="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",--DEFAULT
      DD_FEMALE="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",--DEFAULT
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
--    > invisible/hang model system
}--playerPartsTypesInfo

--EXEC

--tex
--info on plparts fpk / model id
--searching for first section of modelid (ex sna1) will get more hits
this.plPartsInfo={
  plparts_avatar_man={modelId="avm0_body0"},--tex for avatar customization
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
  plparts_ddf_swimwear_g={modelId="dlg0_main0"},
  plparts_ddm_swimwear_g={modelId="dlg1_main0"},
  plparts_ddf_swimwear_h={modelId="dlh0_main0"},
  plparts_ddm_swimwear_h={modelId="dlh1_main0"},
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
  plparts_ocelot={modelId="ooc0_main1"},
  plparts_quiet={modelId="quip_main0_def0"},
}--plPartsInfo

--tex TODO: build reverse lookup table if nessesary


--tex vars.playerCamoType drives some fova applications
--\chunk0_dat\Assets\tpp\pack\player\fova\plfova_*.fpk*
--corresponding to PlayerCamoType enum
this.playerCamoTypes={
  "OLIVEDRAB",--0
  "SPLITTER",--1
  "SQUARE",--2
  "TIGERSTRIPE",--3
  "GOLDTIGER",--4
  "FOXTROT",--5
  "WOODLAND",--6
  "WETWORK",--7
  "ARBANGRAY",--8
  "ARBANBLUE",--9
  "SANDSTORM",--10
  "REALTREE",--11 --does not set
  "INVISIBLE",--12 --does not set
  "BLACK",--13
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
  "SWIMWEAR_C03",--82,FOXTROT
  "SWIMWEAR_C05",--83,WETWORK
  "SWIMWEAR_C06",--84,SPLITTER
  "SWIMWEAR_C38",--85,PARASITE MIST
  "SWIMWEAR_C39",--86,OLD ROSE
  "SWIMWEAR_C44",--87,CAMOFLAGE GREEN
  "SWIMWEAR_C46",--88,IRON BLUE
  "SWIMWEAR_C48",--89,RED RUST
  "SWIMWEAR_C53",--90,MUD

  "SWIMWEAR_G_C00",--91,OLIVEDRAB
  "SWIMWEAR_G_C01",--,TIGERSTRIPE
  "SWIMWEAR_G_C02",--,GOLDTIGER
  "SWIMWEAR_G_C03",--,FOXTROT
  "SWIMWEAR_G_C05",--,WETWORK
  "SWIMWEAR_G_C06",--,SPLITTER
  "SWIMWEAR_G_C38",--,PARASITE MIST
  "SWIMWEAR_G_C39",--,OLD ROSE
  "SWIMWEAR_G_C44",--,CAMOFLAGE GREEN
  "SWIMWEAR_G_C46",--,IRON BLUE
  "SWIMWEAR_G_C48",--,RED RUST
  "SWIMWEAR_G_C53",--102,MUD

  "SWIMWEAR_H_C00",--103,OLIVEDRAB
  "SWIMWEAR_H_C01",--,TIGERSTRIPE
  "SWIMWEAR_H_C02",--,GOLDTIGER
  "SWIMWEAR_H_C03",--,FOXTROT
  "SWIMWEAR_H_C05",--,WETWORK
  "SWIMWEAR_H_C06",--,SPLITTER
  "SWIMWEAR_H_C38",--,PARASITE MIST
  "SWIMWEAR_H_C39",--,OLD ROSE
  "SWIMWEAR_H_C44",--,CAMOFLAGE GREEN
  "SWIMWEAR_H_C46",--,IRON BLUE
  "SWIMWEAR_H_C48",--,RED RUST
  "SWIMWEAR_H_C53",--114,MUD

  "OCELOT",--115,
  "QUIET",--116,
--"MAX",--255--sinces underlying variable is a byte
}--playerCamoTypes--SYNC player2_camouf_param

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
  "ARBANGRAY",--8
  "ARBANBLUE",--9
  "SANDSTORM",--10
  --"REALTREE",--11 --does not set
  --"INVISIBLE",--12 --does not set
  "BLACK",--13
  "PANTHER",--26
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
}--playerCamoTypesCommon

--EXEC, WORKAROUND: alternate would just to be to shift this above playerPartsTypesInfo
for i,playerPartsInfo in ipairs(this.playerPartsTypesInfo)do
  if playerPartsInfo.camoTypes and playerPartsInfo.camoTypes.COMMON then
    playerPartsInfo.camoTypes=this.playerCamoTypesCommon
  end
end

--tex ASSUMPTION currently if no playerTypes, assume ALL
--(or rather use playerPartsType to figure out what playerTypes allowed since there's more exceptions with SCARF and NAKED)
--see 'Camo fovas' below for explanation of fovaCamoId
--could be fancy and build the fpk and fv2 paths via the player parts modelName + fovaCamoId
--but just going to explicitly put them out, which reflects the arrays LoadPlayerCammoFpk/Fv2 anyway
--and is clearer for it I'm going to allow overloading/extending that
--GOTCHA: playerParts that have no camo/variants still have a playerCamoType, but no actual camo fpk/fv2 returned
--so don't use info.playerParts..<playerType>.fpk as a check, use .<playerType> itself (and check if table vs bool if actually using .<playerType> entry)
this.playerCamoTypesInfo={
  {
    name="OLIVEDRAB",
    description="Olive Drab",
    playerCamoType=0,
    developId=19001,
    fovaCamoId=00,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",
        },
        --tex exe side AVATAR reuses SNAKE array, but I'm duplicating here (for all camos)
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",
        },
      },--NORMAL
      --tex is just a dupe of normal
      NORMAL_SCARF={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",
        },
      },--NORMAL_SCARF
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c00.fv2",
        },
        --tex exe side AVATAR reuses SNAKE array, but I'm duplicating here (for all camos)
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c00.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c00.fv2",
        },
      },--NAKED
    },--playerParts
  },--OLIVEDRAB
  {
    name="SPLITTER",
    description="Splitter",
    playerCamoType=1,
    developId=19002,
    fovaCamoId=06,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c06.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c06.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v06.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v06.fv2",
        },
      },
      NORMAL_SCARF=true,--DEBUGNOW TODO all dupes of NORMAL
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c06.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c06.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c06.fv2",
        },
      },--NAKED
    },--playerParts
  },--SPLITTER
  {
    name="SQUARE",
    description="Square",
    playerCamoType=2,
    developId=19003,
    fovaCamoId=12,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c12.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c12.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v12.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v12.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c12.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c12.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c12.fv2",
        },
      },--NAKED
    },--playerParts
  },--SQUARE
  {
    name="TIGERSTRIPE",
    description="Tiger Stripe",
    playerCamoType=3,
    developId=19010,
    fovaCamoId=01,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c01.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c01.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v01.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v01.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c01.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c01.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c01.fv2",
        },
      },--NAKED
    },--playerParts
  },--TIGERSTRIPE
  {
    name="GOLDTIGER",
    description="Gold Tiger",
    playerCamoType=4,
    developId=19011,
    fovaCamoId=02,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c02.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c02.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v02.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v02.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c02.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c02.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c02.fv2",
        },
      },--NAKED
    },--playerParts
  },--GOLDTIGER
  {
    name="FOXTROT",
    description="Desert Fox",
    playerCamoType=5,
    developId=19020,
    fovaCamoId=03,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c03.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c03.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v03.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v03.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c03.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c03.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c03.fv2",
        },
      },--NAKED
    },--playerParts
  },--FOXTROT
  {
    name="WOODLAND",
    description="Woodland",
    playerCamoType=6,
    developId=19021,
    fovaCamoId=10,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c10.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c10.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v10.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v10.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c10.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c10.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c10.fv2",
        },
      },--NAKED
    },--playerParts
  },--WOODLAND
  {
    name="WETWORK",
    description="Wetwork",
    playerCamoType=7,
    developId=19022,
    fovaCamoId=05,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c05.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c05.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v05.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v05.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c05.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c05.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c05.fv2",
        },
      },--NAKED
    },--playerParts
  },--WETWORK
  --Console special edition
  {
    name="ARBANGRAY",
    description="Gray Urban",
    playerCamoType=8,
    developId=19030,
    fovaCamoId=08,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c08.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c08.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v08.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v08.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c08.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c08.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c08.fv2",
        },
      },--NAKED
    },--playerParts
  },--ARBANGRAY
  {
    name="ARBANBLUE",
    description="Blue Urban",
    playerCamoType=9,
    developId=19031,
    fovaCamoId=07,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c07.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c07.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v07.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v07.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c07.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c07.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c07.fv2",
        },
      },--NAKED
    },--playerParts
  },--ARBANBLUE
  {
    name="SANDSTORM",
    description="APD (Pixelated Desert)",
    playerCamoType=10,
    developId=19032,
    fovaCamoId=11,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c11.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c11.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v11.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v11.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c11.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c11.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c11.fv2",
        },
      },--NAKED
    },--playerParts
  },--SANDSTORM
  {
    name="REALTREE", --OFF --does not set
    playerCamoType=11,
  --exe NORMAL array entry is 0
  },--REALTREE
  {
    name="INVISIBLE", --OFF --does not set
    playerCamoType=12,
  --exe NORMAL array entry is 0
  },--INVISIBLE
  {
    name="BLACK",
    description="Black Ocelot",
    playerCamoType=13,
    developId=19033,
    fovaCamoId=13,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c13.fv2",
        },
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c13.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v13.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v13.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c13.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c13.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c13.fv2",
        },
      },--NAKED
    },--playerParts
  },--BLACK
  --
  {
    name="SNEAKING_SUIT_GZ",
    description="SV-Sneaking suit (GZ)",
    playerCamoType=14,
    developId=19040,
    playerParts={
      NORMAL={
        SNAKE={
          --DEBUGNOW mystery, no matches? also weird that a single/unique actually has a camo value when they usually dont
          fpk=5920914369742744086,--522B503FBA05AA16h
          fv2=6956193077379482837,--60895CBF963C44D5h
        },
        AVATAR={
          --DEBUGNOW mystery, no matches?
          fpk=5920914369742744086,--522B503FBA05AA16h
          fv2=6956193077379482837,--60895CBF963C44D5h
        },
        DD_MALE={
          fpk=5920482023112522521,--5229C7082EB53B19h
          fv2=6955816467441122854,--6088063940A3FE26h
        },
        DD_FEMALE={
          fpk=5920447342875638851,--5229A77D8F81FC43h
          fv2=5920447342875638851,--608AE00996023DEAh
        },
      },
      SNEAKING_SUIT=true,
    },
    playerTypes={
      SNAKE=true,
      AVATAR=true,
    }
  },--SNEAKING_SUIT_GZ
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
  },--SNEAKING_SUIT_TPP
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
      AVATAR=true,
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
      AVATAR=true,
    }
  },
  {
    name="PANTHER",
    description="Animals",
    playerCamoType=26,
    developId=19012,
    fovaCamoId=14,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c14.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c14.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v14.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v14.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c14.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c14.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c14.fv2",
        },
      },--NAKED
    },--playerParts
  },--PANTHER
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
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c23.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c23.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v23.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v23.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c23.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c23.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c23.fv2",
        },
      },--NAKED
    },--playerParts
  },--C23
  {
    name="C24",
    description="Ambush",
    developId=19091,
    playerCamoType=37,
    fovaCamoId=24,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c24.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c24.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v24.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v24.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c24.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c24.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c24.fv2",
        },
      },--NAKED
    },--playerParts
  },--C24
  {
    name="C27",
    description="Solum",
    developId=19092,
    playerCamoType=38,
    fovaCamoId=27,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c27.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c27.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v27.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v27.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c27.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c27.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c27.fv2",
        },
      },--NAKED
    },--playerParts
  },--C27
  {
    name="C29",
    description="Dead Leaf",
    developId=19093,
    playerCamoType=39,
    fovaCamoId=29,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c29.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c29.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v29.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v29.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c29.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c29.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c29.fv2",
        },
      },--NAKED
    },--playerParts
  },--C29
  {
    name="C30",
    description="Lichen",
    developId=19094,
    playerCamoType=40,
    fovaCamoId=30,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c30.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c30.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v30.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v30.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c30.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c30.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c30.fv2",
        },
      },--NAKED
    },--playerParts
  },--C30
  {
    name="C35",
    description="Stone",
    developId=19095,
    playerCamoType=41,
    fovaCamoId=35,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c35.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c35.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v35.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v35.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c35.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c35.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c35.fv2",
        },
      },--NAKED
    },--playerParts
  },--C35
  {
    name="C38",
    description="Parasite Mist",
    developId=19096,
    playerCamoType=42,
    fovaCamoId=38,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c38.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c38.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v38.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v38.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c38.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c38.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c38.fv2",
        },
      },--NAKED
    },--playerParts
  },--C38
  {
    name="C39",
    description="Old Rose",
    developId=19097,
    playerCamoType=43,
    fovaCamoId=39,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c39.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c39.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v39.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v39.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c39.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c39.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c39.fv2",
        },
      },--NAKED
    },--playerParts
  },--C39
  {
    name="C42",
    description="Brick Red",
    developId=19098,
    playerCamoType=44,
    fovaCamoId=42,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c42.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c42.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v42.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v42.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c42.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c42.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c42.fv2",
        },
      },--NAKED
    },--playerParts
  },--C42
  {
    name="C46",
    description="Iron Blue",
    developId=19099,
    playerCamoType=45,
    fovaCamoId=46,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c46.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c46.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v46.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v46.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c46.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c46.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c46.fv2",
        },
      },--NAKED
    },--playerParts
  },--C46
  {
    name="C49",
    description="Steel Grey",
    developId=19100,
    playerCamoType=46,
    fovaCamoId=49,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c49.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c49.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v49.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v49.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c49.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c49.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c49.fv2",
        },
      },--NAKED
    },--playerParts
  },--C49
  {
    name="C52",
    description="Tselinoyarsk",
    developId=19101,
    playerCamoType=47,
    fovaCamoId=52,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c52.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c52.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v52.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v52.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c52.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c52.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c52.fv2",
        },
      },--NAKED
    },--playerParts
  },--C52
  -------------
  {
    name="C16",
    description="Night Splitter",
    developId=19120,
    playerCamoType=48,
    fovaCamoId=16,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c16.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c16.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v16.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v16.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c16.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c16.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c16.fv2",
        },
      },--NAKED
    },--playerParts
  },--C16
  {
    name="C17",
    description="Rain",
    developId=19121,
    playerCamoType=49,
    fovaCamoId=17,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c17.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c17.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v17.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v17.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c17.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c17.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c17.fv2",
        },
      },--NAKED
    },--playerParts
  },--C17
  {
    name="C18",
    description="Green Tiger Stripe",
    developId=19122,
    playerCamoType=50,
    fovaCamoId=18,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c18.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c18.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v18.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v18.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c18.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c18.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c18.fv2",
        },
      },--NAKED
    },--playerParts
  },--C18
  {
    name="C19",
    description="Birch Leaf",
    developId=19123,
    playerCamoType=51,
    fovaCamoId=19,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c19.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c19.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v19.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v19.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c19.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c19.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c19.fv2",
        },
      },--NAKED
    },--playerParts
  },--C19
  {
    name="C20",
    description="Desert Ambush",
    developId=19124,
    playerCamoType=52,
    fovaCamoId=20,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c20.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c20.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v20.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v20.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c20.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c20.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c20.fv2",
        },
      },--NAKED
    },--playerParts
  },--C20
  {
    name="C22",
    description="Dark Leaf Fleck",
    developId=19125,
    playerCamoType=53,
    fovaCamoId=22,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c22.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c22.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v13.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v13.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c22.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c22.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c22.fv2",
        },
      },--NAKED
    },--playerParts
  },--C22
  {
    name="C25",
    description="Night Bush",
    developId=19126,
    playerCamoType=54,
    fovaCamoId=25,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c25.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c25.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v25.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v25.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c25.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c25.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c25.fv2",
        },
      },--NAKED
    },--playerParts
  },--C25
  {
    name="C26",
    description="Grass",
    developId=19127,
    playerCamoType=55,
    fovaCamoId=26,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c26.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c26.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v26.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v26.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c26.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c26.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c26.fv2",
        },
      },--NAKED
    },--playerParts
  },--C26
  {
    name="C28",
    description="Ripple",
    developId=19128,
    playerCamoType=56,
    fovaCamoId=28,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c28.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c28.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v28.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v28.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c28.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c28.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c28.fv2",
        },
      },--NAKED
    },--playerParts
  },--C28
  {
    name="C31",
    description="Citrullus",
    developId=19129,
    playerCamoType=57,
    fovaCamoId=31,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c31.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c31.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v31.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v31.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c31.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c31.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c31.fv2",
        },
      },--NAKED
    },--playerParts
  },--C31
  {
    name="C32",
    description="Digital Bush",
    developId=19130,
    playerCamoType=58,
    fovaCamoId=32,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c32.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c32.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v32.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v32.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c32.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c32.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c32.fv2",
        },
      },--NAKED
    },--playerParts
  },--C32
  {
    name="C33",
    description="Zebra",
    developId=19131,
    playerCamoType=59,
    fovaCamoId=33,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c33.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c33.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v33.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v33.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c33.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c33.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c33.fv2",
        },
      },--NAKED
    },--playerParts
  },--C33
  {
    name="C36",
    description="Desert Sand",
    developId=19132,
    playerCamoType=60,
    fovaCamoId=36,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c36.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c36.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v36.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v36.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c36.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c36.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c36.fv2",
        },
      },--NAKED
    },--playerParts
  },--C36
  {
    name="C37",
    description="Steel Khaki",
    developId=19133,
    playerCamoType=61,
    fovaCamoId=37,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c37.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c37.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v37.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v37.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c37.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c37.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c37.fv2",
        },
      },--NAKED
    },--playerParts
  },--C37
  {
    name="C40",
    description="Dark Rubber",
    developId=19134,
    playerCamoType=62,
    fovaCamoId=40,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c40.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c40.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v40.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v40.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c40.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c40.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c40.fv2",
        },
      },--NAKED
    },--playerParts
  },--C40
  {
    name="C41",
    description="Gray",
    developId=19135,
    playerCamoType=63,
    fovaCamoId=41,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c41.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c41.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v41.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v41.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c41.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c41.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c41.fv2",
        },
      },--NAKED
    },--playerParts
  },--C41
  {
    name="C43",
    description="Camoflage Yellow",
    developId=19136,
    playerCamoType=64,
    fovaCamoId=43,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c43.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c43.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v43.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v43.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c43.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c43.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c43.fv2",
        },
      },--NAKED
    },--playerParts
  },--C43
  {
    name="C44",
    description="Camoflage Green",
    developId=19137,
    playerCamoType=65,
    fovaCamoId=44,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c44.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c44.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v44.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v44.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c44.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c44.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c44.fv2",
        },
      },--NAKED
    },--playerParts
  },--C44
  {
    name="C45",
    description="Iron Green",
    developId=19138,
    playerCamoType=66,
    fovaCamoId=45,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c45.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c45.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v45.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v45.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c45.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c45.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c45.fv2",
        },
      },--NAKED
    },--playerParts
  },--C45
  {
    name="C47",
    description="Light Rubber",
    developId=19139,
    playerCamoType=67,
    fovaCamoId=47,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c47.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c47.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v47.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v47.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c47.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c47.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c47.fv2",
        },
      },--NAKED
    },--playerParts
  },--C47
  {
    name="C48",
    description="Red Rust",
    developId=19140,
    playerCamoType=68,
    fovaCamoId=48,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c48.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c48.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v48.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v48.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c48.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c48.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c48.fv2",
        },
      },--NAKED
    },--playerParts
  },--C48
  {
    name="C50",
    description="Steel Green",
    developId=19141,
    playerCamoType=69,
    fovaCamoId=50,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c50.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c50.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v50.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v50.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c50.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c50.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c50.fv2",
        },
      },--NAKED
    },--playerParts
  },--C50
  {
    name="C51",
    description="Steel Orange",
    developId=19142,
    playerCamoType=70,
    fovaCamoId=51,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c51.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c51.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v15.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v51.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c51.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c51.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c51.fv2",
        },
      },--NAKED
    },--playerParts
  },--C51
  {
    name="C53",
    description="Mud",
    developId=19143,
    playerCamoType=71,
    fovaCamoId=53,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c53.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c53.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v53.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v53.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c53.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c53.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c53.fv2",
        },
      },--NAKED
    },--playerParts
  },--C53
  {
    name="C54",
    description="Steel Blue",
    developId=19144,
    playerCamoType=72,
    fovaCamoId=54,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c54.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c54.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v54.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v54.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c54.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c54.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c54.fv2",
        },
      },--NAKED
    },--playerParts
  },--C54
  {
    name="C55",
    description="Dark Rust",
    developId=19145,
    playerCamoType=73,
    fovaCamoId=55,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c55.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c55.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v55.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v55.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c55.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c55.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c55.fv2",
        },
      },--NAKED
    },--playerParts
  },--C55
  {
    name="C56",
    description="Citrullus two-tone",
    developId=19146,
    playerCamoType=74,
    fovaCamoId=56,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c56.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c56.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v56.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v56.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c56.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c56.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c56.fv2",
        },
      },--NAKED
    },--playerParts
  },--C56
  {
    name="C57",
    description="Gold Tiger Stripe Two-tone",
    developId=19147,
    playerCamoType=75,
    fovaCamoId=57,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c57.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c57.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v57.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v57.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c57.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c57.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c57.fv2",
        },
      },--NAKED
    },--playerParts
  },--C57
  {
    name="C58",
    description="Birch Leaf Two-tone",
    developId=19148,
    playerCamoType=76,
    fovaCamoId=58,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c58.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c58.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v58.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v58.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c58.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c58.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c58.fv2",
        },
      },--NAKED
    },--playerParts
  },--C58
  {
    name="C59",
    description="Stone Two-tone",
    developId=19149,
    playerCamoType=77,
    fovaCamoId=59,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c59.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c59.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v59.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v59.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c59.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c59.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c59.fv2",
        },
      },--NAKED
    },--playerParts
  },--C59
  {
    name="C60",
    description="Khaki Two-tone",
    developId=19150,
    playerCamoType=78,
    fovaCamoId=60,
    playerParts={
      NORMAL={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c60.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c60.fv2",
        },
        DD_MALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v60.fv2",
        },
        DD_FEMALE={
          fpk="/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v60.fv2",
        },
      },
      NORMAL_SCARF=true,
      NAKED={
        SNAKE={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c60.fv2",
        },
        AVATAR={
          fpk="/Assets/tpp/pack/player/fova/plfova_sna8_main0_c60.fpk",
          fv2="/Assets/tpp/fova/chara/sna/sna8_main0_c60.fv2",
        },
      },--NAKED
    },--playerParts
  },--C60
  ---------------------
  --tex SNAKE/AVATAR exe entries are all default fatigues (as is the playerParts)
  --even though it doesnt look up the table for swimwear
  --"/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",--DEFAULT
  --"/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",--DEFAULT
  --tex the actual fpk/fv2s seem to be the same between DD_MALE/DD_FEMALE
  --and the same between SWIMWEAR,SWIMWEAR_H,SWIMWEAR_G
  {
    name="SWIMWEAR_C00",
    description="Olive Drab",
    developId=19151,
    playerCamoType=79,
    playerParts={
      SWIMWEAR=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2",
      },
    },
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
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2",
      },
    },
  },
  --
  {
    name="SWIMWEAR_G_C00",
    description="Olive Drab",
    developId=19163,
    playerCamoType=91,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C01",
    description="Tiger Stripe",
    developId=19164,
    playerCamoType=92,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C02",
    description="Gold Tiger",
    developId=19165,
    playerCamoType=93,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C03",
    description="Desert Fox",
    developId=19166,
    playerCamoType=94,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C05",
    description="Wet Work",
    developId=19167,
    playerCamoType=95,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C06",
    description="Splitter",
    developId=19168,
    playerCamoType=96,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v06.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v06.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v06.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v06.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C38",
    description="Parasite Mist",
    developId=19169,
    playerCamoType=97,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C39",
    description="Old Rose",
    developId=19167,
    playerCamoType=98,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C44",
    description="Camoflage Green",
    developId=19171,
    playerCamoType=99,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C46",
    description="Iron Blue",
    developId=19172,
    playerCamoType=100,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C48",
    description="Red Rust",
    developId=19173,
    playerCamoType=101,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2,",
      },
    },
  },
  {
    name="SWIMWEAR_G_C53",
    description="Mud",
    developId=19174,
    playerCamoType=102,
    playerParts={
      SWIMWEAR_G=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2,",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2,",
      },
    },
  },
  --
  {
    name="SWIMWEAR_H_C00",
    description="Olive Drab",
    developId=19175,
    playerCamoType=103,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v00.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v00.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C01",
    description="Tiger Stripe",
    developId=19176,
    playerCamoType=104,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v01.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v01.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C02",
    description="Gold Tiger",
    developId=19177,
    playerCamoType=105,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v02.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v02.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C03",
    description="Desert Fox",
    developId=19178,
    playerCamoType=106,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v03.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v03.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C05",
    description="Wet Work",
    developId=19179,
    playerCamoType=107,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v05.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v05.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C06",
    description="Splitter",
    developId=19180,
    playerCamoType=108,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v06.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v06.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v06.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v06.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C38",
    description="Parasite Mist",
    developId=19181,
    playerCamoType=109,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v38.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v38.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C39",
    description="Old Rose",
    developId=19182,
    playerCamoType=110,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v39.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v39.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C44",
    description="Camoflage Green",
    developId=19183,
    playerCamoType=111,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v44.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v44.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C46",
    description="Iron Blue",
    developId=19184,
    playerCamoType=112,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v46.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v46.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C48",
    description="Red Rust",
    developId=19185,
    playerCamoType=113,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v48.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v48.fv2",
      },
    },
  },
  {
    name="SWIMWEAR_H_C53",
    description="Mud",
    developId=19186,
    playerCamoType=114,
    playerParts={
      SWIMWEAR_H=true,
    },
    playerTypes={
      DD_MALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2",
      },
      DD_FEMALE={
        fpk="/Assets/tpp/pack/player/fova/plfova_cmf0_main0_def_v53.fpk",
        fv2="/Assets/tpp/fova/chara/dlf/cmf0_main0_def_v53.fv2",
      },
    },
  },
  {
    name="OCELOT",
    description="Ocelot",
    --developId=,
    playerCamoType=115,
    playerParts={
      OCELOT=true,
    },
    playerTypes={
      OCELOT=true,
    },
  },
  {
    name="QUIET",
    description="Quiet",
    --developId=,
    playerCamoType=116,
    playerParts={
      QUIET=true,
    },
    playerTypes={
      QUIET=true,
    },
  },
}--playerCamoTypesInfo

--WORKAROUND 
--TODO: fill out manually
for i,camoInfo in ipairs(this.playerCamoTypesInfo)do
  if camoInfo.playerParts.NORMAL_SCARF then
    camoInfo.playerParts.NORMAL_SCARF=camoInfo.playerParts.NORMAL
  end
end

--REF Camo fovas
--<id> == two digit fova common camo id (see playerCamoTypesInfo .fovaCamoId and plPartsInfo .modelId above)
--swimsuits have their own ids
--id can be cribbed from p08 in EquipDevelopConstSetting

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
--in /0/00.dat
--/Assets/tpp/pack/player/fova
--plfova_cmf0_main0_def_v<swimsuit camoId>.fpk/d
--ex-plfova_cmf0_main0_def_v46.fpk
--fova files \Assets\tpp\fova\chara\dlf\cmf0_main0_def_v<swimsuit camo id>.fv2

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
  {--0
    name="NONE",
    description="None",
    playerFaceEquipId=0,
  },
  {--1
    name="BANDANA",
    description="Bandana",
    playerFaceEquipId=1,
    playerTypes={
      [PlayerType.SNAKE]=true,
      [PlayerType.AVATAR]=true,
    },
  --playerPartsTypes=normal,scarf,naked,leather jacket
  },
  {--2
    name="INFINITY_BANDANA",
    description="Infinity Bandana",
    playerFaceEquipId=2,
    playerTypes={
      [PlayerType.SNAKE]=true,
      [PlayerType.AVATAR]=true,
    },
  },
  {--3
    name="BALACLAVA",
    description="Balaclava",
    playerFaceEquipId=3,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  --playerPartsTypes=normal,swimsuit
  },
  {--4
    name="SP_HEADGEAR",--Blacktop
    description="SP-Headgear",
    playerFaceEquipId=4,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  --playerPartsTypes=sneaking suits,battledress,swimsuit
  },
  {--5
    name="HP_HEADGEAR",--Greentop
    description="HP-Headgear",
    playerFaceEquipId=5,
    playerTypes={
      [PlayerType.DD_MALE]=true,
      [PlayerType.DD_FEMALE]=true,
    },
  --playerPartsTypes=sneaking suits,battledress
  },
}--playerFaceEquipIdInfo

--tex from LoadPlayerSnakeFaceFpk,Fv2
--indexed by playerFaceId, but bandanas (playerFaceEquipId 1,2) = playerFaceId + 3
--TODO: figure out where playerFaceId chosen for snake
--TODO: document GOLD,SILVER from LoadPlayerSnakeFaceFpk which is tied up in logic
--face3 only used in \Assets\tpp\pack\mission2\story\s10280\s10280_d12.fpk
this.snakeFaceInfo={
  {--0
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face0_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face0_v00.fv2",
  },
  {--1
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face1_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face1_v00.fv2",
  },
  {--2
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face2_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face2_v00.fv2",
  },
  {--3
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face4_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face4_v00.fv2",
  },
  {--4
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face5_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face5_v00.fv2",
  },
  {--5
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face6_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_face6_v00.fv2",
  },
}--snakeFaceInfo

--tex TODO mockfox doesnt dump the enum complete? only NONE,NORMAL, the enum is actually complete though so this is currently only for REF
this.PlayerHandType={
  "NONE",--0
  "NORMAL",--1
  "STUN_ARM",--2
  "JEHUTY",--3
  "STUN_ROCKET",--4
  "KILL_ROCKET",--5
  "GOLD",--6
  "SILVER",--7
}

--tex from exe LoadPlayerBionicArm*, driven by vars.playerHandType
this.playerHandTypes={
  {--0--NONE
    fpk=0,
    fv2=0,
  },
  {--1--NORMAL
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm0_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm0_v00.fv2",
  },
  {--2--STUN_ARM
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm3_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm3_v00.fv2",
  },
  {--3--JEHUTY
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm4_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm4_v00.fv2",
  },
  {--4--STUN_ROCKET
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm2_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm2_v00.fv2",
  },
  {--5--KILL_ROCKET
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm1_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm1_v00.fv2",
  },
  {--6--GOLD
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm6_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm6_v00.fv2",
  },
  {--7--SILVER
    fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm7_v00.fpk",
    fv2="/Assets/tpp/fova/chara/sna/sna0_arm7_v00.fv2",
  },
}--playerHandTypes

--tex mostly for IH ivars to differentiate some features
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

local modelInfoSuffix="_modelInfo"
function this.PrintPlayerBodyVars()
  --  InfCore.DebugPrint"playerTypes"
  --  for n,name in ipairs(this.playerTypes) do
  --    local enum=PlayerType[name]
  --    InfCore.DebugPrint(name.."="..tostring(enum))
  --  end

  --  InfCore.DebugPrint"playerPartsTypes"
  --  for n,name in ipairs(this.playerPartsTypes) do
  --    local enum=PlayerPartsType[name]
  --    InfCore.DebugPrint(name.."="..tostring(enum))
  --  end

  InfCore.DebugPrint"playerCamoTypes"
  for n,name in ipairs(this.playerCamoTypes) do
    local enum=PlayerCamoType[name]
    InfCore.DebugPrint(name.."="..tostring(enum))
  end
end

function this.GetPlayerPartsTypes(playerPartsTypeSettings,playerType)
  local InfFova=this

  local checkDeveloped=Ivars.skipDevelopChecks:Is(0)

  local playerPartsTypes={}
  for i,partsTypeName in ipairs(playerPartsTypeSettings) do
    local partsType=InfFova.PlayerPartsType[partsTypeName]
    if partsType==nil then
      InfCore.Log("WARNING: GetPlayerPartsTypes: partsType==nil for "..tostring(partsTypeName))
    end
    local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]
    if not partsTypeInfo then
      InfCore.Log("WARNING: GetPlayerPartsTypes: could not find partsTypeInfo for "..partsTypeName,true)
    else
      local playerTypeName=InfFova.playerTypes[playerType+1]
      local playerPartsFpk=partsTypeInfo.playerPartsFpk and partsTypeInfo.playerPartsFpk[playerTypeName] or 0
      if playerPartsFpk==0 then
        InfCore.Log("WARNING: GetPlayerPartsTypes: could not find playerPartsFpk for "..partsTypeName.. " "..playerTypeName)
      else
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
  return playerPartsTypes
end


function this.GetCamoTypes(partsTypeName)
  local InfFova=this
  local partsType=InfFova.PlayerPartsType[partsTypeName]
  local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]
  if not partsTypeInfo then
    InfCore.DebugPrint("WARNING: could not find partsTypeInfo for "..partsTypeName)
    return
  end

  local playerTypeName=InfFova.playerTypes[vars.playerType+1]
  --InfCore.DebugPrint(playerTypeName)--DEBUG

  local playerPartsFpk=partsTypeInfo.playerPartsFpk and partsTypeInfo.playerPartsFpk[playerTypeName] or 0

  if playerPartsFpk==0 then
    InfCore.DebugPrint("WARNING: "..partsTypeInfo.name.." does support player type "..tostring(playerTypeName))--DEBUG
    return
  end

  local playerCamoTypes=partsTypeInfo.camoTypes

  if partsTypeInfo.camoTypes==nil then
    local camoType=PlayerCamoType[partsTypeName]
    if camoType~=nil then
      table.insert(playerCamoTypes,partsTypeName)
    else
      InfCore.Log("WARNING: PlayerCamoType nil for "..partsTypeName)--DEBUG
      table.insert(playerCamoTypes,"OLIVEDRAB")--PlayerCamoType 0
    end
  end

  local checkDeveloped=Ivars.skipDevelopChecks:Is(0)

  local checkedCamoTypes={}
  if Ivars.skipDevelopChecks:Is(1) then
    checkedCamoTypes=playerCamoTypes
  else
    for i,camoName in ipairs(playerCamoTypes)do
      local camoType=PlayerCamoType[camoName]
      if camoType then
        local camoInfo=InfFova.playerCamoTypesInfo[camoType+1]
        if camoInfo then
          if camoInfo.developId and checkDeveloped then
            if TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=camoInfo.developId} then
              table.insert(checkedCamoTypes,camoName)
            end
          else
            table.insert(checkedCamoTypes,camoName)
          end
        end
      end
    end
    --tex ivar doesnt switch away/skip on empty camo list, so just add 1 as default
    if #checkedCamoTypes==0 then
      checkedCamoTypes[#checkedCamoTypes+1]=playerCamoTypes[1]
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
    InfCore.Log("WARNING: GetFovaTable playerTypeName==nil",true)
    return
  end
  if playerPartsTypeName==nil then
    InfCore.DebugPrint("WARNING: GetFovaTable playerPartsTypeName==nil",true)
    return
  end
  --InfCore.DebugPrint(playerTypeName.." "..playerPartsTypeName)--DEBUG

  local playerPartsType=this.PlayerPartsType[playerPartsTypeName]
  if playerPartsType==nil then
    InfCore.Log("WARNING: GetFovaTable playerPartsType==nil",true)
    return
  end

  local playerPartsTypeInfo=this.playerPartsTypesInfo[playerPartsType+1]
  if playerPartsTypeInfo==nil then
    InfCore.Log("WARNING: GetFovaTable playerPartsTypeInfo==nil",true)
    return
  end

  if playerPartsTypeInfo.name~=playerPartsTypeName then
    InfCore.Log("WARNING: GetFovaTable playerPartsTypeInfo.name~=playerPartsTypeName",true)
    return
  end

  if playerPartsTypeInfo.playerFpk==nil then
    --TODO: warning off till all filled out
    --InfCore.Log"WARNING: GetFovaTable playerPartsTypeInfo.plPartsName==nil"
    return
  end

  local plPartsName=playerPartsTypeInfo.plPartsName.ALL or playerPartsTypeInfo.plPartsName[playerTypeName]
  if plPartsName==nil then
    InfCore.Log("WARNING: GetFovaTable plPartsName==nil for player type "..tostring(playerTypeName),true)
    return
  end

  local modelDescription=playerPartsTypeInfo.description or playerPartsTypeInfo.name

  if printInfo then
    InfCore.Log("playerType:"..playerTypeName..", playerParts:"..playerPartsTypeName..", plPartName:"..plPartsName,true)
  end

  local moduleName=plPartsName..modelInfoSuffix
  local modelInfo=_G[moduleName]
  if modelInfo then
  --InfCore.DebugPrint("modelInfo "..moduleName.." found")--DEBUG
  else
    --InfCore.DebugPrint("modelInfo "..moduleName.." not found")--DEBUG
    return nil,modelDescription
  end

  local modelInfoDescription=modelInfo.modelDescription
  if modelInfoDescription then
    if type(modelInfoDescription)~="string" then
      InfCore.Log("WARNING: GetFovaTable modelDescription is not a string",true)
    else
      modelDescription=modelInfoDescription
    end
  end

  local noBlackDiamond=modelInfo.noBlackDiamond

  local fovaTable=modelInfo.fovaTable
  if fovaTable==nil then
    --OFF InfCore.DebugPrint"WARNING: GetFovaTable fovaTable==nil"
    return fovaTable,modelDescription,noBlackDiamond
  end
  if #fovaTable==0 then
    InfCore.Log("WARNING: GetFovaTable #fovaTable==0",true)
    return
  end

  return fovaTable,modelDescription,noBlackDiamond
end

function this.GetFovaInfo(fovaTable,fovaIndex)
  local currentFovaInfo=fovaTable[fovaIndex]
  if currentFovaInfo==nil then
    InfCore.DebugPrint"WARNING: GetFovaInfo currentFovaInfo==nil"
    return
  end

  local fovaDescription=currentFovaInfo.fovaDescription

  if fovaDescription then
    if type(fovaDescription)~="string" then
      InfCore.DebugPrint"WARNING: GetFovaInfo fovaDescription~=string"
      fovaDescription=nil
    end
  end


  local fovaFile=currentFovaInfo.fovaFile
  if fovaFile==nil then
    InfCore.DebugPrint"WARNING: GetFovaInfo fovaFile==nil"
    return
  end
  if type(fovaFile)~="string" then
    InfCore.DebugPrint"WARNING: GetFovaInfo fovaFile~=string"
    return
  end

  fovaDescription=fovaDescription or fovaFile

  return fovaDescription,fovaFile
end

function this.FovaInfoChanged(fovaTable,fovaIndex)
  if fovaIndex<1 then
    InfCore.DebugPrint"WARNING: FovaInfoChanged fovaIndex<1"
    return true
  end

  if fovaIndex>#fovaTable then
    --InfCore.DebugPrint"FovaInfoChanged fovaIndex>#fovaTable"--DEBUG
    return true
  end

  if Ivars.fovaPlayerType:Get()~=vars.playerType then
    --InfCore.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end

  if Ivars.fovaPlayerPartsType:Get()~=vars.playerPartsType then
    --InfCore.DebugPrint"FovaInfoChanged Ivars.fovaPlayerType~=vars.playerType"--DEBUG
    return true
  end
end


function this.SetFovaMod(fovaIndex,ignoreChanged)
  --InfCore.DebugPrint("SetFovaMod fovaIndex="..fovaIndex)--DEBUG

  local fovaTable,fovaDescription,noBlackDiamond=this.GetCurrentFovaTable()
  if fovaTable==nil then
    return
  end

  if not ignoreChanged and this.FovaInfoChanged(fovaTable,fovaIndex) then
    --InfCore.DebugPrint"SetFovaMod FovaInfoChanged, returning"--DEBUG
    return
  end


  if fovaIndex>#fovaTable then
    InfCore.DebugPrint"WARNING: SetFovaMod fovaIndex>#fovaTable"
    return
  end

  local fovaDescription,fovaFile=this.GetFovaInfo(fovaTable,fovaIndex)

  --InfCore.DebugPrint("applyfova "..fovaFile)--DEBUG
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

function this.PlayerFaceSanityCheck()
  local faceEquipInfo=this.playerFaceEquipIdInfo[vars.playerFaceEquipId+1]
  if faceEquipInfo and faceEquipInfo.playerTypes and not faceEquipInfo.playerTypes[vars.playerType] then
    vars.playerFaceEquipId=0
  end

  if InfMain.IsOnlineMission(vars.missionCode)then
    if vars.playerFaceId > Soldier2FaceAndBodyData.highestVanillaFaceId then
      if vars.playerType==PlayerType.DD_MALE then
        vars.playerFaceId=0
      elseif vars.playerType==PlayerType.DD_FEMALE then
        vars.playerFaceId=InfEneFova.DEFAULT_FACEID_FEMALE
      end
    end
  end
end

--
function this.LoadLibraries()
  InfCore.LogFlow("InfFova LoadModelInfoModules")

  local path="/Assets/tpp/pack/player/parts/"
  local suffix="_modelInfo"
  local extension=".lua"
  local sucess, err = pcall(function()
    for packName,partsInfo in pairs(this.plPartsInfo) do
      Script.LoadLibrary(path..packName..suffix..extension)
    end
  end)
end

function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnFadeInDirect()
  --tex calling from function rather than msg since it triggers on start, possibly splash or loading screen, which fova naturally doesnt like because it doesn't exist then
  if Ivars.enableFovaMod:Is(1) then
    this.SetFovaMod(Ivars.fovaSelection:Get()+1)
  end
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Messages()
  return Tpp.StrCode32Table{
    UI={
      --tex Helispace mission-prep ui
      {msg="MissionPrep_EndSlotSelect",func=function()
        this.CheckModelChange()
      end},
    },
  }
end

return this
