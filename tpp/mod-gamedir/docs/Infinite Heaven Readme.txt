= Infinite heaven =
r196 - 2016-12-10
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

NOTE: Infinite Heaven has been restructured, with some of it's files now loading from a sub-folder of MGS_TPP folder. Use Install Infinite Heaven.bat or see Install.txt for details.

NOTE: Infinite Heaven now uses SnakeBite 0.8.4, get it here: http://www.nexusmods.com/metalgearsolidvtpp/mods/106

New for r196
Build for SnakeBite 0.8.4

Added Headgear (cosmetic) to Filter Faces (splits headgear from Unique filter)
(via Player Settings > Appearance menu)

Fixed: Female Wildcard face range incorrect, resulting in defaulting to smushmanface.
Fixed: Quests with balaclavas breaking those soldiers - thanks shynbean and PerkPrincess for your report.
Fixed: mbAdditionalSoldiers,"More soldiers on MB plats" not loading the additonal soldiers, reulting in empty platforms - thanks shynbean for the report.
Fixed: IH interrogations would not return wildcard soldier locations - thanks rargh for the report.
Fixed: Soldier headgear on fobs being incorrect.

New for r195
Wildcard soldiers and hostages have staff parameters regenerated. Should always have a skill assigned now and have high stats (in respect to current mb level/stats draw)

Fixed: Crash on startup with missing InfModelRegistry/mod folder
Fixed: Phasechange update not working, had found the issue just prior, but thanks GloomMouse for the report anyway.
Fixed: (partial), setting unlockSideOpNumber via profile will not give OUT OF BOUNDS error, but currently still won't be able to set them > 157 - to new sideops - thanks pk5547 for the report.

Option: "Female staff selection" - added Half setting.
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

New for r194
New sideops for Mother Base:
SideOp: "Sheep in the Keep" - "Logistics had a mishap and let a herd of sheep loose on the Command Platform. Fulton them so they can take them to the Conservation Platform." 
SideOp: "Birds in the Belfry" - "Your staff has been having some issues with birds roosting in the Intel Platform Enclosure. See if you can clear them out." 
SideOp: "Rats in the Basement" - "The grow-room under the Support Platform is plagued by rodents.&#xA;Find them among the plants." 
[youtube]Xe5VjKC2f9w[/youtube]
https://youtu.be/Xe5VjKC2f9w

Fixed: Some defaults not applying on fob.
Fixed: Allow skull types not actually filtering the skulls select - thanks SoullessMadness for the report.
Fixed: (mostly) Allow heavy armor in free/missions, Custom prep with armor % high would cause soldiers either defaulting to non armored or not rendering body.
Fixed: Animals camo selectable via the camo option in appearance menu.
Fixed: TppQuest.UpdateActiveQuest now using level seed for random or side ops selection mode. This fixes mismatch bettween aparent selected sideop (ui cues) and actual sideop pack/script loaded when directly spawning into a quest load area, possibly a rare issue in free roam, but a clear issue on mother base. Should also prevent the change of sideops from ACC to level.
Fixed: Enable Ocelot in MB causing Sahelenthropus mission to infinite load - thanks CapLagRobin for the report.

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