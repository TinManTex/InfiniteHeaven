--InfPlayerParts.lua
--DEPENDENCY: IHHook
--namespace CharacterFova
--tex extending vars.player* character select system via IHHook
--see InfFova for documentation on existing character values
--notes before i forget
--underlying variable for playerType,playerPartsType,playerCamoType is char/1 byte so max 256 (0-255)
--loadplayerbleh functions trigger on playerType and playerCamoType change but not playerPartsType VERIFY
--AVATAR player parts not being identical to SNAKE cause the change to fail to load in ACC (due to the 2nd player instance for the 'reflection')
--does not seem to cause an issue in-mission where there is only the singular player instance

--REF playerPartsInfo lua in MGS_TPP\mod\playerParts
--filling out all params rather than working example
--local this={
--  name="DD_MALE_SWIMWEAR",
--  infoType="PLAYERPARTS",
--  description="normal dd male swimwear",--for ih character select option
--  playerTypeName="DD_MALE",--vars.playerType name, or nil for all playerTypes. there's still so much tied to playerType that cant yet divorce playerParts from it entirely, nor create new ones
--  partsTypeName="SWIMWEAR",--vars.playerPartsType name or a common name for collating playerParts for different playerTypes to one logical id
--  partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_swimwear.fpk",
--  partsParts="/Assets/tpp/parts/chara/dlf/dlf1_main0_def_v00.parts",
--  skinToneFv2="/Assets/tpp/fova/chara/dlf/dlf1_main0_v00.fv2",--tex TODO seems to be limited to the vanilla playerCamoTypes that are set up for it
--  needHead=true,--true=use the head system (for the current playerType) or not (when parts includes head)
--  needBionicHand=false,--SNAKE,AVATAR only, true=show the bionic hand model or not (when parts includes hand)
--}--this
--return this

--DEBUGNOW TODO: search Player.SetUseBlackDiamondEmblem

local this={}

local IHH=IHH

