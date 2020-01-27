= Infinite heaven =
r202 - 2017-04-09
by tin man tex
For MGSV version 1.10 (in title screen) 1.0.7.1 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
Or see the Features and Options.html file in the Infinite Heaven .zip

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
r202 - 2017-04-09
NOTE: With SnakeBite 0.8.6 you no longer need to manually copy the \mod folder to MGS_TPP\, SnakeBite will install it.

Fixed: Number of helis on < 7 clusters, including mass bunching when only command is built.

Option: ihSideopsPercentageCount - "Include IH sideops in completion percentage." - Additional IH sideops count towards game completion percent - defaults to off.
(via sideops menu)

Option: mbAdditionalNpcs - "Additional NPCs" - Adds different NPCs standing around mother base, including ground crew, researchers and Miller.
(via mother base > Show characters menu)

New for r201:
Fixed: Mother base soldier getting set to hostile - thanks captainking91, others for the reports
Option: customSoldierTypeFREE - Custom soldier type in Free roam - Override the soldier type of enemy soldiers in Free Roam.
(via Enemy Prep menu)
Added settings for DD suit (same options as Custom soldier type): MSF GZ, XOF Gasmasks, XOF GZ, Genome Soldier. May need to re set your DD suit setting as some existing items in list have been shifted.
[youtube]lbTLjpAjGso[/youtube]
https://youtu.be/lbTLjpAjGso
[youtube]fNusYTO57hA[/youtube]
https://youtu.be/fNusYTO57hA

New for r200:
Option: forceDemoAllowAction - "Force allow actions" - Prevents disabling of player actions during cutscene, but most cutscenes require the Disable cutscene camera mod on the IH files page.
(via Cutscenes menu)

Feature: Quickmenu binds for when cutscenes running, currently only Free cam useful with above option and Disable cutscene camera mod.
[youtube]cmCK82ft9Oo[/youtube]
https://youtu.be/cmCK82ft9Oo

Fixed: Non critical external modules failing to load will no longer block the IH menu from opening - thanks CantStoptheBipBop for the report.
Fixed: Skull attack on quarantine platform failing part way through ParasiteAppear - thanks pk5547 for the report.
Fixed: Cutscene reset.
Fixed: Using mbShowCodeTalker - "Show Code Talker" option on a save before meeting him causing infinite load - thanks junguler for the report.
Fixed: Quick heli pull-out toggle no longer triggers if idroid open.
Fixed: FreeCam code not disabling when changing level.

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
[#]: [Option name] : [Setting value or description] [menu item type symbol]
Example:
4: Mobility level : Grade 2

Menu item type symbols:
Sub-menu >
Command >>
Command that closes menu when done >]
[Option Name] <Action> : [Setting]
Selected setting is applied by pressing <Action> 

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
Gary
Joseph
Lisa
Надежда
Ian
WolfJack
Oliver
Daniel
Domenico
Ryuta
Thanks a lot.
All the mod users on nexus for trying the mod and bug reports.
All the other MGSV mod authors past and current for adding to the community.
You for reading this
