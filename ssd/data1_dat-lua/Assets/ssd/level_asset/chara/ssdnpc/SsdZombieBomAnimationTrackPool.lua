this={}
local variationCount=36
SsdZombie.SetVariationCountBom(variationCount)
local unkTable={13,14,15,17,18,19}
local animTable={
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_200m.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_400m.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_600m.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_800m.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_1000m.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_90_l1.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_90_r1.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_180_l1.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_180_r1.gani","Walk",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_200m.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_400m.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_600m.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_800m.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_1000m.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_90_l1.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_90_r1.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_180_l1.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_180_r1.gani","Dash",true,true,unkTable},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front02.gani","Damage",false,false,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front08.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front09.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front11.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_front12.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back02.gani","Damage",false,false,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back09.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_back12.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_left02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_left03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_left04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_left05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_left06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_damage_right07.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f01.gani","Damage",false,false,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f07.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_f08.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f09.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f10.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f11.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f12.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f13.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f14.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_f15.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b01.gani","Damage",false,false,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b07.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l_b08.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b09.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b10.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b11.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b12.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b13.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b14.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r_b15.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r01.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_r06.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l01.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l02.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l03.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l04.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l05.gani","Damage",false,true,nil},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb/sdzmb_s_dmg_l06.gani","Damage",false,true,nil}
}
SsdZombie.SetAnimationTableBom(animTable)
local extendedAnimTable={
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_200m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_walk_a_200m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_400m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_walk_a_400m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_600m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_walk_a_600m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_800m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_walk_a_800m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_walk_a_1000m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_walk_a_1000m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_90_l1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_wk_90_l1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_90_r1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_wk_90_r1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_180_l1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_wk_180_l1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_wk_180_r1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_wk_180_r1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_200m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_dash_a_200m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_400m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_dash_a_400m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_600m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_dash_a_600m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_800m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_dash_a_800m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_s_dash_a_1000m.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_s_dash_a_1000m_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_90_l1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_dsh_90_l1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_90_r1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_dsh_90_r1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_180_l1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_dsh_180_l1_x.gani"},
  {"/Assets/ssd/motion/SI_game/fani/bodies/sdzm/sdzmb2/sdzmb2_dsh_180_r1.gani","/Assets/ssd/motion/SI_game/fani/ext/sdzm/sdzmb2/sdzmb2_dsh_180_r1_x.gani"}
}
SsdZombie.SetExtendedAnimationTableBom(extendedAnimTable)
return this
