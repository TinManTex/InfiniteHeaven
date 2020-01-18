= Infinite heaven =
r86 2015-11-19
by tin man tex
For MGSV version 1.0.6.0 (1.06 in title screen)

A mod for MGSV intended to extend play through customisable settings and features.

Note for r86:
Swapped the Mb cutecene mode settings disable and play, if you had these set prior to this version change it to what you wanted.

New in r86
Fix: A few cutscenes I broken in r56, oops
Fix: mbDontDemoDisableOcelot dont disable occelot on cutscene hanging many cutscene ends
- thanks TheChosenOne896 for the reports

Don't disable Ocelot after cutscenes - expanded to cover more cutscenes


New in r85
Fix: osp weapon settings only set if profile not default - temporary fix for empty magazines on mission start (will still happen with individual osp settings though)
Fix: some unexposed appearance settings running on set-to-default, manifested as player changing to snake, olive drab on FOB.
Fix: fulton being set to level 1 on mission start
- thanks GaKoDuck for the reports

Unlock weapon customization - game progression unlock without having to complete legendary gunsmith sideops, good for newgame in combo with the previous unlock player avatar.
Disable mission intro credits
Extended Enable all buddies in motherbase option to allow buddies on the Zoo platform, now you can take D-Dog or D-Horse to visit some animals.
[youtube]N9xfnH8ivAI[/youtube] 
https://www.youtube.com/watch?v=N9xfnH8ivAI


New in r80:
Enemy phases menu:
Change minimum and max phase of CPs in an area around player.
Examples:
minimum and maximum to SNEAK, will return enemies to the lowest alert level.
Minimum to caution will set the enemies to the minimum alerted/run everywhere/gun ready phase.
EVASION and ALERT are a bit more tricky, as they have a lot of enemy behaviors associated with them.
EVASION normally automatically downgrades to CAUTION if there's no last-known-position for the player.
ALERT automatically sets last-known to player position, even if no enemies have no line of sight.
So in my implmentation EVASION will initially set ALERT.

Don't downgrade phase - independent of above, prevents the game auto downgrade of phases after player not being spotted for a while, this however leads to odd behavior at ALERT as the enemy will infinitely suppress the last-known-position. It's usually better to just set the minimum phase.

Demonstration of phase settings: 
[youtube]veL0btXaOb4[/youtube]
https://www.youtube.com/watch?v=veL0btXaOb4


Headgear (cosmetic) - Chose from a variety of balaclavas, helmets with NVG and Gas masks. Cosmetic only (no headgear bonuses)
Demonstration: 
[youtube]1DlkIV3KduI[/youtube]
https://www.youtube.com/watch?v=1DlkIV3KduI


Infinite Heaven features:
------------------------------
Demonstrations:
Mother base settings:
[youtube]PSWTQwJNaRU[/youtube]
https://www.youtube.com/watch?v=PSWTQwJNaRU

Player Restriction - disable of game settings to customize your challenge

Includes Subsistence profiles, sets of customized settings that lets you go into any mission or free roam with same (and more) restrictions as subsistence missions, or with just a secondary of your choice.

Pure - as the missions with more restrictions: OSP forced, Items off, Hand upgrades off, ASAP time forced, vehicle off, fulton  off, support off, head markers off, heli attack off, central landing zones off.

Bounder - Pure as base but allows: Buddy, changing Suit (which should also allow model swaps), Level 1 Fulton, head markers

OSP Weapon settings - Seperate from subsistence mode (but subsistence uses it), allows you to enter a mission with primary and secondary weapons set to none, individually setable.

Arm abilitiy levels - Sonar, Mobility, Precision, Medical - can now be individually set.

Disable Head markers independantly from objective/placed markers (markers for other objects like vehicles/fultonable weapons are also disabled however due to the game function).

Mission Entance/Exit options:

Start on foot - skip heli ride into mission and start on the ground.

Abort Mission (Return to ACC) added to Motherbase pause menu.

Enemy Preparedness:

Reset - to 0

Max - the same 'revenge system' max as the extreme missions. Most soldiers have gear equipped, such as helmets, body armor, nvg, many heavy weapons deployed.

Resupply in #missions - the number of missions the enemy dispatch/resupply with unlock after your last successful dispatch mission for that type.

Mother Base soldier tweaks:

Weapon loadout - using fob equip grade and range

Suits - same range as fob missions

War Games - set mother base soliders hostile with non-lethal or lethal weapons

Enable all buddies in motherbase - does not clear D-Horse and D-Walker if set from deploy screen and returning to mother base, the will however spawn off map, use the call menu to have them respawn near.

Parameters:

General Enemy parameter tweaks - switch to default if you're combining with a mod like TPP Harcore.
    Increased enemy sight at night time, because it's always full moon/so bright anyway.

Player health scaling 400-0%(1hp)

Enemy health scaling 400-0% (requires Enemy Parameters Tweaked)

Side ops:

Unlock random Sideops for areas - The normal games sideops system breaks the map into areas, with only one sideop allowed to be active at a time. In the retail game it's chosen in a first found manner. Uncompleted story missions and uncompleted sideops get priority of selection over replayable sideops.
This setting changes it to a random selection of potential sideops, with the same priorities. Force replay adds completed sideops to the potential selection. Force Open adds most sideops to the selection pool.

