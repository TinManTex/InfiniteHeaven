= Infinite heaven =
r157 - 2016-05-29
by tin man tex
For MGSV version 1.09 (in title screen) 1.0.7.1 in exe (wtf kjp)

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, Mother base invasion with multiple attack helicopters, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Infinite Heaven features
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/4/]http://www.nexusmods.com/metalgearsolidvtpp/articles/4/[/url]

YouTube playlist of demonstrations for many features
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

NOTE: Remember to exit to ACC before upgrading Infinite Heaven, upgrading will cause issues continuning a save that's mid mission is likely to cause issues.

r157
Feature: IH events, basically sets of IH features randomly or manually triggered on Free roam or MB start.
Free roam events (can stack):
Crashland: Starts you on foot in at a random start point and randomly selects OSP options - cleared primary, secondary, back weapons, items, support items.

Lost-coms: Disables most mother base support menus and disable all heli landing zones except from main bases/towns.

Hunted: Sets the enemy to combat alert every 15-45 seconds (this also sets the player spotted position right on you), and also disables heli landing zones in a 2k radius from your start position, so you'll have to travel if you want to 'get out'.

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

New for r155
Wildcard soldiers now equipped with highest grade DD weapons.
Fixed: hang on return to mother base and Random CP subtype in missions  - thanks Simonz93 for the save file

Fixed: Invisible soldier bodies for amored soldiers in afghanistan sideops - thanks Simonz93 for the report

Updated to 1.09
DD Equip Grade increased to 11, so you should you can equip DD or enemies with the new weapons (assuming Allow undeveloped DD equipment is on).

Wildcard soldiers now have a chance for some of the rarer faces.

Fixed: Hang after load on Quarantine and Zoo platforms.
Fixed: Mission 22 - Retake the Platform start of foot position under the water - result of above - thanks NasaNhak for the report

Feature: Walker gears on mother base
[youtube]DLCHjSmc5tg[/youtube]
https://www.youtube.com/watch?v=DLCHjSmc5tg
[youtube]DIssEXzZkwo[/youtube]
https://www.youtube.com/watch?v=DIssEXzZkwo
Option: enableMbWalkerGears - "Enable walker gears"
Option: mbWalkerGearsColor - "Walker gears type" -
	"Soviet",
	"Rogue Coyote",
	"CFA",
	"ZRS",
	"Diamond Dogs",
	"Hueys Prototype (texture issues)",
	"All gears random of one type",
	"Each gear random type",
Option: mbWalkerGearsWeapon - "Walker gears weapons" -    
	"Even split of weapons",
	"Minigun",
	"Missiles",
	"All gears random of one type",
	"Each gear random type",  
	
(via Mother base Menu)

"Attack heli type" renamed "Attack heli class"
Added "All one random type","Each heli random type" to heli class.
Options: vehiclePatrolClass - "Vehicle patrol class" - "Default","Dark grey","Red","All one random type","Each vehicle random type","Enemy prep" 

Disclaimer:
------------------------------
Use the mod at you own risk (which can be mitigated by backing up saves and files replaced by mod)
This mod is still largely untested, detailed feedback at Nexus page welcome.

Installation
------------------------------
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


Change Log:
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