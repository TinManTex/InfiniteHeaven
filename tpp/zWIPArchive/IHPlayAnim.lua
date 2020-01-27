--DEBUGNOW
local this={}

this.ivarTest={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1,increment=1},
}

this.ivars={--DEBUGNOW
  ivarTest=this.ivarTest,
}

this.playAnimMenu={
  description="Play anim menu",--DEBUGNOW
  context="HELISPACE",
  options={
    "Ivars.ivarTest",
  }
}

this.menuDefs={
  playAnimMenu=this.playAnimMenu,
}

this.langStrings={
  ivarTest="Ivars test",
}

this.packages={
-- DEBUGNOW  "/Assets/tpp/pack/mission2/ih/motionloader.fpk",
--  "/Assets/mgo/pack/player/motion/mgo_player_resident_motion.fpk",--tex in mgo chunk
}

local motions_table = {
  {"Salute",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_start_l.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_idl_l.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_ed_l.gani"
  },

  {"VenomSnake",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_idl_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_ed.gani"
  },

  {"Ocelot",
  "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_idl_l.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/ocep/ocepbud/ocepbud_s_slt_ed.gani"
  },

  {"QuietThumbsUpGood",
  "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_st_l.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_idl_l.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/quip/quipnon/quipnon_s_good_ed_l.gani"
  },


  {"MaruSign",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_6_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_6_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"BatsuSign",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_7_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_7_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"DVolunteer",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_9_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_9_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"DBow",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_8_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_8_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"Push",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_23_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_23_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"Disappointed",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_16_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_16_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"StandAttention",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_21_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_21_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"GratitudeBow",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_22_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_22_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"Karate",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_20_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_20_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"KungFu",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_18_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_18_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"BodyBuilderFrontChest",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_1_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_1_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"BodyBuilderSideChest",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_2_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_2_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"RollDanceUp",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_3_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_3_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"RollDanceSide",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_4_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_4_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },


  {"RollDanceDown",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_5_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_5_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"UDanceUp",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_25_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_25_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"UDanceSide",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_26_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_26_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"LDanceUp",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_28_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_28_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"LDanceSide",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_29_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_29_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"GutsPose",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_17_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_17_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"SuperSUp",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_10_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_10_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"SuperSSide",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_11_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_11_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"
  },

  {"Pointing",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_19_st.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_19_lp.gani",
  "/Assets/mgo/motion/SI_game/fani/bodies/snam/snamidl/snamidl_s_ed.gani"},

  {"missionClearMotionFob",
  "/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani"}
}

function this.AddMissionPacks(missionCode,packPaths)
  --DEBUGNOW
  if missionCode < 5 then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

function this.PlayAnim()
  local index=5
  local subindex=2
  local hold=false
  local arepeat=false
    Player.RequestToPlayDirectMotion {  
    motions_table[index][1],
    {
      motions_table[index][subindex],
      hold,
      "",
      "",
      "",
      arepeat
    },{}
  }
end

return this