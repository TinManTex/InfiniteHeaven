= Infinite heaven =
r178 - 2016-09-06
by tin man tex
For MGSV version 1.10 (in title screen) 1.0.7.1 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, Mother base invasion with multiple attack helicopters, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

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


PSA: FOB defender spawning but getting stuck with a black screen.
------------------------------

The issue: FOB defender getting stuck at a full black screen after connection, and can hear the FOB about them.
If the attacker dies when the defender is in this state they will get stuck looking at their body with a loading circle.

The cause: If either player has Infinite Heaven r174 or earlier installed. The issue would not appear if both players had IH installed.

This is a very specific issue and not related to disconnects or any hangs on loading screens with tips/DD logo background.

Fix: Users of IH should update to r176. Non-mod users should no longer have this issue playing with players of IH r176.

Technical: The issue is caused when the game tries to sync some variables but fails due to the differing definitions between the host-client/IH-normal. The fixed version of IH shifts its one use of this type of variable to another that doesn't attempt to sync.

I apologize to the community for taking a while to track down this issue. While I had been aware of the issue for a while I was under the impression it was only affecting users of Infinite Heaven. A further delay was due to testing with other users of IH which hid the issue. Also due to logistics of requiring another person to test with, on top of the already high difficulty of debugging scripting, and the strange behaviour, I delayed tackling the problem. 

Those are explanations, but not excuses. My priorities were wrong on this.

From the very start nearly a year ago I designed Infinite Heaven to disable its features when going on to FOB, however due to how the code is mostly shared between the modes there still has been the occasional issue, but nothing that affected non-users of IH until this bug.
Sorry to those who it has affected.

I would like to thank those that reported the issue, those that offered help with testing, and most recently i-ghost and Maniac_34 for helping me test while tracking down the issue.

New for r178
Feature: Custom profiles - You can now edit/creat custom setting profiles. See InfProfiles folder from the Infinite Heaven .zip

Option: Filter faces - "Show all","Unique","Head fova mods" - filters the list of faces in the appearance menu
Fixed: A number of player restriction options not applying - thanks Gambchon for the report.

New for r177
Reverted: Menu only print option name on menu up/down. Too much of an anoyance for little gain.
Fixed: Trigger game event option does not require random trigger chance settings to be enabled.
Fixed: Incorrect ammo count after disabling OSP weapon options. May still happen after exiting real subsistence missions into free-play, but can be fixed by changing the affected weapons to different types.
Fixed: Enemy phase modifications breaking IH menu in wargames - thanks i-ghost for the report and save file to test.
Option: printOnBlockChange - debug option that prints on block updates.
(via the in mission Debug stuff menu)

New for r176
Options: Appearance options
Player type - Snake, Avatar, DD Male, DD Female
Suit type - the different suits, will use the Fova lua name if the model swap has included it.
Camo type - Cammo, if the suit supports it
Headgear - The usual mission selectable headgear. Bandanas(Snake/Avatar), Balaclavas etc.
Face - (DD soldiers only), cycle backward to the end to get the more unique faces, including Hideo. 
The previous player headgear (cosmetic) option has been removed, the headgear is in the faces list about a quater from the end.
(via Appearance menu in Player settings menu or in In Mission menu)
[youtube]a0PJJVkDQe8[/youtube]
https://youtu.be/a0PJJVkDQe8

Option: "Soldier night sight scale" - seperate sight scale applied to night

Addition: Menu up and down now support bigger increments by holding <Fire>
Change: Menu will only print out the option name, and not the setting while navigating up and down, the auto display shows the full text. This should cut down a little of the text printed/needing to catch up when cycling through the menu.

Reverted: Removed fulton restriction on Invasion. The weirdness is still there, but the odd extraction count seems to be with normal extractions.

New for r174
Fixed: Skull event clear does disable weather changes - thanks mgs5tppfan for the report
Fixed: (Maybe) Crash on exiting mother base invasion events - thanks various people for reports, could you please verify this is fixed.
Change: Women in Enemy Invasion mode changed to percentage (actually percentage chance per soldier choice rather than strict percentage)
Addition: Femme Fatales added to mother base events.
Command: In mission Buddy Equipment change - Buddy equiment is changed to selected setting when <Action> is pressed.
(via Buddy menu in mission menu)
Change: Quiet move to last marker faces quiet in the same angle as the player when the command is called.
[youtube]JxgQ5ZjX8ao[/youtube]
https://youtu.be/JxgQ5ZjX8ao

New for r173
Fixed: The selection of DD bodies being limited to one or two when that body type has a table of types.
Fixed: Wildcard body selection for table of types.
Fixed: More soldiers on MB plats soldier count on checkpoint reload, manifested as no soldiers on last plats and double on first.
Fixed: Hang on motherbase checkpoint reload from InfNPC, exacerbated by above.

Added: MSF to MB DD Suits
[youtube]5IPi0Kpauu8[/youtube]
https://youtu.be/5IPi0Kpauu8

New for r172
Updated to TPP 1.10
Extra unassigend soldiers in Africa added to lrrps.
Freecam defaults to player position on first activate
Added swimsuit to mb DD male,female.
[youtube]Z_skYFSL-EI[/youtube]
https://youtu.be/Z_skYFSL-EI
Added swimsuit to female wildcard soldiers suit list.

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

QuickMenu:
- A way to quickly trigger certain Infinite Heaven commands.

Hold down <Call>(Q or Left bumper) and press:

<Binoculars>(F or Right bumper) to toggle the IH main menu

In mission Quick Menu:
<Ready weapon>(Right mouse or Left Trigger) to warp to last placed usermarker
<Fire>(Left mouse or Right Trigger) to open the menu to heli-to last usermarker (a kludge, but nessesary to activate the inter landingzone ride on heli)
<Action>(E key or Y button) to activate TSM
<Reload>(R key or B button) to activate Free cam
<Dash>(Shift or Left stick click) to activate Static camera
<Change Stance>(C key or A button) to have Quiet move to last usermarker

Profiles:
See InfProfiles Readme

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
Various people for their donations, including:
Oliver
Daniel
Domenico
Ryuta
Thanks a lot.
All the mod users on nexus for trying the mod and bug reports
You for reading this