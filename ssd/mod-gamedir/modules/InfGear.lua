-- InfGear.lua --WIP
-- Implments switching of player Gear.
-- Limited point as can't switch color/fova variants (TODO: see if SetGear takes any other parameters, though there's no usage cases of such).
-- though may be useful if adding new gear via registergear/gearconfig is possible.

--NOTES: ssd uses a version of the MGO gear system for player character customization
--SEE: /Assets/ssd/script/gear/RegisterGear.lua, /Assets/ssd/level_asset/config/GearConfig.lua

-- DEP: modified RegisterGear
local this={}

--REF ssd exe TODO: Mock, compare with mgo
--GearType
--CYLINDER
--HELMET
--ARM
--UPPER_BODY
--LOWER_BODY
--INNER
--
--GearGender
--MALE
--FEMALE
--
--GearMaskLevel
--ALLOFF
--ALLON_LV1
--ALLON_LV2
--ALLON_LV3
--
--GearState
--GEAR_STATE_SIZE_BY_UINT32
--GRAR_MAX_COUNT
--RegisterGear
--SetMaskLevel
--SetCylinder
--SetCylinderAll
--SetCylinderLevel
--SetGear
--Gear

--REF s10060_sequence
--PLAYER_DEMO_GEAR_TABLE = {
--  [ PlayerType.AVATAR_MALE ] = {
--    [ GearType.HELMET ] = "hdm18_main0_v00",
--    [ GearType.UPPER_BODY ] = "uam3_main0_v00",
--    [ GearType.ARM ] = "arm17_main0_v00",
--    [ GearType.LOWER_BODY ] = "lgm4_main0_v00",
--  },
--  [ PlayerType.AVATAR_FEMALE ] = {
--    [ GearType.HELMET ] = "hdf18_main0_v00",
--    [ GearType.UPPER_BODY ] = "uaf3_main0_v00",
--    [ GearType.ARM ] = "arf17_main0_v00",
--    [ GearType.LOWER_BODY ] = "lgf4_main0_v00",
--  },
--},

--if Tpp.IsTypeTable( genderGearTable ) then
--  for gearType, modelId in pairs( genderGearTable ) do
--    Gear.SetGear{ type = gearType, id = modelId, }
--  end
--end
--Gear.SetGear{ type=GearType.INNER }

--REF title_sequence
--function this.RestorePlayerGearState()
--  local count = GearState.GRAR_MAX_COUNT * GearState.GEAR_STATE_SIZE_BY_UINT32
--  for i=1, count do
--    vars.gearState[i-1] = this.tmp_gearState[i]
--  end
--end

this.playerTypeToGender={
  [PlayerType.AVATAR_MALE]="Male",
  [PlayerType.AVATAR_FEMALE]="Female",
}

this.gearConfigToGearType={
  --Base=--?
  --Mask=? --tex only male has a mask entry - tnk0_main0_v00, maybe it falls back to male if not femal?
  --??=GearType.CYLINDER,--?
  Helmet=GearType.HELMET,
  Arm=GearType.ARM,
  UpperBody=GearType.UPPER_BODY,
  LowerBody=GearType.LOWER_BODY,
  Inner=GearType.INNER,
}