Open specific sideop - enables that specifc sideop.

Warning: still largely untested, unknown how replaying the story missions affect things.

Cutscenes:

Use current soldier in cutscenes instead of snake.

Disable Mother Base cutscenes - Disables some arrive at motherbase cutscenes that cause infinite loading screens on some saves. This bug also occurs on unmodified games. If you have a save already stuck in this state (already at the MB loading screen) try my separate 'MB loading screen fix' mod.

Play selected mother base cutscene - Can choose from many of the mother base cutscenes that play on returning. Requires the setting 'MB cutscene play mode' to be set to 'Play selected'

'Show assets Menu' in Mother base Menu:

Show mother base assets - Big Boss posters, Nuke Elimination Monument, Sahelanthropus, Eli (in theory, haven't actually seen him though), Code Talker (the game doesn't animate or have collision for him).

Don't lock goal doors - useless unless you like swishing doors.

Don't disable Ocelot after cutscenes - with this you can leave Occelot on MB in person after some cutscenes.

Don't disable buddies after cutscenes - likewise with buddies (ddog mostly)


Patchups:

Unlock playable avatar - unlock avatar before mission 46

Unlock weapon customization - game progression unlock without having to complete legendary gunsmith missions

Return Quiet - instantly runs same code as the Reunion mission 11 replay.

Start Offline - Start the game in offline mode, this also removes the connect option from the pause menu.

Retail Bug fixes:

Enemies Revenge system level for Fulton was fulton was 0 low, 1 blank, 2 high, now 0 blank 1 low 2 high.

TppMission.GoToEmergencyMission() -> TppDefine.STORY_MISSION_LAYOUT_CODE[missionCode] instead of vars.missionCode


By design I try to keep the initial install to all regular game settings and only changed via infinite heavens in-game mod menu.
All settings are reset to off on doing a FOB mission. But I suggest you play offline while the mod is installed. Snakebite mod manager allows easy toggling of mods.

Disclaimers:
------------------------------
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, feedback at Nexus page welcome.

Thanks:
------------------------------
Kojima Productions for the great game
Sergeanur for qartool
atvaark for his fox tools
ThreeSocks3 for finding the custom text output for Announce log. Check out his Basic Trainer mod.
emoose for cracking lua in fpks
jRavens for testing
Topher for the great mod manager Snakebite
rikimtasu for Chinese translation
All the mod users on nexus for trying the mod and bug reports

Preperation/insurance:
------------------------------
Back up your save files for safety
<steam path>\userdata\<user id>\287700 and
<steam path>\userdata\<user id>\311340

MGSV uses two save folders
- 311340 is Ground Zeros steam id, but used by MGSV for save data even if GZ is not installed.
- 287700 is TPP steam id, most of the files here seem to be just backup, except for TPP_GRAPHICS_CONFIG

Copy both folders to a safe place.

You may want to back up periodically as you play in case you come across save breaking issues with the mod.

Back up TPPs original 01.dat in
<steam path>\steamapps\common\MGS_TPP\master\0\
This does not apply if you've already modded it.

If you installed an earlier version of Infinite heaven than r44 manually find and restore your original game 00.dat backup or revalidate the game through steam:

Right click on the game in steam library, choose properties from bottom of menu, local files tab, verify integrity of game cache button.
or click this steam://validate/287700

If it gets stuck at 0% for more than a few minutes steam is being stupid, validate one of the valve games first, hl2, portal etc then try validating mgsv again.

It should say 1 file needs to be redownloaded, so go to steam downloads and make sure that happens.

Instalation:
------------------------------
Use SnakeBite Mod Manager 0.5 or later: nexusmods.com/metalgearsolidvtpp/mods/106/
Uninstall any earlier version of Infinite Heaven
Install Infinite Heaven.msgv

WARNING: Applying this mod to any game version after the one stated at the top of the readme involved will likely prevent the game from working. Simply uninstall using SnakeBite and wait for the mod to be updated.

Uninstallation:
------------------------------
Exit any missions, return to the ACC.
The mod saves some varables to the save file, but on initial testing (I welcome feedback on this) there is no issue with loading a save from this mod after the mod has been removed (provided you have exited to ACC)
Use uninstall in SnakeBite.

Usage:
------------------------------
While in ACC Heli (full menu), or in-mission (small menu)
Hold the weapon <Reload> button (default R on keyboard, or B on controller) for a second to toggle the mod menu when in the ACC
Or hold <Quick dive> (space key or X button)when in mission.

(modding limitation, currently no know way to detect if in idroid menu where navigation keys conflict)
So toggle mod menu on, change setting, toggle it off before you use idroid.

Use either Arrow keys or Dpad to navigate the menu.
Up/Down to select option.
Left/Right to change setting or open submenu.

Press <Change Stance> button to go to previous menu.

Press <Call> button to reset current setting.

Known issues:
The Announce Log used for the display has a delay on entries, so slow down your button presses when changing the settings.

