= Infinite heaven =
r250 - 2021-04-19
by tin man tex
For MGSV version 1.15 (in title screen), 1.0.15.2 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features, as well as providing addon systems to support other mods.

Addon systems include allowing custom sidops, missions, enemy soldier types.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
Or see the Features and Options.html file in the Infinite Heaven .zip

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------

The introduction of IHHook has had plenty of teething troubles, so thanks to all those who have worked wth me to try and nail down the problems.

r250
IHHook:
Fix: Keys being stuck on when opening menu.
Fix: font helpmarker font folder text - thanks OldBoss for the report
Development: Gives error logging for all lua files loading by default (including those in fpks), and runtime error logging for anything that's p-called by the engine.

IH:
Fix: FOB soldiers (and probably DD soldiers in MB wargames with certain weapon setups) having invisible pistol.
Seems I may have broken it in in r176 - August ‎2016 whew - thanks kapacb (and probably many others in the past) for the report.

Fix: Quest addon state flags management - was broken some time around r224 meaning if an addon quest index had been cleared it would stay cleared even if uninstalling quest and installing different one that took that index.

Fix: GetCurrentRouteSetType - RouteSelector - redefinition of local var with same name clobering scope and returning nil. Would cause soldier shifts to fail, meaning no change between night day routes, and no sleeping/hold routes. Bug was introduced while deminifying in r129 - February 2016. Ouch.

RouteSet menu - Options to randomize what routes soldiers use in a Command Post
Randomize RouteSets in free roam
Randomize RouteSets in missions - warning: may mess up some required routes for the mission to progress.
	Enables all following options. Also randomizes current routeSet on mission load/reload. 
	Requires randomize group priority or group routes to be on.

Randomize on shift change - MGSV already has a 'shifts' system that trigger at morning and night, this applies the randomisation at these times.
Randomize on phase change - Randomize current routeSet when enemy phase changes in any way, Sneak, Caution, Alert, Evasion. Up or down.

Randomize group priority - Each routeSet for a CP has a number of groups of routes, this will change the order the groups are picked from and vary the routes connecting shifts.
Randomize group routes - Each routeSet for a CP has a number of groups of routes, this will change the order within the group.

Randomize RouteSet now - Command for if you just want to change things up, or see how the options change things.
[youtube]pZRcPNlZmng[/youtube]
https://youtu.be/pZRcPNlZmng

menu_enableCursorOnMenuOpen - "Enable mouse cursor on menu open" - "Automatically enable mouse cursor when IHMenu opens. The cursor can also be seperately toggled with F2"
(via IH system menu)
Dafaults to on, but as mouselook is now disabled when cursor is on I though this the best way to allow user some control beyond manually toggling it.

r249
IHHook:
Style Editor: Font/size selection, copy fonts to MGS_TPP\mod\fonts to add more - thanks IroquoisPliskin, others for the request.
[youtube]pZRcPNlZmng[/youtube]
https://youtu.be/pZRcPNlZmng

IHMenu improved: Menu items list now descreases in size with window meaning the bottom of the list and setting line wont dissapear when making smaller window.
Window itself no longer adds a scrollbar but help text now has it's own scroll bar. So you don't have to scroll the menu away just to scroll the help text.

Fix: Alt-tabbing or doing anything else that would reset the d3d device would apply the menu InitialText again, which would only fix once you went into a menu to reset the menu list - thanks Yooungi for the report.

IH:
mbIncreaseStaffSaluteReactions - "Add more salute reactions" - "Adds additional reactions from MB staff when 
via ACC > Mother Base menu > Staff menu 
Thanks caplag for lending your notes and your discussion.
[youtube]svLN4LFAh8w[/youtube]
https://youtu.be/svLN4LFAh8w

Auto Abort-to-ACC when vars.locationCode or vars.missionCode not a valid vanilla or addon code - could be caused by uninstalling an addon mission while save was in mission.
Fix: Reset setting and go back menu hotkeys repeat spamming due to being OnHeld instead of OnHoldTime.