--tex built from GearConfig
--main1 variants dont actually seem to exist in files unless they are still hashed (but given the fpks are listed in RegisterGear they shouldnt be).
--missing definitions hang the gear change system (processing circle will continue endlessly, further calls to even valid modelids will be ignored)
--there are some fpk files that arent listed in registergear or gearconfig, they will result in game crash instead of hang, or just hang
--then there's entries like bdm0_main0_v01 that map to different fpks (bdm0_main0_v00)
this.gearByType={
  Male = {
    Arm = {
      "arm0_main0_v00",
      "arm1_main0_v00",
      "arm2_main0_v00",
      "arm3_main0_v00",
      "arm4_main0_v00",
      "arm5_main0_v00",
      "arm6_main0_v00",
      "arm7_main0_v00",
      "arm8_main0_v00",
      "arm9_main0_v00",
      --"arm9_main1_v00",
      "arm10_main0_v00",
      "arm11_main0_v00",
      "arm12_main0_v00",
      "arm13_main0_v00",
      "arm14_main0_v00",
      "arm15_main0_v00",
      "arm16_main0_v00",
      "arm17_main0_v00",
      "arm18_main0_v00",
      --"arm18_main1_v00",
      --"arm19_main0_v00",
      --"arm19_main1_v00",
      --"arm20_main0_v00",
      --"arm20_main1_v00",
      "arm21_main0_v00",
      "arm22_main0_v00",
      --"arm22_main1_v00",
      "arm23_main0_v00",
      --"arm23_main1_v00",
      "arm24_main0_v00",
    --"arm24_main1_v00",
    --"arm25_main0_v00",
    --"arm25_main1_v00",
    --"arm26_main0_v00",
    --"arm26_main1_v00",
    },

    Helmet = {
      "eye_m04",
      "hat30_main0_v00",
      "hat_f31",
      "hat_m09",
      "hat_m13",
      "hat_m21",
      "hdm0_main0_v00",
      "hdm1_main0_v00",
      "hdm2_main0_v00",
      "hdm3_main0_v00",
      "hdm4_main0_v00",
      "hdm5_main0_v00",
      "hdm6_main0_v00",
      "hdm7_main0_v00",
      --"hdm7_main1_v00",
      "hdm8_main0_v00",
      "hdm9_main0_v00",
      "hdm10_main0_v00",
      "hdm11_main0_v00",
      "hdm12_main0_v00",
      "hdm13_main0_v00",
      "hdm14_main0_v00",
      "hdm15_main0_v00",
      "hdm16_main0_v00",
      "hdm17_main0_v00",
      "hdm18_main0_v00",
      "hdm19_main0_v00",
      "hdm20_main0_v00",
      --"hdm20_main1_v00",
      "hdm21_main0_v00",
      --"hdm22_main0_v00",
      --"hdm22_main1_v00",
      --"hdm23_main0_v00",
      --"hdm23_main1_v00",
      "hdm24_main0_v00",
      "hdm25_main0_v00",
      "hdm26_main0_v00",
      --"hdm26_main1_v00",
      "hdm27_main0_v00",
      --"hdm27_main1_v00",
      "hdm28_main0_v00",
      --"hdm28_main1_v00",
      --"hdm29_main0_v00",
      --"hdm29_main1_v00",
      --"hdm30_main0_v00",
      --"hdm30_main1_v00",
      "hdm31_main0_v00",
    --tex not listed in registergear or gearconfig but fpks exist
    --will crash game instead of hang
    --TODO: add to registergear
          "hdm90_main0_v00",
    --      "hdm91_main0_v00",
    --      "hdm92_main0_v00",
    },

    Inner = {
      "bdm0_main0_v01",
      "bdm5_main0_v01",
      "bdm6_main0_v01",
      "bdm7_main0_v01",
      "bdm8_main0_v01",
      "bdm9_main0_v01",
      "bdm10_main0_v01",
      "bdm11_main0_v01",
      "bdm12_main0_v01",
      "bdm13_main0_v01",
      "bdm14_main0_v01",
      --"bdm15_main0_v01",
      --tex has fpks
--      "bdm1_main0_v00",
--      "bdm1_main1_v00",
--      "bdm1_main2_v00",
      --tex there more fpks untested
    },

    LowerBody = {
      "lgm0_main0_v00",
      "lgm1_main0_v00",
      "lgm2_main0_v00",
      "lgm3_main0_v00",
      "lgm4_main0_v00",
      "lgm5_main0_v00",
      --"lgm5_main1_v00",
      "lgm6_main0_v00",
      "lgm7_main0_v00",
      "lgm8_main0_v00",
      "lgm9_main0_v00",
      "lgm10_main0_v00",
      "lgm11_main0_v00",
      "lgm12_main0_v00",
      "lgm13_main0_v00",
      "lgm14_main0_v00",
      "lgm15_main0_v00",
      "lgm16_main0_v00",
      "lgm17_main0_v00",
      "lgm18_main0_v00",
      "lgm19_main0_v00",
      --"lgm19_main1_v00",
      --"lgm20_main0_v00",
      --"lgm20_main1_v00",
      --"lgm21_main0_v00",
      --"lgm21_main1_v00",
      "lgm22_main0_v00",
      --"lgm22_main1_v00",
      "lgm23_main0_v00",
      --"lgm23_main1_v00",
      "lgm24_main0_v00",
      --"lgm24_main1_v00",
      "lgm25_main0_v00",
      --"lgm25_main1_v00",
      "lgm26_main0_v00",
    --"lgm26_main1_v00",
    },

    Mask = { "tnk0_main0_v00" },

    UpperBody = {
      "rgm0_main0_v00",
      "rgm1_main0_v00",
      "rgm2_main0_v00",
      "rgm3_main0_v00",
      "rgm4_main0_v00",
      "rgm5_main0_v00",
      "rgm6_main0_v00",
      "rgm7_main0_v00",
      "rgm8_main0_v00",
      "rgm9_main0_v00",
      "rgm10_main0_v00",
      "rgm11_main0_v00",
      "rgm12_main0_v00",
      "rgm13_main0_v00",
      "rgm14_main0_v00",
      "rgm15_main0_v00",
      "rgm16_main0_v00",
      "rgm17_main0_v00",
      "rgm18_main0_v00",
      "rgm19_main0_v00",
      "uam0_main0_v00",
      "uam1_main0_v00",
      "uam2_main0_v00",
      --"uam2_main1_v00",
      "uam3_main0_v00",
      "uam4_main0_v00",
      "uam5_main0_v00",
      "uam6_main0_v00",
      "uam7_main0_v00",
      "uam8_main0_v00",
      --"uam8_main1_v00",
      "uam9_main0_v00",
      --"uam9_main1_v00",
      "uam10_main0_v00",
      --"uam10_main1_v00",
      "uam11_main0_v00",
      --"uam11_main1_v00",
      "uam12_main0_v00",
      --"uam12_main1_v00",
      "uam13_main0_v00",
      --"uam13_main1_v00",
      "uam14_main0_v00",
      --"uam14_main1_v00",
      "uam15_main0_v00",
    --"uam15_main1_v00",
    }
  },
  Female = {
    Arm = {
      "arf0_main0_v00",
      "arf1_main0_v00",
      "arf2_main0_v00",
      "arf3_main0_v00",
      "arf4_main0_v00",
      "arf5_main0_v00",
      "arf6_main0_v00",
      "arf7_main0_v00",
      "arf8_main0_v00",
      "arf9_main0_v00",
      --"arf9_main1_v00",
      "arf10_main0_v00",
      "arf11_main0_v00",
      "arf12_main0_v00",
      "arf13_main0_v00",
      "arf14_main0_v00",
      "arf15_main0_v00",
      "arf16_main0_v00",
      "arf17_main0_v00",
      "arf18_main0_v00",
      --"arf18_main1_v00",
      --"arf19_main0_v00",
      --"arf19_main1_v00",
      --"arf20_main0_v00",
      --"arf20_main1_v00",
      "arf21_main0_v00",
      "arf22_main0_v00",
      --"arf22_main1_v00",
      "arf23_main0_v00",
      --"arf23_main1_v00",
      "arf24_main0_v00",
      --"arf24_main1_v00",
      --"arf25_main0_v00",
      --"arf25_main1_v00",
      --"arf26_main0_v00",
    --"arf26_main1_v00",
    },

    Helmet = {
      "eye_f04",
      "hat_f13",
      "hat_f21",
      "hat_m31",
      "hdf0_main0_v00",
      "hdf1_main0_v00",
      "hdf2_main0_v00",
      "hdf3_main0_v00",
      "hdf4_main0_v00",
      "hdf5_main0_v00",
      "hdf6_main0_v00",
      "hdf7_main0_v00",
      --"hdf7_main1_v00",
      "hdf8_main0_v00",
      "hdf9_main0_v00",
      "hdf10_main0_v00",
      "hdf11_main0_v00",
      "hdf12_main0_v00",
      "hdf13_main0_v00",
      "hdf14_main0_v00",
      "hdf15_main0_v00",
      "hdf16_main0_v00",
      "hdf17_main0_v00",
      "hdf18_main0_v00",
      "hdf19_main0_v00",
      "hdf20_main0_v00",
      --"hdf20_main1_v00",
      "hdf21_main0_v00",
      --"hdf22_main0_v00",
      --"hdf22_main1_v00",
      --"hdf23_main0_v00",
      --"hdf23_main1_v00",
      "hdf24_main0_v00",
      "hdf25_main0_v00",
      "hdf26_main0_v00",
      --"hdf26_main1_v00",
      "hdf27_main0_v00",
      --"hdf27_main1_v00",
      "hdf28_main0_v00",
      --"hdf28_main1_v00",
      --"hdf29_main0_v00",
      --"hdf29_main1_v00",
      --"hdf30_main0_v00",
      --"hdf30_main1_v00",
      "hdf31_main0_v00",
    },

    Inner = {
      "bdf0_main0_v01",
      "bdf5_main0_v01",
      "bdf6_main0_v01",
      "bdf7_main0_v01",
      "bdf8_main0_v01",
      "bdf9_main0_v01",
      "bdf10_main0_v01",
      "bdf11_main0_v01",
      "bdf12_main0_v01",
      "bdf13_main0_v01",
      "bdf14_main0_v01",
      --"bdf15_main0_v01",
    },

    LowerBody = {
      "lgf0_main0_v00",
      "lgf1_main0_v00",
      "lgf2_main0_v00",
      "lgf3_main0_v00",
      "lgf4_main0_v00",
      "lgf5_main0_v00",
      --"lgf5_main1_v00",
      "lgf6_main0_v00",
      "lgf7_main0_v00",
      "lgf8_main0_v00",
      "lgf9_main0_v00",
      "lgf10_main0_v00",
      "lgf11_main0_v00",
      "lgf12_main0_v00",
      "lgf13_main0_v00",
      "lgf14_main0_v00",
      "lgf15_main0_v00",
      "lgf16_main0_v00",
      "lgf17_main0_v00",
      --"lgf18_main0_v00",
      "lgf19_main0_v00",
      --"lgf19_main1_v00",
      --"lgf20_main0_v00",
      --"lgf20_main1_v00",
      --"lgf21_main0_v00",
      --"lgf21_main1_v00",
      "lgf22_main0_v00",
      --"lgf22_main1_v00",
      "lgf23_main0_v00",
      --"lgf23_main1_v00",
      "lgf24_main0_v00",
      --"lgf24_main1_v00",
      --"lgf25_main0_v00",
      --"lgf25_main1_v00",
      --"lgf26_main0_v00",
    --"lgf26_main1_v00",
    },

    Mask = {},

    UpperBody = {
      "rgf0_main0_v00",
      "rgf1_main0_v00",
      "rgf2_main0_v00",
      "rgf3_main0_v00",
      "rgf4_main0_v00",
      "rgf5_main0_v00",
      "rgf6_main0_v00",
      "rgf7_main0_v00",
      "rgf8_main0_v00",
      "rgf9_main0_v00",
      "rgf10_main0_v00",
      "rgf11_main0_v00",
      "rgf12_main0_v00",
      "rgf13_main0_v00",
      "rgf14_main0_v00",
      "rgf15_main0_v00",
      "rgf16_main0_v00",
      "rgf17_main0_v00",
      "rgf18_main0_v00",
      "rgf19_main0_v00",
      "uaf0_main0_v00",
      "uaf1_main0_v00",
      "uaf2_main0_v00",
      --"uaf2_main1_v00",
      "uaf3_main0_v00",
      "uaf4_main0_v00",
      "uaf5_main0_v00",
      "uaf6_main0_v00",
      "uaf7_main0_v00",
      "uaf8_main0_v00",
      --"uaf8_main1_v00",
      --"uaf9_main0_v00",
      --"uaf9_main1_v00",
      --"uaf10_main0_v00",
      --"uaf10_main1_v00",
      "uaf11_main0_v00",
      --"uaf11_main1_v00",
      "uaf12_main0_v00",
      --"uaf12_main1_v00",
      "uaf13_main0_v00",
      --"uaf13_main1_v00",
      --"uaf14_main0_v00",
      --"uaf14_main1_v00",
      --"uaf15_main0_v00",
    --"uaf15_main1_v00",
    }
  },
}

