= Infinite heaven =
r253 - 2021-06-15
by tin man tex
For MGSV version 1.15 (in title screen), 1.0.15.3 in exe
Compatable IHHook version: r15b

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

r253 - 2021-06-15
InfFulton:
Fulton menu (in ACC)
fulton_autoFultonFREE, fulton_autoFultonMISSION - Extraction team in Free Roam/Missions
"Extraction team will recover enemies you have neutralized after you've travelled some distance from them (usually to next command post). 
This lets you do low/no fulton runs without having to sacrifice the recruitment side of gameplay.

fultonVariationRange - "Fulton success variation","Subtracts the percentage from fulton success in a periodic fashion."
fultonVariationInvRate="Fulton variation inv rate","Inverse rate (higher slower) of fulton variation cycle"

InfInterrogation:
fix: Inter cp stash interrogation quests would just endlessly loop between some paired soldiers as the array for advancement state was too small - thanks William for your reports.

r252 - 2021-06-05
InfShootingPractice:
Support for new Shooting Practice sideops, as the vanilla SP sidops use online saves which can't be added to, IH SP sideops save to ih_quest_states in mod\saves instead.
Will display best time when entering the start marker since it likewise can't use the ranking ui.

quest_enableShootingPracticeRetry - "Enable Shooting Practice Retry" - "Does not hide the starting point when Shooting Practice starts or finishes, and allows you to cancel while in progress and start again."
quest_setShootingPracticeCautionTimeToBestTime - "Set Shooting Practice caution time to best time" - "Sets the caution time/time when the timer turns red to the current best time so you have a clearer idea when going for best time."
[youtube]gX3O0pauMOA[/youtube]
https://youtu.be/gX3O0pauMOA

Sideop shown can be downloaded in optional files.

InfHero: 
moved SetDemon, RemoveDemon from InfMainTppIvars
hero_dontSubtractHeroPoints "Don't subtract hero points" - "Actions that usually subtract hero points don't." 
hero_dontAddOgrePoints - "Don't add demon points" - "Actions that usually add demon points don't."
hero_heroPointsSubstractOgrePoints - "Hero points subtract demon points" - "Actions that add hero points subtract the same amount of demon points"
Thanks TheFluffyPlatypus for the queries.

updateStageBlockLoadPositionToCameraPosition - "Update stage position with camera" (via Cam - AroundCam) Replaces the one-off SetStageBlockPositionToFreeCam command.
"Sets the map loading position to the free cam position as it moves. Warning: As the LOD changes away from player position your player may fall through the terrain.

fix: selecting a quest referencing a missing questArea would error out the quest selection

Refactor save system: quest states moved from ih_save to ih_quest_states, users will lose completion status for installed addon sideops.

Debugging: PrintOnMessage to after resendcount check so less message logging spam, and more accurate indication of when message is being sent.

Quest addon system: questInfo allowInWargames to allow quest on mb to be active during wargames.

r251
WarGames: Added FOB phase background music during wargames - thanks Body Damage, and others for the suggestion.

disableKillChildSoldierGameOver - "Disable game over on killing child soldier" (via player restictions menu menu) - thanks CFWMagic for showing a clear example when updating the stand alone mod.

Skull Events
Moved to its own menu (via the Events menu)
A bajillion settings for the event settings and the parameters for the skulls and zombies in the event exposed.
Now (should) work for Free roam addon missions (does on Caplags gntn - US Naval Prison Facility)
[youtube]zE49gPHU3uE[/youtube]
https://youtu.be/zE49gPHU3uE

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
[youtube]K249zxAd1PU[/youtube]
https://youtu.be/K249zxAd1PU

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
