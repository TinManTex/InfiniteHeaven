= Infinite heaven =
r59 2015-10-31
by tin man tex
For MGSV version 1.0.4.3 (1.04 in title screen)

A mod for MGSV intended to extend play through customisable settings and features.

Note for r59:
In game menu toggle changed to Hold-<Quick dive> (space key or X button), ACC menu still on <Reload>

New Options for r56:
OSP modes now only affect the main weapons as was originally instended and does not clear support weapons.
New OSP mode added - Tertiary free (though disallowed in subsistence pure), clears primary and secondary on mission, leaves your chosen tertiaray weapon free.
Start on foot - Skip helicopter ride into missions/free mode.
Menu translations - have a translation system for the menu, but no current actual translations, see below for more info.
Unlock player avatar - without having to complete mission 46
Clock timescale - adjust the day/weather clock, simulation clock unaffected.

New Options for r52:
Cutscenes menu:
Always use current soldier for cutscenes
Disable return-to-mother base cutscenes
Play specific mother base cutscene

New Options for r48:
Change Mother base soldiers equipment
Turn Mother base soldiers hostile

Want to help out?

Translation: Check out the file InfLang.txt in the infinite heaven .zip and see what you can do. Contact me by pm if you want more detail/want to send me your translation. You will be credited in the main infinite heaven description for your kind work.

Features video: My system is not currently set up to record game footage, if someone wants to do a review/spotlight of all the different features of infinite heaven that would be awesome.

Infinite Heaven full features:
Subsistence Mode toggle - Lets you go into any mission or free roam with same restrictions as subsistence missions, or with just a secondary of your choice.
Comes in two profiles:
Pure - as the missions with more restrictions: OSP forced, Items off, Hand upgrades off, ASAP time forced, vehicle off, fulton  off, support off, head markers off, heli attack off, central landing zones off.

Bounder - Pure as base but allows: Buddy, changing Suit (which should also allow model swaps), Level 1 Fulton, head markers

OSP Weapon Loadout - Seperate from subsistence mode (but subsistence uses it), allows you to enter a mission with primary and secondary weapons set to none, or just primary set to none.

Enemy Preparedness max - the same 'revenge system' max as the extreme missions. Most soldiers have gear equipped, such as helmets, body armor, nvg, many heavy weapons deployed.

Mother Base soldier tweaks:

Weapon loadout - using fob equip grade and range

Suits - same range as fob missions

War Games - set mother base soliders hostile with non-lethal or lethal weapons

Parameters:
General Enemy parameter tweaks - switch to default if youre combining with a mod like TPP Harcore.
	Increased enemy sight at night time, because it's always full moon/so bright anyway.

Player health scaling 400-0%(1hp)

Enemy health scaling 400-0% (requires Enemy Parameters Tweaked)

Unlock random Sideops for areas - The sideops system breaks the map into areas, with only one sideop allowed to be active at a time. In the retail game it's chosen in a first found manner. Uncompleted story missions and uncompleted sideops get priority of selection over replayable sideops.
This setting changes it to a random selection of potential sideops, with the same priorities. Force replay adds completed sideops to the potential selection. Force Open adds most sideops to the selection pool.
Warning: still largely untested, unknown how replaying the story missions affect things if multiple sideops work in the same area.

Cutscenes:
Use current soldier in cutscenes instead of snake.

Disable Mother Base cutscenes - Disables some arrive at motherbase cutscenes that cause infinite loading screens on some saves. This bug also occurs on unmodified games. If you have a save already stuck in this state (already at the MB loading screen) try my seperate 'MB loading screen fix' mod.

Play selected mother base cutscene - Can choose from many of the mother base cutscenes that play on returning. Requires the setting 'MB cutscene play mode' to be set to 'Play selected'

Patchups:
Unlock playable avatar - unlock avatar before mission 46

Return Quiet - returns quiet. Not reversable, but not run by default.

Retail Bug fixes:
Enemies Revenge system level for Fulton was fulton was 0 low, 1 blank, 2 high, now 0 blank 1 low 2 high.

