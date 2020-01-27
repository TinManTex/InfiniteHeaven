= Infinite heaven =
r195 - 2016-12-03
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

New for r193
Added: Walker gears assigned to foot patrols in free roam (requires both foot patrols and walker gears in free to be enabled) - pretty flaky with soldiers sometimes ditching walkers in the middle of nowhere though, and (if they make it that far) they'll leave it at their destination base instead of continuing with it.

Added: Walker gear locations to IH interrogations.

Options: "Allow Armor Skulls", "Allow Mist Skulls","Allow Sniper Skulls" - Allow/disallow skull types for Skull attacks - was on TODO, but thanks SoullessMadness for the request.

Option: "Skip startup logos" - Stops the konami/kjp/fox/nvidia logos from showing.". Makes a return after its removal in r90  - thanks morbidslinky for the suggestion.
(via IH system menu)

New for r192
Fixed: Hang on game startup with no ih_save.lua - thanks everyone for the report.

New for r191
Fixed: Container resource scaling - thanks garroth, coolguy3090 for the reports.
Fixed: Mother base Invasion events not applying correctly.
Fixed: mbEnablePuppy - MB puppy DDog not enabling - thanks pk5547 for the report.
Fixed: Debug function PrintInspect now only runs with debugmode, should fix some slowdowns on load.

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
[youtube]4A9GqN0Hpkw[/youtube]
https://youtu.be/4A9GqN0Hpkw

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
<Fire>(Left mouse or Right Trigger) to open the menu to heli-to last usermarker (a kludge, but necesary to activate the inter landingzone ride on heli)
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