r248
IHHook - Support for mgsvtpp JP audio version - thanks everyone for the reports.
[youtube]608ad3UA_EM[/youtube]
https://youtu.be/608ad3UA_EM

r247
Menu: Go back menu and Reset current to default hotkeys must now be held breifly.

Cam - Player Cam hook menu
Uses IHHook to adjust the player camera focal length.
Same method as the 'FOV Modifier' (on nexus)
https://github.com/mon/MGSV-TPP-FoV
This IH feature now superscedes that mod, so if IHHook is working (currently requires 1.0.15.3 eng exe) you should remove that mods d3d11.dll

camhook_enable -Enable Player Cam hook,
Only updates after changing cam mode.
	Focal lengths between modes not equivalent (some other factor being applied)
	Lower focal length = wider FOV,
	Higher focal length = lower FOV
camhook_focalLength_NORMAL="FocalLength Normal",
camhook_focalLength_AIMING="FocalLength Aiming",
camhook_focalLength_HIDING="FocalLength Hiding",
camhook_focalLength_CQC="FocalLength CQC",
camhook_ApplyFOV - "Apply FOV" - "Applies FOV(degrees) proportionally to the different cam mode focal lengths."
[youtube]QRhBMK1S5YA[/youtube]
https://youtu.be/QRhBMK1S5YA

Camera menu (FreeCam)
Renamed "Cam - AroundCam menu"
Added the other AroundCam settings that could only be changed via the button shortcuts while cam was active.
Added some more of the AroundCam settings
targetInterpTime
rotationLimitMinX
rotationLimitMaxX
alphaDistance
All aroundcam settings now save.

PlayCam menu 
Renamed "Cam - PlayCam menu"
moved to root menu.

Fix: fix GenerateEvent event not being reapplied on new session when using forceEvent/Trigger IH Event
Fix: MB wargames events not applying soldier body type (would stay as whatever dd suit setting you had) - thanks KLOC for the report and troubleshooting files to test.

r246
Fix: Hang on mission load - just a dumb typo I forgot to error check. 

r245
Fix: Location addon that adds new questarea while not having any sideops installed set in the area would cause the sideops system to break - thanks Delta 6, Yooungi, caplag for the reports

r244
IHHook:
Fix: Check to see if it's the jp language version. Currently it only warns that IHHook doesn't currently support the version, but that's better than crashing.
Fix: menu close button working from start, doesn't require the IH callback so it can function when it's there as the startup error window.

Infinite Heaven:
Fix: Intel team not marking anything on idroid map - AddGlobalLocationParameters modifies by param not by return.

r243
Fix: A grame crash soon after starting - issue likely was user not having vs redist for what IHHook was built against - thanks fintip for the report and working through test builds with me.

Fix: unlockSideopNumber - 'Unlock specific sideop' not allowing the top most sideop. Had recently cleaned up how some settings ranges were set but forgot that sideops was outside of the normal indexedfrom0 case - thanks psavi for the report (and some others I might have passed by in the past sorry).
unlockSideopNumber now shows the questName.

weather_requestTag - Weather Menu > RequestTag
A collection of sky, lighting settings bundled under a 'tag' name in the locations weatherParameters file.
[youtube]dgz7vyh_3rQ[/youtube]
https://youtu.be/dgz7vyh_3rQ

SetSkyParameters - Weather Menu > various settings:
weather_skyParameterSetSkyScale="Scale of main clouds overhead",
weather_skyParameterAddOffsetY="Height of horizon clouds",
weather_skyParameterSetScrollSpeedRate="Scrolling speed of horizon clouds",

Mission Addon system:
Initial implementation of sideop support.
[youtube]rBSvPVxLSbc[/youtube]
https://youtu.be/rBSvPVxLSbc