Replaying sideop 144, Remains of Man on Fire, will leave your character stuck in the Quarantine helipad and unable to abort the mission and requiring you to restore your save. Avoid completing the mission (extracting body).

Starting a mission with subsistence will still show the loadout screen, and will show the last missions visual setup,
it should refresh when you change any settings, or if you exit to the title menu, or just enter the mission.

Buddy may have to be repicked after turning off subsidence.

Turning off subsistence pure will still prevent you from selecting buddy, exiting to title and back might fix it, entering a mission will.

Enemy Life percentage doesn't seem to effect stun.

Subsidence mode will still technically do a full deployment cost of what's set. Manual solution, have a loadout with all items set to none and cheapest weapons.

When changing General Enemy Parameters back to Default you must exit to title to have the setting save, then restart the game to have it load the default enemy parameters.

There may be some overrides for Max Prepare that I've missed, I've noticed on small guard posts soldiers rarely have equipment. Also some items seem to override others, so you wont see many if any gas masks.

Changelog:
------------------------------
r86
Fix: A few cutscenes I broken in r56, oops
Fix: mbDontDemoDisableOcelot dont disable occelot on cutscene hanging cutscene end
TppMbFreeDemo.PlayMtbsEventDemo, dont nil DemoOnEnd, instead case by case it in demoOptions
- thanks TheChosenOne896 for the reports
Option: mbDontDemoDisableBuddy
Option: mbDontDemoDisableOcelot expanded to more cases
Fix: remebered to update in-game version string lol

r85 - 2015-11-19 - public release
Fix: osp weapon settings only set if profile not default - temporary fix for empty magazines on mission start (will still happen with individual osp settings though)
Fix: some unexposed appearence settings running on set-to-default, manifested as player changing to snake, olive drab on FOB.
Fix: fulton being set to level 1 on mission start
- thanks GaKoDuck for the reports

r84
Refactor: InfMain.Update - Phase mod broken to own function, InfButton.UpdateHeld(),InfButton.UpdatePressed() shifted from InfMenu.Update, InfMenu.Update now called from InfMain.Update instead of TppMain.
Refactor: DebugPrint split and print strings larger than Announcelog limit
Command: warpPlayerCommand - just initial testing with hard coded positions.
Command: Unlock weapon customisation - game progression unlock
Command: Exting unlock player avatar changed from Ivar to command - not that there's much difference, the deliniation is ivar is it's own setting, and almost always saved, command does a thing, and doesn't care about it's own state, in this case we're just setting another game var.
Fix: Phase mod disabled for mother base. MB is not set up for caution routes aparently, also even with friendly set they will go hostil on alert

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
Fix:  Secondary and Back weapon osp settings swapped - thanks for the report ThereisnoLion

r77
Various player appearance vars.
InfMenu: option:OnSelect call in GetSetting()

r76 - 2015-11-14 - public release
Option: abortMenuItemControl, added to Subsistence Pure profile - thanks for thesuggestion MayonnaisePlant
Fix: startOffline not checking if save value nil first, only would hit on r75 for new users to the mod. - thanks animefreakIIX for the report.

r75 - 2015-11-14 - public release
Fix: subsistence mission without subsistence profile set hang on loading screen
Fix: setting change increment mult not rounded to integer
Option: startOffline
Fix: CanArriveQuietInMb - Quiet not showing in motherbase cell/demos.
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
Fix: dev setting startoffline was on

r71 - 2015-11-09 - public release
Command: ResetRevenge/Enemy preparedness - thanks for the prodding TruckerHatRyan
Option: revengeBlockForMissionCount
Revenge options _SetUiParameters
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
Previous menu on <Change Stance>
Reset current setting changed to <Call>

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
Reset setting key added <stance>
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
Menu toggle key changed to <Reload>
Fixed Secondary Enabled OSP not working - Thanks again Psithen
Reset settings moved to menu option

r31 2015-09-30 - public release
Enemy Parameters bug fix, was causing night parameters to be zeroed - Thanks Psithen for the report
Unlock all Side-Ops.
r30 Option Menu refactor
    Confirm setting option for menu items
r29
Subsistence: 'Buddy enabled' profile changed to 'Bounded (+Buddy +Suit)' - so you can use your model swaps

r28 2015-09-26 - public release
Enemy Prepared max kinks worked out, now confirmed works like the normal game would if all values maxed.
r27    Buddy Support for subsistence (Allow Quiets Attack/Scout, downside(?) is enables buddy change in field)
    Subsistence Weapon Loadout renamed OSP Weapon Loadout to make it clearer it's independent from Subsistence

r26 - 2015-09-23 - public release 5
General Params setting for allowing default files/mods to override
r25 Subsidence loadouts broken out to separate option
    Buddy enabled setting for Subsistence
r24 Buttons system refactor
    Menu toggle changed to 1 second button hold
    In game settings display removed
    Menu off on idroid key press

r21 - 2015-09-23 - 4th public release
Buttons system refactor

r20 - 2015-09-23 - 3nd public release
Option Menu refactor
r19 All Settings off if FOB

r18 - 2015-09-23 - 2nd public release
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