By design I try to keep the initial install to all regular game settings and only changed via infinite heavens in-game mod menu. 
All settings are reset to off on doing a FOB mission. But I suggest you play offline while the mod is installed. A future version of snakebite will allow easily toggling of mods.

Disclaimers:
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, feedback at Nexus page welcome.

Thanks:
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
This does not apply if you've aready modded it.

If you installed an earlier version of Infinite heaven than r44 manually find and restore your original game 00.dat backup or revalidate the game through steam:

Right click on the game in steam library, choose properties from bottom of menu, local files tab, verify integrity of game cache button.
or click this steam://validate/287700

If it gets stuck at 0% for more than a few minutes steam is being stupid, validate one of the valve games first, hl2, portal etc then try validating mgsv again.

It should say 1 file needs to be redownloaded, so go to steam downloads and make sure that happens.

Instalation:
Use SnakeBite Mod Manager 0.5 or later: nexusmods.com/metalgearsolidvtpp/mods/106/
Uninstall any earlier version of Infinite Heaven
Install Infinite Heaven.msgv

WARNING: Applying this mod to any game version after the one stated at the top of the readme involved will likely prevent the game from working. Simply uninstall using SnakeBite and wait for the mod to be updated.

Uninstallation:
Exit any missions, return to the ACC.
The mod saves some varables to the save file, but on initial testing (I welcome feedback on this) there is no issue with loading a save from this mod after the mod has been removed (provided you have exited to ACC)
Use uninstall in SnakeBite.

Usage:
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

Manual selection of a sideop will not prevent games sideop selection from opeining a sideop in the same area. Even though both will show on map and will give ui que of sideop start, one of the two will not actually activate its script, so you will not encounter the objective items or characters.

Starting a mission with subsistence will still show the loadout screen, and will show the last missions visual setup, 
it should refresh when you change any settings, or if you exit to the title menu, or just enter the mission.

Buddy may have to be repicked after turning off subsidence.

Turning off subsitence pure will still prevent you from selecting buddy, exiting to title and back might fix it, entering a mission will.

Enemy Life percentage doesn't seem to effect stun.

Subsidence mode will still technically do a full deployment cost of what's set. Manual solution, have a loadout with all items set to none and cheapest weapons.

When changing General Enemy Parameters back to Default you must exit to title to have the setting save, then restart the game to have it load the default enemy parameters.

There may be some overrides for Max Prepare that I've missed, I've noticed on small guard posts soldiers rarely have equipment. Also some items seem to override others, so you wont see many if any gas masks.

Changelog:
r59 - 2015-10-31 - public release
In game menu toggle change to Evade

r58
Show player position
Start on foot for motherbase, starts on command platform
Even more info added to InfLang for translators

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
Return Quiet re-added, now as menu option, non reversable

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
r33 2015-10-01
Skip Autosave warning checkup on game start
3/4 of initial splash screens sped up. - Thanks emoose for lua decrypt making this possible
r32 2015-10-01
Menu toggle key changed to <Reload>
Fixed Secondary Enabled OSP not working - Thanks again Psithen
Reset settings moved to menu option
r31 2015-09-30 - public release
Enemy Parameters bug fix, was causing night parameters to be zeroed - Thanks Psithen for the report
Unlock all Side-Ops.
r30 Option Menu refactor
	Confirm setting option for menu items 
r29 2015-09-27
Subsistence: 'Buddy enabled' profile changed to 'Bounded (+Buddy +Suit)' - so you can use your model swaps
r28 2015-09-26 - public release
Enemy Prepared max kinks worked out, now confirmed works like the normal game would if all values maxed.
r27	Buddy Support for subsistence (Allow Quiets Attack/Scout, downside(?) is enables buddy change in field)
	Subsistence Weapon Loadout renamed OSP Weapon Loadout to make it clearer it's independent from Subsistence
r26 - 2015-09-23 - public release 5
General Params setting for allowing default files/mods to override
r25 Subsidence loadouts broken out to seperate option
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
