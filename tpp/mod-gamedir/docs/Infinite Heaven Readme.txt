= Infinite heaven =
r162 - 2016-06-18
by tin man tex
For MGSV version 1.09 (in title screen) 1.0.7.1 in exe (wtf kjp)

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, Mother base invasion with multiple attack helicopters, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Infinite Heaven features and options
------------------------------
See: Features and Options.txt file
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]http://www.nexusmods.com/metalgearsolidvtpp/articles/5/[/url]

YouTube playlist of demonstrations for many features
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
NOTE: NOTE: Remember to exit back to ACC before upgrading Infinite Heaven, upgrading a save that's mid mission is likely to cause issues.

New for r162
Fixed: Patrol vehicle classes not actually applying - thanks NasaNhak for the report
Change: Vehicle classes apply to non patrol vehicles (Afgh only)
Fixed: Random CP subtype now resets table if not enabled for mode.
Fixed: Returned molotok to wildcard soldiers, had accidentally replaced it with the high grade DD fob rifle.

Menu: World menu added, IH event chance, Clock timescale options moved to it.

Option: Repopulate music tape radios - thanks Apantos for the suggestion
(via World menu)

Sideop selection mode - Default (first found), Random, <side ops category> - Lets you influence the sideops selection.
[youtube]RmAl4NzZ9oo[/youtube]
https://youtu.be/RmAl4NzZ9oo

Option: Randomize minefield mine types - Randomizes the types of mines within a minfield from the default anti-personel mine to gas, anti-tank, electromagnetic

Option: Enable additional minefields - In the game many bases have several mine fields but by default only one is enabled at a time, this option lets you enable all of them. Still relies on enemy prep level to be high enough for minefields to be enabled.
[youtube]EujEm1cKWG0[/youtube]
https://youtu.be/EujEm1cKWG0

Option: Disable Intel team herb spotting (requires game restart) - Since the variable is only read once on game startup this setting requires a game restart before it will activate/deactivate. (PlayerRestrictions menu)

Option: Equipment on trucks - Puts a random piece of equipment on the back of patrol trucks.
(via Patrol vehicle menu)

New for r161
Fixed: Hard-lock on mother base on a cluster with only one platform with "Soldiers move between platforms" on - thanks 
BarelyFatal for the report and the save file to test with.
Fixed: Ocelot being stuck on upper areas of early game in-construction command platform with "Enable Ocelot" on.
Fixed: "Random CP subtype in missions" menu item would just show option==nil warning - thanks megamen123 for the report.

Option: Soldier item drop chance" - Soldiers drop items upon elimination.
(via soldier parameters menu)
[youtube]kafjLfvAifI[/youtube]
https://youtu.be/kafjLfvAifI

New for r160
Fixed: Removed debug commands from root of in-mission menu, whoops.

Fixed: Ghost light from patrol soldiers radio - appeared on enclosed patrol vehicles and patrol soviets with light armor.

New for r159
Fixed: Enemy patrol helis getting stuck/rotating at 'landing' position.

Fixed: MB Cutscene playback - now doesn't set mbFreeDemoPlayedFlag, so shouldn't cause issues if played before they are normally triggered - thanks BarelyFatal for the report.

Change: Number of Wild card soldiers increased, may also now appear in patrol vehicles (trucks,jeeps)

Tuning: MB events: DD staff now equiped with non lethal for Training event. Soviet Invasion DD Equip off, Coyote attack enemy 
heli types to each random, dd equip level lowered. Events ises varied settings of mbNpcRouteChange

Fixed: MB wargames/events - soldiers will now follow routes when in caution mode (before they would just stay in their last position before alert)

Change: split event random trigger chance % setting into MB and Free, thanks Recaldy for the suggestion.

Option: Enable more soldiers on MB plats - increases (non main) platforms from 4 soldiers to 7-8.
Option: Soldiers move between platforms - soldiers will periodically move between platforms (only within the same cluster).
(via Mother base menu)
[youtube]azkVA-D_Rq8[/youtube]
https://youtu.be/azkVA-D_Rq8

