= Infinite heaven =
r225 - 2018-03-06
by tin man tex
For MGSV version 1.12 (in title screen) 1.0.12.0 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
Or see the Features and Options.html file in the Infinite Heaven .zip

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
New for r225:
Fixed: Hang on load with no ih_save, wasn't initializing igvars oops - thanks серёжа for the report and the save files to test.

New for r224:
Motions menu - Play different animations on player. A motion group may contain several related animations (usually lead-in, idle, lead-out)
Option: Motion group - Press <Action> to play the selected animation.
Option: Motion number - Press <Action> to play the selected animation.
Option: Hold motion - Holds motion, requires stop motion to stop.
Option: Repeat motion - Repeat motion at end, some animations don't support this.
Option: Stop motion - Use to stop motions with motion hold or motion repeat.
Option: Play motion - Closes menu and plays current selected motion.
(via in-mission menu)
[youtube]k51-8vHI2mU[/youtube]
https://youtu.be/k51-8vHI2mU

InfPosition:
Positions list from ShowPosition migrated to it's own command, commands for adding user markers, clearing, and writing them to \mgsv_tpp\mod\ added
Positions menu - for writing in game postitions to files, useful for getting positions when creating sideops.
Commands:
Add current position to Positions List - Add current player or freecam position to Positions List, positions list can be written to file with Write Positons List command.
Add markers to Positions List - Adds current user markers to positions list, positions list can be written to file with Write Positons List command.
Write Positions List - Writes Positions List to files in MGS_TPP\mod\
Clear Positions List - Clears Positions List
(via in-mission menu)

Command: Support heli to marker - Sends Support heli to Landing Zone closest to the last placed user marker while riding it. This replaces the existing 'Support heli to latest marker' and now can only be used while riding the support heli. This removes a lot of the issues of riding the support heli across the map that the prior method had.
Implmentation wise this works by forcing the heli to a specific route, the WIP version prior to this had too many issues since it used LZ routes, now it uses custom routes thanks to sais FoxLib. So special thanks for his work on the library.
(via in-mission menu)
[youtube]FnPdGm1gXWY[/youtube]
https://youtu.be/FnPdGm1gXWY

New for r222:
IHExt: IHExt is an overlay app that Infinite Heaven can launch to act as the menu when MGSV is in Borderless Fullscreen mode.
The normal IH activation and navigation of the menu remains the same, but if you alt-tab to the overlay you can use mouse and keyboard to more quickly navigate and change settings.
Option: Enable IHExt - Starts IHExt, from that point on will start while game is starting up.
Option: Enable help text (IHExt) - Shows longer description help text in IHExt for some options.
(via IH system menu)
[youtube]lqYmBCeIbEA[/youtube]
https://youtu.be/lqYmBCeIbEA

If you have concerns about IH running the IHExt executable the (terribly rough) source is here for viewing/compiling yourself:
https://github.com/TinManTex/IHExt 

Fixed: Custom sideops with helis not allocating a heli (if no normal heli sidops also active) - Adding hasEnemyHeli to quest definition will add it to the heli quest list - which means force heli reinforce will also block those quests - thanks MorbidSlinky for the report.

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
See MGS_TPP\mod\profiles\All_Options_Example.lua for more info.

Settings save file:
IH writes its settings to ih_save.lua in the MGS_TPP\mod\saves folder.
While the file is editable, editing an inMission save is likely to cause issues.

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
sai for FoxLib and further MGSV research.
Various people for their donations, including:
Domenico
Jeong
Lee
Nicholas
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
