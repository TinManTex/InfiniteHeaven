= Infinite heaven =
r190 - 2016-11-06
by tin man tex
For MGSV version 1.10 (in title screen) 1.0.7.1 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Infinite Heaven features and options
------------------------------
See: Features and Options.html file in the Infinite Heaven .zip
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]http://www.nexusmods.com/metalgearsolidvtpp/articles/5/[/url]

YouTube playlist of demonstrations for many features
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
NOTE: Remember to exit back to ACC before upgrading Infinite Heaven, upgrading a save that's mid mission is likely to cause issues.

NOTE: Infinite Heaven has been restructured, with some of it's files now loading from a sub-folder of MGSV_TPP folder. Use Install Infinite Heaven.bat or see Install.txt for details.

New for r190
NOTE: Infinite Heaven now save its options to ih_save.lua in MGSV_TPP\mod folder. You will have to set the settings up from scratch when updating to this version.
See 'Settings save file:' below for more notes.
Settings are now saved on IH menu close (as well as on normal save).

Fixed: Wild card soldiers faces showing incorrect (most noticably female/male heads/bodies mixups) when in Afghanistan with vehicle patrols on - thanks shynbean, Silverforte for the report.
Fixed: Morale boosts options not applying - thanks Alduintheworldnommer for the report
Fixed: Attack helis not showing in mother base with Support and Attack helis

Menus: Enemy patrols menu renamed 'Patrols and deployments menu'
Wilcard shifted to Patrols and deployments menu
Repopulate music tape radios" shifted to progression menu
"Randomize minefield mine types", "Enable additional minefields" shifted to Prep system menu
Events stuff shifted to Events menu

Option: resourceAmountScale - "Resource amount scale" "Scales the amount of resources when gathered (Small box resources, containers, diamonds, plants)"
Module: InfResource - implements above via ScaleResourceTables()  

Added Setting: Enemy prep mode "Prep levels + Custom overrides" setting added - overrides the Enemy prep levels config with any Custom prep settings that aren't set to their default setting - thanks rargh for the suggestion

Option: enableWalkerGearsFREE - "Walker gears in free roam" - "Adds a Walker gear to each main base."
(via Patrols and deployments menu)
Known issue: In Africa a walker gear model will appear hovering in Kiziba Camp next to the delivery pad. This is a bug in the original game (you can confirm by playing Footprints of Phantoms unmodded.)

New for r189
Fixed: Skull attack not restarting if continuing from a save.
Fixed: Crash on first encounter of Quiet in free roam with Skull attacks on - thanks Silverforte for the report and save file.
Fixed: Player type appearance option - thanks SoullessMadness, FullBody86 for the reports.

Feature: Mist parasites/Sniper Skulls added to Skulls attack feature.
Option: parasiteWeather - Weather on Skull attack - None, Parasite fog, Random
(via World menu)

New for r188
Fixed: Infinite load with Enemy heli patrols set to Enemy prep - thanks  Wanlorn for the report and save file to test with.

New for r187
Fixed: Install IH batch file - thanks CantStoptheBipBop for the changes.
Fixed: Infinite load on mission Episode 43 with Custom equip table with DD equip - thanks YoshimitsuYamada for the report and save file to test.
Fixed: Don't Drop equip and Warp to user marker when in vehicle - ta NasaNhak 
Fixed: Some non wildcard soldier faces showing as female.
Fixed: Case where IH give could not load from MGSV_TPP\mod error even with the files clearly in the folder (may have only been issue with a seperate lua install) - thanks CantStoptheBipBop for running the tests.
Fixed: Hard crash in some situations with attack heli patrols (possibly with More Animals mod?), had to reduce number heli from 7 to 3 though :/

Option: Enable QuickMenu, quickmenu is now disabled by default.
(via IH system menu)
Menu: IH system menu - shifted various options related to IH itself here.

Feature: Camo parasites/Sniper Skulls added to Skulls attack feature.
[youtube]X4P6SpNu_EY[/youtube]
https://youtu.be/X4P6SpNu_EY

New for r185
Feature: Equip 'NONE' for primary and secondary via the normal mission prep equipment select screen. The entries will show as a white square with '---'' as the text - thanks unknown321 for the mod/research.
[youtube]8Db_B4Ao5wE[/youtube]
https://youtu.be/8Db_B4Ao5wE

