# Infinite Heaven Change Log.md
Just notable changes, see github commits for full  
https://github.com/TinManTex/InfiniteHeaven

### r261 - 2023-03-24  
---------------------
'Warp to latest marker' now works when driving vehicle or walker gear.  
[youtube]FVc0bw9ooFs[/youtube]  
https://youtu.be/FVc0bw9ooFs  

Fix: disableHerbSearch possibly not working correctly.  

Fix: Randomize RouteSets being called despite individual options being off (though not if main setting was off).  
thanks caplag for a related report.  

Fix: "Custom soldier type in Free/Mission" resetting to off after game is next restarted. Was broken as of r247 - thanks Spectral for the report and troubleshooting files. 

Fix: enemy soldier type addons with multiple bodies not working, was broken as of r258 - thanks Spectral for the report.  

Fix: Some cases of Player Cam hook (FOV) not applying.  

Fix: InfSoldierFaceAndBody not retaining its data on script reload. Affected Apearance menu > Face option when Filter set to Head fova addons.  

Fix: Back in the dark ages I changed mvars.ene_soldierIDList itself from its original [cpId][soldierId]=cpDefine index to [cpId][soldierId]=soldierName as the value didnt seem to be used anywhere, and I wanted a lookup. Didn't really end up using it much, it was better to just iterate soldierDefine again, so its been reverted.  
(and API/dev warning I guess if anyone was using it as its modified form in their scripts)

Fix: TppRevenge.SetEnableSoldierLocatorList (actually broken out by IH from `_ApplyRevengeToCp`) not applying in MB. Don't think it affected anything since it failed in a way that it was still applying revenge for all soliders in a cluster, just that it was applying multiple times (with exact same values).  
See the NOTE: in SetEnableSoldierLocatorList for my puzzlement about it.  

Fix: Custom DD female type no longer dependant on Custom DD (male) type being set. Either of them will default to normal DD mb body if setting is OFF.  

Motherbase menu > 'DD Suit', 'DD Suit female' renamed 'Custom DD type in MB' in line with 'Custom Soldier type in mission/free'.  
The underlying Ivars already were named customSoldierTypeMB_ALL, so you shouln't have to re-set the setting.  

AroundCam (FreeCam):  
When AroundCam on, but with Adjust-mode off, changing settings via will now update AroundCam.  

Fix: FreeCam hang if on when Abort mission.  

API: addon missionInfo (See notes in InfMission)  
clearExistingMissionStartSettings - only for use when overriding a vanilla mission, clears all the mission start data so the following options you set can work cleanly  
noBoxMissionHeliRoute / NO_ORDER_FIX_HELICOPTER_ROUTE support, requires isNoOrderBoxMission to be set

clearMissionStartHeliRoute is to give actual support for NO_HELICOPTER_ROUTE_MISSION_LIST, before it was just riding on the assumption that if the addon author gave a startPos they wouldn't have heli routes/starts set up, this gives the same support as the base game for those missions.  

isNoOrderBoxMission, likewise giving explicit setting for NO_ORDER_BOX_MISSION

- thanks caplag for the suggestions

API: LoadExternalModule: Don't reload module if prevModule and not isReload.  
This was causing the early InfInit LoadExternalModuled modules Ivars,IvarsPersist and InfSoldierFaceAndBody to be reloaded.  
In the case of InfSoldierFaceAndBody it would loose all its data since those functions were called manually rather than PostAllModulesLoad.  

API: InfUserMarker.GetMarkerPosition return type changed from Vector3 to {x,y,z} as it's more commonly used through other IH functions.  

### r260 - 2023-03-10  
---------------------
Fix: quest adding their missionPacks in helispace - thanks CapLag for an unrelated report that made me test something related.  

Fix: Repop of sideop 144 tent_q99040 "Secure the Remains of the Man on Fire" arival on quarantine platform leaving player stuck in helipad.  

Fix: Infinite load screen when IH startOnFoot used when force go to mb on quest clear > demo play. Another case of the prior fix in r259 for start on foot, which Repop of sideop 144 is also a case of. 

Fix: Several bugs setting quest flags incorrectly. Could result in some of the hidden/managed quests activating or not.  
Could also cause the all sideops disabled bug.  
A manual fix is to run "Reroll sideops selection" with "Repop mode" set to Allways.  

Ancillary ih saves (addon mission and quest states) are now cleared on new game.  

InfQuest / IH Sideops menu:  
[youtube]2UUXDfMfrso[/youtube]  
https://youtu.be/2UUXDfMfrso  

Renamed unlockSideOpNumber to quest_forceQuestNumber, just an internal name change to be more consistant and accurate. Though you will have to set the setting again.  

Renamed ihSideopsPercentageCount to quest_addonsCountForCompletion, just an internal name change to be more consistant and accurate. Though you will have to set the setting again.  

quest_updateRepopMode="Repop mode": "On none left"|"Allways"
Lets you choose the behaviour of how repeatable sideops are refreshed. 
The update is run for the sideop area of a quest you just finished, 
or for all areas when changing many of the IH sideops options or rerolling sideops. 
The default behaviour 'On none left' will only repopulate sideops when there are no other uncompleted sideops, and all other repeatable sideops have been completed. 
'Allways' will refresh repeatable quests every time the update is called.  

quest_setIsOnceToRepop="Repop one-time sideops"
"Lets you force story and one-time sideops to be replayable."
Replaces "Unlock Sideops mode".  

quest_selectForArea="Selection for Area mode"
Renamed from sideOpsSelectionMode
Categories removed, use the Sideops category filter menu instead. 
'Random Addon' setting added to prioritize Addon sideops.  
Sideops are broken into areas to stop overlap, this setting lets you control the choice which repop sideop will be selected to be Active for the area.  
'Random Addon' will prioritize Addon sideops first.  
All selection is still prioritized by uncompleted story sideops, then other uncompleted sideops, then repop sideops selected by this option.  

"Show on UI menu"  
Replaces "Show all open sideops"  
Settings for what sideops to show and how they should be sorted depedending on various parameters for sideops on the idroid sideops list.  
The vanilla behavior just shows current Active and Cleared sideops, in index order, which lets you see past progression/completion,
Though since uncleared sideops do have priority, one will be selected for Active.  
So if there's multiple uncleared for an area they will not be shown, which gives you less of an idea of future progression.  
These option give you individual control for showing sideops depending on their conditions.  
For a given sideop multiple of the underlying conditions may be true at one time and either depend on your progress through the game, or from other IH settings.  
There is however a limit of 192 entries for the sideop list (there's 157 sideops in the base game), which some settings might push over if you have addon sideops, in which case some Cleared entries be randomly dropped from the list.  
See the notes for each option for more info.  
Sorting:  
Sorting will proceed through all flags that have a sorting setting (not set to None). So sort is in respect to the option above it.  
None: Will not apply any specific sort, so will just be in index order, but may be moved around if other flags sort it.  
The other settings, Top, Bottom or Ascending, Descending depending on the flag type, will sort as the settings suggest, but in relation to the prior flags.  
Since the final sort is by sideop index (the number on the left of the entry in the sideop list) you can use that to see where the list sections from one sorted flag type to the next.  

quest_uiShow_Active="Active" - "Default is Show. Sideops that are Active are the ones actually currently in play and start when you arrive in the sideop area. Independent of Cleared. You normally wouldn't set this setting to Hide."
quest_uiShow_Cleared="Cleared" - "Default is Show. Quests that have been completed."
quest_uiShow_Uncleared="Uncleared" - "Quests that have not been completed."
quest_uiShow_Activable="Activable" - Only shows those sideops in the selection for being Activated (which includes Active). Usually the best setting to show what sideops are being considered depending on all the underlying conditions and IH settings."
quest_uiShow_Open="Open" - "Will try and show all Open sideops, which is usually every sideop as soon as they are introduced through game progression. Most likely to hit the UI limit entries when a lot of addon sideops are installed."

quest_uiSort_Active="Sort Active" - Top|Bottom
quest_uiSort_Cleared="Sort Cleared" - Top|Bottom
quest_uiSort_Uncleared="Sort Uncleared" - Top|Bottom
quest_uiSort_Activable="Sort Activable" - Top|Bottom
quest_uiSort_Open="Sort Open" - Top|Bottom
quest_uiSort_category="Sort by Category" - Ascending|Descending - "The base game sideops are more or less ordered by category already, however addon sideops are added to the end, this sorts by a similar order but puts Story sideops first."
quest_uiSort_locationId="Sort by Location" - Ascending|Descending -
quest_uiSort_questArea="Sort by sideop area" - Ascending|Descending -"Each main location of the game (Afgh, Africa) is sectioned into about 8 sideops areas to stop overlap and manage loading. You can look at the sideop index to clarify where the list goes from one area to the next (the numbers within an area will be increasing, then be lower for the first sideop in another area). You may want to use in combination with Sort by Location."

Sideops selection menu:  
ivars renamed from `sideop_<CATEGORY>` to `quest_category_<CATEGORY>`
Settings changed from OFF, ON to "ALL","NONE","ADDON_ONLY"
This lets you have per catergory selection of only Addon sidops.  

Quest Addon questInfo: 
Added canActiveQuest=function(questName) --Optional. All quests repop by default (are available to repeat), returning false will stop it from being considered for selection. Use this if you need to stop the quest from Active selection after the initial canOpenQuest.  

### r259 - 2023-02-18
---------------------
Fix: InfPositions Loadposistions, thanks cap for fix.  
Fix: ih_mission_states not restoring, thanks cap for report.  
Fix: Start missions on foot hang on mission end if MB demo triggered. This is an anchient bug that has unfortunately likely been around almost as long as IH itself. Thanks OldBoss for the report and save files.  
Fix: profiles breaking due to help strings with newlines. thanks EntranceJew for the report.  
InfLookup: A lot of Message signatures, and general message logging rework from EntranceJew
Debugging: Bunch of flow logging to get a better understanding of infinite loading screen, though the answer there is most often just 'the exe is loading stuff and it didn't like something aboout one of the data files'
Fix: InfWeather losing addon weather info on script reload, thanks EntranceJew for the report.  
Fix: appearanceDebugMenu fova ivars fix. They still don't do anything, but they were breaking the menu. And due to the exe crash issue after applying several times it's still of limited use. Thanks retali8 for the report.  
Fix: 'Warp to last user marker' and Warp body to FreeCam position remove announcelog spam that queues when warping - Thanks SinovialVermin8 for the report
Fix: 'Support heli to marker' failing with '#coords.pos~=3' warning. Seems feature was broken as of last version - thanks Dr Solus for the report.  

InfMotion|Motions menu > motionWarpToOrig|"Warp to original position after play". Since some animations move player position through geometry this may help to recover - thanks caplag for implementation.  

Mission Addons: various features that were limited to vanilla freeroam now work in addons.  

IH Saves: ih_mission_states, ih_quest_states, ih_priority_staff now only save if the related features are used. So possibly slight better performance when saving.  
Existing files will still hang around even if they have no meaningful data in them though.  
Are also now checked to see if they exist first before loading them, so no potentially confusing error message it used to log when trying to load them reguardless.  

InfAutoDoc:  
Features and Options docs using same option type indicator as menus. Commands no longer show a 0-1 range.  

Debugging and dev stuff:  
ivars GettSettingText calls wrapped in PCallDebug, and log a warning to make it easier to track down broken functions (and not have them break the menu).  

Some loading logging, probably won't catch much since most load hangs will be inside exe and lua will just be waiting for TppMission.CanStart which will never come.  

InfCore.PCall correct multi returns - thanks EntranceJew for the method.  

PCall and LoadExternalModule announceLogs errors.  

r258 - 2022-07-13
IHHook ver r17

InfCamHook: moved from IHHook install to IH.  

Run AutoDoc", "AutoDoc creates the Features and Options txt and html in docs folder, and profiles/All_Options_Example based on the current menus and options, including any added by other mod IH modules. It will overwrite any existing files."
via IH system menu. 

InfMission: Mission Addons completion, tasks, best rankings support, saved to mod\saves\ih_mission_states.lua

Invalid mission task save data clearing improved - thanks cap.  

InfMissionQuest: 
Side ops in missions menu
enableMissionQuest="Enable side ops in missions" - "Enable side ops in missions using a hand-picked selection of side ops in specific story missions."
- thanks cap

InfBodyInfo / custom enemy soldier addon system:  
Added support for bodyIdTable ala TppEnemy. Currently just a single entry rather than multiple soldierSubTypes like TppEnemy.  

customSoldierTypeMISSION="Custom soldier type in Missions", "WARNING: Unique soldiers in the mission are likely to either be the default body from the selected custom soldier type, or have visual issues if there isn't one."

changeCpTypeMISSION,FREE,MB_ALL="Force CP type in ..",
"Default","Soviet","American","Afrikaans"}
"Changes Command Post Type, which controls the language spoken by CP and HQ. 
WARNING: Will break subtitles. 
WARNING: some CP types don't have responses for certain soldier call-ins for different languages."

Thanks Wolbacia, Your401kPlan for poking away making bodyInfo addons and other soldier replacements leading to these improvments.  

InfModelProc renamed InfSoldierFace, moved to \modules

Soldier parameters:  
Added in-mission menu. Changes to soldier params apply on map load or checkpoint reset.  

InfProgression:  
Gathers existing progression options.  

repopAARadars "Repopulate AA Radars", "Number of mission completes before destroyed Anti Air Radars are rebuilt."

Starting on foot with no given rotation will point you toward center of map instead of always 0 degrees.  

InfGameEvent:  
gameEventChanceMB/"MB event random trigger chance" split into individual chances for the different event types.  

InfChimera: 
Now writes out TppEquip enums for parts, and comments what parts var name is.  
Load now actually loads from specified file instead of just loading them at start, so you can edit the file manually and re-load it.  

fix: Free roam addons no longer added to missions list, should fix a progression calculation issue.  

InfTransition:  
Simple mission transistion system via switches.  

Quests:  
Shooting practice quests can be made for non mtbs locations.  

InfProgression:  
Moved a bunch of existing progression related options to module.  

API: Mission Addon
missionInfo .hideMission : 
Does not add mission to idroid mission selection.  
Mission/task completion will not be saved for the mission.  
Does not count toward installed mission limit.  
Can still be loaded via IH mission load command, or by lua ReserveMissionClear or by transition system.  

r257 - 2021-08-04
InfCamHook moved to IHHook r16 installation.  

fix: Custom soldier type RANDOM hanging on load if it chose off-by-1 lowest value.  

fix: MB GameEvents always triggering on any chance but 0 - thanks Adchap for the report

fix: Sideop remaining active on clear on non Shooting Practice sideops while Shooting Practice Retry enabled - thanks countfuzzball for the report

InfEmblem:  
"Load emblem","Load emblem from MGS_TPP\\mod\\emblems . After loading emblem you must go to the normal Customize emblem system and OK it for it to reapply it. It will also regenerate it next time game is started."
"Save emblem","Save emblem to MGS_TPP\\mod\\emblems"
(via Customize menu)
[youtube]VyEj1cPbKX4[/youtube]
https://youtu.be/VyEj1cPbKX4

InfChimera:  
Chimera is MGSVs weapon cusomization system, this menu lets you save/load from the Customize > Weapons idroid menu
"Weapon category","Changes which weapon category the slots refer to."
"Load to slot 1","Load chimera from MGS_TPP\\mod\\chimeras to spcified slot"
"Save from slot 1","Save chimera of specified slot for to MGS_TPP\\mod\\chimeras "
"Clear slot"
(via Customize menu)
[youtube]K3khMmt9S7I[/youtube]
https://youtu.be/K3khMmt9S7I

Save name input for Avatar, Emblem, and Chimera requires IHHook r16.  

Customize menu
Avatar, Emblem, and Chimera

InfLookup: TppEquip reverse enums

r256 - 2021-07-20
fix: disableCamText - Around mode Disable mode text feedback now saves setting - thanks caplag for pointing it out.  

fulton_recoverCritical "Extraction recover critical", "Requires Extraction team option enabled. Extraction team will recover critically shot soldiers (ie 'dead' soldiers). Depending on medical section success. This lets you play with more lethal weapons while still keeping up with the recruitment gameplay."
(via Fulton menu)
[youtube]oGiF4KpNo-Y[/youtube]
https://youtu.be/oGiF4KpNo-Y

"Load avatar", "Load avatar from MGS_TPP\\mod\\avatars"
"Save avatar", "Save avatar to MGS_TPP\\mod\\avatars"
(Via Appearance menu)
Must be in ACC
[youtube]W3enynh89CI[/youtube]
https://youtu.be/W3enynh89CI

r255 - 2021-07-09
fix: hang with Random cp subtype in addon missions.  

customSoldierType: added RANDOM option
GOTCHA: if you were using customSoldierType prior to this update it will be set to the previous body type till you set it again.  

Events: 
Free roam events now work for free roam addon locations
Free roam event options changed from Allow-on/off to percentage chances.  

API: `<mission>_enemy` script 
Direct value to set on all, or per type table options for cpSubTypes, soldierTypes, soldierSubTypes, and cpTypes, cpAnounceLangIds
cpTypes added to set the cp voice
cpAnounceLangIds added to set the cp type in phase change announce.  
soldierSubTypes can be set to true to use cpSubTypes to define soldier subtypes

API: location script weatherProbabilities, extraWeatherProbabilities

r254 - 2021-06-22
fix: hang on exit fob due to IH not handling heroicPoint as string - thanks William for your report and log.  

API: `<mission>_enemy` script 
.cpTypes as either direct CpType or as table of [cpName]=CpType
.cpSubTypes as either one soldierSubType applied to all cps, or table of [cpName]=soldierSubType
.cpAnnounceLangIds - cp name langId used in `TppEnemy._AnnouncePhaseChange`, also see cpSubTypeToLangId
.soldierSubTypes=true (alternative to the existing [soldierSubType]={soldierName,...}), to use .cpSubTypes to define the soldierSubTypes for soldiers of the soldierDefine for those cps.  

InfMainTpp.IsDDEnemy used to bypass staff died messages and hero point loss - should only catch vanilla DD enemies not addon uses of DD soldiers.  

InfSoundInfo, ih/snd_ene_* fpks to load vox_ene soundbanks
fix: Some Custom soldier types having silent voices in mafr

r253 - 2021-06-15
InfFulton:  
Fulton menu (in ACC)
fulton_autoFultonFREE, fulton_autoFultonMISSION - Extraction team in Free Roam/Missions
"Extraction team will recover enemies you have neutralized after you've traveled some distance from them (usually to next command post). 
This lets you do low/no fulton runs without having to sacrifice the recruitment side of gameplay.  
[youtube]NQiXzE6PL2s[/youtube]
https://youtu.be/NQiXzE6PL2s

fultonVariationRange - "Fulton success variation","Subtracts the percentage from fulton success in a periodic fashion."
fultonVariationInvRate="Fulton variation inv rate","Inverse rate (higher slower) of fulton variation cycle"

Moved fulton success menu/ivars to module.  
fultonNoMbSupport/Medical changed tp fultonSupport/MedicalScale

InfInterrogation:  
fix: Inter cp stash interrogation quests would just endlessly loop between some paired soldiers as the array for advancement state was too small - thanks William for your reports.  
changed states from gvars to svars, a holdout from IHs shift away from gvars many years ago (and it should have been svars from the start).  

InfLookup:  
BuildObjectNameLists, so other modules can add to objectNameLists

Module API: TppMission.EstablishedMission* ih module hooks
Ivar API: isPercent percentage range ivars can use :Scale(value)

r252 - 2021-06-05
IHHook split to it's own installation: https://www.nexusmods.com/metalgearsolidvtpp/mods/1226/

InfShootingPractice:  
Support for new Shooting Practice sideops, as the vanilla SP sidops use online saves which can't be added to, IH SP sideops save to ih_quest_states in mod\saves instead.  
Will display best time when entering the start marker since it likewise can't use the ranking ui.  

quest_enableShootingPracticeRetry - "Enable Shooting Practice Retry" - "Does not hide the starting point when Shooting Practice starts or finishes, and allows you to cancel while in progress and start again."
quest_setShootingPracticeCautionTimeToBestTime - "Set Shooting Practice caution time to best time" - "Sets the caution time/time when the timer turns red to the current best time so you have a clearer idea when going for best time."
[youtube]gX3O0pauMOA[/youtube]
https://youtu.be/gX3O0pauMOA

