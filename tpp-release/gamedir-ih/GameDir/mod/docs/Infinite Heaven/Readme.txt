= Infinite heaven =
r259 - 2023-02-18
by tin man tex
For MGSV version 1.15 (in title screen), 1.0.15.3 in exe
Compatible IHHook version: r17 or later

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features, as well as providing addon systems to support other mods.

Addon systems include allowing custom sidops, missions, enemy soldier types.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

It is highly recommended to use IHHook, which is a script extender and graphical menu that has mouse and keyboard support, alongside IH.
[url=https://www.nexusmods.com/metalgearsolidvtpp/mods/1226]IHHook on NexusMods[/url]

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
The most up to date and further documents in MGS_TPP\mod\docs

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
NOTE: IHHook which adds the imgui menu and other supporting feature to Infinite Heaven has been split to it's own installation and nexus page: 
https://www.nexusmods.com/metalgearsolidvtpp/mods/1226/

r259 - 2023-02-18
Fix: InfPositions Loadposistions, thanks cap for fix.
Fix: ih_mission_states not restoring, thanks cap for report.
Fix: Start missions on foot hang on mission end if MB demo triggered. This is an anchient bug that has unfortunately likely been around almost as long as IH itself. Thanks OldBoss for the report and save files.
Fix: profiles breaking due to help strings with newlines. thanks EntranceJew for the report.
InfLookup: A lot of Message signatures, and general message logging rework from EntranceJew
Debugging: Bunch of flow logging to get a better understanding of infinite loading screen, though the answer there is most often just 'the exe is loading stuff and it didn't like something aboout one of the data files'
Fix: InfWeather losing addon weather info on script reload, thanks EntranceJew for the report.
Fix: appearanceDebugMenu fova ivars fix. They still don't do anything, but they were breaking the menu. And due to the exe crash issue after applying several times it's still of limited use. Thanks retali8 for the report.
Fix: 'Warp to last user marker' and Warp body to FreeCam position remove announcelog spam that queues when warping - Thanks SinovialVermin8 for the report
Fix: 'Support heli to marker' failing with '#coords.pos~=3' warning. Seems feature was broken as of last version - thanks Dr Solus for the report.

InfMotion|Motions menu > motionWarpToOrig|"Warp to original position after play". Since some animations move player position through geometry this may help to recover - thanks caplag for implementation.

Mission Addons: various features that were limited to vanilla freeroam now work in addons.

IH Saves: ih_mission_states, ih_quest_states, ih_priority_staff now only save if the related features are used. So possibly slight better performance when saving.
Existing files will still hang around even if they have no meaningful data in them though.
Are also now checked to see if they exist first before loading them, so no potentially confusing error message it used to log when trying to load them reguardless.

Debugging and dev stuff:
ivars GettSettingText calls wrapped in PCallDebug, and log a warning to make it easier to track down broken functions (and not have them break the menu).

Some loading logging, probably won't catch much since most load hangs will be inside exe and lua will just be waiting for TppMission.CanStart which will never come.

InfCore.PCall correct multi returns - thanks EntranceJew for the method.

PCall and LoadExternalModule announceLogs errors.

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
Opening the Infinite Heaven menu:
While in ACC Heli (Safe-space menu), or in-mission (In-mission menu)
Press and hold <Switch Zoom> (V key or RStick click) then press <Dash> (shift key or LStick click) to toggle the mod menu when in the ACC or in-mission.

Or hold <Evade> (Space key or X button)
This can be disabled (via IH system menu > Disable hold menu toggle) if it interferes with your play, the above key combo will still work.

Also, if IHHook is installed, press F3 key.

Using the menu:
If you do not have IHHook installed, or IHExt enabled, Infinite Heaven menu will use the Announce Log on the lower left, which is very limited due to its update rate.
While the menu it will repeatedly show just the current menu option.

Description of menu items:
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

When enabled hold the <Call Radio> (Q key or Left bumper) button then hold one of the following:

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
