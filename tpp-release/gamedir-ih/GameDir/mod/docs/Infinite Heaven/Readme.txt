= Infinite heaven =
r258 - 2022-07-04
by tin man tex
For MGSV version 1.15 (in title screen), 1.0.15.3 in exe
Compatable IHHook version: r17 or later

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features, as well as providing addon systems to support other mods.

Addon systems include allowing custom sidops, missions, enemy soldier types.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
The most up to date and further documents in MGS_TPP\mod\docs

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
NOTE: IHHook which adds the imgui menu and other supporting feature to Infinite Heaven has been split to it's own installation and nexus page: 
https://www.nexusmods.com/metalgearsolidvtpp/mods/1226/

r258 - 2022-07-01
Run AutoDoc", "AutoDoc creates the Features and Options txt and html in docs folder, and profiles/All_Options_Example based on the current menus and options, including any added by other mod IH modules. It will overwrite any existing files."
via IH system menu. 

InfMission: Mission Addons completion, tasks, best rankings support, saved to mod\saves\ih_mission_states.lua

Invalid mission task save data clearing improved - thanks cap.

InfMissionQuest: 
Side ops in missions menu
enableMissionQuest="Enable side ops in missions" - "Enable side ops in missions using a hand-picked selection of side ops in specific story missions."
- thanks cap

InfBodyInfo / custom enemy soldier addon system:
Added support for bodyIdTable ala TppEnemy. Currently just a single entry rather than multiple soldierSubTypes like TppEnemy.

customSoldierTypeMISSION="Custom soldier type in Missions", "WARNING: Unique soldiers in the mission are likely to either be the default body from the selected custom soldier type, or have visual issues if there isn't one."

changeCpTypeMISSION,FREE,MB_ALL="Force CP type in *",
"Default","Soviet","American","Afrikaans"}
"Changes Command Post Type, which controls the language spoken by CP and HQ. 
WARNING: Will break subtitles. 
WARNING: some CP types don't have responses for certain soldier call-ins for different languages."

Thanks Wolbacia, Your401kPlan for poking away making bodyInfo addons and other soldier replacements leading to these improvments.

InfModelProc renamed InfSoldierFace, moved to \modules

Soldier parameters:
Added in-mission menu. Changes to soldier params apply on map load or checkpoint reset.

InfProgression:
Gathers existing progression options.

repopAARadars "Repopulate AA Radars", "Number of mission completes before destroyed Anti Air Radars are rebuilt."

Starting on foot with no given rotation will point you toward center of map instead of always 0 degrees.

InfGameEvent:
gameEventChanceMB/"MB event random trigger chance" split into individual chances for the different event types.

InfChimera: 
Now writes out TppEquip enums for parts, and comments what parts var name is.
Load now actually loads from specified file instead of just loading them at start, so you can edit the file manually and re-load it.

fix: Free roam addons no longer added to missions list, should fix a progression calculation issue.

InfTransition:
Simple mission transistion system via switches.

Quests:
Shooting practice quests can be made for non mtbs locations.

InfProgression:
Moved a bunch of existing progression related options to module.

API: Mission Addon
missionInfo .hideMission : 
Does not add mission to idroid mission selection.
Mission/task completion will not be saved for the mission.
Does not count toward installed mission limit.
Can still be loaded via IH mission load command, or by lua ReserveMissionClear or by transition system.

See Change Log.txt for more detail.
Or the github repo commits:
https://github.com/TinManTex/InfiniteHeaven/

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

While in ACC Heli (Safe-space menu), or in-mission (In-mission menu)
Press and hold <Switch Zoom> (V key or RStick click) then press <Dash> (shift key or LStick click) to toggle the mod menu when in the ACC or in-mission.


The menu system will display the current
[#]: [Option name] [Effect/ item type symbol] [Setting value or description] 
Example:
4: Mobility level = 2:Grade 2

Effect symbols:
<> Applies change or command when setting is selected/cycled to
>> Applies change or command when pressing <Action>

Menu item type symbols:
> Sub-menu
>> Command
>] Command that closes menu when done

Some settings apply when selected or just set the value when the a feature is triggered by another command or during mission load.

While menu is open:
Use Arrow keys or Dpad to navigate the menu
or
Hold <Switch Zoom> (V key or RStick click) and press movement keys or Left Stick to navigate the menu.

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

When enabled hold the <Switch Zoom> (V key or RStick click) button then hold one of the following:

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
Morbidslinky for creating Side Ops companion and his poking at the quest system as well as his work on Snakebite.
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
