= Infinite heaven =
r37 2015-10-05
by tin man tex

A mod for MGSV intended to extend play through customisable settings and features.

Features:
Subsistence Mode toggle - Lets you go into any mission or free roam with same restrictions as subsistence missions, or with just a secondary of your choice.
Comes in two profiles: 
Pure - as the missions with more restrictions: OSP forced, Items off, Hand upgrades off, ASAP time forced, vehicle off, fulton  off, support off.

Bounder - Pure as base but allows: Buddy, changing Suit (which should also allow model swaps), Level 1 Fulton.

OSP Weapon Loadout - Seperate from subsistence mode (but subsistence uses it), allows you to enter a mission with primary and secondary weapons set to none, or just primary set to none.

Enemy Preparedness max - the same 'revenge system' max as the extreme missions. All soldiers have body armor and helmets, many heavy weapons deployed.

General Enemy parameter tweaks - switch to default if youre combining with a mod like TPP Harcore.
	Increased enemy sight at night time, because it's always full moon/so bright anyway.

Player health scaling 400-0%(1hp)

Enemy health scaling 400-0%

(Option does nothing when general parameters changed to default)

Unlock random Sideops for areas - The sideops system breaks the map into areas, with only one sideop allowed to be active at a time. In the retail game it's chosen in a first found manner. Uncompleted story missions and uncompleted sideops get priority of selection over replayable sideops.
This setting changes it to a random selection of potential sideops, with the same priorities. Force replay adds completed sideops to the potential selection. Force Open adds most sideops to the selection pool.
Warning: still largely untested, unknown how replaying the story missions affect things if multiple sideops work in the same area.

Return Quiet - returns quiet. Not reversable.

Retail Bug fixes:
Enemies Revenge system level for Fulton was fulton was 0 low, 1 blank, 2 high, now 0 blank 1 low 2 high.

Disclaimers:
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, feedback at Nexus page welcome.

Thanks:
Kojima Productions for the great game.
Sergeanur for qartool
atvaark for his fox tools
ThreeSocks3 for finding the custom text output for Announce log. Check out his Basic Trainer mod.
emoose for cracking lua in fpks

Preperation/insurance:
Back up your save files for safety
<steam path>\userdata\<user id>\287700 and
<steam path>\userdata\<user id>\311340

MGSV uses two save folders
- 311340 is Ground Zeros steam id, but used by MGSV for save data even if GZ is not installed.
- 287700 is TPP steam id, most of the files here seem to be just backup, except for TPP_GRAPHICS_CONFIG

Copy both folders to a safe place

Back up TPPs 01.dat in
<steam path>\steamapps\common\MGS_TPP\master\0\
You may just rename it in place if you wish.

Instalation:
Copy mod 01.dat to
<steam path>\steamapps\common\MGS_TPP\master\0\

NOTE: This file is currently (2015-09-22, TPP version 1.006) unused.
Future TPP updates may overwrite the file and the mod.

Uninstallation:
Exit any missions, return to the ACC.
The mod saves some varables to the save file, but on initial testing (I welcome feedback on this) there is no issue with loading a save from this mod after the mod has been removed (provided you have exited to ACC)
Delete <steam path>\steamapps\common\MGS_TPP\master\0\01.dat
Replace your backed up game 01.dat
Though the game loads fine without it.
Alternatively 'verify integrity of game cache' option in steam should work.

Usage:
While in ACC Heli
Hold the weapon <Reload> button (default R on keyboard, or B on controller) for a second to toggle the mod menu.
(modding limitation, currently no know way to detect if in idroid menu where navigation keys conflict)
So toggle mod menu on, change setting, toggle it off before you use idroid.

Use either arrow keys or Dpad to navigate the menu.
Up/Down to select option.
Left/Right to change option setting.

Press change stance button to reset curren setting.

Known issues:
The Announce Log used for the display has a delay on entries, so slow down your button presses when changing the settings.

Starting a mission with subsistence will still show the loadout screen, and will show the last missions visual setup, 
should refresh when you change any settings, or if you exit to the title menu, or just enter the mission.
Buddy may have to be repicked after turning off subsidence.
Enemy Life percentage doesn't seem to effect stun.
Subsidence mode will still technically do a full deployment cost of what's set. Manual solution, have a loadout with all items set to none and cheapest weapons.
Changing General Enemy Parameters to Default requires starting and aborting a mission, then restarting the game.

History:
r37 2015-10-05
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