Option: Drop current equip - thanks ThreeSocks for the original mod, and the many others who have requested it be included in IH since then.
[youtube]e2hcrZrWjYg[/youtube]
https://youtu.be/e2hcrZrWjYg

QuickMenu: 
Now customizable by editing QuickMenuDefs in MGSV_TPP\mod 
TSM returned to instant activation.
Added Drop current equip on <LIGHT_SWITCH> (X key/Dpad right)

Option: loadExternalModules - reloads the lua files in MGSV_TPP\mod
(via debug menu)
Feature: LoadExternalModules combo <Stance>,<Action>,<Ready weapon>,<Binoculars>

Profiles: Added 'Subsistence - Game' to be closer to actual Game subsistence, leaving Pure as a kind of Subsistence+

Disclaimer:
------------------------------
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, detailed feedback at Nexus page welcome.

Installation
------------------------------
See: Installation.txt file in the Infinite Heaven .zip 
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/2/]http://www.nexusmods.com/metalgearsolidvtpp/articles/2/[/url]

Usage:
------------------------------

Infinite Heaven menu:

While in ACC Heli (full menu), or in-mission (small menu)
Hold <Quick dive> (space key or X button on controller) for 2 seconds to toggle the mod menu when in the ACC or in-mission.

The menu system will display the current
[Option name] - [Setting value or description]
Sub-menus are indicated by >
Command >>
Command that closes menu when done >]
[Option Name] <Action> - Selected is applied by pressing <Action> 

Use either Arrow keys or Dpad to navigate the menu.
Up/Down to select option.
Left/Right to change setting or open sub menu.

The size/step of the setting change can be made bigger/smaller by holding <Ready weapon> or <Fire>. 

Press <Binoculars> button to reset current setting.

Press <Reload> button to set the current setting to it's minimum.
Press <Change Stance> button to go to previous menu.

By design I try to keep the initial install to all regular game settings and only changed via infinite heavens in-game mod menu.
All settings are reset to off on doing a FOB mission. But I suggest you play offline while the mod is installed. Snakebite mod manager allows easy toggling of mods.

Quick Menu:
A way to quickly trigger certain Infinite Heaven commands.
(Must be enabled via option in IH system menu, or by editing InfQuickMenuDefs.lua)

<Ready weapon>(Right mouse or Left Trigger) to warp to last placed usermarker
<Fire>(Left mouse or Right Trigger) to open the menu to heli-to last usermarker (a kludge, but nessesary to activate the inter landingzone ride on heli)
<Action>(E key or Y button) to activate TSM
<Reload>(R key or B button) to activate Free cam
<Dash>(Shift or Left stick click) to activate Static camera
<Change Stance>(C key or A button) to have Quiet move to last usermarker

Profiles:
Profiles are lists of settings for IH options, can be used as an alternative, or in conjunction with IHs in-game menu.
See InfProfiles Readme and InfProfiles.lua for further info.

Settings save file:
IH writes ih_save.lua in the MGSV_TPP\mod folder.
Save file for IH options, other IH state variables are still saved to the normal game save.
Saved on IH menu close, and also when the game saves normally.
Only saves settings changed from their default
Read on game load
While the file is editable, editing an inMission save is likely to cause issues.
Theres is also no current read/write retry on locked file so editing while game is running is not advised.

Known Issues
------------------------------
See FAQ Known issues.txt file
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/6/]http://www.nexusmods.com/metalgearsolidvtpp/articles/6/[/url]

Change Log
------------------------------
See: Change Log.txt file in the Infinite Heaven .zip
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/1/]http://www.nexusmods.com/metalgearsolidvtpp/articles/1/[/url]

Thanks:
------------------------------
Kojima Productions for the great game
Sergeanur for qartool
atvaark for your fox tools
ThreeSocks3 for finding the custom text output for Announce log
emoose for cracking lua in fpks
jRavens for your early testing
Shigu for your specific testing and discussions
Topher for your great mod manager Snakebite
NasaNhak for your voluminous questions and suggestions
unknown123 for the MGSV research.
Various people for their donations, including:
Надежда
Ian
WolfJack
Oliver
Daniel
Domenico
Ryuta
Thanks a lot.
All the mod users on nexus for trying the mod and bug reports
You for reading this