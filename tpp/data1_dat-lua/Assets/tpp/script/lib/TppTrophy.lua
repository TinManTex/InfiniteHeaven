local a={}a.MISSION_CLEAR={[10010]=1,[10020]=2,[10040]=3,[10070]=4,[10090]=5,[10110]=6,[10140]=7,[10151]=8,[10260]=9,[10280]=10}a.BUDDY_FRIENDLY_MAX={[BuddyFriendlyType.HORSE]=26,[BuddyFriendlyType.DOG]=27,[BuddyFriendlyType.QUIET]=28}
local _={afgh={"afgh_field_cp","afgh_remnants_cp","afgh_tent_cp","afgh_fieldEast_ob","afgh_fieldWest_ob","afgh_remnantsNorth_ob","afgh_tentEast_ob","afgh_tentNorth_ob","afgh_village_cp","afgh_slopedTown_cp","afgh_commFacility_cp","afgh_enemyBase_cp","afgh_commWest_ob","afgh_ruinsNorth_ob","afgh_slopedWest_ob","afgh_villageEast_ob","afgh_villageNorth_ob","afgh_villageWest_ob","afgh_enemyEast_ob","afgh_bridge_cp","afgh_fort_cp","afgh_cliffTown_cp","afgh_bridgeNorth_ob","afgh_bridgeWest_ob","afgh_cliffEast_ob","afgh_cliffSouth_ob","afgh_cliffWest_ob","afgh_enemyNorth_ob","afgh_fortSouth_ob","afgh_fortWest_ob","afgh_slopedEast_ob","afgh_powerPlant_cp","afgh_sovietBase_cp","afgh_plantWest_ob","afgh_sovietSouth_ob","afgh_waterwayEast_ob","afgh_citadel_cp","afgh_citadelSouth_ob"},mafr={"mafr_outland_cp","mafr_outlandEast_ob","mafr_outlandNorth_ob","mafr_flowStation_cp","mafr_swamp_cp","mafr_pfCamp_cp","mafr_savannah_cp","mafr_swampEast_ob","mafr_swampWest_ob","mafr_swampSouth_ob","mafr_pfCampEast_ob","mafr_pfCampNorth_ob","mafr_savannahEast_ob","mafr_savannahWest_ob","mafr_chicoVilWest_ob","mafr_hillSouth_ob","mafr_banana_cp","mafr_diamond_cp","mafr_hill_cp","mafr_savannahNorth_ob","mafr_bananaEast_ob","mafr_bananaSouth_ob","mafr_hillNorth_ob","mafr_hillWest_ob","mafr_hillWestNear_ob","mafr_factorySouth_ob","mafr_diamondNorth_ob","mafr_diamondSouth_ob","mafr_diamondWest_ob","mafr_factoryWest_ob","mafr_lab_cp","mafr_labWest_ob"}}a.DOMINATION_TARGET_CP_COUNT={afgh=#_.afgh,mafr=#_.mafr}a.DOMINATION_TARGET_CP_NAME_LIST={}
for o,_ in ipairs(_.afgh)do
a.DOMINATION_TARGET_CP_NAME_LIST[_]=true
end
for o,_ in ipairs(_.mafr)do
a.DOMINATION_TARGET_CP_NAME_LIST[_]=true
end
if TppCommandPost2.SetDominationTargetCpList then
TppCommandPost2.SetDominationTargetCpList{afgh=_.afgh,mafr=_.mafr}
end
function a.Unlock(a,o,_)
if not(TppMission.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM))then
if not gvars.trp_isGot[a]then
if o then
local a=0
if _ then
a=_
end
TppHero.SetAndAnnounceHeroicOgrePoint{heroicPoint=o,ogrePoint=a}
end
end
gvars.trp_isGot[a]=true
end
Trophy.TrophyUnlock(a)
local a=true
for _=1,47 do
if not gvars.trp_isGot[_]then
a=false
break
end
end
if a then
if not gvars.trp_isGot[0]then
gvars.trp_isGot[0]=true
end
end
end
function a.UnlockOnMissionClear(_)
local _=a.MISSION_CLEAR[_]
if _ then
a.Unlock(_)
end
end
function a.UnlockOnBuddyFriendlyMax()
for _,o in pairs(a.BUDDY_FRIENDLY_MAX)do
if TppBuddyService.GetFriendlyPoint(_)>=100 then
a.Unlock(o,5e3,-5e3)
end
end
end
function a.UnlockOnAllMissionTaskCompleted()
local _=true
for a,o in pairs(TppResult.MISSION_TASK_LIST)do
if not TppUI.IsAllTaskCompleted(a)then
_=false
break
end
end
if _ then
a.Unlock(13,3e4)
end
end
function a.UnlockOnAllQuestClear()a.Unlock(17)
end
return a
