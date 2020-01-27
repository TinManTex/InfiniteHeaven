-- InfMotion.lua
-- tex handles playing .ganis on player via Player.RequestToPlayDirectMotion
-- additional player animations can be loaded by seperate fpk with mtar and an TppPlayer2AdditionalMtarData Entity to point to the mtar.
-- (see /Assets/tpp/pack/mission2/ih/ih_additional_motion.fpk)
-- TODO: build an addon system for it if there's interest
local this={}

--REF DEBUGNOW TppPaz has more info on anim system
-->
this.registerIvars={
  'motionGroupIndex',
  'motionGaniIndex',
  'motionHold',
  'motionRepeat',
}

this.motionGroupIndex={
  inMission=true,
  range={min=1,max=2},--DYNAMIC
  GetSettingText=function(self,setting)
    return this.motionGroups[setting]
  end,
  OnSelect=function(self)
    self.range.max=#this.motionGroups
  end,
  OnChange=function(self,previousSetting,setting)
    if setting>#this.motionGroups then
      self:Set(1)
    end
    if setting<1 then
      self:Set(#this.motionGroups)
    end

    --tex make sure it's in bounds
    Ivars.motionGaniIndex:OnSelect()
  end,
  OnActivate=function(self,setting)
    this.PlayCurrentMotion(true)
  end,
}

this.motionGaniIndex={
  inMission=true,
  range={min=1,max=2},--DYNAMIC
  GetSettingText=function(self,setting)
    local groupIndex=Ivars.motionGroupIndex:Get()
    local motionName=this.motionGroups[groupIndex]
    return motionName.." anim:"..setting
  end,
  OnSelect=function(self)
    local groupIndex=Ivars.motionGroupIndex:Get()
    local motionName=this.motionGroups[groupIndex]
    local motionsForGroup=this.motions[motionName]
    self.range.max=#motionsForGroup

    local setting=self:Get()
    if setting>self.range.max then
      self:Set(1)
    end
    if setting<1 then
      self:Set(self.range.max)
    end
  end,
  OnActivate=function(self,setting)
    this.PlayCurrentMotion(true)
  end,
}

this.motionHold={
  range=Ivars.switchRange,
  settingNames="set_switch"
}

this.motionRepeat={
  range=Ivars.switchRange,
  settingNames="set_switch"
}

--menu command
InfMenuCommands.playCurrentMotion={
  isMenuOff=true,
}
--<
-->
this.registerMenus={
  'motionsMenu',
}

this.motionsMenu={
  options={
    "Ivars.motionGroupIndex",
    "Ivars.motionGaniIndex",
    'Ivars.motionHold',
    'Ivars.motionRepeat',
    "InfMotion.StopMotion",
    "InfMotion.PlayCurrentMotion",
  }
}
--< menu defs
-->
this.langStrings={
  eng={
    motionsMenu="Motions menu",
    motionGroupIndex="Motion group",
    motionGaniIndex="Motion number",
    motionHold="Hold motion",
    motionRepeat="Repeat motion",
    stopMotion="Stop motion",
    playCurrentMotion="Play motion",
  },
  help={
    eng={
      motionsMenu="Play different animations on player. A motion group may contain several related animations (usually lead-in, idle, lead-out)",
      motionGroupIndex="Press <Action> to play the selected animation.",
      motionGaniIndex="Press <Action> to play the selected animation.",
      motionHold="Holds motion, requires stop motion to stop.",
      motionRepeat="Repeat motion at end, some animations don't support this.",
      stopMotion="Use to stop motions with motion hold or motion repeat.",
      playCurrentMotion="Closes menu and plays current selected motion.",
    },
  },
}
--<

this.motions={
  --tex looking at anims from mtar_dictionary attack, see https://github.com/TinManTex/mgsv-lookup-strings/tree/master/Strings/brutegen/mtar-gani
--  zzTest={
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_q_ed.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_q_idl.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_q_st.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_s_ed.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_s_idl.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapcig/snapcig_s_st.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_c_b2f_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_c_f2b_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_c_idl_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_c_stp_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/enet/enetnon/enetnon_ful_idl.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_book.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_dh2s_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_p_idl.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_dh_lp.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_idl_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_idl_r.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_tn_0.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_tn_l0.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s2dh_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_rde_rear_st_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_rde_st_l.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_rde_st_r.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_dve_ed_b.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_dve_lp_b.gani",
--    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_dve_st_b.gani",
--  },
  missionClearMotion={"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani"},
  missionClearMotionFob={
    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani",
  },
  end_of_snapdam_s_die_idl_l={
    "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapdam/snapdam_s_die_idl_l.gani",
  },
  --REF mgo AppealActions.lua --DEBUGNOW
  Salute={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_start_l.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_idl_l.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_ed_l.gani"
  },

  VenomSnake={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_idl_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_ed.gani"
  },

  Ocelot={
    "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_idl_l.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_ed.gani"
  },

  QuietThumbsUpGood={
    "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_st_l.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_idl_l.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_ed_l.gani"
  },

  MaruSign={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_6_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_6_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  BatsuSign={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_7_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_7_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  DVolunteer={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_9_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_9_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  DBow={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_8_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_8_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  Push={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_23_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_23_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  Disappointed={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_16_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_16_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  StandAttention={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_21_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_21_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  GratitudeBow={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_22_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_22_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  Karate={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_20_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_20_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  KungFu={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_18_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_18_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  BodyBuilderFrontChest={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_1_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_1_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  BodyBuilderSideChest={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_2_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_2_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  RollDanceUp={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_3_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_3_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  RollDanceSide={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_4_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_4_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },


  RollDanceDown={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_5_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_5_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  UDanceUp={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_25_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_25_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  UDanceSide={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_26_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_26_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  LDanceUp={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_28_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_28_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  LDanceSide={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_29_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_29_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  GutsPose={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_17_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_17_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  SuperSUp={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_10_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_10_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  SuperSSide={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_11_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_11_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  Pointing={
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_19_st.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_19_lp.gani",
    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"},
}

this.motionGroups={}
for name,ganis in pairs(this.motions)do
  this.motionGroups[#this.motionGroups+1]=name
end
table.sort(this.motionGroups)

InfMenuCommands.playCurrentMotion={
  isMenuOff=true,
}
function this.PlayCurrentMotion(dontCloseMenu)
  --tex causes RequestToPlayDirectMotion to not fire, todo: yield/wait a frame?
  --Player.RequestToStopDirectMotion()

  local motionName=this.motionGroups[Ivars.motionGroupIndex:Get()]

  --param2Table
  local ganiPath=this.motions[motionName][Ivars.motionGaniIndex:Get()]
  local holdMotion=Ivars.motionHold:Get()==1
  local unk3GameObjectTargetName=""
  local unk4CNPTargetName=""--tex attachment stuff
  local unk5MTPTargetName=""--tex attachment stuff, the legacy CameraSubjectiveParams has --   attachPointName   = "MTP_GLOBAL_A", with    attachType      = "GlobalMotionPoint", above
  local repeatMotion=Ivars.motionRepeat:Get()==1
  local param2Table={
    ganiPath,
    holdMotion,
    unk3GameObjectTargetName,
    unk4CNPTargetName,
    unk5MTPTargetName,
    repeatMotion,
  }

  --param3Table --tex same type of table as param2, theres only one use case of param2 (not that theres many usages of RequestToPlayDirectMotion)
  local unk7AnimState=""
  local unk8Bool=false
  local unk9GameObjectTargeName=""
  local unk10CNPTargetName=""
  local unk11MTPTargetName=""
  local unk12Bool=true
  local param3Table=nil

  Player.RequestToPlayDirectMotion{motionName,param2Table,param3Table}

  --KLUDGE
  if dontCloseMenu ~= true then
    InfMenu.MenuOff()
  end

  --REF
  --  Player.RequestToPlayDirectMotion {
  --    "rideVehicleRear",
  --    {
  --      "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapplv/snapplv_s_rde_rear_st_l.gani",
  --      false,
  --      "vehs_citadel_0001",
  --      "CNP_ppos_c",
  --      "MTP_GLOBAL_C",
  --      true
  --    },
  --    {
  --      "stateDirectPlayRideRearLeftSeatOnVehicle",
  --      true,
  --      "vehs_citadel_0001",
  --      "CNP_ppos_c",
  --      "MTP_GLOBAL_C",
  --      true
  --    }
  --  }

  --REF
  --  Player.RequestToPlayDirectMotion{
  --    "handBookToPaz",
  --    {
  --      actionPath,
  --      false,
  --      pazLocator,
  --      "Move",
  --      "MTP_GLOBAL_C",
  --      false
  --    }
  --  }
end

function this.StopMotion()
  Player.RequestToStopDirectMotion()
end

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_additional_motion.fpk",
}
--DEBUGNOW add some conditionals
function this.AddMissionPacks(missionCode,packPaths)
  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

return this
