= Infinite heaven =
r260 - 2023-03-08
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

r260 - 2023-03-08
Fix: quest adding their missionPacks in helispace - thanks CapLag for an unrelated report that made me test something related.

Fix: Repop of sideop 144 tent_q99040 "Secure the Remains of the Man on Fire" arival on quarantine platform leaving player stuck in helipad.

Fix: Infinite load screen when IH startOnFoot used when force go to mb on quest clear > demo play. Another case of the prior fix in r259 for start on foot, which Repop of sideop 144 is also a case of. 

Fix: Several bugs setting quest flags incorrectly. Could result in some of the hidden/managed quests activating or not. 
Could also cause the all sideops disabled bug.
A manual fix is to run "Reroll sideops selection" with "Repop mode" set to Allways.

Ancillary ih saves (addon mission and quest states) are now cleared on new game.

InfQuest / IH Sideops menu:

Renamed unlockSideOpNumber to quest_forceQuestNumber, just an internal name change to be more consistant and accurate. Though you will have to set the setting again.

Renamed ihSideopsPercentageCount to quest_addonsCountForCompletion, just an internal name change to be more consistant and accurate. Though you will have to set the setting again.

quest_updateRepopMode="Repop mode": "On none left"|"Allways"
Lets you choose the behaviour of how repeatable sideops are refreshed. 
The update is run for the sideop area of a quest you just finished, 
or for all areas when changing many of the IH sideops options or rerolling sideops. 
The default behaviour 'On none left' will only repopulate sideops when there are no other uncompleted sideops, and all other repeatable sideops have been completed. 
'Allways' will refresh repeatable quests every time the update is called.

quest_setIsOnceToRepop="Repop one-time sideops"
"Lets you force story and one-time sideops to be replayable."
Replaces "Unlock Sideops mode".

quest_selectForArea="Selection for Area mode"
Renamed from sideOpsSelectionMode
Categories removed, use the Sideops category filter menu instead. 
'Random Addon' setting added to prioritize Addon sideops.
Sideops are broken into areas to stop overlap, this setting lets you control the choice which repop sideop will be selected to be Active for the area.
'Random Addon' will prioritize Addon sideops first.
All selection is still prioritized by uncompleted story sideops, then other uncompleted sideops, then repop sideops selected by this option.

"Show on UI menu"
Replaces "Show all open sideops"
Settings for what sideops to show and how they should be sorted depedending on various parameters for sideops on the idroid sideops list.
The vanilla behavior just shows current Active and Cleared sideops, in index order, which lets you see past progression/completion,
Though since uncleared sideops do have priority, one will be selected for Active.
So if there's multiple uncleared for an area they will not be shown, which gives you less of an idea of future progression.
These option give you individual control for showing sideops depending on their conditions.
For a given sideop multiple of the underlying conditions may be true at one time and either depend on your progress through the game, or from other IH settings.
There is however a limit of 192 entries for the sideop list (there's 157 sideops in the base game), which some settings might push over if you have addon sideops, in which case some Cleared entries be randomly dropped from the list.
See the notes for each option for more info.
Sorting:
Sorting will proceed through all flags that have a sorting setting (not set to None). So sort is in respect to the option above it.
None: Will not apply any specific sort, so will just be in index order, but may be moved around if other flags sort it.
The other settings, Top, Bottom or Ascending, Descending depending on the flag type, will sort as the settings suggest, but in relation to the prior flags.
Since the final sort is by sideop index (the number on the left of the entry in the sideop list) you can use that to see where the list sections from one sorted flag type to the next.

quest_uiShow_Active="Active" - "Default is Show. Sideops that are Active are the ones actually currently in play and start when you arrive in the sideop area. Independent of Cleared. You normally wouldn't set this setting to Hide."
quest_uiShow_Cleared="Cleared" - "Default is Show. Quests that have been completed."
quest_uiShow_Uncleared="Uncleared" - "Quests that have not been completed."
quest_uiShow_Activable="Activable" - Only shows those sideops in the selection for being Activated (which includes Active). Usually the best setting to show what sideops are being considered depending on all the underlying conditions and IH settings."
quest_uiShow_Open="Open" - "Will try and show all Open sideops, which is usually every sideop as soon as they are introduced through game progression. Most likely to hit the UI limit entries when a lot of addon sideops are installed."

quest_uiSort_Active="Sort Active" - Top|Bottom
quest_uiSort_Cleared="Sort Cleared" - Top|Bottom
quest_uiSort_Uncleared="Sort Uncleared" - Top|Bottom
quest_uiSort_Activable="Sort Activable" - Top|Bottom
quest_uiSort_Open="Sort Open" - Top|Bottom
quest_uiSort_category="Sort by Category" - Ascending|Descending - "The base game sideops are more or less ordered by category already, however addon sideops are added to the end, this sorts by a similar order but puts Story sideops first."
quest_uiSort_locationId="Sort by Location" - Ascending|Descending -
quest_uiSort_questArea="Sort by sideop area" - Ascending|Descending -"Each main location of the game (Afgh, Africa) is sectioned into about 8 sideops areas to stop overlap and manage loading. You can look at the sideop index to clarify where the list goes from one area to the next (the numbers within an area will be increasing, then be lower for the first sideop in another area). You may want to use in combination with Sort by Location."

Sideops selection menu:
ivars renamed from sideop_<CATEGORY> to quest_category_<CATEGORY>
Settings changed from OFF, ON to "ALL","NONE","ADDON_ONLY"
This lets you have per catergory selection of only Addon sidops.

Quest Addon questInfo: 
Added canActiveQuest=function(questName) --Optional. All quests repop by default (are available to repeat), returning false will stop it from being considered for selection. Use this if you need to stop the quest from Active selection after the initial canOpenQuest.

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