InfHero: 
moved SetDemon, RemoveDemon from InfMainTppIvars
hero_dontSubtractHeroPoints "Don't subtract hero points" - "Actions that usually subtract hero points don't." 
hero_dontAddOgrePoints - "Don't add demon points" - "Actions that usually add demon points don't."
hero_heroPointsSubstractOgrePoints - "Hero points subtract demon points" - "Actions that add hero points subtract the same amount of demon points"
Thanks TheFluffyPlatypus for the queries.  

updateStageBlockLoadPositionToCameraPosition - "Update stage position with camera" (via Cam - AroundCam) Replaces the one-off SetStageBlockPositionToFreeCam command.  
"Sets the map loading position to the free cam position as it moves. Warning: As the LOD changes away from player position your player may fall through the terrain.  

fix: selecting a quest referencing a missing questArea would error out the quest selection

Refactor save system: quest states moved from ih_save to ih_quest_states, users will lose completion status for installed addon sideops.  

Debugging: PrintOnMessage to after resendcount check so less message logging spam, and more accurate indication of when message is being sent.  

Quest addon system: questInfo allowInWargames to allow quest on mb to be active during wargames.  

r251 - 2021-04-06
WarGames: Added FOB phase background music during wargames - thanks Body Damage, and others for the suggestion.  

disableKillChildSoldierGameOver - "Disable game over on killing child soldier" (via player restictions menu menu) - thanks CFWMagic for showing a clear example when updating the stand alone mod.  

Skull Events
Moved to its own menu (via the Events menu)
A bajillion settings for the event settings and the parameters for the skulls and zombies in the event exposed.  
Now (should) work for Free roam addon missions (does on Caplags gntn - US Naval Prison Facility)
[youtube]K249zxAd1PU[/youtube]
https://youtu.be/zE49gPHU3uE

API:  
svar size for helis,walkerGears and uavs now set like mvars.ene_maxSoldierStateCount, and settable via `<missionScript>_enemy` .MAX_HELI_STATE_COUNT etc (search TppEnemy .SetMaxHeliStateCount)

missionInfo addons can override vanilla missions.  

cpPositions built from actual positions, which allows for the GetClosestCp to work for addon missions.  

missionInfo.lzInfo to fill out various TppLandingZone stuff and allow GetClosestLZ to work for addon missions.  

r250 - 2021-04-19
Fix: FOB soldiers (and probably DD soldiers in MB wargames with certain weapon setups) having invisible pistol.  
Seems I may have broken it in in r176 - August ‎2016 whew - thanks kapacb (and probably many others in the past) for the report.  

Fix: Quest addon state flags management - was broken some time around r224 meaning if an addon quest index had been cleared it would stay cleared even if uninstalling quest and installing different one that took that index.  

Fix: GetCurrentRouteSetType - RouteSelector - redefinition of local var with same name clobering scope and returning nil. Would cause soldier shifts to fail, meaning no change between night day routes, and no sleeping/hold routes. Bug was introduced while deminifying in r129 - February 2016. Ouch.  

RouteSet menu - Options to randomize what routes soldiers use in a Command Post
Randomize RouteSets in free roam
Randomize RouteSets in missions - warning: may mess up some required routes for the mission to progress.  
	Enables all following options. Also randomizes current routeSet on mission load/reload. 
	Requires randomize group priority or group routes to be on.  

Randomize on shift change - MGSV already has a 'shifts' system that trigger at morning and night, this applies the randomisation at these times.  
Randomize on phase change - Randomize current routeSet when enemy phase changes in any way, Sneak, Caution, Alert, Evasion. Up or down.  

Randomize group priority - Each routeSet for a CP has a number of groups of routes, this will change the order the groups are picked from and vary the routes connecting shifts.  
Randomize group routes - Each routeSet for a CP has a number of groups of routes, this will change the order within the group.  

Randomize RouteSet now - Command for if you just want to change things up, or see how the options change things.  
[youtube]K249zxAd1PU[/youtube]
https://youtu.be/K249zxAd1PU

menu_enableCursorOnMenuOpen - "Enable mouse cursor on menu open" - "Automatically enable mouse cursor when IHMenu opens. The cursor can also be seperately toggled with F2"
(via IH system menu)
Dafaults to on, but as mouselook is now disabled when cursor is on I though this the best way to allow user some control beyond manually toggling it.  

Fix: PostModuleReload not being called, was broken in r238. Should fix a few reload scripts issues.  

Mission Addon System: 
Automatically add townparameter cps as InfMain.cpPosition for IH GetClosestCp function.  
MergeRouteSetDefine - add outofrain, call SetOutOfRainRoute when no loc_locationCommonRouteSets

InfUtil:  
CopyTable
RandomizeArray



r249 - 2021-04-12
mbIncreaseStaffSaluteReactions - "Add more salute reactions" - "Adds additional reactions from MB staff when 
via ACC > Mother Base menu > Staff menu 
Thanks caplag for lending your notes and your discussion.  
[youtube]svLN4LFAh8w[/youtube]
https://youtu.be/svLN4LFAh8w

Auto Abort-to-ACC when vars.locationCode or vars.missionCode not a valid vanilla or addon code - could be caused by uninstalling an addon mission while save was in mission.  
Fix: Reset setting and go back menu hotkeys repeat spamming due to being OnHeld instead of OnHoldTime.  

debugStuffMenu (via debugInMissionMenu)
	selectSpeechSoldier
	selectSpeechSoldier2
	debug_CallVoice
	debug_CallConversation

r248 - 2021-04-08
Version bump and IHHook ver

r247 - 2021-04-05
Cam - Player Cam hook menu
Uses IHHook to adjust the player camera focal length.  
Same method as the 'FOV Modifier' (on nexus)
https://github.com/mon/MGSV-TPP-FoV
This IH feature now superscedes that mod, so if IHHook is working (currently requires 1.0.15.3 eng exe) you should remove that mods d3d11.dll

camhook_enable -Enable Player Cam hook,
Only updates after changing cam mode.  
	Focal lengths between modes not equivalent (some other factor being applied)
	Lower focal length = wider FOV,
	Higher focal length = lower FOV
camhook_focalLength_NORMAL="FocalLength Normal",
camhook_focalLength_AIMING="FocalLength Aiming",
camhook_focalLength_HIDING="FocalLength Hiding",
camhook_focalLength_CQC="FocalLength CQC",
camhook_ApplyFOV - "Apply FOV" - "Applies FOV(degrees) proportionally to the different cam mode focal lengths."
[youtube]QRhBMK1S5YA[/youtube]
https://youtu.be/QRhBMK1S5YA

Camera menu (FreeCam)
Renamed "Cam - AroundCam menu"
Added the other AroundCam settings that could only be changed via the button shortcuts while cam was active.  
Added some more of the AroundCam settings
targetInterpTime
rotationLimitMinX
rotationLimitMaxX
alphaDistance
All aroundcam settings now save.  

PlayCam menu 
Renamed "Cam - PlayCam menu"
moved to root menu.  

Debug Menu: Added manualsequence from devinacc menu.  

InfMenu: Break out DisplayCurrentMenu so Ivar commands that change ivars in their menu can refresh it.  

Ivars refactor: completed more of the shift of using .settings directly instead of .range to guard the bounds. 
As well as IvarProc.SetSettings to rebuild the .enum, 
and ivar. Init called on all ivars during postallmodulesload to set those ivars that use tables in other modules as settings.  

Fix: fix GenerateEvent event not being reapplied on new session when using forceEvent/Trigger IH Event
Fix: MB wargames events not applying soldier body type (would stay as whatever dd suit setting you had) - thanks KLOC for the report and troubleshooting files to test.  


r246 - 2021-04-01
Fix: Hang on mission load - just a dumb typo I forgot to error check. 

r245 - 2021-04-01
Fix: Location addon that adds new questarea while not having any sideops installed set in the area would cause the sideops system to break - thanks Delta 6, Yooungi, caplag for the reports

r244 - 2021-03-31 
Fix: Intel team not marking anything on idroid map - AddGlobalLocationParameters modifies by param not by return.  

r243 - 2021-03-29
Fix: unlockSideopNumber - 'Unlock specific sideop' not allowing the top most sideop. Had recently cleaned up how some settings ranges were set but forgot that sideops was outside of the normal indexedfrom0 case - thanks psavi for the report (and some others I might have passed by in the past sorry).  

unlockSideopNumber now shows the questName.  

quietRadioMode - 'Quiets MB radio track' now lists the track names.  

weather_requestTag - Weather Menu > RequestTag
A collection of sky, lighting settings bundled under a 'tag' name in the locations weatherParameters file.  
[youtube]dgz7vyh_3rQ[/youtube]
https://youtu.be/dgz7vyh_3rQ

SetSkyParameters - Weather Menu > various settings:  
weather_skyParameterSetSkyScale="Scale of main clouds overhead",
weather_skyParameterAddOffsetY="Height of horizon clouds",
weather_skyParameterSetScrollSpeedRate="Scrolling speed of horizon clouds",

Mission Addon system:  
Initial implementation of sideop support.  
[youtube]rBSvPVxLSbc[/youtube]
https://youtu.be/rBSvPVxLSbc

locationInfo .questAreas via InfQuest.AddLocationQuestAreas

missionInfo .globalLocationMapParams (untested) via 
 \Assets\tpp\pack\mbdvc\mb_dvc_top.fpkd \ mbdvc_map_location_parameter.lua GetGlobalLocationParameter

General api:  
PlayerStatusEx - Extended version of PlayerStatus enum 
https://metalgearmodding.fandom.com/wiki/PlayerStatus
- thanks to the herculean research by BigBootyBoss

r242 - 2021-03-27
Fix: changeCpSubType - Random CP subtype erroring.  

r241 - 2021-03-27
Fix: Addon missions breaking when IHHook not initialized - thanks Yooungi for the report

Log IHHook ver, or warn.  
Write IHHook ver to ih_save .ihhookVer

r240 - 2021-03-26
Fix: Game crashing on startup with enableIHExt.  
Was trying to log with announcelog via debugprint, which should have been ok because it had a guard against the announcelog not stood-up crash by checking vars.missionCode not nil. Except it should have been checking missionCode wasnt MAX - 65535 - thanks everyone for the report and Venom Raven for the ih_save and testing.  
Fix: Mission-prep features menu repeated entry in player restrictions menu removed (is being auto added via parent tag) - thanks OldBoss for the report.  

IMGUI: Default style tweaked.  

Mission Addon system: 
Free roam missions now get registered to the free roam tab and not the mission tab.  
In theory should support moving from an addon free roam to a mission set in that location and visaversa (via mission leave out of bounds).  

requestTppBuddy2BlockController var for missionInfo to have TppBuddy2BlockController.CreateBlock and Load called like they would for afgh/mafr. Though inial testing with gntn it doesn't seem to fix selected buddy from mission start not actually enabled issue like I thought it might.  

Free roam missions get proper langId for entry thanks to IHHook, uses locationMapParams.locationNameLangId or defaults to tpp_loc_<lowercase locationName>

