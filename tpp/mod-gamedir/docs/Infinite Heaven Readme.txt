= Infinite heaven =
r200 - 2017-03-05
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

NOTE: Infinite Heaven has been restructured, with some of its files now loading from a sub-folder of MGS_TPP folder. Use Install Infinite Heaven.bat or see Install.txt for details.

NOTE: Infinite Heaven now uses SnakeBite 0.8.4, get it here: http://www.nexusmods.com/metalgearsolidvtpp/mods/106

New for r200:
Option: forceDemoAllowAction - "Force allow actions" - Prevents disabling of player actions during cutscene, but most cutscenes require the Disable cutscene camera mod on the IH files page.
(via Cutscenes menu)

Feature: Quickmenu binds for when cutscenes running, currently only Free cam useful with above option and Disable cutscene camera mod.

Fixed: Non critical external modules failing to load will no longer block the IH menu from opening - thanks CantStoptheBipBop for the report.
Fixed: Skull attack on quarantine platform failing part way through ParasiteAppear - thanks pk5547 for the report.
Fixed: Cutscene reset.
Fixed: Using mbShowCodeTalker - "Show Code Talker" option on a save before meeting him causing infinite load - thanks junguler for the report.
Fixed: Quick heli pull-out toggle no longer triggers if idroid open.
Fixed: FreeCam code not disabling when changing level.

New for r199:
Fixed: Crashland event not triggering injury.
Feature: Pause/resume playing cutscenes by pressing Quickdive
Feature: Restart cutscene by pressing Reload

Option: disableOutOfBoundsChecks - Disable out of bounds checks - Disables the out of mission area visual noise and game over checks.
(via Debug menu)
Option: disableGameOver - Disable game over - disables various game over screens.
(via Debug menu)
Fun for testing things out, but likely breaking things.

New for r198:
NOTE: Infinite Heavens MGS_TPP\mod folder has been restructured, if manually updating back up ih_save.lua, delete MGS_TPP\mod folder, copy the new folder entirely from Infinite Heaven zip, the put ih_save in mod\saves

Fixed: Legendary animal sideops not completing on fulton - thanks iponomama for the report.

Fixed: Afghanistan quests with unique bodies (Armor, Wandering MB soldiers) being invisible, was broken since r155 - thanks everyone for the reports.

Fixed: Soldiers having no heads on Mission 43 "Shining Lights Even In Death" - thanks AustrianWarMachine for the report.

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

When enabled hold the <Call> button then hold one of the following:

<Ready weapon>(Right mouse or Left Trigger) to warp to last placed usermarker
<Fire>(Left mouse or Right Trigger) to open the menu to heli-to last usermarker (a kludge, but necesary to activate the inter landingzone ride on heli)
<Action>(E key or Y button) to activate TSM
<Reload>(R key or B button) to activate Free cam
<Dash>(Shift or Left stick click) to activate Static camera
<Change Stance>(C key or A button) to have Quiet move to last usermarker

Profiles:
Profiles are lists of settings for IH options, can be used as an alternative, or in conjunction with IHs in-game menu.
See InfProfiles Readme and InfProfiles.lua for further info.

Settings save file:
IH writes ih_save.lua in the MGS_TPP\mod folder.
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
Lisa
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