r242
Fix: changeCpSubType - Random CP subtype erroring.

r241
Fix: Addon missions breaking when IHHook not initialized - thanks Yooungi for the report

r240
Fix: Game crashing on startup with enableIHExt.
Was trying to log with announcelog via debugprint, which should have been ok because it had a guard against the announcelog not stood-up crash by checking vars.missionCode not nil. Except it should have been checking missionCode wasnt MAX - 65535 - thanks everyone for the report and Venom Raven for the ih_save and testing.
Fix: Mission-prep features menu repeated entry in player restrictions menu removed (is being auto added via parent tag) - thanks OldBoss for the report.

IMGUI: Default style tweaked.

Mission Addon system: 
Free roam missions now get registered to the free roam tab and not the mission tab.
In theory should support moving from an addon free roam to a mission set in that location and visaversa (via mission leave out of bounds).

Free roam missions get proper langId for entry thanks to IHHook, uses locationMapParams.locationNameLangId or defaults to tpp_loc_<lowercase locationName>

r239
Update to MGSV version 1.0.15.3
IHHook: IMGUI style editor with save/load. Via IH System Menu > UI Style Editor
[youtube]_AbPHXTgfLg[/youtube]
https://youtu.be/_AbPHXTgfLg

r238:
Update to MGSV version 1.0.15.2

Includes IHHook, dll proxy for extending IHs capabilities (similar concept to SKSE), and providing a dear-Imgui version of IH menu (to supersede IHExt).
See docs\IHHook-Changelog.txt or github.com/TinManTex/IHHook
[youtube]4V7lPJ2t_rw[/youtube]
https://youtu.be/4V7lPJ2t_rw

Added: Appearance menu - skipDevelopChecks - Allows items that haven't been developed to be selected in the Appearance menu.
Added: attackHeliType - UTH Blackfoot - thanks caplag for discovering uth TppHeliParameters applied to TppEnemyHeli 
Known Issues: UTH wont attack with missiles despite doing the long on sound and behaviour. UTH attack heli classes not actually visually different.
[youtube]ERL7okZVcW4[/youtube]

Added: GeneralHelpItem - mostly for seeing the extensive help text when show help is on.

Added: menu_disableToggleMenuHold - Disable hold menu toggle - Disables the legacy one-button <dive> hold-to-toggle menu, the two button menu combo <zoom_change> + <dash> will still work.

Camera menu:
Added: 'Reset camera position to player' (still can be accessed by pressing the ih camera reset button (binoc) and <dash>) - thanks Muffins for the suggestion (of an obvious oversight).
Added: positionXFreeCam (and Y,Z) - more useful since you can enter the value directly with IHH menu, useful if you have some position from somewhere but you don't know where it is in game.

Mission prep features override:
Replaces the "Mission-prep restrictions menu"

heliSpace_SkipMissionPreparetion - Skip mission prep
heliSpace_NoBuddyMenuFromMissionPreparetion - Disable select-buddy
heliSpace_NoVehicleMenuFromMissionPreparetion - Disable select-vehicle
heliSpace_DisableSelectSortieTimeFromMissionPreparetion - Disable select-sortie time

Lets you force on or off the various mission prep features, though some may not make sense or have stuff overidden by the mission, such as enabling mission prep for the prologue.

Fix: getBodyInfo reverted to directly reading ivar, should fix some issues related to enemy customBodyType - thank Solidus Snake for the report
Fix: GetGroundStartPosition - guard against unexpected mbLayoutCode (still no idea of the situation that would cause the value) - thank Solidus Snake for the files (and caplag for getting him to enable logging)
Fix: All customWeaponTable vars off would error.
Fix: (of a previous fix) of wildcard soldiers causing the game to hang with some sideops,  thanks worthless person for the report.
Fix: GetLastUserMarkerIndex - sometimes would not return correct marker, affected IH features using user markers.

See Change Log.txt for more detail.

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