TppLocation included in IH (can't think of any mods that would mod this so should be a save move).  

Refactor: Move InfUtil.GetLocationName into TppLocation to replace.  

r239 - 2021-03-24
Update to MGSV version 1.0.15.3

r238 - 2021-03-20
Update to MGSV version 1.0.15.2

Includes IHHook, dll proxy for extending IHs capabilities (similar concept to SKSE), and providing a dear-Imgui version of IH menu (to supersede IHExt).  
See IHHook-Changelog.txt or github.com/TinManTex/IHHook
[youtube]ERL7okZVcW4[/youtube]
https://youtu.be/ERL7okZVcW4


Added: Appearance menu - skipDevelopChecks - Allows items that haven't been developed to be selected in the Appearance menu.  
Added: attackHeliType - UTH Blackfoot - thanks caplag for discovering uth TppHeliParameters applied to TppEnemyHeli 
Known Issues: UTH wont attack with missiles despite doing the long on sound and behaviour. UTH attack heli classes not actually visually different.  
[youtube]4V7lPJ2t_rw[/youtube]
https://youtu.be/4V7lPJ2t_rw

Added: GeneralHelpItem - mostly for seeing the extensive help text when show help is on.  

Added: menu_disableToggleMenuHold - Disable hold menu toggle - Disables the legacy one-button [DIVE] hold-to-toggle menu, the two button menu combo [ZOOM_CHANGE] + [DASH] will still work.  

Camera menu:  
Added: 'Reset camera position to player' (still can be accessed by pressing the ih camera reset button (binoc) and [DASH]) - thanks Muffins for the suggestion (of an obvious oversight).  
Added: positionXFreeCam (and Y,Z) - more useful since you can enter the value directly with IHH menu, useful if you have some position from somewhere but you don't know where it is in game.  

Ivars / options:  
enableHelp renamed menu_enableHelp - to get the new default of on to stick.  
disableSelectVehicle, disableSelectTime, disableSelectBuddy changed to per mission type heliSpace_ flags:  

Mission prep features override:  
Replaces the "Mission-prep restrictions menu"

heliSpace_SkipMissionPreparetion="Skip mission prep"
heliSpace_NoBuddyMenuFromMissionPreparetion="Disable select-buddy"
heliSpace_NoVehicleMenuFromMissionPreparetion="Disable select-vehicle"
heliSpace_DisableSelectSortieTimeFromMissionPreparetion="Disable select-sortie time"

Lets you force on or off the various mission prep features, though some may not make sense or have stuff overidden by the mission, such as enabling mission prep for the prologue.  

InfMotion / Motions menu: motionCloseMenuOnPlay - Close menu on Playing motion, defaults to off - thanks choc for bringing it up.  

Filestructure: ih_additional_motion.fpk moved from pack/mission2 to the more appropriate pack/player/motion.  

mod\devmodules - a collection of IH dev modules created to help with specific aspects of modding.  

docs\Development.txt - a couple of modding links, also mentioning the above.  

InfWeaponIdTable
Addon system to add weaponIdTable that enemy soldiers equip from.  
Selected via `weaponTableGlobal<MissionMode>` - Global soldier weapon table in FreeRoam/Missions/MB 
via the Custom soldier equip menu.  
Example addon in mod\devmodules\weaponIdTables
The existing 'Enemy use custom weapon table' feature uses the selected table to combine from.  

Internal and api changes:  
startOnFoot support for custom free missions.  
MissionCheckFree expanded to custom missions.  
weaponIdTable support for custom missions via missionInfo
heliSpaceFlags support for custom missions via missionInfo - thanks caplag for suggestion

OnRestoreSvars called on IH Modules.  

Refactor: core scripts to Assets//ih, using LoadLibrary external fallback loading.  
LoadExternalModule internal loading support.  

InfCore.GetGamePath: 
Use IHHook GetGamePath if available.  
Fall back to default steam path if package.path fails.  

Refactor: My messy dev stuff - debugshiz and devmenu pushed into IHDebugVars module

Fix: getBodyInfo reverted to directly reading ivar, should fix some issues related to enemy customBodyType - thank Solidus Snake for the report
Fix: GetGroundStartPosition - guard against unexpected mbLayoutCode (still no idea of the situation that would cause the value) - thank Solidus Snake for the files (and caplag for getting him to enable logging)
Fix: error on session change when IHH starts IHext
Fix: All customWeaponTable vars off would error.  
Fix: (of a previous fix) of wildcard soldiers causing the game to hang with some sideops,  thanks worthless person for the report.  
Fix: GetLastUserMarkerIndex - sometimes would not return correct marker, affected IH features using user markers.  
Fix: IHExt shouldn't start with IHHook - thanks Zacc for the report.  

r237 - 2020-03-31
Fix: Game % completion was lower than it should have been, and task completion in ui was showing a higher value than max.  
See: PATCHUP: BADDATA in InfMission, gvars.ui_isTaskLastComleted
This was due to me messing up the indexing when clearing some of the empty mission slots to use in the IH mission addon system, and a fox engine quirk where setting the save var (TppScriptVar) of TYPE_BOOL to 0 would set it to true.  
Caveat: Some users games that were saved prior to r234 might have some tasks marked as completed even if they hadn't done them yet.  
Thanks nishi980 for the report.  

Fix: My build process was including some files from a snakebite install run, hard to say what if any issues this caused beyond a bigger install size - thanks caplag for the report.  

Debug: InfCore.RefreshFileList outputs to cmd_stderr.txt

Fix: The automatic menu close on IH reloadscripts was called at a bad time casing it to  ihsave after Ivars had been reloaded but before it had been stood up in postallmodules (more specficially the ivars in modules loaded after InfMenu). Then if user reloadscript again without ihsaving the save file would effectively been cleared for those it could not find definitions for. 

Fix: r237b - missed " before stderr filename, causing refreshfilelist to fail - thanks morbidslinky for the fix

r236 - 2020-03-18
Fix: InfExtToMgsv mgsvToExtComplete not being set leasing ih_toextcmds.txt to always write all commands, which eventually IHExt would get fed up with. Was somehow lost in some refactoring. Thanks OldBoss for the report.  

r235 - 2020-03-15
gameOverOnDiscovery/ now works in free roam.  
gameOverOnDiscovery added to playerRestrictionsInMissionMenu
playerRestrictionsInMissionMenu added (actually renamed back to it's actual name and markersInMissionMenu split off). Thanks Steve Harvery for the prompt.  

Fix: UAVs on FOB should show their correct grade.  
Bug was due from me missing a subltle change while merging the mgsv 1.09 patch in April 2016, ouch.  
It got lost in the noise of variable name changes due to the minified lua files. Thanks elquinto for the belated report.  

InfUserMarker.PrintMarkerGameObject
Fix: PrintMarkerGameObject sol svars print.  
Added: Prints GetPosition of object.  

r234 - 2020-02-10
Refactor: Data: Build veh_rl_*_ih packs based on the veh_rl_ packs, removed modded veh_rl fox2s, which suould free up mods for the player vehicles without conflicting with that.  
IH modified the player / veh_rl vehicle packs for it's free roam vehicle patrol option.  

1. Because the packs were nice complete packs for vehicles, which was important in the early days when I didn't have the knowledge or tooling to create my own fpks.  

2. To bump up the instance count for TppVehicle2BodyData and TppVehicle2AttachmentData because I hit the issue of them using up the instances resulting in sideops vehicles appearing invisible.  

Though I still don't understand the logic on that since I can have more vehicles than instances in the patrols and they'll still show, but the sideops, which aren't even using the patrol vehicle packs will be affected.  

In some ways it's similar to the useextendfova problem wildcards have with sideops.  

Thanks placeholderthesteam for the prompt.  

InfDemo,InfMenu,InfMenuDefs,InfQuickMenuDefs:  
Added: In-Cutscene IH menu can be opened while cutscene playing.  
Fixed: Quick menu not working while in cutscenes.  
Change: Pause cutscene bind changed from EVADE (dive button) to STANCE (crouch button)

InfNPC:  
Change: Additional NPCs changed to a sub menu where you can individually set which additional npcs you want to appear - thanks Muffins for the suggestion.  

Fix: Completion percentage dropping to 99% and completed tasks counting higher than max - thanks AsiaSkyly and badbard99 for the reports.  

Fix: MB staff died message should appear in Mission 43 - thanks GrimreaperIII3 for the report.  
Was being overzealous in TppHero.SetAndAnnounceHeroicOgrePoint, still may need attention.  
Also a longstanding errant character I added (the curse of binding an easily pressed mouse button to a keyboard character) in s10240_sequence Damage message may have been causing an issue.  

Fix: Wildcard Soldiers causing some sideops to have missing enemies or soldiers and a resulting infinite load on reload or exit free roam.  
This seems to be a very long standing bug that I wasn't able to reproduce till recently.  
Unfortunately the fix comes at a cost of removing female soldiers from the wildcard feature as the bug is due to some fundamental problem with using the extend part system they use for their models in combination with sideops which was never used in the base game. 
Thanks TheIronIris for providing save files and information so I could reproduce the issue.  

Shifted the IH sideops (mother base animals and Blackfoot down) out of IH installation to their own addon mod. This stays truer to IH's 'default by default' policy and helps the sideops count now that the community has made many sideops.  

headInfo addons (fovaInfo):  
Added overwriteFaceId
Added uiTextureName
Allows addon creators to overwrite the games existing head definitions for MB Staff.  
See the notes in mod\core\InfModelProc.lua for more info.  

Thanks Cuba for his mod pushing in this direction to prompt me to add the feature.  

IH Core:  
InfMain.UpdateBegin for a Update before any other modules (base game Updates are after, and InfMain.Update was last).  
module .Update functions now get the missionTable param.  

Implementation of IHHook features (if installed):  
Call to IHH.Init from init.lua
Call to IHH.OnUpdate from TppMain (actually from InfMain.UpdateBegin)

Communication between IH and IHExt using named pipe for better performance when using the IHExt menu.  

Logging (mostly used for debugging) through IHH for better performance.  

r233 - 2019-11-27
Version bump for MGSV version 1.0.15.1
There was no actual script changes in the last MGSV update (nor this one) that made this necesary, but it slipped by when I got busy.  

Fix: Running prologue with debug mode on would cause weirdness. (10010 OnRestoreSVars has a yeild so PCalling it would error-skip the function).  
InfCore.Validate: Clarified error message, does not bail on first fail so all failures can be logged.  
InfUtil.InsertUniqueInList: Because sometimes you just gotta.  
InfMission: small refactor
InfMission: fleshed out a lot more missing missionInfo/mission addon stuff: 
TppEneFova.fovaSetupFuncs, TppResult.MISSION_GUARANTEE_GMP, TppResult.MISSION_TASK_LIST, TppEneFova.noArmorForMission, 
TppEneFova.missionArmorType, TppEneFova.missionHostageInfos, NO_ORDER_BOX_MISSION,
`<free roam mission>_sequence.missionStartPosition.orderBoxList`, `<free roam mission>_orderBoxList`
InfMission: missionInfo module support enabling hot zones (which is really just to bypass my disable OOB hack).  
Thanks caplag for pointing to some of these with his addon mission.  
See InfMission for example of the mission addon module.  

r232 - 2018-08-01
Fixed: 'DD Suit female' settings showing as 'table'

Refactor: customSoldierType - keys off igvars bodyType and bodyTypeExtend on PreMissionLoad instead of always off ivar. Provides some leeway in handling outcomes from body addons.  

r231 - 2018-07-28
InfRoutes - Counterpart to InfPositions, InfObjects as a load/save list of routes used for some debug options.  

InfNPCHeli
Custom heli patrol routes 
heli_patrol_routes_afgh.fpk - heli_patrol_routes_afgh.frt, and mafr counterpart. 
Just based of the drp routes I was using but with edges sanded off and sendmessage at and route.  
Route change is now msg based and now that distance to troublesome parts of the route are no longer an issue the update loop can be ditched (but still currently used for mtbs for changing route periodically).  
TppEnemy.StoreSVars/RestoreOnContinueFromCheckPoint2 reverted to saving heli svars, heli state should now, the previous bug that this was a workaround for is mysteriously absent, possibly due to the fact I'm not forcing route on continue.  

Fixed: InfMenu.PostModuleReload MenuOff moved to PreModuleReload, the save triggered by the normal menu off process would run into strife as Ivars had been cleared and the rest of the modules hadn't reloaded yet to add them back.  

InfModelProc: Soldier2FaceAndBodyData calls into this for body fova additions like it does face fova.  

Removed Setting: staff 'DD Suit' - 'Fatigues - All' setting to relieve additional fv2 limit for future addons. Won't return till/if full FoxKit gets full fv2 support.  

Framework: Soldier body fv2/fovaInfo addon support from \mod\fovaInfo via InfModelProc (bad name) to Soldier2FaceAndBodyInfo, have had face fovaInfo support for a long time, this just extends to body fovaInfo.  
Framework: WIP Soldier bodyInfo support from \mod\bodyInfo via InfBodyInfo to customSoldierType ivar(s). Still needs system to handle outcomes from uninstalled addons.  

Added Settings: Ocelot and Quiet added to Appearance > Player Type - WARNING: Ocelot and Quiet player types have side effect when used due to trying to work around them being restricted to FOB. The Pause menu will be disabled and the game may hit an infinite load if you complete a mission while they are used. Use nexusmods.com/metalgearsolidvtpp/mods/518 by BobDoleOwndU to fix sound issues with using these player types.  

Updated to TPP 1.0.13

r230 - 2018-05-08
Fixed: IHExtToMgsv.ProcessCommands calling WriteToExtTxt every frame, seems like this bug may have been in there since wpf IHExts creation.  
Fixed: IHExtToMgsv.ProcessCommands Not converting mgsvToExtComplete arg to number. Though the WriteToExtTxt concat seemed to interpret ok anyway?
Fixed: IHExtToMgsv.ProcessCommands no longer polls ih_tomgsvcmds.txt unless menu is open. This does mean no independant commands from IHExt, but apart from sessionchange, and togglemenu there werent any anyway.  
This should hopefully reduce the cases of lag on systems that are sensitive to how IH handles i/o - thanks to darkallnight for the reports and files to test with.  
Logging: Changed some LogFlow calls to Log for startup
Logging: lua memory usage 
Sys: running garbagecollect at end of start and LoadExternalModules. Can only assume the engine is doing some kind of lua management. hopefully this wont interfere.  
Refactor: IvarProc.BuildSaveText and other aspects of IH save to decrease save time.  
Fixed: Shifted various list based Ivars to index from 0 so IHExt combobox is not off-by-one.  
IvarProc: Vector3Ivar and other supporting functions to manage vector4 as ivar.  

InfObjects: Counterpart to InfPositions but for game object names, prior InfLookup.GetObjectList commands now use this.  
Objects menu
Counterpart to Positions menu, for adding to, saving/loading a game object name list. The list is used for other commands/features like warp, PlayCam target.  

ih_save: IvarProc.BuildSaveText now only writes if there's been a change. Should likewise help the i/o sensitive systems.  

InfPlayCam
PlayCam: Alternative camera to Free cam - thanks choc for prompting me to look at it.  
(via Camera menu > PlayCam menu)
[youtube]CQKOO-jnkBI[/youtube]
https://youtu.be/CQKOO-jnkBI

r229 - 2018-04-21
Fixed: Removal of some not-actually-subp subps from buildtool being too enthusiastic.  
Fixed: ShowFreeCamPosition not working.  
Fixed: Add position to position list not adding free cam position when in free cam.  
Fixed: Menu could be activated during loadscreen.  
Fixed: InfMenuCommands.ToggleFreeCam > InfCamera.ToggleFreeCam for SOC quickmenu.  
Fixed: Warp mode not working and also breaking IH menu - thanks everyone for the reports.  
TppEnemy: WIP quest support for hostage route, has issue where it wont work when reactivating quest though (leaving quest area and returning).  
TppEnemy: WIP quest support for uav setup, has crashing issue, either hitting the usual combined resources issue or it's not happy with being loaded/reloaded at runtime. uav fpk not yet in release build.  

r228 - 2018-04-16
Fixed: IH buttons/menu responsiveness when using HighSpeedCam/TimeScaleMode - InfButtons/InfMenu using os.clock instead of Time.GetRawElapsed (which is synced to game timescale) - thanks VenomHSCV for the prod.  
InfWeather:  
Option: weather_forceType - Force weather
Option: weather_fogDensity - Fog density
Option: weather_fogType - Fog type
(via In-mission > Weather menu)

Option: clock_setTime - Set clock time
(via In-Mission > Time scale menu)

QuickMenu: Reverted button back to [CALL]

r227 - 2018-04-04
Fixed: Prior style QuickMenus breaking in various ways (SOC quickmenu for example).  
Refactor: No longer calling WriteToExtTxt() every ExtCmd, should smooth IHExt performance a bit.  
IHExt: Better handling of selecting menuLine text when giving focus via mouse click.  

r226 - 2018-04-03
Changes to buttons/keys:  
InfMenu: While menu open hold <Switch Zoom> (V key or RStick click) + player move (WSAD or left stick) to navigate menu
Quick menu: No longer uses [CALL], now activated with <Switch Zoom> (V key or RStick click) + command key (see MGS_TPP\mod\modules\InfQuickMenuDefs.lua)

ChangeLog: merged some older seperate modfpk/data changelogs.  

Refactor: OnChange self,setting,previousSetting swapped to self,setting,previousSetting.  
Refactor: InfMenu lang stuff moved to InfLangProc.  
Refactor: InfMenu, InfLZ, InfRevenge to external.  
Refactor: execChecks.inHelispace renamed inSafeSpace, missioncode check function added
Refactor: InfMenuDefs.heliSpaceMenu renamed safeSpaceMenu
Refactor: Remaining Tpp requires modules InfButton, InfModules, InfMain moved to external / core
Refactor: InfInitMain to load and Exec prior Tpp requires modules and kick off LoadExternalModules
InfCore: LoadLibrary: Wrapped lua chunk load in PCall to catch errors (was only catching LoadFile)

WIP: sys_increaseMemoryAlloc - increases various memory allocation sizes, to no noticable effect on stability `-_-`
WIP: quest_useAltForceFulton - fires CheckDeactiveQuestAreaForceFulton when outside quest activeArea instead of by traps, needs testing as posibly the trap method was added because of issues with what this is attempting.  

Fixed: IHExt InfMenu.GetSetting GetSettingText out of bounds. Affected buddyChangeEquipVar, possibly a couple other menu items - thanks WyteKnight for the report.  
Fixed: QuietMoveToLastMarker not working, hadn't transfered a localopt of SendCommand  - thanks WyteKnight for the report.  
Fixed: DropCurrentEquip not working, issue as above - thanks Saladin1251 for the report.  
Fixed: Changing 'Player life scale' in-mission not working - thanks Ronix0 for the report.  
Fixed: Zombie Obliteration hang on load, hadn't added localopts when moving SetUpMBZombie from InfMain - thanks magicc4ke for the report.  
Fixed: IHExt - not displaying current setting upon activating an option from IHExt.  

IHExt: MenuLine changed from Label to TextBox, GotKeyboardFocus, EnterText commands.  
IHExt: Search (EnterText > InfMenu.BuildMenuDefForSearch). Alt-tab to IHExt, click or tab the text of the menu line below the menu list. Type something and press Enter.  

r225 - 2018-03-07
Fixed: Hang on load with no ih_save, wasn't initializing igvars oops - thanks серёжа for the report and the save files to test.  

r224 - 2018-03-06
IHExt: args[1] - gameProcessName

Refactor: InfMain.LoadLibraries > module.LoadLibraries
Refactor: Ivars split into modules that have the main use/implmentation of the Ivar (or even <module>Ivars when that gets too hefty).  
Refactor: InfMenuDefs split into modules.  
Refactor: InfLang split into modules.  
Refactor: IvarProc missionModeIvars split to missionModeIvarsNames (string) so ih modules can support. fixup of string table to ivar table done at postmodulesload
Refactor: InfFova moved from libs to external.  
Refactor: InfMain split to InfMainTpp, InfTimeScale, external. Probably needs more splitting.  
Refactor: TppDbgStr32 methods/lookup table migrated into InfLookup. mod/strings/ > Str32 lookup now on InfLookup.PostAllModulesLoad instead of OnInitializeTop which should help mission loading time with debug mode on a bit.  
TppDbgStr32 reverted to vanilla/no longer included in build.  

InfMotion:  
Motions menu - Play different animations on player. A motion group may contain several related animations (usually lead-in, idle, lead-out)
Option: Motion group - Press <Action> to play the selected animation.  
Option: Motion number - Press <Action> to play the selected animation.  
Option: Hold motion - Holds motion, requires stop motion to stop.  
Option: Repeat motion - Repeat motion at end, some animations don't support this.  
Option: Stop motion - Use to stop motions with motion hold or motion repeat.  
Option: Play motion - Closes menu and plays current selected motion.  
(via in-mission menu)

InfPosition:  
Positions list from ShowPosition migrated to it's own command, commands for adding user markers, clearing, and writing them to \mgsv_tpp\mod\ added
Positions menu - for writing in game postitions to files, useful for getting positions when creating sideops.  
Commands:  
Add current position to Positions List - Add current player or freecam position to Positions List, positions list can be written to file with Write Positons List command.  
Add markers to Positions List - Adds current user markers to positions list, positions list can be written to file with Write Positons List command.  
Write Positions List - Writes Positions List to files in MGS_TPP\mod\
Clear Positions List - Clears Positions List
(via in-mission menu)

Data: Walker instance count dropped from 16 to 14 - 10x for IH and 4x for quest. Should ease the gameobject limit/issue a little bit too.  
Workaround: Walker positions in free roam now static / using locator positions. Setposition breaks when other locators are loaded in sideop. This workaround doesnt really work for motherbase since it has the further requirements of only having walkers on platforms that are actually built (and I'm not about to make 7x10 variations).  

Command: Support heli to marker - Sends Support heli to Landing Zone closest to the last placed user marker while riding it. This replaces the existing 'Support heli to latest marker' and now can only be used while riding the support heli. This removes a lot of the issues of riding the support heli across the map that the prior method had.  
Implmentation wise this works by forcing the heli to a specific route, the WIP version prior to this had too many issues since it used LZ routes, now it uses custom routes thanks to sais FoxLib. So special thanks for his work on the library.  
(via in-mission menu)

r223 - 2017-10-02
Fixed: IHExt help box appearing on map change - thanks vollmerej1 for the report.  
Fixed: ih_tomgsvcmds being read every frame, causing stutter on some systems. Lua io has a bigger overhead than I thought - thanks BurkusCat for his data, others for their reports. 

r222 - 2017-09-19
IHExt: Included in build - thanks MorbidSlinky for the SnakeBite update.  

Fixed: Custom sideops with helis not allocating a heli (if no normal heli sidops also active) - Adding hasEnemyHeli to quest definition will add it to the heli quest list - which means force heli reinforce will also block those quests - thanks MorbidSlinky for the report.  

Fixed: StartIHExt with paths with spaces in them - thanks GambChon for the report.  

r221 - 2017-09-17
Fixed: IHExt setting when IHExt is not installed.  

IHExt: added helptext, menutitle, combobox for settings.  

r220 - 2017-09-11
Addition: Added 'Enemy prep' setting to Attack heli patrols options - sets the number of helis to scale with enemy prep level.  

Fixed: Hang on load when ih_save contains an unknown variable (most recently caused by my rename of heliPatrols ivars) - an access to the ivar slipped outside of my check to see if the ivar actually existed. - thanks ashy8000 for the save files and others for the reports.  

Fixed: Re-added <Action> tag to options that have OnActivate, was a bit too zealous in removing it. 

InfButton: some localopts, adjustments for repeat speed with IHExt.  

Debugging: InfCore.PCall force logs error.  

IHExt: Output menu to list.  

r219 - 2017-09-03
(Actually added in r218, but not in easily accessable menu)
Options: setStageBlockPositionToMarkerClosest, setStageBlockPositionToFreeCam, resetStageBlockPosition - sets stageblock loading position. You have to put player in a safe spot/bump player health to 650% so they dont die when their current position unloads and they (may) fall through terrain till they hit level floor.  
(via in mission debug menu)

Fixed: Lag or load hangs due to a file that was removed for r218 that may have been left in MGS_TPP\mod\modules if mod user didn't uninstall r217 or earlier correctly using snakebite.  
Detail: Added empty function InfCore.DoToMgsvCommands which InfProcessExt calls. Would not have been an issue except I also removed the ivar that would exit before the call and the check for it was ==0, a not ivar would have covered the ivar being null too and prevented the issue (though I would not have been aware of the file lingering for some users).  

Modules: Support for Ivar and menu definitions in IH modules.  

r218 - 2017-08-31
heliPatrolsMB, heliPatrolsFREE renamed attackHeliPatrolsFREE, attackHeliPatrolsFREE "Attack heli patrols in free roam",
  "Attack heli patrols in MB", value is now number of attack helis.  
Option: supportHeliPatrolsMB - split from heliPatrolsMB, is number of support npc helis, count will take priority over attack helis to fit to number of mother base clusters built.  
Beyond giving some more control over amount of helis you face, it also lets things be a bit quieter in mother base while still having helis fly around. 
Because of this change you will have to set the options again, sorry for the inconvenience.  

Refactor: InfMenuDefs,InfQuickMenuDefs commands change to string/lazy binding. Some commands that were just wrappers to other modules reference them directly.  
InfQuickMenuCommands: Merged with InfMenuCommands

Fixed: ApplyProfile failing on random table of setting strings. 
Fixed: ApplyProfile failing on missing ivar.  

IHExt: Shift from console to wpf proto branch.  

Option: enableIHExt (was postExtCommands) 'Enable IHExt', now launches IHExt (if present).  


r217 - 2017-08-22
Just repack/snakebite exe version for 1.0.12.0 which only updated exe.  

r216 - 2017-08-22
GameEvent: Other swimsuits added to Femme Fatales event.  
Fixed: Random roam event selection failing.  
InfCore: path serperators changed to forwardslash.  
InfLookup: Strings moved out of individual modules to strings folder with .txt files. Bit longer loading, but more managable to add to.  
InfLookup: GameIdToName fixed.  
InfLookup: subtitleId32ToString now uses supb_dictionary
Mock: More yeilding to host during load. 

Options: mbShowHuey - Show Huey - Shows Huey in BattleGear hangar and in cutscenes even before he's arrived or after he's left story-wise.  
(via Mother Base > Show characters menu)
Option: mbForceBattleGearDevelopLevel - Force BattleGear built level - Changes the build state of BattleGear in it's hangar, 0 is use the regular story progression.  
(via Mother Base > Show assets menu)

Options: MB Ocean options - adjust various parameters of ocean movement.  
(via MB Ocean menu while in mother base)

Fixed: removed \mod from package.path which caused users who had old IH pre-mod folder restructure installs to fail on load (and one cause of 'Could not load modules from MGS_TPP\').  
Should have done this when I did the restucture.  

r215 - 2017-08-13
Fixed: Hang on load, due to a ghost of an old file or something. Sorry.  

r214 - 2017-08-13
Fixed: ih_priority_staff sometimes clearing saved data

BuildTool: Copy docs to makebite\GameDir
InfAutoDoc: Now writes All options profile to release - thanks pk5547 for the report.  
Now that these are automated should stop me from ocasionally forgetting to include the current ones when building release lol.  

r213 - 2017-08-09
Fixed: playerPartsType/'Suit type' syntax error causing it to be missing from menu - thanks SoullessMadness for the report
Fixed: Heavy Armor in free roam option being missing from menu, and the knock on effect of the rest of the menu options being missing from Features and Options document and All options profile. Thanks Nano-Ocelot, pk5547 for the reports.  

Option: enableEventHUNTED - "Allow Hunted event"
Option: enableEventCRASHLAND - "Allow Crashland event"
Option: enableEventLOST_COMS - "Allow Lost Coms event"
Will allow you to filter the free roam events from being chosen.  
(via Events menu)

Feature: Priority MB staff list 
Module: InfMBStaff, save ih_priority_staff

Command: "Add player staff to MB priority"
Command: "Remove player staff to MB priority"
Command: "Add marked staff id MB priority"
Command: "Remove marked staff to MB priority"
Command: "Clear MB staff priority list"
(via Mother base > Staff menu)

Using these commands you can either add the current chosen staff member, or a staff member that you've marked to the priority list. Upon visiting mother base these members will be chosen to be on base (assuming they are not on deploy mission).  

Menu: Staff menu, apart from the above, mbPrioritizeFemale,mbMoraleBoosts have been moved here.  

Option: mbEnableMissionPrep - "Enable mission prep to MB" - may require an exit/return from ACC to take effect.  
(via Mission-prep restrictions menu)

More mockfox stuff.  

r212 - 2017-08-03
Fixed: Primary/Secondary NONE slots conflicting with swimsuit dev entries.  
Fixed: Camo type appearance menu option erroring when no developed camos for current suit.  
Fixed: playerPartsType/'Suit type' now sets playerCamoType on change.  

Addition: 1.0.11 Swimsuits added to customSoldierType (free,DD Suit)

customSoldierType - filters to developed

r211 - 2017-08-02
Updated for mgstpp 1.0.11.0

Added: itemLevelIntScope - Int-Scope level, itemLevelIDroid - Int-Scope level. Lets you set the item grade - thanks Saladin1251 for the suggestion. 
(via Player restrictions > Item level menu)

Fixed: Invisible tanks in Afghanistan freeroam sideops with vehicle patrols on. Misspelled veh_rl_east_tnk_fpkd as veh_rl_east_tank_fpkd when I renamed them back in r196 due to snakebite dictionary update. Oops - thanks pk5547 for save data and report.  

Commands: setSelectedObjectToMarkerClosest, setSelectedCpToMarkerClosestCp - debug shiz.  

Addition: 1.0.11 Swimsuits added to appearance menu.  

r210 - 2017-07-22
Fixed: Quarantine platform soldiers having no weapons with custom equip table.  
Fixed: mbNpcRouteChange - 'Soldiers move between platforms' not working on initial cluster load, looks like I broke it in r208 - thanks pk5547 for save data, others for the report.  
Fixed: Additional npcs with no faces on quarantine and Skulls T-Posing, just disabling additional npcs on quarantine completely at the moment - thanks pk5547 for save data and report.  
Fixed: InfEquip.DropItem on GetPosition nil (Eli)
Fixed: postExtCommands not passing currentSetting to OnSelect (unlockSideOpNumber)

Mock: Various settings to manage the distinction between host types.  

r209 - 2017-07-17
Debug: loadToACC settable on ih_save to have game load ACC on continue from title menu instead of loading saved mission. 
Is same as holding Escape for a couple of seconds at tile, but possibly more discoverable or providable.  

AutoDoc/WriteProfile: IsForProfile now excludes non save ivars.  

Mock: Bunch of work on Mock pulling from Dump.  

Fixed: Skulls event being forced to Sniper skulls, forgot to revert my debug test which means:  
Fixed: (refixed) Crash on encounter with Quiet in free roam when Parasite event selects Camo skulls.  
Should actually be fixed now. Sorry.  

Fixed: Accidentally left out the IH mother base animal sideops, Blackfoot Down in r208. Woops.  

IvarProc.LoadEvars loads ih_save.lua to global module (instead of just to a local and operating/discarding that), InfQuest.ReadQuestStates reads from that instead of loading ih_save.lua

Refactor: Equipment loading centralized in InfEquip.LoadEquipTable, CreateCustomWeaponTable now takes that loaded equip into account for equipment limit.  
Fixed: Not being able to use weapons/weapon ammo count wrong with custom soldier equipment and other settings on alongside sideops mod. Thanks various people for reports.  

ih_save will retain addon sideops states even when game run with addon sideops not installed.  

r208 - 2017-05-30
Option: loadAddonMission - "Load addon mission" - WIP
(via IH system menu)

Fixed: Sideop list not showing sideops > 192. This is a hard limit in the ui, this workaround manages by skipping random cleared but not currently active sideops. Reroll sideops selection will also reroll this selection.  
Ref InfQuest.GetSideOpsListTable

Option: showAllOpenSideopsOnUi "Show all open sideops" - "Shows all open sideops in sideop list, this mostly affects open but not yet completed sideops from hiding others. There is however a limit of 192 entries for the sideop list, so some will be randomly dropped from the list."
(via Sideops menu)

Fixed: mbAdditionalNPCS KLUDGE DDs groundcrew on Zoo 

Fixed: Female soldiers defaulting to male olive drab body when DD suit female set to Off instead of olive drab female while DD Suit for male not Off - thanks Saladin1251 for the report and save files.  
Fixed: Invisible helmets for female wildcard soldiers (removed helmet propety alltogether) - thanks halo4kid for the report.  

Refactor: InfCore.RefreshFileList parse a single dir > ih_files.txt instead of one per subfolder.  

Option: ihMissionsPercentageCount - "Include addon missions in completion percentage" 
(via IH system menu)

Fixed: (refixed) Crash on encounter with Quiet in free roam when Parasite event selects Camo skulls. Thanks AyyKyu for the report and files.  

Updated: showPosition - now adjusted by -0.8 for a more accurate ground position
Updated: showPosition - writes rotationsXML / quaternion of current playerY

Option: speedCamNoDustEffect - "No screen effect" - "Does not apply the dust and blur effect while TSM is active."
(via Time scale menu)

Data: location\ombs\ombs.fpk/d - adapted from mbqf
Data: location\ombs\pack_common\ombs_common.fpk/d adaptped from mbqf_common/ gz ombs_common
See wip\old mother base for just gz ombs ombs_common.  
Data: location\ombs\pack_small\*.fpk/d adapted from location/mbqf

Data: mission2\free\f30045\f30045.fpk/d based on f30050_hanger_btg05.fpk/d
Data: ftsb for ombs modified from mbqf ftsb to point to ombs pack_common

Module: InfMission - to patch in various location and mission info.  

MGO maps: remove MGO only entities from pack_common fpkds.  

r207 - 2017-05-10

Addition: Addon sideop on Sideop selection mode to filter for additional sideops.  

InfCore: gameIdToName,GetGameObjectId. For lookups.  

Fixed: 'Fatigues All' Custom soldier type/DD suit hanging on load.  

InfMain.OnAllocate: bumped equip block size and max pickable count.  
Fixed: Equipment on trucks equipment not appearing with some other settings. Afghanistan range of equipment less than Africa.  
InfQuest: requestEquipIds > RequestLoadToEquipMissionBlock for sideops with pickables.  

r206 - 2017-05-02

FreeCam: Speed adjust rate change to be slower.  

Option: rerollQuestSelection - Reroll quest selection
(via Sideops menu)

Fixed: NPC positions on outer clusters when command cluster is under grad 4/not fully built (currently just disabling NPCs on the outer clusters for that situation).  

Fixed: XRay markers. 
No idea how I broke it, or more specifically why it was working when it was called where it was.  

Command: selectedChangeWeapon renamed dropTestEquip
Command: dropLoadedEquip pulls from loadEquip table.  
Command: selectEvent

Option: hideContainersMB - "Hide containers"
Option: hideAACannonsMB - "Hide AA cannons"
Option: hideAAGatlingsMB - "Hide AA gatlings"
Option: hideTurretMgsMB - "Hide turret machineguns"
(via Mother base > Show Assets menu)
Removing AA guns can be good for wargames if you dont want something that can swiss cheese helis around.  
Removing all the AA and the conainers can be useful if you want to drive/gallop around the platforms without so much stuff being in the way.  

Fixed: Some custom soldier type/dd suit bodies incorrect.  

Debuging: Logging of TpSequence.SetNextSequence
InfHooks: Debughooks also logging function args

InfQuest: Allow quest block script to use external quest definition as its replacement. 
InfQuest: Reworked to allow reloading scripts while in-game.  

r205 - 2017-04-29
Addition: DD Suit - Fatigues All - will have random selection from all fatigue camos.  

Refactor: Shift from IsFemale cmd (which is actualy only for hostage) to own IsFemale set/get function. Would cause bodyInfo to always default to male causing various issues for dd suit female/female wildcards as they defaulted to male bodyInfo. Still don't have full coverage as selection of faceId is later than many functions that use bodyInfo.  
Fixed: various DD suit/wildcard females issues. 

Module: InfMBAssets - implements fulton/ir sensor alarm response.  
Option: enableFultonAlarmsMB - "Enable asset alarms" - "Enables anti fulton theft alarms on containers and AA guns. Only partially working, will only trigger alarm once.",
Option: enableIRSensorsMB - "Enable ir sensors" - "Enable ir sensor gates. Only partially working, will only be at level 1 (one beam) and will only trigger alarm once.",
(via Mother base > Show Assets menu)

Data: ih_ships.fpk
Option: mbShowShips - "Show ships" - Shows some ships around mother base.  
(via Mother base > Show Assets menu)

InfMain: Refactor - shifting some module specific code to the modules
InfSoldierParams: Made external.  

Fixes: Various modules with on cluster load setup when moving to the seperation plat (which won't actually happen outside of warping). Seems like the initial idea might have been to be travel to it without loading a seperate missioncode. One texture in the game (no idea of the name/path) shows a map of

Sideop: Blackfoot down updated. Added soldiers to river LZ (routes from q11050).  

Update: Add/subtract demon points decreased to 90k per use - thanks SoullessMadness for the suggestion.  
See https://www.gamefaqs.com/boards/718564-metal-gear-solid-v-the-phantom-pain/72466130 for breakdown of the demon points levels.  

InfLookup: More message signatures.  
InfStrCode: Changed to read .lookupStrings table from any modules. Bunch of string scrapes from exe,fox2,lang dict added to modders resource.  

r204 - 2017-04-23
(version skip because of 202a/203 snakebite 0.8.5 .6 ver confusion)

EquipIdTable: Assigned world models to EQP_IT_Stealth,EQP_IT_InstantStealth (reusing idroid model), EQP_IT_ParasiteMist, EQP_IT_ParasiteCamouf, EQP_IT_ParasiteHard, EQP_IT_Pentazemin, EQP_IT_Clairvoyance, EQP_IT_ReflexMedicine (reusing bait model)

Improved: itemDropChance - Soldier item drop - now has chance to drop Pentezemin, Noctocyanin, Acceleramin. 

Sideop: Blackfoot down, was mostly built for testing out sideop features.  

InfButton: OnComboActive
InfCore: LoadBoxed to LoadSimpleModule with box flag

Doc: Documentation installed to \MGS_TPP\mod\docs

Command: Save to UserSaved profile. - "Saves current IH settings to UserSaved profile at MGS_TPP\profiles\UserSaved.lua."
(via IH system menu)

Ivars: Tagged with inMission (with default assumption being false/only load time setting).  

Fixed: Setting Custom soldier type to a DD body showing the Staff member has died message/points - thanks coolguy3090 for the report.  

Data: ih hostage parts for MSF_GZ,DOCTOR_0,DOCTOR_1,NURSE_3_FEMALE,CHILD_0
InfNPC: better per cluser,per plat filtering of npc types.  
mbAdditionalNpcs - Doctors and Nurses added to Medical, children added to all.  

Option: postExtCommands - enables output for IHExt

InfLookup: More message signatures, gameobject names.  

Change: [STANCE] heli-pull out toggle changed from press to hold 0.85.  

Fixed: Multiple female hostage sideops only applying female voice to one hostage. (in TppEnemy.SetupActivateQuestHostage)

InfQuest: Shift questInfo luas to load from external quests folder. 
InfQuest: qst_questClearedFlag now saved directly instead of just the index of.  

Data: Shifted soundbank loading files (.sdf,fox2s) from ih_hostage_def.fpkd to ih_hostage_base.  
Data: Created 'other' sound bank loader for non english hostage soundbanks.  

Sideop Dev feature: IH quest definition disableLzs, lets sideops authors disable landing zones while the sideop is active.  
Sideop Dev feature: questCompleteLangId will act as langId if announceLogId doesnt exist.  
Sideop Dev feature: pass through to DebugIHQuest external module to allow more rapid testing of quest block scripts.  
Updated IH quest example
Thanks Morbidslinky for driving many of these features.  

r202 - 2017-04-09
Fixed: Number of helis on < 7 clusters, including mass bunching when only command is built.  

Option: ihSideopsPercentageCount - "Include IH sideops in completion percentage." - Additional IH sideops count towards game completion percent - defaults to off.  
(via sideops menu)

Refactor: InfModelProc - fovaInfo entries can now be referenced by fv2 filename, allows using existing entries instead of having to add duplicate.  
Refactor: InfEneFova - the various head fova infos now referenced by fova name instead of index.  
Refactor: Some functions shifted from InfCore to InfUtil, InfUtil loaded earlier during startup.  

Refactor: pattern for messages in external modules changed to niling messageExecTable straight off in Init/OnReload and having OnMessage just be a call to Tpp.DoMessage instead of bailing on specific checks. 

Feature: Completed randomFaceListIH for quests, a downside is it doesn't support mixed specific face and random like randomFaceList does - thanks MorbidSlinky for the headsup.  

Known Issue: Crash on exit from title after having returned to acc from mb during the game session with mbAdditionalNpcs. Similar issue to r179 which also involved hostage entities (do comp r179 vs r178/f30050_npc.fox2)

Data: ih_hostage_base.fpk/d - based off mis_com_mafr_hostage.fpk, to complement bodyInfo system.  

Refactor: InfNPC to InfSoldier
Module: InfNPC - split from InfHostage, handles mbAdditionalNpcs="Additional NPCs",

Option: mbAdditionalNpcs - "Additional NPCs" - Adds different NPCs standing around mother base, including ground crew, researchers and Miller.  
(via mother base > Show characters menu)

r201 - 2017-03-30
Fixed: Mother base soldier getting set to hostile - thanks captainking91, others for the reports

revengeModeMB is now revengeModeMB_ALL

Refactor: InfEneFova.ddBodyInfo split to modules\InfBodyInfo.lua .bodyInfo.  

Data: `ih_soldier_base.fpk/*_mdl.fpk`

Refactor: InfModelProc, now loads all fovaInfo files in mod\fovaInfo 
InfLookup: added (possibly incomplete) gameObjectClass names.  

Option: customSoldierTypeFREE - Custom soldier type in Free roam - Override the soldier type of enemy soldiers in Free Roam.  
(via Enemy Prep menu)
Added settings for DD suit (same options as Custom soldier type): MSF GZ, XOF Gasmasks, XOF GZ, Genome Soldier. May need to re set your DD suit setting as some existing tiems in list have been shifted.  

Refactor: InfEneFova.AddBodyPacks added, ddBody pack setup shifted from TppMissionList to InfNPC, in conjunction with the mission mode ivars for customSoldierType give coverage to any mission.  

Refactor: Improved GetHeadGearForPowers selection

r200 - 2017-03-05
Option: forceDemoAllowAction - "Force allow actions" - Prevents disabling of player actions during cutscene, but most cutscenes require the Disable cutscene camera mod on the IH files page.  
(via Cutscenes menu)

Feature: Quickmenu binds for when cutscenes running, currently only Free cam useful with above option and Disable cutscene camera mod.  

Refactor: Non critical external modules failing to load will no longer block the IH menu from opening - thanks CantStoptheBipBop for the report.  
Fixed: Skull attack on quarantine platform failing part way through ParasiteAppear - thanks pk5547 for the report.  
Fixed: Cutscene reset.  
Fixed: Using mbShowCodeTalker - "Show Code Talker" option on a save before meeting him causing infinite load - thanks junguler for the report.  
Fixed: Quick heli pull-out toggle no longer triggers if idroid open.  
Fixed: FreeCam code not disabling when changing level.  

r199 - 2017-02-11
Fixed: Lack of error message when MGS_TPP\mod or subfolders missing.  

Refactor: Allow external modules to run Update without execchecks, execstate guff.  

Refactor: InfLookup - expanded different lookup types, message signature to lookup types.  

Refactor: InfGameEvent shifted to external.  
Fixed: Crashland event not triggering injury.  

Module: InfDemo
Feature: Pause/resume playing cutscenes by pressing Quickdive
Feature: Restart cutscene by pressing Reload

Option: disableOutOfBoundsChecks - Disable out of bounds checks - Disables the out of mission area visual noise and game over checks.  
(via Debug menu)

Option: disableGameOver - Disable game over - disables various game over screens, haven't tested much so use with caution.  
(via Debug menu)

r198 - 2017-01-31
Refactor: File per profile, list all profiles in profiles folder.  
Refactor: Load all external modules load from modules folder/don't have to manually add to InfModules
Refactor: ih_save.lua now in mod\saves

Fixed: Legendary animal sideops not completing on fulton - thanks iponomama for the report.  

Fixed: Afghanistan quests with unique bodies (Armor, Wandering MB soldiers) being invisible, was broken since r155 - thanks everyone for the reports.  
Detail: ih_soldier_loc_free soldier count dropped from 50 to 40. Don't know why the number of soldiers is breaking the fova system here, quest fova for unique bodies (which is set up on quest block load) breaks, but if you allocate the body in pre mission load it's fine. *shrug*

Fixed: Soldiers having no heads on Mission 43 "Shining Lights Even In Death" - thanks AustrianWarMachine for the report.  

r197 - 2017-01-11
Refactor: Rename InfLog to InfCore, .Add to .Log

Refactor: InfInspect loading shifted to init.lua
Refactor: IvarProc,Ivars - dependancies removed

Refactor: InfProc - save system made a little more ameniable to reading/writing other sections.  

Build: Included TppVarInit to manually hook StartTitle (as its loaded after requires list/InfHook)

Fix: gameSaveFirstLoad now somewhat accurate (wasn't actually used), and InfMain.OnStartTitle can be used as on-first game save load.  

InfQuest: installedQuests management of gvars quest states for IH quest sub-mods. The existing IH quests will be cleared on start of this version but will keep their state as long as the ih_save has the installedQuests added.  

Module: InfSecurityCam WIP
Data: ih_security_cam.fpk
Works but crashes on map exit (some times, but consistantly till (sometimes) proper map reset (ie not just abort to acc/start again), assuming its the combined gameobject/allocation issue.  

Module: InfUAV WIP
Data: ih_uav.fpk/d
Working, but not useful without custom routes.  

Module: InfHostage WIP (acually starteds in prior versions). 
Setting face via uniquesettings doesn't seem to set body skin fova?
SetRelative vehicle requires a route to be set. 
Hostages can't follow travelplans as far as I can tell.  
A few attempt to expand quest random face system to more than one face per quest, but the whole thing is super flakey and will more often than not not load the head, including weirdness where it will, then will stop rendering it while in game.  

Fixed: Start offline option preventing dlc items - thanks morbidslinky for the fix.  

Fixed: Starting on map floor on mother base start on foot on first visit after building a platform in the command cluster - thanks NasaNhak 
(InfMain.OnGameStart)

Refactor: Ivars system,ih_save loaded on init.lua, now (non-gvar) ivars useable from very start of script system execution.  

Command: setAllFriendly - In debug stuff menu

Feature: External loading/replacement of most scripts via MGS_TPP\mod\<script path>, more for modder expermentation than average user.  

r196 - 2016-12-10
Core: GetPath nil fallback to C:\

Added Headgear (cosmetic) to Filter Faces (splits headgear from Unique filter)

Fixed: Onselect settings param passing through

Build for SnakeBite 0.8.4
Data: veh_rl_* to proper names from hashed.  

Fixed: Female Wildcard face range incorrect, resulting in defaulting to smushmanface.  

Fixed: Quests with balaclavas breaking those soldiers - thanks shynbean and PerkPrincess for your report.  

Fixed: mbAdditionalSoldiers,"More soldiers on MB plats" not loading the additonal soldiers, reulting in empty platforms - thanks  shynbean for the report.  

Fixed: IH interrogations would not return wildcard soldier locations - thanks rargh for the report.  

Fixed: Soldier headgear on fobs.  

r195 - 2016-12-03

Wildcard soldiers and hostages have staff parameters regenerated. Should always have a skill assigned now and have high stats (in respect to current mb level/stats draw)

Refactor: Only call module prereload/postreload on actual user module reload.  
PostAllModulesReload renamed PostAllModulesLoad to clarify it's execution.  

mbPrioritizeFemale - "Female staff selection" - added Half setting.  

Fixed: Crash on startup with missing InfModelRegistry (loadboxed forceing debugprint/anouncelog in start.lua which is aparently too early for announcelog system)

InfEnemyPhase - fixed phasechange update, had found the issue just prior, but thanks GloomMouse for the report anyway.  

InfQuest: Added randomFaceList support to registerquests

InfQuest: WIP quest mod support. Split questInfo into seperate modules to allow quest mods. Example quest created, but broke it at some point, and still need documentation, need to get this version out though for some fixes.  

Show position command: expanded to logprint large block name, small block index, quest area and isinside areatypes;
command now adds positions to a table and logprints them out, useful for getting a bunch of positions without having to scour the output for them individually (though I should just dump them to a file)

Functionality: Extended TppEneFova PreMissionLoad fova setup to external modules.  

Data: `ih_quest.<langcode>.lng2` split to `ih_general.<langcode>lng2`
Module: InfUtil - split some functions from InfMain

Fixed: (partial), setting unlockSideOpNumber via profile will not give OUT OF BOUNDS error, but currently still won't be able to set them > 157 - to new sideops - thanks pk5547 for the report.  

Refactor: Shifted IvarProc.OnCreateOrLoadSaveData into LoadEvars, consequently ih_save initial load is earlier, in init mission load.  
Need to split from gvars if I want to go earlier.  

Data: Split ih_bird_quest.fpk/d into ih_raven.fpk/d
Increased number of ravens to 8.  
Sideop: Birds in the belfrey - number of birds increased.  
Data: Split ih_rat_quest.fpk/d into ih_rat.fpk/d

Option: mbEnableBirds - "Enable Birds" - enables birds flying around mother base.  
(via the Mother base > Show characters menu)

Expanded resource amount scales to scale by type:  
enableResourceScale="Enables the resource scale options that scale the amount of resources when gathered (material case resources, containers, diamonds, plants)",
resourceScaleMaterial="Material case scale"
resourceScalePlant="Plant scale"
resourceScalePoster="Poster scale"
resourceScaleDiamond="Diamond scale"
resourceScaleContainer="Container scale"
(via Progression menu > Resource scale menu)

Data:  
ih_hostage_pdd5.fpk/d from mis_com_fob_hostage
split to:  
ih_hostage_loc - 4 hostage locators

ih_hostage_pdd5_def - TppHostage2 hostage defintion with prs/pdd5_main0_def_v00.parts to match ih_hostage_dd

r194 - 2016-11-18

Fixed: Some defaults not applying on fob.  

Fixed: Allow skull types not actually filtering the skulls select - thanks SoullessMadness for the report.  

Fixed: (mostly) Allow heavy armor in free/missions, Custom prep with armor % high would cause soldiers either defaulting to non armored or not rendering body.  

Refactor: InfUserMarker shifted to external

Debug: Added debugUpdate - pcalls on TppMain.OnUpdate / module updates

InfMain: Added PostModuleReload callback for external modules

Module Additions: ihQuestsInfo,RegisterQuests - pulls together various quest data for easier setup of new quests.  

SideOp: quest_q30100 - "Sheep in the Keep" - "Logistics had a mishap and let a herd of sheep loose on the Command Platform. Fulton them so they can take them to the Conservation Platform." 
SideOp: quest_q30101 - "Birds in the Belfry" - "Your staff has been having some issues with birds roosting in the Intel Platform Enclosure. See if you can clear them out." 
SideOp: quest_q30102 - "Rats in the Basement" - "The grow-room under the Support Platform is plagued by rodents.&#xA;Find them among the plants." 
[youtube]Xe5VjKC2f9w[/youtube]
https://youtu.be/Xe5VjKC2f9w

Functionality: TppAnimal.CheckQuestAllTarget,TppQuest.Update to allow for quest update notification on multiple animal quest update
Added support for target name list in quest script animallist.  

Fixed: Animals camo selectable via the camo option.  
Fixed: RETAILBUG: TppAnimal quest assigning ani_questTargetList to exact same tables, which caused issue when trying to assign different messageid in CheckQuestAllTarget
Wasn't actually an issue in retail since there was no quests with more than one animal.  
Fixed: Mb puppy no longer disables sideops on Command cluster.  
Refactor: As above, mbPuppy shifted from quest Mtbs_child_dog to it's own module/fpk 
Data: ih_puppy.fpk/d built from quest_child_dog.fpk/d
Module: InfPuppy

Fixed: TppQuest.UpdateActiveQuest now using level seed for random or side ops selection mode. This fixes mismatch bettween aparent selected sideop (ui cues) and actual sideop pack/script loaded when directly spawning into a quest load area, possibly a rare issue in free roam, but a clear issue on mother base. Should also prevent the change of sideops from ACC to level.  

Data: Fpk \Assets\tpp\pack\ui\lang\lang_default_data_eng.fpk - Assets\tpp\lang\ui\ih_quest.eng.lng2

Data: \Assets\tpp\pack\mission2\quest\ih\ ih_sheep_quest.fpk/d,ih_bird_quest.fpk/d,ih_rat_quest.fpk/d

Fixed: Enable Ocelot in MB causing Sahelenthropus mission to infinite load - thanks CapLagRobin for the report.  

r193 - 2016-11-13
Refactor: Shifted plain table user files loading to InfLog.LoadBoxed.  

Added: Walker gears assigned to foot patrols in free roam (requires both foot patrols and walker gears in free to be enabled) - InfWalkerGears.AddLrrpWalkers,SetUpEnemyGear, pretty flaky with soldiers ditching walkers in the middle of nowhere though, also (if they make it that far), they'll leave it at their destination base instead of continuing with it.  

Added: Walker gear locations to IH interrogations.  

Refactor: ModifyVehiclePatrolSoldiers changed to to ModifyLrrpSoldiers
Refactor: Addlrrps split to cp creation and cp fill (shifted to ModifyLrrpSoldiers)

Options: armorParasiteEnabled="Allow Armor Skulls", mistParasiteEnabled="Allow Mist Skulls",camoParasiteEnabled="Allow Sniper Skulls" - Allow/disallow skull types for Skull attacks - was on TODO, but thanks SoullessMadness for the request.  

Option: skipLogos - "Skip startup logos" - Stops the konami/kjp/fox/nvidia logos from showing.". Makes a return after its removal in r90  - thanks morbidslinky for the suggestion.  
(via IH system menu)

r192 - 2016-11-09
Fixed: Hang on game startup with no ih_save.lua - thanks everyone for the report.  

Refactor: InfMain. .ModifyVehiclePatrolSoldiers .AddLrrps .AddWildCards shifted to InfNPC, external arguments either now passed in directly or documented.  

Fixed: Some functions that modify soldiierDefine providing different setup on checkpoint restart.  

r191 - 2016-11-07
Fixed: Container resource scaling, Tpp.MergeTable isn't a good idea when sub keys are tables/you want to modify the merged - thanks garroth, coolguy3090 for the reports.  
Fixed: Mother base Invasion events not applying correctly.  
Fixed: mbEnablePuppy - MB puppy DDog not enabling - thanks pk5547 for the report.  

Debug: InfLog.PrintInspect only if debugMode - Debug function PrintInspect now only runs with debugmode, should fix some slowdowns on load.  

Refactor: InfFova - more info fleshed out, modelId, fovaCamoId, developIds/checks added for player parts types/camos.  
Module: InfQuest - InfMain.BlockQuest > InfQuest, mbEnablePuppy and unlockSideopNumber combined to InfQuest.GetForced

r190 - 2016-11-06
Fixed: Wild card soldiers faces showing incorrect (most noticably female/male heads/bodies mixups) when in Afghanistan with vehicle patrols on - thanks shynbean, Silverforte for the report.  

Menus: Enemy patrols menu renamed 'Patrols and deployments menu'
Wilcard shifted to Patrols and deployments menu
Repopulate music tape radios" shifted to progression menu
"Randomize minefield mine types", "Enable additional minefields" shifted to Prep system menu
Events stuff shifted to Events menu

Feature: Settings save file - evars/ih_save.lua - Most Ivars now write to evars instead of gvars. Various InfProc functions for reading/writing evars to ih_save.lua.  

Refactor: InfHooks back to table of hooks idea.  
InfHooks: TppSave.DoSave  > InfMain.OnSave

InfLog: log adds lines to table and writes out all via table concat.  

Fixed: Morale boosts options not applying - thanks Alduintheworldnommer for the report

Refactor: InfMain ModifyEnemyAssetTable to InfNPC

Refactor: InfVehicle to external
Refactor: InfEquip shited to external

Data: Westheli def and loc split from f30050_heli.fox2 to ih_westheli_defloc.fox2/fpk
Data: soldier locators split from f30050_npc.fox to to ih_soldier_loc_mb.fox2/fpk, 30010,30030 to ih_soldier_loc_free.fox2/fpk, extra soldier count in 30010/30020 unified from 40/60 to 50. TotalCount in mafr dropped to combat combined pack crash (combinations of soldier/para/walker/heli crash, decreasing totalcounts of the principle game objects fix it. Assuming some memory allocation limit/issue at this point.)
Data: ih_walker_gear_loc.fpk / ih_walker_gear_loc.fox2
Data: walker totalCount dropped to 16 to prevent combo crash
Data: Added sdf file and referencing fox2 to ih_parasite_mist - should hopefully fix the Mist Skulls make not sound issue (even though on my initial test I couldn't reproduce) - thanks angelolujan1 for the report
Refactor: External module calls for TppMissionList.GetMissionPackagePath > AddMissionPacks

Fixed: Attack helis not showing in mother base with Support and Attack helis.  

Option: resourceAmountScale - "Resource amount scale" "Scales the amount of resources when gathered (Small box resources, containers, diamonds, plants)"
Module: InfResource - implements above via ScaleResourceTables()  

Added Setting: Enemy prep mode "Prep levels + Custom overrides" setting added - overrides the Enemy prep levels config with any Custom prep settings that aren't set to their default setting - thanks rargh for the suggestion

Option: enableWalkerGearsFREE - "Walker gears in free roam" - "Adds a Walker gear to each main base."
(via Patrols and deployments menu)
Known issue: In Africa a walker gear model will appear hovering in Kiziba Camp next to the delivery pad. This is a bug in the original game (you can confirm by playing Footprints of Phantoms unmodded.)

r189 - 2016-10-24
Fixed: Skull attack not restarting if continuing from a save.  
Fixed: Crash on first encounter of Quiet in free roam with Skull attacks on - thanks Silverforte for the report and save file.  

Refactor: IvarProc/Ivars - ditched remants of profile ivars onsubsetting changed.  
Refactor: InfMain - reorganized functions something closer to execution flow

Fixed: IvarProc.GetTableSetting for ivar settingsTable as array - affected Player type appearance option - thanks SoullessMadness, FullBody86 for the reports.  

Debug:  
InfLog.StrCode32 - passes through Fox.StrCode32 to a strcode>string lookup table
InfLog.StrCode32ToString - uses above lookup table and TppDbgStr32s system to provide run time StrCode32ToString for registered strings.  
Option: debugMessages - prints on message system calls to log.  
Returned forced announcelog clear on SetGameStatus to toggled on debugMode, but also not InfLog.doneStartup so it can still show during startup.  
Module: InfLookup - consolidated various lookup functions.  
InfLog.AddFlow / ivar debugFlow - to mark/log program flow.  

Feature: Mist parasites/Sniper Skulls added to Skulls attack feature.  
Refactor: InfParasite - culled mixed appearance mode, need to get things clear between the individual types first. This fixes the missing health gauges though.  
Data: ih_parasite_mist.fpk/d adapted from mission packs
Option: parasiteWeather - Weather on Skull attack - None, Parasite fog, Random
(via World menu)

r188 - 2016-10-18
Fixed: Infinite load with Enemy heli patrols set to Enemy prep - thanks  Wanlorn for the report and save file to test with.  
Refactor: Most InfModule module calls wrapped in PCallDebug

r187 - 2016-10-18
Fixed: Infinite load on mission Episode 43 with Custom equip table with DD equip - thanks YoshimitsuYamada for the report and save file to test.  

Refactor: InfMain.externalModules to Ivars.  
Refactor: External modules exquivalent of Tpp requires list - Init,OnReload and message support.  
Refactor: InfParasite message definitions moved from InfMain to InfParasite. InfParasite shifted to external.  
Refactor: Pass setting to OnChange 

Fixed: Don't Drop equip and Warp to user marker when in vehicle - ta NasaNhak 
Setting: npcHeliUpdate - NPC Helis - added "Attack helis" setting (was just "Support helis","Support and Attack helis").  
Refactor: InfNPC heli in light of above (mostly splitting out use of mbEnemyHelis as HP48 indicator)

Refactor: InfMain.externalModules to InfModules module.  
Refactor: updateIvars merged into external module loading, execState broken out from the ivars into their respective modules.  

Refactor: InfMBVisit messages and calls shifted from InfMain into module
Refactor: InfEnemyPhase from module based update to timer.  
Refactor: InfEneFova.RandomFaceId
Feature: Camo parasites/Sniper Skulls added to Skulls attack feature.  
InfParasite reworked.  
Data: ih_parasite_camo.fpk/d adapted from s10130_area

Profile: Updated Subsistence - Game, now should be pretty accurate to the regular subsistence missions settings - thanks TideGear for the prompting.  

Fixed: Install IH batch file - thanks CantStoptheBipBop for the changes.  
Fixed: Some non wildcard soldier faces showing as female.  
Fixed: Made GetGamePath/packages.path parsing more robust, should catch case of empty initial path - thanks CantStoptheBipBop for running the tests.  
Fixed: Added some missing afgh CP positions to InfMain.cpPositions, affected use of GetClosestCpPosition (only parasite positioning)
Fixed: Hard crash in some situations with attack heli patrols (possibly with more animals mod? VERIFY), had to reduce number of TppEnemyHeli gameobjects (enemy_heli_<loc>.fox2) from 8 to 4 though :/

Option: Enable QuickMenu, quickmenu is now disabled by default.  
Menu: IH system menu - shifted various options related to IH itself here.  

Data:  
\Assets\tpp\pack\mission2\ih\ih_parasite_camo_fpk
\Assets\tpp\pack\mission2\ih\ih_parasite_camo_fpkd

r186 - 2016-09-30
Fixed: Profiles with loadOnACCStart not applying - thanks pk5547 for the report
Fixed: AutoDoc - including nonConfig menus, which also broke defaults profile - thanks pk5547 for the report

r185 - 2016-09-30
Feature: Equip 'NONE' for primary and secondary via the normal mission prep equipment select screen. The entries will show as a white square with '---'' as the text - thanks unknown321 for the mod/research.  

Option: Drop current equip - thanks ThreeSocks for the original mod, and the many others who have requested it be included in IH since then.  

QuickMenu: 
Now customizable by editing QuickMenuDefs in MGSV_TPP\mod 
Instant flag for Quick menu commands to allow TSM instant activation.  
Added Drop current equip on <LIGHT_SWITCH> (X key/Dpad right)

AutoDoc: Features header changed from txt file to table. More features documented.  

Option: loadExternalModules - reloads the lua files in MGSV_TPP\mod
(via debug menu)
LoadExternalModules combo [STANCE],<ACTION>,<HOLD>,<SUBJECT>

Refactor: InfProfiles.lua external/run time reload on profiles option select.  
Refactor: Ivars,InfMenuDefs,InfQuickMenuDefs,InfMenuCommands,InfLang load externally via InfMain.LoadExternalModules
Refactor: InfQuickMenuDefs some functions to direct references, rest split to InfQuickMenuDefs.  
Refactor: InfMain - Dependancy on Ivars (mostly tables of ivars I shifted out of functions for optimization), updateIvars shifted to Ivars and built on load.  
Refactor: Ivars split into IvarProc for functions that operate on ivars, leaving Ivars as just the definitions (and some setup)
Refactor: InfMain split to InfMBVisit, InfWarp
Menu: Shifted 'Disable landing zones' option from Player restrictions menu to Support heli menu, seems a better fit.  
Split Debug/System menu to Progression menu

Profiles: Added 'Subsistence - Game' to be closer to actual Game subsistence, leaving Pure as a kind of Subsistence+

r184 - 2016-09-26
Fixed: Quick menu should not activate if holding a quick menu command button then holding the quick menu on button(CALL), will only be activated on quick menu on button(CALL) held then pressing a quick menu command button - thanks LucrassKelvac for your report.  
I'm aware some people will still have issue with how quick menu is activated, depending on how they play. Quick menu will be much more configurable in comming version.  

r183 - 2016-09-24
Fixed: Infinite load screen on traveling between free<>mission for some missions - thanks RealQi for the save file.  
Improved: Added delay on quick menu command activation. Should mean less accidental triggering of quick menu commands - thanks RealQi for the prod.  

r182 - 2016-09-22
Fixed: Being unable to ready weapon when all Custom equip options are turned on and prep config has all weapons set - thanks Gambchon for the report and save file.  
Option: mbqfEnableSoldiers - Force enable Quaranine platform soldiers - in the normal game the Qurantine platform soldiers are disabled once you capture Skulls. This option re-enables them.  
(via Mother Base menu)
Added: IH visit morale support for Quarantine plat.  
Added: Suit support for Quarantine plat.  
Added: Custom soldier equip for Quarantine plat - if you have been using the 'MB staff use custom equip' you will have to set it again this version as the update has reset it.  
Added: Skulls attack support for Quarantine plat - no seperate option, uses 'Enable Skull attacks in Free roam'. Alternatively can be triggered by attacking captured Skulls in the cells.  
Exposed: mbEnableLethalActions - Allow lethal actions - Enables lethal weapons and actions on Mother Base. You will still get a game over if you kill staff.  
(via Mother Base menu)

r181 
InfMessageLog: Realised I was being stupid and why my prior uses of io failed. message log outputs to file now. God, how many months of me thinking the module was blocked lol - thanks TideGear for putting me in the mindset to test try it again.  
Append mode still seems to be no-go, gives 'Domain error', same message most other errors (open 'r' with no file found).  
Refactor: InfMessageLog/AddMessage renamed to InfLog/Add. Less typing for something thats going to get a lot of use.  
Loading shifted to start of init.lua so it can cover from very start of lua execution.  
Refactor: InfInspect reverted to just the kikito inspect (well that and wrapped into module), rest of (actually used) non-inspect module functions shifted to InfLog.  
Refactor: InfMenu.DebugPrint shifted to InfMessageLog
Refactor: TryFunc shifted to InfLog.PCall.  
Ivars: OnChange,OnActivate,OnSelect wrapped in PCall. The vast majority are initiated by the user through the menu so performance is less of a concern (and now that I have actual logging worth keeping in-place)

r180 - 2016-09-17
Refactor: Completeted weapontable support for tables of weaponids per weapon.  
Refactor: _CreateDDWeaponIdTable reverted to vanilla, InfEquip.CreateDDWeaponIdTable take's it's place for dd equip.  
Change: DD Equip is now Custom soldier equip
Ivars: customWeaponTable*,weaponTable.  
- Allow soldiers to have equipment from other locations/types, including DD equipment usually only used on FOB. Soldiers are assigned a random weapon of the type the prep system assigns them, so you'll see more weapon variation - thanks NasaNhak and others for the suggestion.  

r179 - 2016-09-14
Refactor: Decoupled most ivars dependancy on another (such as profile)
Refactor: Removed some Ivars ivar profiles.  
Fixed: Crash on exit from title having visited MB during the game session.  
Option: dontOverrideFreeLoadout - Keep equipment Free<>Mission - Prevents equipment and weapons being reset when going between free-roam and missions. - thanks NasaNhak (yeah it only took me 5 months to actually look at it lol), and more recently XWolfJackX for the suggestion.  
(via Player restrictions menu)
Fixed: Infinite load on free roam if Attack heli class set to Random - thanks darkshadows97 for the report and save file.  

r178 - 2016-09-06
Option: playerFaceIdFilter - Filter faces - "Show all","Unique","Head fova mods" - filters the list of faces in the appearance menu
Fixed: A number of player restriction options not applying - thanks Gambchon for the report.  
Feature: Custom profiles - InfProfiles - selectProfile
Autodoc: Extended to write defaults profile.  

r177 - 2016-09-02
Fixed: Trigger game event option does not require random trigger chance settings to be enabled.  
Fixed: Incorrect ammo count after disabling OSP weapon options. May still happen after exiting real subsistence missions into free-play, but can be fixed by changing the affected weapons to different types.  
Fixed: Enemy phase modifications breaking IH menu in wargames - thanks i-ghost for the report and save file to test.  
Option: printOnBlockChange - debug option that prints on block updates.  
Reverted: Menu option only print on menu up/down. Too much of an anoyance for little gain.  
Reverted: Config save on IH menu close, left over from r175
WIP: Head fova mod support.  

r176 - 2016-08-29
Fixed: FOB defender spawning but getting stuck with a black screen, the issue boiled down to svars definition mismatch between client/client - thanks Maniac_34 and i-ghost for helping me with testing.  
Refactor: Related to above - inf_interCpQuestStatus reworked due to it's shift from svars.  
Fixed: Buddy equip change developed check.  
Option: soldierNightSightDistScale - seperate sight scale applied to night
Research: Runtime faceDefinition mod, Soldier2FaceAndBodyData, `Ivar. *Fova`, InfFova.ApplyFaceFova. Unfortunately SetFaceFovaDefinitionTable crashes the engine if run multiple times.  
WIP: resourceAmountScale - Resource amount scale - Since Anyones Tpp improvements mods and other resource mods conflict might as well add it so they don't have to jump through hoops.  
Refactor: DisplaySetting shifted to a message que, it doesn't help much lol
Addition: Menu up and down now support bigger increments by holding [FIRE]
Change: Menu will only print out the option name, and not the setting while navigating up and down, the auto display shows the full text. This should cut down a little of the text printed/needing to catch up when cycling through the menu.  
Reverted: Removed fulton restriction on Invasion. The weirdness is still there, but the odd extraction count seems to be with normal extractions.  
Options:  playerType,playerPartsType,playerCamoType,playerFaceEquipId,playerFaceId. Options been there forever, just had it disabled since Threesocks mod was good enough. Now made (mostly) usernice, so user can use Hideo and Big Boss sneaking suit options as well as the FOB camos they have unlocked. Face selection still needs work, rather than having users cycle through hundreds of faces.  
Player type - Snake, Avatar, DD Male, DD Female
Suit type - the different suits, will use the Fova lua name if the model swap has included it.  
Camo type - Cammo, if the suit supports it
Headgear - The usual mission selectable headgear. Bandanas(Snake/Avatar), Balaclavas etc.  
Face - (DD soldiers only), cycle backward to the end to get the more unique faces, including Hideo. 
The previous player headgear (cosmetic) option has been removed, the headgear is in the faces list about a quater from the end.  
(via Appearance menu in Player settings menu or in In Mission menu)

r175
REVERTED
Refactor: Majority of settings shifted from mission save slot to config
Seperate save file TPP_CONFIG_DATA_MOD with increased size.  
Basically want (have for long time) breathing space with the amount of stuff I can save.  
Now does a config slot save on IH menu close.  
NOTE: This means users will have to re-set both the game config and the IH settings.  

r174 - 2016-08-09
Refactor: DD body info, making male/female split a bit clearer.  
Fixed: Skull event clear does disable weather changes - thanks mgs5tppfan for the report
Fixed: (Maybe) Crash on exiting mother base invasion events - thanks various people for reports, could you please verify this is fixed.  
Command: buddyChangeEquipVar - InfBuddy - In mission Buddy Equipment change - Buddy equiment is changed to selected setting when <Action> is pressed.  
(via Buddy menu in mission menu)
Change: Quiet move to last marker faces quiet in the same angle as the player when the command is called.  
Change: Women in Enemy Invasion mode changed to percentage (actually percentage chance per soldier choice rathen than strict percentage)
Addition: Femme Fatales added to mother base events.  

r173 - 2016-08-04 - public release 
Fixed: The selection of DD bodies being limited to one or two when that body type has a table of types.  
Fixed: Wildcard body selection for table of types.  
Added: MSF to MB DD Suits
Fixed: More soldiers on MB plats soldier count on checkpoint reload, manifested as no soldiers on last plats and double on first.  
Fixed: Hang on motherbase checkpoint reload from InfNPC, exacerbated by above.  

r172 - 2016-08-03 - public release
Extra unassigend soldiers in Africa added to lrrps.  
Freecam defaults to player position on first activate
Fixed: Aparently I accidentally pasted over skeletonnames for TargetTruckCamera sometime back in r124, oops. Would only affect a specic situation in s10090
Updated to 1.10
Added swimsuit to mb DD male,female.  
Added swimsuit to female wildcard soldiers suit list.  

r171 - 2016-07-28 - public release
Change: Patrol helis now assigned to the closest CP
Fixed: Removed some debug messages from convoy setup, oops, had a file regression.  

r170 - 2016-07-28 - public release
Fixed: Foot patrols and quest soldiers now zombified during skulls attack.  
Fixed: Zombieifed soldiers during skulls attack now have zombie skin - thanks  AGANEK for the report.  
Change: Vehicle patrols - Easter Coms - Sakhra Ee loop is now a convoy.  

r169 - 2016-07-19 - public release
Fixed: Actual subsistence missions retaining OSP setting after exit - thanks AGANEK for the report
Fixed: Turning off NPC heils also turning off free roam heli patrols - thanks Tamriel1989 for the report.  
Change: Skulls time max increased
Fixed: Warp to user marker failing with error message when selecting objects that don't support GetPosition 
Fixed: Increased vertical offset on user marker warp to mitigate falling through world.  
- thanks NasaNhak for the suggestions.  
Fixed: playerHealthScale - Player life scale max dropped to 650% to prevent overflow - thanks NasaNhak
Menu: Player life scale added to in-mission menu.  
Menu: Soldier item drop chance added to in-mission menu.  

r168 - 2016-07-14 - public release
Fixed: Free roam skulls now immediately go in to combat on next apearance after one has been fultoned. This is to work around the issue of them getting stuck in an idle state.  
Fixed: Free roam skull event will no longer try to re-trigger after all the skulls have been fultoned.  
Fixed: Skull event triggering when option turned off - thanks Shaun 557 for the report.  
Fixed: Skulls not apearing in Africa

r167 - 2016-07-12 - public release
Fixed: Quest elimination counter showing incorrectly.  
Fixed: Infinite load on recover man on fire sideop quarantine cutscene with start-on-foot on - thanks CantStoptheBipBop for the report and save file.  
Fixed: Min/Max options would not push up/down their counterpart.  
Affected: DD Equip Grade, and many custom prep config options.  

Feature:  enableParasiteEvent - Enable Skull attacks in Free roam - Skull attacks at a random time (in minutes) between Skull attack min and skull attack max
parasitePeriod_MIN - Skull attack min (minutes)
parasitePeriod_MAX - Skull attack max (minutes)
(via World menu)

r166 - 2016-07-04 - public release
Module: InfQuickMenuDefs - quickmenu, actual implmentation in InfMenu

Feature: Time scale mode - using HighSpeedCamera that's used in CQC/Death and I assume Reflex - thanks Shigu for reminding me
Command: highSpeedCameraToggle - Toggle TSM - Lets you manually toggle Time scale mode that's usually used for Reflex/CQC
Option: speedCamContinueTime="TSM length (seconds) - The time in seconds of the TSM
Option: speedCamWorldTimeScale="TSM world time scale -  scale of the world, including soldiers/vehicles during TSM
Option: speedCamPlayerTimeScale="TSM player time scale - Time scale of the player during TSM

r165 - 2016-07-02 - public release
Fixed: Infinite load on Motherbase with Walker gears and a low number of platforms - thanks rzaldi for the report and save file.  

r164 - 2016-06-30 - public release
mbAdditionalSoldiers - added routes from sneak to night and visa versa. Addional soldiers now total 9 (from 4) per plat instead of min(+4,#routes).  

Fixed: Infinite load on certain mother base cutscenes - thanks BarelyFatal for the report and save files. 

r163 - 2016-06-28 - public release
Fixed: Hang on load in Africa with Vehicle patrols turned off - thanks CantStoptheBipBop for the report and save file.  
Fixed: Hang on load with Custom prep for free or mission and DD suit set to 'Equip grade' - thanks Arballisk  for the report and save file.  

Autodoc: to html.  

IH menu item type indicators change:  
Option = Setting
Menu >
Command >>
Command that closes menu >]

Command: requestHeliLzToLastMarker - Support heli to latest marker
Requests Support heli to Landing Zone closest to the last placed user marker. Can also be used to ride the support heli to another LZ if the IH menu is open and the option is selected when getting into the heli. This however has an issue where the doors will close on take-off preventing you from shifting between heli sides, the chaingun on your side can still be used however.  
Shout-out to NasaNhak who also discovered this independently.  
Command: forceExitHeli - Force exit helicopter - Lets you exit the helicopter while riding it, mind the fall.  

r162 - 2016-06-18 - public release
Fixed: Patrol vehicle classes not actually applying - thanks NasaNhak for the report
Change: Vehicle classes apply to non patrol vehicles (Afgh only)
Menu: World menu added, IH event chance, Clock timescale options moved to it.  
Option: repopulateRadioTapes - Repopulate music tape radios - thanks Apantos for the suggestion
(via World menu)
Refactor: InfVehicle, various changes
Fixed: Random CP subtype now resets table if not enabled for mode.  
Refactor: SetupInterCpQuests,AddLrrps - various replacements of random pools with shufflebags.  
Fixed: Returned molotok to wildcard soldiers, had accidentally replaced it with the high grade DD fob rifle.  
Option: sideOpsSelectionMode - Sideop selection mode - Default (first found), Random, <side ops category>
Option: randomizeMineTypes - Randomize minefield mine types - Randomizes the types of mines within a minfield from the default anti-personel mine to gas, anti-tank, electromagnetic
Option: additionalMineFields - Enable additional minefields - In the game many bases have several mine fields but by default only one is enabled at a time, this option lets you enable all of them. Still relies on enemy prep level to be high enough for minefields to be enabled.  
Option: disableHerbSearch - Disable Intel team herb spotting (requires game restart) - Since the variable is only read once on game startup this setting requires a game restart before it will activate/deactivate. (PlayerRestrictions menu)
Fixed: BlockQuest function shifted to replay only
Sidop 82 - make contact with emerich blocked from selection since it's simply a lead-in to a mission.  
Option: putEquipOnTrucks  - Equipment on trucks - 
(via Patrol vehicle menu)

Data:  
f30010_item.fox2 - copied/added to project
TppPickableLocatorParameter - some picables added for puton trucks

r161 - 2016-06-11 - public release
Fixed: Hard-lock on mother base on a cluster with only one platform with "Soldiers move between platforms" on - thanks 
BarelyFatal for the report and the save file to test with.  
Fixed: Ocelot being stuck on upper areas of early game in-construction command platform with "Enable Ocelot" on.  
Fixed: "Random CP subtype in missions" menu item would just show option==nil warning - thanks megamen123 for the report.  
Option: itemDropChance - InfEquip - Soldier item drop chance - Soldiers drop items upon elimination.  
(via soldier parameters menu)

r160 - 2016-06-06 - public release
Fixed: More fine grained application of RADIO body to lrrp and lrrp vehicles to stop radio light from appearing on: soviets with soft armor, enclosed vehicles.  
Fixed: Removed debug commands from root of in-mission menu, oops

r159 - 2016-06-06 - public release
Fixed: Wildcards repeatedly adding to uniquesettings
Change: Increased number of wild card soldiers to 12
Wild card soldiers may now be placed in patrol vehicles (trucks,jeeps)
Fixed: stuff using groundstartpositions to GetGroundStartPostion that I hadn't adjusted to its data layout change, oops. Included npc helis getting stuck/rotating at 'landing' position.  
Change: DD staff now equiped with non lethal for Training event.  
Refactor: reserve soldier count/tables per mission.  
Tuning: MB events: Soviet Invasion DD Equip off, Coyote attack enemy heli types to each random, dd equip level lowered. Events ises varied settings of mbNpcRouteChange
MB wagames/events - patched caution routes with sneak, soldiers will now follow routes when in caution mode (before they would just stay in their last position before alert)
Fixed: MB Cutscene playback - now doesn't set mbFreeDemoPlayedFlag, so shouldn't cause issues if played before they are normally triggered - thanks BarelyFatal for the report.  
Option: split event random trigger chance % setting into MB and Free, thanks Recaldy for the suggestion.  
Refactor: InfNPC migrated to InfNPCOcelot, additional routes added for ocelot (command plat1 night and salutation routes)
Option:  mbAdditionalSoldiers="Enable more soldiers on MB plats",
Option:  mbNpcRouteChange, InfNPC - Soldiers move between platforms, soldiers will periodically move between platforms (only within the same cluster).  
(via Mother base menu)
Autodoc: prepend Features into, output directly to file.  

Data:  
f30050_npc.fox2
Soldier2GameObject_DDmlWait
realizedcount increased from 12 to 24
totalcount from 126 to 250
soldier locators added (100)

r158 - 2016-06-01 - public release
Fixed: disableLzs rename holdout (still noCentralLzs) on bounder profile
Fixed: Disable landing zones hanging on loading mother base
Fixed: Maybe hopefully possibly. FOB defense black screen - thanks Shigu for helping test

r157 - 2016-05-29 - public release
Module: InfGameEvent
Save var (non user): mis_event {OFF,WARGAMES} - used to drive the wargames event set up which sets various ivars as no-save, only really useful for mb currently as there's no in-game saves and can just prevent restore/bail to ACC
Fixed: changed start on foot mission start timers workaround, previous workaround resulted in pause menu issues such as options item not appearing and double abort items (both abort mission and abort to acc) - thanks CantStoptheBipBop for the report
Fixed: Cutscene DDogGoWithMe infinite load screen after scene finish when triggered via MB cutscene play mode - thanks PIESOFTHENORTH for the report.  
Fixed: Walker gear types were off by one.  
Removed the purposeless menu back command in the root of in-mission menu - thanks Digitaltomato for the report
Refactor: noCentralLzs changed to disableLzs {"OFF","ASSAULT","REGULAR"}, mbdvc_map_mission_parameter restores to something saner
Menu: Patchup menu renamed Debug/system menu

r156
Option: debugMode - "Debug IH mode" - Switches on some error messages and enables the announce log during loading.  
Refactor: Various options to mission mode check style, users will have to set those settings again:  
Random CP subtype, Start on foot, prep mode, .. use DD equipment
Refactor: InfMenuDefs min max ivars
Various optimisations
External: Thrashed out a menu auto documentation tool, still have to transfer much existing documentation text to it.  

r155 - 2016-05-11 - public release
Wildcard soldiers now equipped with highest grade in dd weapons table.  
DD equip grade raised to 15 to match UI/futureproof.  
Fixed: hang on return to mother base and Random CP subtype in missions  - thanks Simonz93 for the save file

r154 - 2016-05-11 - public release
Fixed: Reverted reserve soldier locators in afgh fox2. Fixes Invisible soldier bodies for amored soldiers in afghanistan sideops - thanks Simonz93 for the report
Don't know why mafr is seemingly fine with more soldiers

r153 - 2016-05-11 - public release
Updated to 1.09 - why on earth did KJP regress the exe version to 1.0.7.1?
mbSoldierEquipGrade - DD Equip Grade increased to 11, so you should you can equip DD or enemies with the new weapons (assuming Allow undeveloped DD equipment is on).  

r152
Refactor: Stop a few code paths from running in fob mode to try and fix a potential hang on connect.  
Refactor: Male wildcards to use RegisterUniqueSetting, body table in InfEneFova/abomination removed from TppEnemy body table
Male wildcards now use face id table
Added the rarer faces to female face id table

r151
Refactor: Changed most features that used mbfreemission mission checks to just 30050, fixes below
Fixed: Hang after load on Quarantine and Zoo platforms.  
Refactor: InfLZ.groundStartPositions sub-tables for mb layouts, existing table to sub-table 1. 
Fixed: Mission 22 - Retake the Platform start of foot position under the water - result of above - thanks NasaNhak for the report
Feature: Walker gears on mother base
Module: InfWalkerGear
Option: enableMbWalkerGears - "Enable walker gears"
Option: mbWalkerGearsColor - "Walker gears type" -
	"Soviet",
	"Rogue Coyote",
	"CFA",
	"ZRS",
	"Diamond Dogs",
	"Hueys Prototype (texture issues)",
	"All gears random of one type",
	"Each gear random type",
Option: mbWalkerGearsWeapon - "Walker gears weapons" -    
	"Even split of weapons",
	"Minigun",
	"Missiles",
	"All gears random of one type",
	"Each gear random type",  
	
(via Mother base Menu)
GOTCHA: They're actually always enabled since the game object instances don't seem to start unrealised like other gameobjects.  
Shifted Ocelots start position.  
"Attack heli type" renamed "Attack heli class"
Added "All one random type","Each heli random type" to heli class.  
Options: vehiclePatrolClass - "Vehicle patrol class" - "Default","Dark grey","Red","All one random type","Each vehicle random type","Enemy prep" 

Data:  
f30050_npc.fox2 - added WalkerGearGameObject, usually it's in it's own .fox2 (walkergear_main_enemy ex) in the mission fpkd
f30010_npc.fox2 - added walker gear gobject and locators

r150 - 2016-05-04 - public release
Ivars - minPhase,maxPhase,keepPhase now turns on phaseUpdate
Refactor: Ivar execChecks renamed execCheckTable to prevent name confusion
Fixed: InfMain.ExecUpdate, UpdateExecChecks iterating execCheckTable,execChecks via ipairs instead of pairs - would cause the menu in ACC to break (not enable) on initial load when enemy phase modifications were on - thanks everyone for the reports, and CantStoptheBipBop for the save file
printPhaseChanges changed if phaseUpdate on to stop spam
WIP - disableSpySearch - redacted (heh) since GetGlobalLocationParameter is too restrictive for my liking

r149 - 2016-05-01 - public release
quietMoveToLastMarker - User marker menu > "Quiet move to last marker" - sets a position similar to the Quiet attack positions, but can be nearly anywhere. Quiet will still abort from that position if it's too close to enemies.  
"Heli patrols in free roam" settings changed to numerical values.  
mbEnablePuppy - Show characters menu > "Enable puppy DDog" - "Off","Missing eye","Normal eyes". Took me a while to figure this out since it was tucked away in a quest, also took a while to track down why it seemed to disable itself which resolved to ClearWithSaveMtbsDDQuest.  
Refactor: shifted interrogation resetnormal kludge out of TppInterrogation and unincluded it from the build.  
Fixed: No callouts for some DD suit settings.  
disableNoStealthCombatRevengeMission  - Prep system menu > "Allow Enemy Prep shift after free roam" - allows enemy prep points shift after free roam
MbVisitDay: Clock message - drives another mb visit reward and the new `_ReduceRevengePointByTime`
revengeDecayOnLongMbVisit / `_ReduceRevengePointByTime` - Prep system menu > "Enemy prep decrease on long MB visit" - currently reduces after 3 days (stacking), reduces the same as checken hat use reduction, ie stealth/combat by < 1/4 a level at low revenge levels, and 1/2 at high.  

r148 - 2016-04-27 - public release
DDog SetMotherBaseCenterAndRadius increased to cover whole mb (if mbEnableBuddies)
Wildcard soldiers:  
Number of wild card soldiers increased
Removed 0 fulton sucess
Feature IH Interrogation: Add some interrogations, can't seem to add new to subps, some other data definition missing I guess.  
Travel plans of LRRPs
Locations of wild card soldiers.  
Inter CP quest: Sets up pairs of soldiers in different cps, interrogating one will give CP of other, interrogating him will give a reward of unprocessed resources (around a couple of containers worth) or a skull soldier/parasite on the next extraction (reaching checkpoint etc)
Menu: Show characters menu - enable ocelot shifted from mb menu, others shifted from Show assets menu.  
Mother base menu> Show characters menu > Reset Paz - Resets Paz state to beginning
Update: Mother base morale boost points now stack, both for visiting several clusters and having many soldiers salute. 

r147 - 2016-04-14 - public release
Feature: Ivar mbMoraleBoosts, various functions in infmain. Mother base menu > "Staff-wide morale boost for visit" Staff wide morale boost on having a number of soldiers salute, or visiting a number of clusters (with at least one salute on each).  
Fixed: f30050_sequence, mbWarGamesProfile. Mother base wargames zombie modes will no longer auto fulton wandering soldier style zombies when they retreat to the inter cluster struts.  

r146 
Fixed: enemyHeliPatrol options actually affect the number of helis, woops.  
Patrol Heli routes:  
Fixed: patrol helis no longer chooses route from other location/invalid route.  
Fixed: routes where patrol heli couldn't reach the landing node now change route when near.  
Longer time between route switch
Will not switch when near arrival
Will switch soon after arrival
Added Wialo Kallai route (afgh)
Added Route near Luftwa Valley (mafr)
Heli patrol known bug: support heli cannot target helis when there's multiple helis in the world.  

r145 - 2016-04-07 - public release
Refactor: the mighty ReservePlayerLoadingPosition split assunder, in an attempt to make more readable
Added:   "Start free roam on foot","Start missions on foot","Start Mother base on foot" with: "Off","All but assault LZs","All Lzs" - thanks NasaNhak for the idea
Fixed: PrintMarkerGameObject when nil cpName, added npcHeli names
Freecam: Can now move cam horizontally while in vertical mode.  
Freecam: Added move speed scale adjust mode via DASH
Freecam: move scale min decreased, max increased.  
Feature: "Heli patrols in free roam" - "None","Min","Mid",Max","Enemy prep". Extension of mb heli patrol, using assault lzs, 
Workaround: bunch of trouble figuring out heli weirdness on checkpoint restore till I realised the heli save state has been brutally pared down to only saving one.  
Workaround: disabled wormhole in Invasion, already did so with fulton (or rather set sucess to 0) but didnt remember wormhole doesnt use sucess %, also fixed my workaround applying 0 success if invasion on even if not in motherbase, woops.  
Modfpk: heli locators added to free roam fox2s
Modfpk: heli interiors sbh0_intr0_ene.fmdl to reinforce heli fpks, reference in fpkd/fox2



r144
Change: Hand levels min to 0, this will allow disabling of Sonar - thanks vollmerej1 for the suggestion.  
Added "Default" to mother base "Attack heli type" - thanks NasaNhak for the idea
Added "Support and Attack helis" to "Enable npc helis", has an issue on checkpoint restart however.  
Change: Disable buddies to Disable select buddies in mission prep
Internal: Removed npc heli prepset workaround, issue was update was running before nessesary variables were set up.-
Fixed: Manually opening support heli door on mission start being conflated with disablePullOutHeli
Fixed: Enemy phase options should now work in Wargames.  
Refactor: More modules broken out from InfMain
Refactor: Unified IsCheck,ExecCheck to MissionCheck, added a few functions to ease comparing multiple similar ivars that only diferentiate by mission 
Update-Ivars Init support execchecks like UpdateFunc
Refactor: InfNPC split to InfNPCHeli

r144x
Research: FOB Coop - dead-end, "S_DISABLE_TARGET","S_DISABLE_NPC_NOTICE" blocked engine side for player instance 1 - thanks Shigu for suggestion and help testing.  

r143 - 2016-03-28 - public release
In-Mission - User marker menu
"Warp to latest marker"
"Print latest marker"
"Print all markers"
setSelectedCpToMarkerObjectCp
Refactor: InfMain broken into several different modules

r142
Fixed: Resetting random seed in addtolrrps, would have knock-on effect to wildcard soldiers.  
Fixed: Wildcard powers, was reusing a table instead of copying it, resulted in all being assigned sniper. Thanks Crippsey for the report.  
Fixed: Head markers and world markers options interfering with each other - thanks washtubs for the report
Fixed: Player life scale maximum dropped to 750% as it overflows at higher percentage when medical 3 arm is equiped.  
Fixed: Don't force reinforce request on if not heli, since it breaks vehicle reinforcements, added as default for free roam since there's an in engine check that stops all vehicle reinforce calls.  
Fixed: Start-on foot for transfer between zoo and quarantine - thanks NasaNhak
Fixed: Start on foot Abort now Return to ACC.  
Change: Subsistence missions would default to Pure if osp profile was set to default or custom, now it only set to pure if dfault or all weapons set to Use selected - thanks blejky
Fixed: Abort to heli code block being able to be triggered when not in title mode.  

r141 - 2016-03-24
Research: armored vehicles on mother base, load fine, just can't get assigned soldiers to stay in them. Think I need to clear their routes but setting routes at runtime isn't working for some reason.  
InfFova module, pulled together notes and info from player body vars.  
modelInfo lua loading.  
Options: enableFovaMod, fovaSelection - built through InfFova.  
model swaps and fovas: Masked scarf Snake, Soviets>plparts_dd_male,Pfs>plparts_dd_male

r140 - 2016-03-16 - public release
Updated to MGSV version 1.08 

r139 - 2016-03-14 - public release
Fixed: DD Suit PF All showing corrupted models.  
Option: Warp body to FreeCam position
Fixed: Black screen post-load hang on motherbase with DD suit and start-on foot on clusters not fully built out.  
Fixed: No staff on motherbase clusters with DD suit on clusters not fully built out. Thanks Crippsey for the report and save file.  
Fixed: Repopulated diamonds not giving gmp. Thanks plinkey for the report.  

r138 - 2016-03-05 - public release
Fixed: Crash on some vehicle sideops with vehicle patrol on (op 98, possibly 97), missed an attachmentinstancecount in the west_wav_machinegun fox2, oops.  

r137
f30050_heli.fox2 added enemyheli locators, rest of definition handled by reinforce fpk
reinforce_heli_mafr fpkd enemy_heli_mafr.fox2 - increased instances to 8
Ivar: mbEnemyHeli
npcHeliUpdate switches to enemyHeliList on mbEnemyHeli
Disable unique characters during wargames (ocelot,eli etc)
Option: mbWargameFemales - "Females in Invasion mode"
Fixed: mbEnableFultonAddStaff, wasn't in right spot and was getting overridden by what it was supposed to override lol, enabled for Invasion wargame
Added RegisterMissionBaseStaffTypes 30050 to start2nd so I don't modify MbmCommonSetting.lua and tread on other mods toes. Invasion missions should get normal range of soldier ranks.  
Option: mbEnemyHeliColor - "Heli type in Invasion mode"
Workaround: Fulton disable on Invasion. There's some weirdness with add tempstaff count off, still happens with manual heli extract but at least the soldiers seem to be capped right.  

r136
Mother base colletables (diamonds,plants) repopulate, requires helicopter exits from mother base as pause menu abort skips the repop count decrement (you need to do that anyway if you want to save any actions you made while on motherbase). Takes several visits before repop, the same as the normal game, but at least may give you some incentive to roam motherbase and zoo for them again.  
f30050_heli.fox2 added westheli, westheli usually has it's own fox2 but the custom fpkd issue still remains.  
Feature: npcHeliUpdate - enables 3 TppOtherHelis in mother base, update function manages routes around Mb

r135 - 2016-03-05 - public release
Wildard soldiers: Number of soldiers incread to #Cps/5, number of females increased to 2.  
mbDontDemoDisableOcelot removed.  
Option: mbEnableOcelot - runs an update function to enable/warp and set a route for ocelot on motherbase
Decreased alphaDistance on free cam to 0.1, should be able to get closer to character without them fading out.  

r134
veh_rl_*.fpkd/*fox2 - bodyInstances,attachmentInstanceCount increased to 4. 1 - player vehicle + 2 (quests max) + 1 patrol. 
These packs are actually for the player vehicle but I'm loading them to get the patrol vehicles to work, the veh_mc* packs in common don't actually have ready-to-go data definitions. Editing data is falling into 'not default by default' behaviour which I don't really like, but there's not many options. In the past I tried rolling my own packs but there's issues with fpkds with fox2s (can see this by unpacking an fpkd changing the gztool file pack xml order and repacking) that lead to crashes or extreme memory leaks (like several gb of memory in a minute).  

Blockquests: removed armor vehicle quest block on vehicle patrol
Regression: Patrol vehicle spawn type random to level seed
Refactor: TppEnemyFova> break out WildCardFova
Added full range of female faces to wildcard females

r133 - 2016-03-01 - public release
Fixed: Head markers off did not work on heli entry - thanks washtubs for the report.  
Option: disableWorldMarkers - thanks brunovisk114 for the suggestion
In mission menu: playerRestrictionsInMissionMenu
MB suit male: SOVIET_ALL, PF_ALL

r132
Patrols setup refactor - shifted to OnInitializeTop, all now modify the missionTable scripts directly since they are unloaded/reloaded anyway.  
AddToLrrp split into ModifyPatrolVehicleSoldiers, AddLrrp
Option: enableWildCardFreeRoam
Wildcard - added weapon and body tables, AddWildCard, decided to just replace existing soldier due to: Adding soldiers being unreliable, will allow me to add feature to all missions without having to add extra soldiers to fox2s (assuming I can do it in a way that doesn't interfere with mission critical soldiers).  
Free mission .sdfs: add other soldier soundbanks


r131 - 2016-02-22 - public release
Fixed: Hang of FOB all load, thanks SoullessMadness for the report. FOB defense hang on load unconfirmed since it's hard to test.  
Vehicle Patrols: Improved soldier assignment, Soldier assigned from reserve pool to fill rnd min(2,vehicleSeats),vehicleSeats (seats defined in base vehicle info), soldier already assigned above seat count get put into pool.  
Gives more variation, allows jeeps to have up to 4 people, fixes sillyness with tanks stopping, dropping off a dude, then attacking.  
NOTE: all other vehicles than crash on setrelativevehicle if soldiers assigned > 2. APCs carrying are handled differently.  
Also hits the same non realize bug as below, soldiers do sometimes finally realize. Vehicle will initially drive off as if it's full, but if soldier realizes will wait till soldier reaches it an gets in.  
Don't know if it's something due to my method of warping to soldiers for testing.  
Changed from saving/restoring vehicle type enum from svar to random by same seed, vehicle basicType is stored in mvar.  
Options: lrrpSizeFreeRoam min, max, disabled for now to get decent coverage

r130
Option: mbPrioritizeFemale, by default the game tries to put a minimum of 2 female DD on that cluster (from that cluster), MAX bumps it to MAX_STAFF_NUM_ON_CLUSTER, so basicall all the females you have, does not include Command cluster, None clears the staff selection of females
Option: mbDDSuitFemale, extendedparts does work independently so was relatively painless
More options for DD Suit, Soviet berets, hoodies, PF misc, using the unique quest/mission bodies from missions/quests.  

r129
Fixed: Missing Tpp.IsUav, kjp decided to add this at some point even though there's an identical IsUAV. May fix the incorrect or unregistered fob fulton task types.  
Option: enableLrrpFreeRoam - bunch of soldier locators added to free roam fox2s which are assigned a cp(lrrp) and a travelplan between two randomly chosen bases.  
Some odd things: Setting to coppied travelplans often causes soldier to not realize (even with force enable and realize), adding too many copied travelplans to the mission luas breaks the normal vehicle lrrps (soliers still spawn but thy wont get in vehicle)

r128 - 2016-02-11 - public release
Expanded mbDDSuit to Xof, Soviet a/b, PF a/b/c
ddBodyInfo extended to include soldiersubtype, hasHeadgear renamed helmetOnly, noDDHeadgear, hasHelmet, hasFace to allow various combinations of dd headgear and model gear.  
f30050_npc: add reinforce_block scriptblock
add more corpse game objects, mother base only had 2, interesting note: also corpse system seems keeps one in reserve or something
vox_f30050.sdf - soundbank load refs for enemy_af/mafr/zombie added
mbts_enemy, override soldiertype depending on GetCurrentDDBodyInfo
GetSoldierType, GetSubsoldier - override depending on currentddbody
mbEnableLethal - enable lethal actions on motherbase
mbEnableFultonAddStaff
mbNonStaff - also no demon points increase on mbnonstaff kills
No game over on soldier die in mother base when mbwargames and enablelethal
disableCamText
mbWarGames->mbWarGamesProfile, toggling some of above, the individual settings are currently non-user facing.  

r127
Percentage floats changed to int, will fall into uint8/16, saves save file space
Fixed: SetPercentagePowersRange using orphaned/prior name of SetMinMax, since it was called by revengeConfigProfile.WIDE it's likely that it wouldnt set its subsettings.  
Fixed: Custom enemy prep clear armor if it can't be used.  
Custom config bypass some (config wide) combination restrictions, namely shield and missile, shotgun and mg in same config.  
Made allowmissileweapon combo actually work, and not just allow assault, decided to not allow with mg though

r126
Camera refactor:  
Cam edit mode and current cam split.  
Player cams for each stance/move mode
Ivars for cam variables. This is where I seem to have hit the save file limit, no, just unrelated varables acting odd as if forgotten or overflowed.  
Research/deminification of TppSave and other save functions, bumping the save size for the mission category is likely to be a reciepie for disaster since it combines categories in one file and it's smack in the middle of some. Looks like I could add my own save file if I could add a category, but categories ar pow2 and max is at 255 suggesting there's no room even if it would just accept the field from lua/not require it in exe, or it would be if mgo category didn't fit into this scheme, but then that's only defined in mgo exe.  

r125
Refactor InfMenuDefs, on table build adds reset settings and go back items
Fixed: Mb cutscene time using hour setting for minute.  
Split Enemy use DD equipment into Free roam and Missions
Fixed: noOnChangeSub also blocking OnChange for profiles - basically any profile that set other profiles was broken.  
Fixed: Wormhole disable was reversed, also renamed to Wormhole Level since it's the same implementation as Fulton Level
Option: soldierHearingDistScale

r124 - 2015-01-30 - public release
mbWargames: Zombie mode - mixes regular puppet and msf.  
Options: disableRetry, gameOverOnDiscovery - to replicate total stealth settings

r123
InfButton: some bitmasks added/renamed to proper from lua, don't seem to be in the playerpad section in the exe though
Refactor InfMenu refresh current setting now combined with Activate (ACTION key)
MenuOn/Off() -> OnActivate OnDeactivate
Activate/deactivate checks > CheckActivate
revengeModeForMb check moved out of IsNoRevengeMission to selectrevengetype itself so it doesnt cause any revenge points change.  
Refactor
Added free cam mode, similar implmentation to warp mode but disabling normal controls via padmask to open up keys for own use.  
Menu open equip disableActionFlag now bit flipping instead of just saving/restoring previous. Still have odd issues when trying to mix with multiple disables (with free cam for example) seemingly flipping unrelated flags.  
Update-ivars now (manually in Onchange) call an OnActivate/Deactivate, key repeat settings shifted there instead of in update.  


r122 - 2016-01-23 - public release
Headmarkers should remain disabled in all situations, hopefully - thanks Psithen for the report
Refactor: blocking quests due to reinforcement and patrol vehicle settings via unlockSideOpNumber and TppQuest.UpdateActiveQuest unified to InfMain.BlockQuest. unlockSideOpNumber now silently skips.  
"ACTIVE_DECOY","GUN_CAMERA" added to custom config
Mb wargames non-lethal extended to custom config.  

r121
Option: revengeModeForMb - "Mother base prep mode" - "Off","FOB style","Enemy prep levels","Custom prep"
Options: mbDemoOverrideTime, mbDemoOverrideWeather - thanks qwertyuiop1234567899 for the suggestion
Various renames to solidify terms:  
Subsistence Mode renamed Subsistence profile to match other uses of the term in the menu, and since that's what the varable has been named for months lol.  
Free mode to Free roam, mode should be a term reserved for specific behaviour, possibly with multiple settings.  
Profile is a curated set of option settings.  

r120
Option: enableSoldiersWithVehicleReinforce
IsDDBodyEquip to make body/headgear independant from mbSoldierEquipGrade
Refactor: MinMaxIvar for creating such paired ivars.  
Refactor: mbSoldierEquipGrade split to min, max, changed to grade value 1-10
Option: allowUndevelopedDDEquip
Options: enableMbDDEquip, enableEnemyDDEquip, replace mbSoldierEquipGrade 0/OFF, drives IsDDEquip
Option: enableEnemyDDEquip - overrides weaponIdTable with DD

r119 - 2016-01-17 - public release
Ivars - subName, PushMin, PushMax to handle adjusting paired ivars.  
Reworking of custom prep menu order and item names.  

r118
Change remove demon to subtract demon points, less ideal since there's no feedback of current value so cant tell the lower bounds, but it works for people the prior method didn't - thanks drkcrstl for the feedback
Custom prep profile with wide,max,min, max replaces prior revenge level based max.  
SetCustomRevengeUiParameters as rough indication of custom prep config.  

r117
InfMenu: support for function call OnActivate when pressing action on selected option.  
Reasearch into Player.ChangeEquip
Test of quiet humming command, result: only for boss quiet game object, sad.  
Welcome message added for entering acc from title.  
Ivars: support for IsCheck on named setting :Is
Option: disableNoRevengeMissions
Custom revenge config: WIP most individual revenge config settings settable
Refactor: A number of gvar instead of ivar references missed in the prior refactor
Disallow menu if in carboard box

r116 - 2015-12-30 - public release
Un-fixed a Retail bug, the game is apparently relying on it's broken behavior lol. Manifested as: Some end of cutscene loadscreen hangs, prologue/truth post heli hallway non-trigger. Possibly much more.  

r115 - 2015-12-27 - public release
Fixed: AddPowerSetting, was trashing it by using same name in two variables, the perils of deminification. Possibly affected fob soldier settings.  
Powersettings to DD headgear
Load screen splashes reverted to base game. Kjp did too much voodoo in respect to the Nvidia splash screen for me to be happy with touching it.  

r114
Refactor: complete ivar get, removed fobs reset settings - instead returns off/default on ivar access.  
Refactor: mbDDsuit - pull various body setup data to single table ddBodyInfo and reference that

r113
Regression Fixed: in mission menu when on buddy (horse,walker) - thanks Crotaro for report
Refactor: ivar get via ivar functions instead of gvar value (started, not yet complete)
Option: revengeProfile, default, heaven - to manage the profusion of revenge ivars
Option: enableMgVsShotgunVariation
Option: randomizeSmallCpPowers

r112
Options: disableMissionsWeaponRestriction, disableMotherbaseWeaponRestriction -> revenge CANNOT_USE_ALL_WEAPON_MISSION
Ivar:Is/OptionIsSetting support direct value insead of only enum
Option: balanceWeaponPowers - WIP
Option: allowMissileWeaponsCombo
Option: disableConvertArmorToSheild
Refactor: InfMain.GetSumBalance, InfMain.BalancePowers, CreateCpConfig split from `TppRevenge._ApplyRevengeToCp`
Command: debug - forceAllQuestOpenFlagFalse
Refactor: various options now communicated to ApplyPowerSetting via soldierConfig

r111 - 2015-12-19 - public release
Fixes to ResetSettings, as a result also fixes FOB loading.  

r110 - 2015-12-18 - public release
Update to TPP 1.0.7.0

r109
Options: changeCpSubTypeFree, changeCpSubTypeForMissions
Refactor: InfMenu. Next/PrevSetting/ChangeSetting. Support `<ivar>.GetNext()`, `<ivar>.GetSettingText()`

r108
Vehicle patrols changed to using releif vehicle(player vehicle) fpks
Option: allowHeadGearCombo - calculates cp config a second time with headgear combinations allowed.  
Option: balanceHeadGear - adjust

r107
Option: vehiclePatrolPackType, switches between quest packs and custom fpks - thanks blejky for the report

r106 - 2015-12-14 - public release
ig_*.fpk/ fpkd. Initially started as copies of the respective quests I was using to get proper vehicle references for patrol vehicles, since using the quest fpks directly intereferes with quests - still not exactly sure what aspect, guessing the quest script block load given it went away when I deleted it, but tests showed the script itself wasn't loaded, so guessing the script block entity in the fox2 got engaged, don't know.  
Stripping down the packs further revealed some troublesome issues with fox2 files relying on specifc file orders, or possibly something more.  
Fixed: (due to above) vehicle patrols interfering with sideops - thanks blejky for the report

r105
Fixed: Reset all settings was completely broken, varable but didnt cat all instances woops.  
Options: applyPowersToOuterBase, applyPowersToLlrp.  

r104
Options: allowHeavyArmorInFreeMode, allowHeavyArmorInAllMissions - currently armor has the same bug as mb armor where hits act like the armor isnt there, still same shots as non armor and no spang sounds of bullets hitting armor.  
Options:  
fultonSuccessMenu="Fulton success menu"
fultonSuccessProfile="Fulton success profile",
fultonSuccessSettings={"Default","Heaven","Custom"},
fultonNoMbSupport="Disable MB fulton support",
fultonNoMbMedical="Disable MB fulton medical",
fultonDyingPenalty="Target dying penalty",
fultonSleepPenalty="Target sleeping penalty",
fultonHoldupPenalty="Target holdup penalty",
fultonDontApplyMbMedicalToSleep="Dont apply MB medical to sleeping/fainted target",
WIP fulton variation over time
fultonSoldierVariationRange
fultonOtherVariationRange
fultonVariationInvRate
Ivars: self.Reset->ResetSetting

r103 - 2015-12-10 - public release
Fixed: Vehicle patrol all of one type loading hang - thanks mgs5tppfan for the report

r102 - 2015-12-09 - public release
Commands: setDemon, removeDemon - thanks PIESOFTHENORTH for the suggestion
Refactor: Removed Item suffix from non menu item names.  
Fixed: patrol vehicle enable types not rebuilding enabled list.  
Research options:  
vehiclePatrolClass
vehiclePatrolPaintType
vehiclePatrolEmblemType
SetPatrolSpawnInfo, revert to default/unmodified painttype, currently only jeeps and trucks using.  
Fixed: forceSuperReinforce out of bounds
Disabled random emblem splashes to see if it's cause of various reported issues.  

r101 - 2015-12-09 - public release
Fixed: xraymarkers
Fixed: A case of the Display menu not showing for some saves, possibly had other ramifications.  

r100 - 2015-12-08 - public release
vehicle patrol vehicle type saving - svar array vehiclePatrolSpawnedTypes, ModifyVehicleSpawn split into PreSpawnVehicle, RestoreVehiclePatrol, ModifyVehicleSpawn
A few iterations till I got this right, was a gvar with a custom clear function, mission svar seems the better way to go though.  

r99
vehicleBaseTypes/ModifyVehicleSpawn refactored to select from ivars/location.  
Options:  
vehiclePatrolDistribution - off, singular, each
vehiclePatrolLvEnable
vehiclePatrolTruckEnable
vehiclePatrolWavEnable
vehiclePatrolWavHeavyEnable
vehiclePatrolTankEnable

r98
InfMain vehicleSpawnInfoTable initial thrash out, ModifyVehicleSpawn() to intercept TppEnemy.SpawnVehicle
Research: None of the fpks you'd expect - COMMON_whatever vehicle, or even reinforce fpks - actually seem to have full references/setup whatever of the mentioned vehicles, quest fpks do however. Built list of fpks for vehicle types.  
Fixes to force reinforce I inadvertantly introduced when cleaning up.  

r97
Fixed: [STANCE] in support heli not setting pull out in mother base
Feature: [STANCE] in support heli now a (non saving) toggle for pull-out, requires you to jump out after setting hold though.  
Option: Start on foot reworked to spawn at selected lz on mother base platforms - thanks to NasaNhak for pointer
Feature: Abort to Heli from title continue. Hold down ESCAPE for 1.5 seconds, the kjp logo will flash, clickin on continue will load ACC instead of continuing mission.  
Research: Vehicle swap. Vehicle spawning seems pretty loose, the issue is the assets/fpk loading.  

r96
OnTimer_FinishReinforce firing on reinforce heli LostControl and reinforce vehicle VehicleBroken, resets heavy reinforce so it can retrigger
heliReinforceChance changed to switch enableHeliReinforce, will revisit if I get vehicle reinforcement more consistant
Disable super reinforce in free till can figure it out.  
Option: forceReinforceRequest
Known Bug: Reinforce heli will spawn with combat alert, you'll hear the ! and it doing a round of attack even though it's far away.  
Option: disableReinforceHeliPullOut, currently have no way to tell if heli has left so cant reset reinforce if it has, this at least removes one case

r95
Fixed: turn off menu when in ground vehicle
Option: soldierAlertOnHeavyVehicleDamage - changes phase of soldiers CP on damage, independant from Ivars.phaseUpate
printPhaseChanges - now via message, so independant from Ivars.phaseUpate, includes cpid and prevPhase, spams a bit more though.  
Option: useSoldierForDemos now covers allowing selected character in Diamond Dogs and Shining Lights missions - thanks NasaNhak and Solidcal for the suggestions.  
InfMenuDefs: useSoldierForDemos also added to playerSettingsMenu
Fixed: Mission timer on Backup Back Down (10054,11054) would not start, startOnFoot now SetIsStartFromFreePlay - thanks NasaNhak the report.  
Fixed: changing subsistence profile would flip it to Custom via unsupressed onsubsettingchanged.  
Tonne of deminification

r94
Option: WIP: forceVehicleReinforce, heliReinforceChance - heli reinforcment initially working, vehicles aparently have a lot of setup in the engine I'm missing out on, but work for some actual missions not in the usual reinforce mission list.  
InfMain: support for game message system - Messages(), OnMessage(), Init and Reload build messageExecTable
Refactor: various settings/functions called in Tpp* message functions now via infmain messages.  
playerHealthScale (and enemyhealtscale) reduced to 900%, hit some odd overflow/wrap limit I think.  

r93
Player and enemy health scale option upper bounds increased to 1000%
Fixed: Use selected soldier in cutscenes should catch all of them now - thanks VickoStojanov for the report.  
Message added to headgear to make clearer it only works for DD soliders - thanks gOKU1983 for the report.  
Fixed: not being able to select weapon when toggling warp mode.  
Fixed: returning to ACC while in vehicle or on buddy preventing mod menu from opening.  
Research: vehicle reinforcement, various things blocking the way, a mission list check, surprisingly few missions used it, quest helis actually use part of the system, and the actual vehicle reinforce setup isn't called in free mode.  

r92 - 2015-11-25 - public release
Thought I was done with heli? Ho ho.  
UpdateHeli > manually open door on mission start by pressing [STANCE], a fun combo is to set 'Mission start open door wait time' to a max and just ride in first person, then pop out whenever you want.  
Start missions on foot shifted to support heli menu.  
NOTE: Aparently DisablePullOut overrides the motherbase taxi service, use the [STANCE] to disable then hit the usual <EVADE> to open the taxi menu
Option: setSearchLightForcedHeli - ok really Disable search light, but the ivar name is closer to command name
Order recieved announclog for a couple of heli settings.  

r91
disableHeliAttack - switch via OnChange, so now can update in-mission,
activation block in TppMain.Oninitialize now InfMain.UpdateHeliVars
Option: setInvincibleHeli
Option: DisablePullOut
Command: PullOut
Feature: Force heli pull-out by pressing STANCE while in heli.  
Various other heli commands explored that turned out not useful.  
InfMain.SplashStateCallback_r, tying in with RandomEmblemSplash to have splashes cover the load period (like the original splashes did that I rashly killed lol), splashes do not block loading, there is a hit however long the splash texture load is though.  
title_sequence - kills off the current random splash, title_sequence usually wait for the normal splashes (that I removed), but in practice they were usually done by then (so I can't really claim any loading speed improvement) and I think the nvidia splash was added to cover the rest.  

r90
Splash screens added to start/end of start.lua, end one is a good indicator that the main luas have loaded/compiled ok and from that point on its onto init mission/init_squence
InfMain.DeleteSplash
InfMain.RandomEmblemSplash
Refactor: InfMain.Update > ExecUpdate - phaseUpdate and warpPlayerUpdate using unified update system.  
Ivar: enablePhaseMod renamed phaseUpdate - users will have to redo their setting

r89
Refactor:InfSoldierParams, soldierParamsProfile, soldierHealthScale - various renaming, shifting block out of TppMain
Option: soldierSightDistScale
Options: `*DistScaleSightParam` - incomplete, still don't know the approach to take here, there's a heck of a lot of settings in SoldierParameterTables, how granular do I want to let the user mod this? scale vs exact value? managing profiles (something closer to TPPHC)?
Command: printSightFormParameterItem
Command: printhealthTableParameterItem
Fixed: Refresh current setting (tapping mod menu button) not checking if it was an actual setting (menu) (would do no harm only wanring message, I knew I put it there for a reason)
Project: MockTest - why didn't I think of this sooner.  
Ivar.enemyPrameters renamed soldierParamsProfile, now a profile to soldierHealthMult(also renamed) and  soldierSightDistScale

r88
Fixed: Menu off when iDroid open improved
Ivars: Is/OptionIsSetting catch case of no enum
IsDefault added
OnSubSettingChanged - doesnt flip profile if subsetting is default or profile is default or custom
Option: defaultHeliDoorOpenTime
InfMain.Update - common execution check flags expanded, passed to the various mod feature update functions
Option:quietRadioMode

r87
Command: warpPlayerMode
Refactor: InfMenu.EndFadeIn, FinishOpeningDemoOnHeli - pull in stuff from TppMission msgs
Option: disableXrayMark - buddies that mark still cause the effect though.  
InfMenuDef allTables setup check IfTable
Equip menu disabled on menu open -- playerWarpMode messes with it though
ButtonRepeat enabled on navigate up/down menu.  
Should improve the experience a bit for gamepad bros.  
InfMenu - disable state extended from menus to all options

r86 - 2015-11-19 - public release
Fixed: A few cutscenes I broken in r56, oops
Fixed: mbDontDemoDisableOcelot dont disable occelot on cutscene hanging cutscene end
TppMbFreeDemo.PlayMtbsEventDemo, dont nil DemoOnEnd, instead case by case it in demoOptions
- thanks TheChosenOne896 for the reports
Option: mbDontDemoDisableBuddy
Option: mbDontDemoDisableOcelot expanded to more cases
Fixed: remebered to update in-game version string lol

r85 - 2015-11-19 - public release
Fixed: osp weapon settings only set if profile not default - temporary fix for empty magazines on mission start (will still happen with individual osp settings though)
Fixed: some unexposed appearence settings running on set-to-default, manifested as player changing to snake, olive drab on FOB.  
Fixed: fulton being set to level 1 on mission start
- thanks GaKoDuck for the reports

r84
Refactor: InfMain.Update - Phase mod broken to own function, InfButton.UpdateHeld(),InfButton.UpdatePressed() shifted from InfMenu.Update, InfMenu.Update now called from InfMain.Update instead of TppMain.  
Refactor: DebugPrint split and print strings larger than Announcelog limit
Command: warpPlayerCommand - just initial testing with hard coded positions.  
Command: Unlock weapon customisation - game progression unlock
Command: Exting unlock player avatar changed from Ivar to command - not that there's much difference, the deliniation is ivar is it's own setting, and almost always saved, command does a thing, and doesn't care about it's own state, in this case we're just setting another game var.  
Fixed: Phase mod disabled for mother base. MB is not set up for caution routes aparently, also even with friendly set they will go hostil on alert

r83
clockTimeScale upper bound increased
Option: telopMode - Disable mission intro credits
Side project: scraper for langId dictionary

r82
mbLayout - research, not much result, mostly used for fob missions I think, doesn't seem to be any actual geometry changes.  
manualMissionCode,loadMissionItem - not much use, the 'no number missions' are supposed to be hard versions of some missions, but I see no evidence that they actually have custom changes.  

r81
Extend mbEnableBuddies to Zoo
Zoo plants should repop.  

r80 - 2015-11-17 - public release
Settings: enablePhaseMod, phaseUpdateRate, phaseUpdateRange, minPhase, maxPhase.  
InfMain: Update(), added to TppMain updateList.  
InfMain.Update: phaseMod functionality.  
TppHero: no heroic point loss on alert if phasemod on.  
Menu: Non gvar Options no longer set to default on selection
Menu: disable option with disableReason langid
Option: ogrePointChange, with no feedback on current value I'm not happy about implementation
Refactor: InfMenuDefs, split to InfMenuCommands

r79
DebugCommands: testing various phase functions

r78
Menu: In mission mod menu no longer open if in walker gear or vehicle - thanks for report SkySta
Fixed:  Secondary and Back weapon osp settings swapped - thanks for the report ThereisnoLion

r77
Various player appearance vars.  
InfMenu: option:OnSelect call in GetSetting()

r76 - 2015-11-14 - public release
Option: abortMenuItemControl, added to Subsistence Pure profile - thanks for thesuggestion MayonnaisePlant
Fixed: startOffline not checking if save value nil first, only would hit on r75 for new users to the mod. - thanks animefreakIIX for the report.  

r75 - 2015-11-14 - public release
Fixed: subsistence mission without subsistence profile set hang on loading screen
Fixed: setting change increment mult not rounded to integer
Option: startOffline
Fixed: CanArriveQuietInMb - Quiet not showing in motherbase cell/demos.  
Option: mbEnableBuddies
Menu: commands to in mission debug submenu
Build with snakebite 0.8

r74 - 2015-11-12 - public release
Update to 1.0.6.0

r73
Options: Show mother base assets, mbShowBigBossPosters,mbShowMbEliminationMonument,mbShowSahelan,mbShowEli,mbShowCodeTalker - thanks qwertyuiop1234567899 for the suggestion
Option: Don't lock goal doors. Useless unless you like swishing doors.  
Option: Don't disable Ocelot after cutscenes - with this you can leave Occelot on mb in person after some cutscenes.  

r72
Fixed: enemies secondary not being set
ModStart to Init, no longer run each Update
Shifted lua file references into the Tpp.lua requires system, in line with how tpp does it. start.lua now unmoddified.  

r71a
Fixed: dev setting startoffline was on

r71 - 2015-11-09 - public release
Command: ResetRevenge/Enemy preparedness - thanks for the prodding TruckerHatRyan
Option: revengeBlockForMissionCount
Revenge options `_SetUiParameters`
Menu: revenge system options
InfMenu: allMenus now set up with all in InfMenuDefs instead of needing updating by hand
langStrings added for all new options.  
Ivar: default to range.min if not set

r70
Weapon OSP submenu to Player restrictions
More options broken out from subsistence profile:  
Hand equipment levels. Own profile and menu. - thanks for suggestion snsonic
Fulton and Wormhole equipment levels, including 0/Disable. Own profile and menu.  
disableBuddies, disableHeliAttack
disableSelectVehicle, disableSelectTime
Disable mission support menus - disableMenuDrop, disableMenuBuddy, disableMenuAttack, disableMenuHeliAttack, disableSupportMenu

r69
Menu: Player Restrictions added, includes Subsistence and OSP settings.  
Subsistence mode converted to new profile system, previous settings that were lumped into single subsistence option now broken out
disableBuddies - not currently user facing
Option: disableHeadmarkers
Option: disableFulton
Menu: Only display menu name on GoBack, not all GoMenu

r68
Ivars: Setting/getting via .Set, Is, Above, BelowOrIs...  
Ivars: settingsTable for custom function per setting, either run on setting change, or value return via ivar.data()
Ivars: SubSetting>parent profile OnSubSettingChanged, just notifies user and sets profile to CUSTOM. Too much effort to do subsettings combination validation for now.  
Option: ospWeaponLoadout now ospWeaponProfile with the original Pure, Secondary
Subsettings: to ospWeaponLoadout - primary/secondary/tertiaryWeaponOsp

r67
Command: showequipgrade
InfHooks added, test out another to keep my impact on other files minimized, though at this point with no other substantial mods and it being unlikely that there will be many more patches I don't know why.  

r66
TppQuestList: questAreaTable.  
Fixed unlockSideopsNum not clearing other quests in area

r65 2015-11-05 - public release
Same dealt with equip range, ugh.  

r64 2015-11-05 - public release
Fixed bug where I set FOB equip grade to 1, like a stupid - Thanks for the report xmetalx59x

r63 2015-11-05 - public release
Fixed bug I introduced in r56 to CloserToPlayerThanDistSqr resulting in quests being cleared to soldier being auto fultoned as player moved out of area. - Thanks for the report bumbousdude25

r62
Refactor InfMenuDefs to Ivars, now builds svars from settings in Ivars via InfMain.DeclareVars.  
InfMain: most enums now part of their ivar
InfMenu: Set to previous option on Menu Back
Helispace menu toggle changed to EVADE same as inMissionMenu

r61
Refactor InfMenu, split out into InfMenuDefs
InfMenu: Added index number before non lang settingsname tables

r60
Refactor InfButton, masks and states
Add some missing button masks

r59 - 2015-10-31 - public release
In game menu toggle change to hold Evade

r58
Show player position
Start on foot for motherbase, starts on command platform
Even more info added to InfLang for translators
Option: Override Japanese lang code with Chinese for menu translation

r57 - 2015-10-31 - test release
Chinese translation included, unconfirmed language code - thanks to rikimtasu
Patchup>>Show language code
More info added to InfLang
Unconfirmed lang codes added to InfLang

r56 2015-10-30 - public release
Clock timescale
OSP now correctly only affects main weapons.  
OSP tertiary free
Start on foot
InfMenu: In game/helispace menu switching
Fixed issue with subsistence mode not turning off centralLzs if an OSP mode was already on.  

r55
Moved incomplete feature out of TppLandingZone to own file
Setting: Unlock player avatar

r54
Revert from game localization system
Own localization system created, functions in InfMenu, strings in InfLang

r53
Call setting onChange on setting reset
1.0.4.4 TppPlayer fulton call fix. They had added an extra parameter to the fulton function, but forgot to add the parameter to a call. There's only two calls to the function in the scripts... oh well mistakes happen.  

r52 2015-10-26 - public release
Current soldier in demos
Select mb return demo

r51
Disable mb triggered prioritylist demos switch

r50
Added localization files for many mod strings. Other languages are currently just english, hopefully can get the community to translate if I can work out the rest (combining multiple localized strings is troublesome)

r49a 2015-10-23 - public release
Snakebite msgv update to 1.0.4.3

r49 2015-10-23
Fix soldiers not driving their patrolling trucks - thanks for report bindleford

r48 2015-10-20 - public release
Retail 1.0.4.1 merge
r48a Snakebite msgv version mismatch fix

r47 2015-10-19
Mother base DD suit
Submenus
Previous menu on [STANCE]
Reset current setting changed to [CALL]

r46
Mother base Wargames - shoutout to E3245
Mother base equip grade
Refactor InfMenu to InfMain, trying to isolate menu system further from mod specific settings

r45
Fixed hang on loading Fob missions, had missed updating the settings reset call from the InfMenu refactor - thanks for report Topher
Fixed reset settings via menu
Disable mod menu if fob mission
Shifted a table from TppDefine, TppDefine no longer used

r44 2015-10-15 - public release
No Central Landing Zones, filter for mission start lzs, filter for in-mission lzs

r43
Refactor due to makebite allowing custom files via GzsTool - thanks Topher, atvaark
InfButton, InfMenu, etc for its repsective stuff that was previously dumped in TppMain.lua
UpdateModMenu direct via TppMain.SetUpdate/Onupdate instead of in tppmission update.  

r42
Re-added various support menu disables on subsistence, missed in the 1.0.4.0 merge.  
Support heli combat turned off - I found it bre3zer
Head markers disabled for Subsistence Pure (xray effect on marked still active).  

r41
Nvida splash removed - thanks for direction LordRamza
Fox engine splash removed (side effect, tied to the showing of nvid, would like to show it, I lovehate fox engine)

r40 2015-10-10 - public release
Rebuilt for 1.0.4.0
Quiet Return function moved out of TppStory.lua, so for now one less file modded.  

r39 2015-10-08 - public release
Updated to patch 1.0.4.0
Uses MGSVModDo.exe to build 00.dat from games 00.dat.  
Uses MGS_QAR_Tool by Sergeanur
Enemy parameters setting saves on exit to title instead of requiring mission start/abort. Still needs restart for Default to take effect (but not for turning on Tweaked)
Value skipping for settings
Manual selection of sideop 144 disabled, may still come up in random selection

r38
Enemy parameters default to.. default
Wormhole forced off for subsistence mode
Equipment downgrades no longer applied to vanilla subsistence missions when subsistence mode off

r37 2015-10-05 - public release
Open specific sideop
Force open added to unlockSideops
unlockSideops rename to random for areas
Return Quiet re-added, now as menu option, non reversible

r36
Menu settings wrap
Navigation keys listed on menu open
Reset setting key added [STANCE]
ButtonRepeat added to button system (needs refactor already though)
Next/prev setting buttonrepeat

r35
sideOps selection changed to random choice per area (was first found)
unlockSideops changed from force all active - doesn't work with current system, can only have one op per quest area - to force repop
UpdateActiveQuest call on unlocksideops change to refresh.  

r34 2015-10-02 - public release
Fulton disabled on subsistence pure
Fulton forced to lvl 1 on subsistence bounder
Hand upgrades forced off on subsistence - sonar, mobility, precision, medical
Fixed setting showing wrongly on menu open
Relevant mission prep menu options disabled on Subsistence mode

r33
Skip Autosave warning checkup on game start
3/4 of initial splash screens sped up. - Thanks emoose for lua decrypt making this possible

r32
Menu toggle key changed to [RELOAD]
Fixed Secondary Enabled OSP not working - Thanks again Psithen
Reset settings moved to menu option

r31 2015-09-30 - public release
Enemy Parameters bug fix, was causing night parameters to be zeroed - Thanks Psithen for the report
Unlock all Side-Ops.  
r30
Option Menu refactor
Confirm setting option for menu items

r29
Subsistence: 'Buddy enabled' profile changed to 'Bounded (+Buddy +Suit)' - so you can use your model swaps

r28 2015-09-26 - public release
Enemy Prepared max kinks worked out, now confirmed works like the normal game would if all values maxed.  
r27    
Buddy Support for subsistence (Allow Quiets Attack/Scout, downside(?) is enables buddy change in field)
Subsistence Weapon Loadout renamed OSP Weapon Loadout to make it clearer it's independent from Subsistence

r26 - 2015-09-23
General Params setting for allowing default files/mods to override

r25
Subsidence loadouts broken out to separate option
Buddy enabled setting for Subsistence
r24
Buttons system refactor
Menu toggle changed to 1 second button hold
In game settings display removed
Menu off on idroid key press

r21 - 2015-09-23
Buttons system refactor

r20 - 2015-09-23
Option Menu refactor
r19 All Settings off if FOB

r18 - 2015-09-23
Quiet Return disabled pending inf load screen saves
r17 Subsistence free secondary
r16 Force relief vehicle fulton

r15 - 2015-09-22 - 1st public release
Settings Reset
r14 Enemy Life scale
r13 Player Life scale
r12 Option Menu refactor
r11 Subsistence Loadouts, vanilla, tranq
r10 Bugfix blueprints
r9 Subsistence force ASAP time
r8 IsManualHard
r7 Options Save
r6 Bugfix revenge fulton
r5 Enemy night parameter tweak
r4 Basic Option Menu
r3 ButtonDown
r2 Quiet Return
r1 Hardcoded IsSubsistence