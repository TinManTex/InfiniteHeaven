--IHDev_WeaponTest.lua
--r3
--tex: for developers to test CS weapons via a command to drop specific equipment

--Usage: copy this lua to mgs_tpp\mod\modules
--edit the table and use the dropTestEquip option which should have been added to the top of IH in-mission menu (cycle option with left/right and press <activate> to drop).

--If it doesn't seem to be working check the mgs_tpp\mod\ih_log.txt and search for ERROR to see any error caught when IH attempted to load the lua (turn on debugMode in the IH debug menu to catch errors past the initial IH startup)

local this={}

--tex for the DropTestItem command
--GOTCHA: there's a limit to how much equipment the game can load, so turn off the IH custom equip feature which may add many due to combining weaponIdTables, and don't add too many items to this at a time.
this.tppEquipTableTest={
    "EQP_WP_West_thg_010",--wu s.pistol grade 1
    "EQP_WP_West_thg_020",--grade 2
    --"EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
    --"EQP_WP_West_thg_040",--grade 5
--"EQP_WP_West_thg_050",--wu s pistol cb grade7

--  "EQP_IT_Stealth",
--  "EQP_IT_Nvg",
--
--  "EQP_IT_ParasiteMist",
--  "EQP_IT_ParasiteCamouf",
--  "EQP_IT_ParasiteHard",
--  "EQP_IT_InstantStealth",
--  "EQP_IT_Pentazemin",
--  "EQP_IT_Clairvoyance",
--  "EQP_IT_ReflexMedicine",

-- "EQP_SLD_SV",
--  "EQP_SLD_PF_00",
--  "EQP_SLD_PF_01",
--  "EQP_SLD_PF_02",
--  "EQP_SLD_DD",
--  "EQP_SLD_DD_G02",
--  "EQP_SLD_DD_G03",
--  "EQP_SLD_DD_01",
--  "EQP_WP_West_hg_010",--AM D114 grade 1 -- PFs and DD hangun
--  "EQP_WP_West_hg_010_WG",--no name/icon/drop model
--  "EQP_WP_West_hg_020",--AM D114 with silencer(on icon) but no ext mag?  grade 4, skull normal strong
--  "EQP_WP_West_hg_030",--geist p3 - shows shotgun icon but clearly isnt, machine pistol grade 4
--  "EQP_WP_West_hg_030_cmn",--as above, no name/icon
--  "EQP_WP_East_hg_010",--burkov grade 1, sov normal strong
--  "EQP_WP_West_thg_010",--wu s.pistol grade 1
--  "EQP_WP_West_thg_020",--grade 2
--  "EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
--  "EQP_WP_West_thg_040",--grade 5
--  "EQP_WP_West_thg_050",--wu s pistol cb grade7
--  "EQP_WP_EX_hg_000",--AM A114 RP grade 7 - silencer, gas cloud
--  "EQP_WP_EX_hg_000_G01",--AM A114 RP grade 8 - silencer, gas cloud
--  "EQP_WP_EX_hg_000_G02",--AM A114 RP grade 9 - silencer, gas cloud
--  "EQP_WP_EX_hg_000_G03",
--  "EQP_WP_EX_hg_000_G04",
--  "EQP_WP_EX_hg_010",--tornado 6 grade 3
--  "EQP_WP_EX_hg_011",--tornado 6 grade 5
--  "EQP_WP_EX_hg_012",--tornado 6 grade 6
--  "EQP_WP_EX_hg_013",--tornado 6 grade 7
--  "EQP_WP_West_sm_010",--ze'ev cs grade 3 pf normal, dd min grade
--  "EQP_WP_West_sm_010_WG",--as above, no icon/name
--  "EQP_WP_West_sm_020",--macht 37 grade 3, pf strong, skull normal strong
--  "EQP_WP_East_sm_010",--sz 336 grade 3, sov normal
--  "EQP_WP_East_sm_020",--sz 336 cs grade 5, sov strong
--  "EQP_WP_East_sm_030",--sz 336 cs grade 3 light, supressor, skull cypr normal
--  "EQP_WP_West_sm_014",--zeeve model, big scope no icon/name, supressor, DD icon backing
--  "EQP_WP_West_sm_015",--as above
--  "EQP_WP_West_sm_016",--loads, but missing icons and some blacked out sights DD backing, DD weapon table
--  "EQP_WP_West_sm_017",--<
--  "EQP_WP_West_sm_019",
--  "EQP_WP_West_sm_01a",
--  "EQP_WP_West_sm_01b",
--  "EQP_WP_East_sm_042",--riot smg stn grd 1 stun
--  "EQP_WP_East_sm_043",
--  "EQP_WP_East_sm_044",
--  "EQP_WP_East_sm_045",
--  "EQP_WP_East_sm_047",
--  "EQP_WP_East_sm_049",
--  "EQP_WP_East_sm_04a",
--  "EQP_WP_East_sm_04b",
--  "EQP_WP_Com_sg_010",--s1000 grade 2
--  "EQP_WP_Com_sg_011",--s1000 cs grade 2, most normal shotty, sov a, pfs, skull, dd min
--  "EQP_WP_Com_sg_011_FL",--as above, flashlight ?
--  "EQP_WP_Com_sg_013",--? mag shotgun no name no icon
--  "EQP_WP_Com_sg_015",--above + scope, light
--  "EQP_WP_Com_sg_020",--kabarga 83, grade 4, looks like same model as 013,14
--  "EQP_WP_Com_sg_020_FL",--as abovem flashlight ?
--  "EQP_WP_Com_sg_016",
--  "EQP_WP_Com_sg_018",
--  "EQP_WP_Com_sg_023",--s1000 air-s stn at least icon grade 3 - icon shows slilencer scope but not in game
--  "EQP_WP_Com_sg_024",--as above, light ?
--  "EQP_WP_Com_sg_025",--as above
--  "EQP_WP_Com_sg_030",--s1000 air-s cs grade 6
--  "EQP_WP_Com_sg_038",--loads, but missing icons and some blacked out sights
--  "EQP_WP_West_ar_010",--AM MRS 4r Grade 3, pfs normal, dd 3rd
--  "EQP_WP_West_ar_010_FL",--flashlight
--  "EQP_WP_West_ar_020",--un arc cs grade 3 PF strong
--  "EQP_WP_West_ar_020_FL",--flashlight
--  "EQP_WP_West_ar_030",--un arc pt cs flashlight scope laser, skull normal and strong
--  "EQP_WP_East_ar_010",--svg 76 grade 1, soviet normal
--  "EQP_WP_East_ar_010_FL",--+flashlight
--  "EQP_WP_East_ar_020",--svg 67 cs grade 4, child
--  "EQP_WP_East_ar_030",--above grade 6, sov strong
--  "EQP_WP_East_ar_030_FL",--+ flashlight
--  "EQP_WP_West_ar_040",--am mrs 4 grade 1
--  "EQP_WP_West_ar_042",--above + supressor scope
--  "EQP_WP_West_ar_055",--scope, no icon name
--  "EQP_WP_West_ar_050",--am mrs 4r grade 5 scope laser
--  "EQP_WP_West_ar_057",--loads, but missing icons and some blacked out sights
--  "EQP_WP_West_ar_059",
--  "EQP_WP_West_ar_05a",
--  "EQP_WP_West_ar_05b",
--  "EQP_WP_West_ar_079",
--  "EQP_WP_West_ar_07a",
--  "EQP_WP_West_ar_07b",
--  "EQP_WP_West_ar_060",--un arc nl stn grade 2
--  "EQP_WP_West_ar_063",--above + scope no icon name
--  "EQP_WP_West_ar_070",--un arc nl stn light grade 4
--  "EQP_WP_West_ar_075",--above + supressor
--  "EQP_WP_West_ar_077",
--  "EQP_WP_West_sr_010",--m2000 d grade 2
--  "EQP_WP_West_sr_011",--PF normal, DD
--  "EQP_WP_East_sr_011",--sov a normal
--  "EQP_WP_East_sr_020",--sov a strong
--  "EQP_WP_EX_sr_000",--molotok-68 grade 9 --icon/scope issues
--  "EQP_WP_West_sr_013",
--  "EQP_WP_West_sr_014",
--  "EQP_WP_West_sr_020",
--  "EQP_WP_West_sr_027",
--  "EQP_WP_West_sr_029",
--  "EQP_WP_West_sr_02a",
--  "EQP_WP_West_sr_02b",
--  "EQP_WP_West_sr_049",
--  "EQP_WP_West_sr_04a",
--  "EQP_WP_West_sr_04b",
--  "EQP_WP_East_sr_032",
--  "EQP_WP_East_sr_033",
--  "EQP_WP_East_sr_034",
--  "EQP_WP_West_sr_037",
--  "EQP_WP_West_sr_047",
--  --"EQP_WP_West_sr_048",
--  "EQP_WP_West_mg_010",--un am cs grade 4 PF normal,strong,
--  "EQP_WP_West_mg_020",--alm 48 grade 2 skull normal strong, dd min
--  "EQP_WP_West_mg_021",--alm48 flashlight grade 4
--  "EQP_WP_East_mg_010",--lpg 61 grade 4, soviet normal
--  "EQP_WP_West_mg_023",--
--  "EQP_WP_West_mg_024",
--  "EQP_WP_West_mg_030",--alm 48 grade 5 flashlight
--  "EQP_WP_West_mg_037",--
--  "EQP_WP_West_mg_039",
--  "EQP_WP_West_mg_03a",
--  "EQP_WP_West_sr_048",
--  "EQP_WP_West_mg_03b",
--  "EQP_WP_West_ms_029",
--  "EQP_WP_West_ms_02a",
--  "EQP_WP_West_ms_02b",
--  "EQP_WP_Com_ms_029",
--  "EQP_WP_Com_ms_02a",
--  "EQP_WP_Com_ms_02b",
--  "EQP_WP_Com_ms_010",--killer bee grade 3, sov, pf, dd,skull strong
--  "EQP_WP_West_ms_010",--fb mr r grade 3, pf,skull normal
--  "EQP_WP_East_ms_010",--grom 11, grade 2, sov normal
--  "EQP_WP_East_ms_020",--cgm 25, used in s10054
--  "EQP_WP_Com_ms_023",
--  "EQP_WP_Com_ms_024",
--  "EQP_WP_Com_ms_020",--killer bee
--  "EQP_WP_Com_ms_026",
--  "EQP_WP_West_ms_020",--fb mr rl nlsp
  "EQP_WP_EX_gl_000",--miraz zh 71 grade 9
}--tppEquipTableTest

function this.PostAllModulesLoad()
  local inMissionMenu=InfMenuDefs.inMissionMenu.options
  local command='Ivars.dropTestEquip'
  if inMissionMenu[1]~=command then
    table.insert(inMissionMenu,1,command)  
  end

  InfEquip.tppEquipTableTest=this.tppEquipTableTest
end

return this