New for r158
Fixed: Disable landing zones hanging loading mother base
Fixed: Maybe hopefully possibly. FOB defense black screen - thanks Shigu for helping test

New for r157
Feature: IH events, basically sets of IH features randomly or manually triggered on Free roam or MB start.
Free roam events (can stack):
Crashland: Starts you on foot in at a random start point and randomly selects OSP options - cleared primary, secondary, back weapons, items, support items.
[youtube]RrWZldWAp6o[/youtube]
https://youtu.be/RrWZldWAp6o

Lost-coms: Disables most mother base support menus and disable all heli landing zones except from main bases/towns.

Hunted: Sets the enemy to combat alert every 15-45 seconds (this also sets the player spotted position right on you), and also disables heli landing zones in a 2k radius from your start position, so you'll have to travel if you want to 'get out'.
[youtube]UXAN6eBoI2M[/youtube]
https://youtu.be/UXAN6eBoI2M

MB events (only one active):
DD Training wargame
Soviet attack
Rogue Coyote attack
XOF attack
DD Infection outbreak
Zombie Obliteration (non DD)

Fixed: changed start on foot mission start timers workaround, previous workaround resulted in pause menu issues such as options item not appearing and double abort items (both abort mission and abort to acc) - thanks CantStoptheBipBop for the report

Fixed: Cutscene DDogGoWithMe infinite load screen after scene finish when triggered via MB cutscene play mode - thanks PIESOFTHENORTH for the report.

Fixed: Walker gear types were off by one.

Fixed: Removed the purposeless menu back command in the root of in-mission menu - thanks Digitaltomato for the report

Refactor: Disable Central Lzs changed to Disable Lzs - Off, Assault, Regular

Menu: Patchup menu renamed Debug/system menu

Refactor: Options that cover multiple modes (Free roam, mission, mb), have had some internal restructuring, so you will have to set them again after upgrading to r157: Random CP subtype, Start on foot, prep mode, .. use DD equipment.

Option: Debug IH mode - Switches on some error messages and enables the announce log during loading. Hopefully this will give more information if your'e having issues with something.

Disclaimer:
------------------------------
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, detailed feedback at Nexus page welcome.

Installation
------------------------------
See: Installation.txt file 
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/2/]http://www.nexusmods.com/metalgearsolidvtpp/articles/2/[/url]

Usage:
------------------------------

While in ACC Heli (full menu), or in-mission (small menu)
Hold <Quick dive> (space key or X button on controller) for 2 seconds to toggle the mod menu when in the ACC or in-mission.

The menu system will display the current
<Option name> - <Setting value or description>
Sub-menus are indicated by >>

Use either Arrow keys or Dpad to navigate the menu.
Up/Down to select option.
Left/Right to change setting or open sub menu.

Press <Change Stance> button to go to previous menu.

Press <Call> button to reset current setting.

Tap mod menu button <Quick dive> while menu is open to refresh current setting.

By design I try to keep the initial install to all regular game settings and only changed via infinite heavens in-game mod menu.
All settings are reset to off on doing a FOB mission. But I suggest you play offline while the mod is installed. Snakebite mod manager allows easy toggling of mods.

Known Issues
------------------------------
See FAQ Known issues.txt file
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/6/]http://www.nexusmods.com/metalgearsolidvtpp/articles/6/[/url]

Change Log
------------------------------
See: Change Log.txt file
or
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/1/]http://www.nexusmods.com/metalgearsolidvtpp/articles/1/[/url]

Thanks:
------------------------------
Kojima Productions for the great game
Sergeanur for qartool
atvaark for his fox tools
ThreeSocks3 for finding the custom text output for Announce log.
emoose for cracking lua in fpks
jRavens for testing
Topher for the great mod manager Snakebite
NasaNhak for your voluminous questions and suggestions
All the mod users on nexus for trying the mod and bug reports
You for reading this