this.registerIvars={
  "gear_Helmet",
  "gear_Arm",
  "gear_UpperBody",
  "gear_LowerBody",
  "gear_Inner",
}

this.OnSelectGear=function(self)
  local gender=this.playerTypeToGender[vars.playerType]
  local gearForGender=this.gearByType[gender]
  local gear=gearForGender[self.gearType]
  self.settings=gear
  self.settingNames=gear
  self.range.max=#self.settings-1
end

this.OnActivateGear=function(self,setting)
  local gearType=this.gearConfigToGearType[self.gearType]
  local modelId=self.settings[setting+1]
  InfCore.Log("SetGear("..tostring(gearType)..","..tostring(modelId)..modelId..")")
  Gear.SetGear{type=gearType,id=modelId}
end

this.gear_Helmet={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  gearType="Helmet",
  OnSelect=this.OnSelectGear,
  OnActivate=this.OnActivateGear,
}

this.gear_Arm={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  gearType="Arm",
  OnSelect=this.OnSelectGear,
  OnActivate=this.OnActivateGear,
}

this.gear_UpperBody={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  gearType="UpperBody",
  OnSelect=this.OnSelectGear,
  OnActivate=this.OnActivateGear,
}

this.gear_LowerBody={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  gearType="LowerBody",
  OnSelect=this.OnSelectGear,
  OnActivate=this.OnActivateGear,
}