this.infos={
  --tex utility entry to clear everything by pushing it into SetOverrideValues
  --actually turning off requires call SetOverrideCharacterSystem(false) too
  OFF={
    name="OFF",
    description="Off",
    partsFpk="",
    partsParts="",
    skinToneFv2="",
  },

  --tex the (vanilla) individual per .parts (which are essentially per playerType)
  --multple playerParts may be assigned to a playerPartsType
  --InfPlayerParts addon system uses same format, see the REF example for more notes
  NORMAL_SNAKE={
    name="NORMAL_SNAKE",--tex SNAKE_FATIGUES would be better, but wouldn't gel with the AVATAR WORKAROUND below
    description="Normal Fatigues Snake",
    playerTypeName="SNAKE",--vars.playerType name, or nil for all playerTypes. there's still so much tied to playerType that cant yet divorce playerParts from it entirely, nor create new ones
    partsTypeName="NORMAL",--vars.playerPartsType name or a common name for collating playerParts for different playerTypes to one logical id
    partsFpk="/Assets/tpp/pack/player/parts/plparts_normal.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",
    --tex from exe IsHeadNeeded* . needHead false/nil = model includes head, true = load the head for that playerType
    needHead=true,
    --tex from exe/IHHook LoadPlayerBionicArm*, see also playerHandType below
    needBionicHand=true,
  },
  NORMAL_DD_MALE={
    name="NORMAL_DD_MALE",
    description="Normal Fatigues DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="NORMAL",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dd_male.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts",
    --tex see exe/IHHook LoadPlayerPartsSkinToneFv2
    --tex in vanilla this is applied to all DD_M (if CheckPlayerPartsIfShouldApplySkinToneFv2) except those with their own specific fv2s
    --rather than handle in function I'll fill out all values, and make the assumption if it has a value then it should be applied (ie CheckPlayerPartsIfShouldApplySkinToneFv2 isn't nessesary)
    skinToneFv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",
    needHead=true,
  },
  NORMAL_DD_FEMALE={
    name="NORMAL_DD_FEMALE",
    description="Normal Fatigues DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="NORMAL",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dd_female.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2",
    needHead=true,
  },

  NORMAL_SCARF_SNAKE={
    name="NORMAL_SCARF_SNAKE",
    description="Normal Fatigues with scarf Snake",
    playerTypeName="SNAKE",
    partsTypeName="NORMAL_SCARF",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  --tex DEBUGNOW exe actually fills out NORMAL_SCARF arrays for DD_MALE/FEMALE with NORMAL entries
  --even though ui doesn't let you select it, fallback if vars.playerPartsType is set I guess

  --tex sneaking suit for venom head/avatar/bionic arm
  SNEAKING_SUIT_GZ_SNAKE={
    name="SNEAKING_SUIT_GZ_SNAKE",
    description="SV-Sneaking suit (GZ) Snake",
    playerTypeName="SNAKE",
    partsTypeName="SNEAKING_SUIT",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna2_main1_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  --tex cant select in ui
  --includes head, in vanilla arrays for DD_MALE/DD_FEMALE even though its not selectable in ui
  --and is parts includes big boss head and arm (wheres the above sna0_main1_def_v00 is for venom/avatar head and bionic arm)
  SNEAKING_SUIT_GZ_DD_MALE={
    name="SNEAKING_SUIT_GZ_DD_MALE",
    description="SV-Sneaking suit (GZ) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="SNEAKING_SUIT",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
  --needHead=true,--DEBUGNOW see what vanilla value is, the actual parts includes head so this should rightly be nil/false
  },

  HOSPITAL={
    name="HOSPITAL",
    description="Hospital Prologue",
    partsTypeName="HOSPITAL",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_hospital.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
  },
  --DEBUGNOW
  --  AVATAR_HOSPITAL={
  --    needHead=true,----VANILLA, has a seperate clause return true in IsHeadNeededForPartsTypeAndAvatar for some reason. VERIFY by running the orig func
  --  },

  MGS1={
    name="MGS1",
    description="MGS1 Solid Snake",
    partsTypeName="MGS1",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_mgs1.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
  },
  NINJA={
    name="NINJA",
    description="MGS1 Cyborg Ninja",
    partsTypeName="NINJA",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ninja.fpk",
    partsParts="/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
  },
  RAIDEN={
    name="RAIDEN",
    description="Raiden",
    partsTypeName="RAIDEN",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_raiden.fpk",
    partsParts="/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
  },

  NAKED_SNAKE={
    name="NAKED_SNAKE",
    description="Naked fatigues Snake",
    playerTypeName="SNAKE",
    partsTypeName="NAKED",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_naked.fpk",
    partsParts= "/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  --DD_MALE/DD_MALE NAKED not selectable in ui, but entries fall back to SNAKE NAKED

  SNEAKING_SUIT_TPP_SNAKE={
    name="SNEAKING_SUIT_TPP_SNAKE",
    description="Sneaking suit (TPP) Snake",
    playerTypeName="SNAKE",
    partsTypeName="SNEAKING_SUIT_TPP",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_venom.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna4_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  SNEAKING_SUIT_TPP_DD_MALE={
    name="SNEAKING_SUIT_TPP_DD_MALE",
    description="Sneaking suit (TPP) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="SNEAKING_SUIT_TPP",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_venom.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna4_plym0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
    needHead=true,
  },
  SNEAKING_SUIT_TPP_DD_FEMALE={
    name="SNEAKING_SUIT_TPP_DD_FEMALE",
    description="Sneaking suit (TPP) DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="SNEAKING_SUIT_TPP",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_venom.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna4_plyf0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",--DEBUGNOW plym?
    needHead=true,
  },

  BATTLEDRESS_SNAKE={
    name="BATTLEDRESS_SNAKE",
    description="Battle dress Snake",
    playerTypeName="SNAKE",
    partsTypeName="BATTLEDRESS",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_battledress.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna5_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  BATTLEDRESS_DD_MALE={
    name="BATTLEDRESS_DD_MALE",
    description="Battle dress DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="BATTLEDRESS",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_battledress.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna5_plym0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",
    needHead=true,
  },
  BATTLEDRESS_DD_FEMALE={
    name="BATTLEDRESS_DD_FEMALE",
    description="Battle dress DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="BATTLEDRESS",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_battledress.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna5_plyf0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2",--DEBUGNOW plym?
    needHead=true,
  },

  PARASITE_SNAKE={
    name="PARASITE_SNAKE",
    description="Parasite suit Snake",
    playerTypeName="SNAKE",
    partsTypeName="PARASITE",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_parasite.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna7_main0_def_v00.parts",
    needBionicHand=true,
  },
  PARASITE_DD_MALE={
    name="PARASITE_DD_MALE",
    description="Parasite suit DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="PARASITE",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_parasite.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna7_plym0_def_v00.parts",
  },
  PARASITE_DD_FEMALE={
    name="PARASITE_DD_FEMALE",
    description="Parasite suit DD Male",
    playerTypeName="DD_FEMALE",
    partsTypeName="PARASITE",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_parasite.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna7_plyf0_def_v00.parts",
  },

  LEATHER_SNAKE={
    name="LEATHER_SNAKE",
    description="Leather jacket Snake",
    playerTypeName="SNAKE",
    partsTypeName="LEATHER",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_leather.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  --DD_MALE/FEMALE not selectable in ui, arrays same values as SNAKE_LEATHER

  GOLD_SNAKE={
    name="GOLD_SNAKE",
    description="Naked Gold Snake",
    playerTypeName="SNAKE",
    partsTypeName="GOLD",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_gold.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna9_main0_def_v00.parts",
    needHead=true,--DEBUGNOW has seperate head handling to apply gold head
    needBionicHand=true,
  },
  --DD_MALE/FEMALE have 0 for their path array entries

  SILVER_SNAKE={
    name="SILVER_SNAKE",
    description="Naked Silver Snake",
    playerTypeName="SNAKE",
    partsTypeName="SILVER",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_silver.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna9_main1_def_v00.parts",
    needHead=true,--DEBUGNOW has seperate head handling to apply silver head
    needBionicHand=true,
  },
  --DD_MALE/FEMALE have 0 for their path array entries

  AVATAR_EDIT_MAN={
    name="AVATAR_EDIT_MAN",
    partsTypeName="AVATAR_EDIT_MAN",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
    partsParts="/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts",
    needHead=true,
  },

  MGS3_SNAKE={
    name="MGS3_SNAKE",
    description="Fatigues (NS) Snake",
    playerTypeName="SNAKE",
    partsTypeName="MGS3",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dla0_main0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dla0_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  MGS3_DD_MALE={
    name="MGS3_DD_MALE",
    description="Fatigues (NS) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="MGS3",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dla0_plym0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dla0_plym0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dla/dla0_plym0_v00.fv2",
    needHead=true,
  },
  --DD_FEMALE has 0 for its path entries

  MGS3_NAKED_SNAKE={
    name="MGS3_NAKED_SNAKE",
    description="Fatigues Naked (NS) Snake",
    playerTypeName="SNAKE",
    partsTypeName="MGS3_NAKED",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dla1_main0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dla1_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  MGS3_NAKED_DD_MALE={
    name="MGS3_NAKED_DD_MALE",
    description="Fatigues Naked (NS) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="MGS3_NAKED",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dla1_plym0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dla1_plym0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dla/dla1_plym0_v00.fv2",
    needHead=true,
  },
  --DD_FEMALE has 0 for its path entries

  MGS3_SNEAKING_SNAKE={
    name="MGS3_SNEAKING_SNAKE",
    description="Sneaking Suit (NS) Snake",
    playerTypeName="SNAKE",
    partsTypeName="MGS3_SNEAKING",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dlb0_main0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dlb0_main0_def_v00.parts",
    needHead=true,
    needBionicHand=true,
  },
  MGS3_SNEAKING_DD_MALE={
    name="MGS3_SNEAKING_DD_MALE",
    description="Sneaking Suit (NS) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="MGS3_SNEAKING",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dlb0_plym0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dlb0_plym0_def_v00.parts",
    needHead=true,
  },
  --DD_FEMALE has 0 for its path entries

  MGS3_TUXEDO_SNAKE={
    name="MGS3_TUXEDO_SNAKE",
    description="Tuxedo Snake",
    playerTypeName="SNAKE",
    partsTypeName="MGS3_TUXEDO",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dld0_main0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dld/dld0_main0_sna.fv2",--DEBUGNOW skintone snake wut?
    needHead=true,
    needBionicHand=true,
  },
  MGS3_TUXEDO_DD_MALE={
    name="MGS3_TUXEDO_DD_MALE",
    description="Sneaking Suit (NS) DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="MGS3_TUXEDO",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dld0_plym0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dld0_plym0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dld/dld0_plym0_v00.fv2",
    needHead=true,
  },
  --DD_FEMALE has 0 for its path entries

  --SNAKE no selectable in ui, but has same values for its path entries
  -- EVA_CLOSE_SNAKE={--DEBUGNOW uhh
  --    name="EVA_CLOSE",
  --    description="Jumpsuit (EVA)",
  --    playerTypeName="SNAKE",
  --    partsTypeName="EVA_CLOSE",
  --    partsFpk="/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk",
  --    partsParts="/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts",
  --    needHead=true,
  --  },
  EVA_CLOSE_DD_FEMALE={
    name="EVA_CLOSE_DD_FEMALE",
    description="Jumpsuit (EVA) DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="EVA_CLOSE",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dle/dle0_plyf0_v00.fv2",
    needHead=true,
  },
  --DD_MALE has 0 for its path entries

  --SNAKE no selectable in ui, but has same values for its path entries
  BOSS_CLOSE_DD_FEMALE={
    name="BOSS_CLOSE_DD_FEMALE",
    description="Sneaking Suit (TB)",
    playerTypeName="DD_FEMALE",
    partsTypeName="BOSS_CLOSE",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts",
    --skinToneFv2=--tex DEBUGNOW why no skintone?
    needHead=true,
  },
  --DD_MALE has 0 for its path entries
  --SNAKE no selectable in ui, but has same values for its path entries
  BOSS_OPEN_DD_FEMALE={
    name="BOSS_OPEN_DD_FEMALE",
    description="Sneaking Suit open (TB)",
    playerTypeName="DD_FEMALE",
    partsTypeName="BOSS_OPEN",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlc/dlc1_plyf0_v00.fv2",
    needHead=true,
  },
  --DD_MALE has 0 for its path entries

  --SNAKE has plparts normal for its path entries
  SWIMWEAR_DD_MALE={
    name="SWIMWEAR_DD_MALE",
    description="Swimsuit DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="SWIMWEAR",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_swimwear.fpk",
    partsParts="/Assets/tpp/parts/chara/dlf/dlf1_main0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlf/dlf1_main0_v00.fv2",
    needHead=true,
  },
  SWIMWEAR_DD_FEMALE={
    name="SWIMWEAR_DD_FEMALE",
    description="Swimsuit DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="SWIMWEAR",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear.fpk",
    partsParts="/Assets/tpp/parts/chara/dlf/dlf0_main0_def_f_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlf/dlf1_main0_f_v00.fv2",
    needHead=true,
  },

  --SNAKE has plparts normal for its path entries
  SWIMWEAR_G_DD_MALE={
    name="SWIMWEAR_G_DD_MALE",
    description="Goblin Swimsuit DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="SWIMWEAR_G",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_g.fpk",
    partsParts="/Assets/tpp/parts/chara/dlg/dlg1_main0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlg/dlg1_main0_v00.fv2",
    needHead=true,
  },
  SWIMWEAR_G_DD_FEMALE={
    name="SWIMWEAR_G_DD_FEMALE",
    description="Goblin Swimsuit DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="SWIMWEAR_G",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_g.fpk",
    partsParts="/Assets/tpp/parts/chara/dlg/dlg0_main0_def_f_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlg/dlg1_main0_f_v00.fv2",
    needHead=true,
  },

  --SNAKE has plparts normal for its path entries
  SWIMWEAR_H_DD_MALE={
    name="SWIMWEAR_H_DD_MALE",
    description="Megalodon Swimsuit DD Male",
    playerTypeName="DD_MALE",
    partsTypeName="SWIMWEAR_H",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_h.fpk",
    partsParts="/Assets/tpp/parts/chara/dlh/dlh1_main0_def_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlh/dlh1_main0_v00.fv2",
    needHead=true,
  },
  SWIMWEAR_H_DD_FEMALE={
    name="SWIMWEAR_H_DD_FEMALE",
    description="Megalodon Swimsuit DD Female",
    playerTypeName="DD_FEMALE",
    partsTypeName="SWIMWEAR_H",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_h.fpk",
    partsParts="/Assets/tpp/parts/chara/dlh/dlh0_main0_def_f_v00.parts",
    skinToneFv2="/Assets/tpp/fova/chara/dlh/dlh1_main0_f_v00.fv2",
    needHead=true,
  },

  --tex while exe does fill out other player types to be their defaults,
  --it doesnt include the actual ocelot parts paths since it just returns them directly
  --on playerType rather than using the playerPartsType[playerType] array
  OCELOT_OCELOT={
    name="OCELOT_OCELOT",
    description="Ocelot",
    playerTypeName="OCELOT",
    partsTypeName="OCELOT",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_ocelot.fpk",
    partsParts="/Assets/tpp/parts/chara/ooc/ooc0_main1_def_v00.parts",
  },
  --tex same deal as ocelot except it has 0 for paths?
  QUIET_QUIET={
    name="QUIET_QUIET",
    description="Quiet",
    playerTypeName="QUIET",
    partsTypeName="QUIET",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_quiet.fpk",
    partsParts="/Assets/tpp/parts/chara/qui/quip_main0_def_v00.parts",
  },

  --tex non vanilla
  --tex same deal as above except there's no actual playerPartsType/playerCamoType (it just returns these hardcoded paths on playerType)
  --  LIQUID_LIQUID={
  --    name="LIQUID_LIQUID",
  --    description="Liquid",
  --    playerTypeName="LIQUID",
  --    partsTypeName="LIQUID",
  --    partsFpk="/Assets/tpp/pack/player/parts/plparts_liquid.fpk",
  --    partsParts="/Assets/tpp/parts/chara/lqd/lqd0_main0_ply_v00.parts",
  --  },

  --tex see SNEAKING_SUIT_GZ_DD_MALE
  --tex includes BB head and arm, so no playerType restriction
  SNEAKING_SUIT_GZ_BIGBOSS={
    name="SNEAKING_SUIT_GZ_BIGBOSS",
    description="SV-Sneaking suit (GZ) BigBoss",
    partsTypeName="SNEAKING_SUIT",
    partsFpk="/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
    partsParts="/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
  },
}--infos

this.names={
  "OFF",
}
this.vanillaNames={
  "NORMAL_SNAKE",
  "NORMAL_AVATAR",
  "NORMAL_DD_MALE",
  "NORMAL_DD_FEMALE",
  "NORMAL_SCARF_SNAKE",
  "NORMAL_SCARF_AVATAR",
  "SNEAKING_SUIT_GZ_SNAKE",
  "SNEAKING_SUIT_GZ_AVATAR",--DEBUGNOW not showing up for avatar
  "SNEAKING_SUIT_GZ_DD_MALE",
  "SNEAKING_SUIT_GZ_BIGBOSS",--tex
  "HOSPITAL",
  "MGS1",
  "NINJA",
  "RAIDEN",
  "NAKED_SNAKE",
  "NAKED_AVATAR",
  "SNEAKING_SUIT_TPP_SNAKE",
  "SNEAKING_SUIT_TPP_AVATAR",
  "SNEAKING_SUIT_TPP_DD_MALE",
  "SNEAKING_SUIT_TPP_DD_FEMALE",
  "BATTLEDRESS_SNAKE",
  "BATTLEDRESS_AVATAR",
  "BATTLEDRESS_DD_MALE",
  "BATTLEDRESS_DD_FEMALE",
  "PARASITE_SNAKE",
  "PARASITE_AVATAR",
  "PARASITE_DD_MALE",
  "PARASITE_DD_FEMALE",
  "LEATHER_SNAKE",
  "LEATHER_AVATAR",
  "GOLD_SNAKE",
  "GOLD_AVATAR",
  "SILVER_SNAKE",
  "SILVER_AVATAR",
  --"AVATAR_EDIT_MAN",--tex problematic
  "MGS3_SNAKE",
  "MGS3_AVATAR",
  "MGS3_DD_MALE",
  "MGS3_NAKED_SNAKE",
  "MGS3_NAKED_AVATAR",
  "MGS3_NAKED_DD_MALE",
  "MGS3_SNEAKING_SNAKE",
  "MGS3_SNEAKING_AVATAR",
  "MGS3_SNEAKING_DD_MALE",
  "MGS3_TUXEDO_SNAKE",
  "MGS3_TUXEDO_AVATAR",
  "MGS3_TUXEDO_DD_MALE",
  "EVA_CLOSE_DD_FEMALE",
  "BOSS_CLOSE_DD_FEMALE",
  "BOSS_OPEN_DD_FEMALE",
  "SWIMWEAR_DD_MALE",
  "SWIMWEAR_DD_FEMALE",
  "SWIMWEAR_G_DD_MALE",
  "SWIMWEAR_G_DD_FEMALE",
  "SWIMWEAR_H_DD_MALE",
  "SWIMWEAR_H_DD_FEMALE",
  "OCELOT_OCELOT",
  "QUIET_QUIET",
--  "LIQUID_LIQUID",
}--vanillaNames

--EXEC WORKAROUND, in vanilla they are the same (or rather it just uses one array for both SNAKE/AVATAR)
--rather that have similar logic, i'll dupe/fill out the data
for partsInfoName,partsInfo in pairs(this.infos)do
  local info={}
  if partsInfo.playerTypeName=="SNAKE"then
    for k,v in pairs(partsInfo)do
      info[k]=v
    end
    info.playerTypeName="AVATAR"
    info.name=info.partsTypeName.."_"..info.playerTypeName
    info.description=info.name
    this.infos[info.name]=info
  end--if SNAKE
end--for infos
--KLUDGE: tacked on GZ suffix means partsTypeName doesn't match for name
this.infos.SNEAKING_SUIT_GZ_AVATAR=this.infos.SNEAKING_SUIT_AVATAR
this.infos.SNEAKING_SUIT_GZ_AVATAR.name=this.infos.SNEAKING_SUIT_GZ_AVATAR
this.infos.SNEAKING_SUIT_AVATAR=nil

for i,partsInfoName in pairs(this.vanillaNames)do
  table.insert(this.names,partsInfoName)
end--for playerPartsTypes

function this.PostAllModulesLoad(isReload)
  if not IHH then
    return
  end

  this.LoadInfos()

  local setting=Ivars.character_playerParts:Get()
  this.ApplyInfo(setting)

  if this.debugModule then
    InfCore.Log("InfPlayerParts")
    InfCore.PrintInspect(this.infos,"infos")
    InfCore.PrintInspect(this.names,"names")
  end
end--PostAllModulesLoad

function this.OnAllocate(missionTable)
  if InfMain.IsOnlineMission(vars.missionCode) then
    IHH.SetOverrideCharacterSystem(false)
  else
  --DEBUGNOW reapply?
  end
end--OnAllocate

--currently UNUSED
--TODO: playerType warn?
function this.SetCharacterOverride(name)
  if name=="OFF"then
    --InfCore.Log("WARNING: InfPlayerParts.SetCharacterOverride OFF")
    IHH.SetOverrideCharacterSystem(false)
    --tex theres an "OFF" entry that will clear the paths, but not strictly nessesary since those funcs are gated by overrideCharacterSystem
  end

  local info=this.infos[name]
  if info==nil then
    InfCore.Log("WARNING: InfPlayerParts.SetCharacterOverride could not find info for "..tostring(name))
  else
    this.SetOverrideValues(info)
    if info.playerTypeName and PlayerType[info.playerTypeName]~=vars.playerType then
      InfCore.Log("WARNING: InfPlayerParts.SetCharacterOverride info playerType does nor match vars.playerType")
    end
  end
end--SetCharacterOverride

function this.SetOverrideValues(partsInfo)
  local playerTypeName=partsInfo.playerTypeName
  local playerType=partsInfo.playerTypeName and PlayerType[partsInfo.playerTypeName] or 255
  IHH.SetPlayerTypeForPartsType(playerType)
  IHH.SetPlayerPartsFpkPath(partsInfo.partsFpk)
  IHH.SetPlayerPartsPartsPath(partsInfo.partsParts)
  IHH.SetSkinToneFv2Path(partsInfo.skinToneFv2)
  IHH.SetUseHeadForPlayerParts(partsInfo.needHead)
  IHH.SetUseBionicHandForPlayerParts(partsInfo.needBionicHand)
end--SetOverrideValues

--Loads \mod\playerParts\*.lua into this.infos
function this.LoadInfos()
  InfCore.LogFlow("InfPlayerParts.LoadInfos")

  local infoPath="playerParts"
  local files=InfCore.GetFileList(InfCore.files[infoPath],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfPlayerParts.LoadInfos: "..fileName)
    local infoName=InfUtil.StripExt(fileName)
    local info=InfCore.LoadSimpleModule(InfCore.paths[infoPath],fileName)
    if not info then
      InfCore.Log("")
    else
      this.infos[infoName]=info
      table.insert(this.names,infoName)
    end
  end--for files

  for infoName, info in pairs(this.infos)do

  end--for infos
end--LoadInfos

--function this.GetInfo()
--  local value=Ivars.character_overrideCharacterSystem:Get()
--  if value<=0 or value > #this.names then
--    Ivars.character_overrideCharacterSystem:Set(0)
--    return nil
--  end
--
--  local name=this.names[value]
--  local info=this.infos[name]
--  return info
--end--GetInfo

function this.RefreshParts()
  --tex KLUDGE force a change so the override values/functions are called TODO: see if you can find the function monitoring vars change
  --tex try and guard against breaking the playerparts system by rapidly changing it (doesnt really work, i think is always true during game)
  if PlayerInfo.OrCheckStatus and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } then
    if vars.playerCamoType==1 then
      vars.playerCamoType=1
    else
      vars.playerCamoType=0
    end
  end
end--RefreshParts

function this.ApplyInfo(setting)
  if setting+1>#this.names then
    InfCore.Log("WARNING: character_playerParts > max")
    ivars.character_playerParts=0
    setting=0
  end
  if setting==0 then
    IHH.SetOverrideCharacterSystem(false)
  else
    local name=this.names[setting+1]
    local partsInfo=this.infos[name]
    if partsInfo==nil then
      InfCore.Log("ERROR: character_playerParts nil for "..tostring(name))
    else
      local playerType=vars.playerType
      local playerTypeName=InfFova.playerTypes[playerType+1]
      InfCore.Log("playerTypeName: "..tostring(playerTypeName))--DEBUGNOW
      if partsInfo.playerTypeName and partsInfo.playerTypeName~=playerTypeName then
        InfCore.Log("WARNING: character_playerParts does not match playerType")
        ivars.character_playerParts=0
      else
        IHH.SetOverrideCharacterSystem(true)
        this.SetOverrideValues(partsInfo)
      end
    end
  end
end--ApplyInfo

this.registerIvars={
  "character_playerParts",
  "character_overrideCharacterSystem",
  "character_playerPartsNeedHead",
  "character_playerPartsNeedHand",
  "character_playerPartsForPlayerType",
}
--DEBUGNOW player parts system tends to hang if you change it too quick
--either guard against with PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, }
--or change this to OnActivate
--tex underlying playerPartsInfo selection, not really surfaced to user,
--using character_playerPartsForPlayerType instead which sets this
--TODO: could replace this with string of playerPartsInfo
this.character_playerParts={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.names,
  OnChange=function(self,setting)
    this.ApplyInfo(setting)
    this.RefreshParts()--KLUDGE
  end,
}--character_playerParts
--tex WORKAROUND, since the ivar system is tied pretty hard to its value
--you cant really supply a filtered view and have it chang and save
--so instead have a seperate ivar that does filter, and just applies/sets the actual value
this.character_playerPartsForPlayerType={
  --save=IvarProc.CATEGORY_EXTERNAL,--tex no save since its just filtered select for the above ivar
  settings={"OFF"},--DYNAMIC
  OnSelect=function(self)
    local partsInfoIndex=Ivars.character_playerParts:Get()
    local currentPartsInfoName=this.names[partsInfoIndex+1]

    local playerType=vars.playerType
    local playerTypeName=InfFova.playerTypes[playerType+1]

    InfUtil.ClearArray(self.settings)
    table.insert(self.settings,"OFF")
    --for partsInfoName,partsInfo in pairs(this.infos)do
    for i,partsInfoName in ipairs(this.names)do
      if partsInfoName~="OFF"then
        local partsInfo=this.infos[partsInfoName]
        if partsInfo then
          if partsInfo.playerTypeName==nil or partsInfo.playerTypeName==playerTypeName then
            if type(partsInfo.partsFpk)~="string"then
              InfCore.Log("WARNING: character_playerPartsForPlayerType "..partsInfoName.." partsFpk~=string")--DEBUGNOW
            else
              table.insert(self.settings,partsInfoName)
            end
          end
        end--if partsInfo
      end
    end--for names
    --table.sort(self.settings)

    IvarProc.SetSettings(self,self.settings)

    --tex this ivar not saved, so find the actual setting
    local foundName=false--tex the index shifting due to installing/uninstalling addons may push the character_playerParts value outside of the playerType
    for i,infoName in ipairs(self.settings)do
      if infoName==currentPartsInfoName then
        ivars[self.name]=i-1--KLUDGE DEBUGNOW
        foundName=true
        break
      end
    end

    if not foundName then
    --tex since this ivar doesnt save will default to 0 anyway
    --InfCore.Log
    end
  end,
  GetSettingText=function(self,setting)
    local infoNameSetting=self.settings[setting+1]
    local info=this.infos[infoNameSetting]
    return info.description or infoNameSetting or "WARNING: invalid value"
  end,
  OnChange=function(self,setting)
    --DEBUGNOW do better
    local infoNameSetting=self.settings[setting+1]
    local info=this.infos[infoNameSetting]
    --tex ivar character_playerParts uses name as settings directly
    local value
    for i,infoName in ipairs(this.names)do
      if infoName==infoNameSetting then
        value=i
        break
      end
    end
    if value==nil then
      InfCore.Log("ERROR: character_playerPartsForPlayerType could not find partsInfoName for setting",true,true)
    else
      Ivars.character_playerParts:Set(value-1)
    end
  end,
}--character_playerPartsForPlayerType

--DEBUG
this.character_overrideCharacterSystem={
  --save=IvarProc.CATEGORY_EXTERNAL,--tex ivar is only for debugging
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    if not IHH then
    --DEBUGNOW
    else
      local enable=setting==1
      IHH.SetOverrideCharacterSystem(enable)
    end
  end,
}
this.character_playerPartsNeedHead={
  --save=IvarProc.CATEGORY_EXTERNAL,--tex ivar is only for debugging
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    if not IHH then
    --DEBUGNOW
    else
      local enable=setting==1
      IHH.SetUseHeadForPlayerParts(enable)
    end
  end,
}
this.character_playerPartsNeedHand={
  --save=IvarProc.CATEGORY_EXTERNAL,--tex ivar is only for debugging
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    if not IHH then
    --DEBUGNOW add lang warn
    else
      local enable=setting==1
      IHH.SetUseBionicHandForPlayerParts(enable)
    end
  end,
}


this.langStrings={
  eng={
    character_playerPartsForPlayerType="Character Suit",
  },
  help={
    eng={
      character_playerPartsForPlayerType=[[Selects playerParts addon (in MGS_TPP\mod\playerParts). Overrides the existing vars.player* / sortie character select.]],
    },
  }
}--langStrings

return this
