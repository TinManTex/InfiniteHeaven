= Infinite heaven =
r220 - 2017-09-11
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
New for r220:
Addition: Added 'Enemy prep' setting to Attack heli patrols options (return of an old feature) - sets the number of helis to scale with enemy prep level.

Fixed: Hang on load when ih_save contains an unknown variable (most recently caused by my rename of heliPatrols ivars) - thanks ashy8000 for the save files and others for the reports.

Fixed: Re-added <Action> tag to options that have OnActivate, was a bit too zealous in removing it. 

New for r219:
(Actually added in r218, but not in easily accessable menu)
Options: setStageBlockPositionToMarkerClosest, setStageBlockPositionToFreeCam, resetStageBlockPosition - sets stageblock loading position. You have to put player in a safe spot/bump player health to 650% so they dont die when their current position unloads and they (may) fall through terrain till they hit level floor.
(via in mission debug menu)
[youtube]A_XJeQk0kvI[/youtube]
https://youtu.be/A_XJeQk0kvI

Fixed: Lag or load hangs due to a file that was removed for r218 that may have been left in MGS_TPP\mod\modules if mod user didn't uninstall r217 or earlier correctly using snakebite.

New for r218:
Change: heliPatrolsMB, heliPatrolsFREE renamed attackHeliPatrolsFREE, attackHeliPatrolsFREE "Attack heli patrols in free roam",
  "Attack heli patrols in MB", value is now number of attack helis.
Option: supportHeliPatrolsMB - split from heliPatrolsMB, is number of support npc helis, count will take priority over attack helis to fit to number of mother base clusters built.
Beyond giving some more control over amount of helis you face, it also lets things be a bit quieter in mother base while still having helis fly around. 
Because of this change you will have to set the options again, sorry for the inconvenience.

Fixed: ApplyProfile failing on random table of setting strings. 
Fixed: ApplyProfile failing on missing ivar.

New for r216:
Fixed: Random roam event selection failing.

Options: mbShowHuey - Show Huey - Shows Huey in BattleGear hangar and in cutscenes even before he's arrived or after he's left story-wise.
(via Mother Base > Show characters menu)

Option: mbForceBattleGearDevelopLevel - Force BattleGear built level - Changes the build state of BattleGear in it's hangar, 0 is use the regular story progression.
(via Mother Base > Show assets menu)

Options: MB Ocean options - adjust various parameters of ocean movement.
(via MB Ocean menu while in mother base)
[youtube]uh0iZfVDUUc[/youtube]
https://youtu.be/uh0iZfVDUUc

New for r215:
Fixed: Hang on load, due to a ghost of an old file or something. Sorry.

New for r214:
Fixed: ih_priority_staff sometimes clearing saved data

All_Options_Example profile up to date, had been forgetting to copy it during my release packaging, now automated that copy - - thanks pk5547 for the report.

New for r213:
Fixed: playerPartsType/'Suit type' syntax error causing it to be missing from menu - thanks SoullessMadness for the report
Fixed: Heavy Armor in free roam option being missing from menu, and the knock on effect of the rest of the menu options being missing from Features and Options document and All options profile. Thanks Nano-Ocelot, pk5547 for the reports.

Option: enableEventHUNTED - "Allow Hunted event"
Option: enableEventCRASHLAND - "Allow Crashland event"
Option: enableEventLOST_COMS - "Allow Lost Coms event"
Will allow you to filter the free roam events from being chosen.
(via Events menu)

Feature: Priority MB staff list
Using these commands you can either add the current chosen staff member, or a staff member that you've marked to the priority list. Upon visiting mother base these members will be chosen to be on base (assuming they are not on deploy mission).

Command: "Add player staff to MB priority"
Command: "Remove player staff to MB priority"
Command: "Add marked staff id MB priority"
Command: "Remove marked staff to MB priority"
Command: "Clear MB staff priority list"
(via Mother base > Staff menu)
[youtube]VjZuqp8KGA0[/youtube]
https://youtu.be/VjZuqp8KGA0

Menu: Staff menu, apart from the above, mbPrioritizeFemale,mbMoraleBoosts have been moved here.

Option: mbEnableMissionPrep - "Enable mission prep to MB" - may require an exit/return from ACC to take effect.
(via Mission-prep restrictions menu)

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