this.gear_Inner={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  gearType="Inner",
  OnSelect=this.OnSelectGear,
  OnActivate=this.OnActivateGear,
}

this.registerMenus={
  "gearMenu",
}

this.gearMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfGear.gear_Helmet",
    "InfGear.gear_Arm",
    "InfGear.gear_UpperBody",
    "InfGear.gear_LowerBody",
    "InfGear.gear_Inner",
  },
}

this.langStrings={
  eng={
    --gearMenu="Gear menu",
  },
  help={
    eng={
      gearMenu="WIP changing gear parts directly",
    },
  }
}

function this.PostAllModulesLoad()
  --InfCore.PrintInspect(GearConfig,"GearConfig")--DEBUGNOW GearConfig module is nil? Its LoadLibraried like everything else I dont know why

  --DEPENDANCY: modified GearConfig which has table outside of the SsdGearConfig.Gears function call.
  --local gears--=GearConfig.gears.GearConfig.Infil--DEBUGNOW
  --  this.gearByType={}
  --  for gender,gearConfig in pairs(gears.GearConfig.Infil)do--tex ssd only uses Infil class
  --    this.gearByType[gender]={}
  --    for gearType,gearInfos in pairs(gearConfig)do
  --      local gearConfigForType={}
  --      this.gearByType[gender][gearType]=gearConfigForType
  --
  --      for i,gearInfo in ipairs(gearInfos)do
  --        if gearInfo.ID then
  --          --gearConfigForType[gearInfo.ID]={Color=gearInfo.Color.DefaultPrimary}
  --          table.insert(gearConfigForType,gearInfo.ID)
  --        end
  --      end
  --      table.sort(gearConfigForType)
  --    end
  --  end

  --InfCore.PrintInspect(InfGear.gearByType,"InfGear.gearByType")--DEBUGNOW
end

return this
