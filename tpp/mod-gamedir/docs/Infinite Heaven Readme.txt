= Infinite heaven =
r210 - 2017-07-22
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
New for r210:
Fixed: Quarantine platform soldiers having no weapons with custom equip table.
Fixed: mbNpcRouteChange - 'Soldiers move between platforms' not working on initial cluster load, looks like I broke it in r208 - thanks pk5547 for save data, others for the report.
Fixed: Additional npcs with no faces on quarantine and Skulls T-Posing, just disabling additional npcs on quarantine completely at the moment - thanks pk5547 for save data and report.
Fixed: InfEquip.DropItem on GetPosition nil (Eli)

New for r209:
Fixed: Skulls event being forced to Sniper skulls, forgot to revert my debug test which means:
Fixed: (refixed) Crash on encounter with Quiet in free roam when Parasite event selects Camo skulls.
Should actually be fixed now. Sorry.
Fixed: Accidentally left out the IH mother base animal sideops, Blackfoot Down in r208. Woops.
Fixed: Not being able to use weapons/weapon ammo count wrong with custom soldier equipment and other settings on alongside sideops mod. Thanks various people for reports.

New for r208:
Fixed: Female soldiers defaulting to male olive drab body when DD suit female set to Off instead of olive drab female while DD Suit for male not Off - thanks Saladin1251 for the report and save files.
Fixed: Invisible helmets for female wildcard soldiers (removed helmet propety alltogether) - thanks halo4kid for the report.

Fixed: (refixed) Crash on encounter with Quiet in free roam when Parasite event selects Camo skulls. Thanks AyyKyu for the report and files.

Fixed: Sideop list not showing sideops > 192. This is a hard limit in the ui, this workaround manages by skipping random cleared but not currently active sideops. Reroll sideops selection will also reroll this selection.

Option: showAllOpenSideopsOnUi "Show all open sideops" - "Shows all open sideops in sideop list, this mostly affects open but not yet completed sideops from hiding others. There is however a limit of 192 entries for the sideop list, so some will be randomly dropped from the list."
(via Sideops menu)

Option: speedCamNoDustEffect - "No screen effect" - "Does not apply the dust and blur effect while TSM is active."
(via Time scale menu)

New for r207:
Fixed: 'Fatigues All' Custom soldier type/DD suit hanging on load.

Addition: Addon sideop on Sideop selection mode to filter for additional sideops.

New for r206:
Option: rerollQuestSelection - Reroll sideops selection
(via Sideops menu)

Fixed: NPC positions on outer clusters when command cluster is under grad 4/not fully built (currently just disabling NPCs on the outer clusters for that situation).

Fixed: XRay markers. No idea how I broke it, or more specifically why it was working when it was called where it was.

Option: hideContainersMB - "Hide containers"
Option: hideAACannonsMB - "Hide AA cannons"
Option: hideAAGatlingsMB - "Hide AA gatlings"
Option: hideTurretMgsMB - "Hide turret machineguns"
(via Mother base > Show Assets menu)
Removing AA guns can be good for wargames if you dont want something that can swiss cheese helis around.
Removing all the AA and the conainers can be useful if you want to drive/gallop around the platforms without so much stuff being in the way.

Fixed: Some custom soldier type/dd suit bodies incorrect.

New for r205:
Option addition: DD Suit - Fatigues All - will have random selection from all fatigue camos.

Fixed: various DD suit/wildcard females issues. 

Option: enableFultonAlarmsMB - "Enable asset alarms" - "Enables anti fulton theft alarms on containers and AA guns. Only partially working, will only trigger alarm once."
Option: enableIRSensorsMB - "Enable ir sensors" - "Enable ir sensor gates. Only partially working, will only be at level 1 (one beam) and will only trigger alarm once."
(via Mother base > Show Assets menu)
[youtube]4tzwI6daxI0[/youtube]
https://youtu.be/4tzwI6daxI0

Option: mbShowShips - "Show ships" - Shows some ships around mother base.
(via Mother base > Show Assets menu)
[youtube]UQBKTgKCT9o[/youtube]
https://youtu.be/UQBKTgKCT9o

Sideop update: Blackfoot down updated. Added soldiers to river LZ (routes from q11050).

Option change: Add/subtract demon points decreased to 90k per use - thanks SoullessMadness for the suggestion.
See https://www.gamefaqs.com/boards/718564-metal-gear-solid-v-the-phantom-pain/72466130 for breakdown of the demon points levels.

New for r204:
Improved: Soldier item drop now has chance to drop Pentezemin, Noctocyanin, Acceleramin. 

Sideop: Blackfoot down, was mostly built for testing out sideop features.
[youtube]3PUfwreDMNI[/youtube]
https://youtu.be/3PUfwreDMNI

Command: Save to UserSaved profile. - "Saves current IH settings to UserSaved profile at MGS_TPP\profiles\UserSaved.lua."
(via IH system menu)

Fixed: Setting Custom soldier type to a DD body showing the Staff member has died message/points - thanks coolguy3090 for the report.

Change: <STANCE> heli-pull out toggle changed from press to hold 0.85.

New for r202:
Fixed: Number of helis on < 7 clusters, including mass bunching when only command is built.

Option: ihSideopsPercentageCount - "Include IH sideops in completion percentage." - Additional IH sideops count towards game completion percent - defaults to off.
(via sideops menu)

Option: mbAdditionalNpcs - "Additional NPCs" - Adds different NPCs standing around mother base, including ground crew, researchers and Miller.
(via mother base > Show characters menu)
[youtube]Z3oZfrW1Ads[/youtube]
https://youtu.be/Z3oZfrW1Ads

MGO headgear fova mod
[youtube]QJpDwlRCybg[/youtube]
https://youtu.be/QJpDwlRCybg
(must download from IH nexus files page under optional files)

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
