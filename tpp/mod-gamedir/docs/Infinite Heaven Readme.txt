= Infinite heaven =
r235 - 2020-03-15
by tin man tex
For MGSV version 1.15 (in title screen), 1.0.15.1 in exe

A mod for Metal Gear Solid V: The Phantom Pain intended to extend gameplay through customizable settings and features.

Has several hundred toggleable options ranging from Subsistence mode for all missions, replay side-ops, Mother base invasions with multiple attack helicopters, Skull attacks in Free roam, Free-cam, skip heli rides, customization of enemy and mother base gear, foot, heavy vehicle and heli patrols in free roam, and much more.

Full Infinite Heaven features and options:
[url=http://www.nexusmods.com/metalgearsolidvtpp/articles/5/]nexusmods.com/metalgearsolidvtpp/articles/5/[/url]
Or see the Features and Options.html file in the Infinite Heaven .zip

YouTube playlist of demonstrations for many features:
[url=https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF]youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF[/url]

Recent changes/additions
------------------------------
r235:
Player restrictions menu added to in-mission menu.
'Game over on combat alert' / gameOverOnDiscovery, now works in free roam (previously only worked in missions) (via Player restrictions menu)
Thanks Steve Harvery for the prompt.

Fix: UAVs on FOB should show their correct grade.
Bug was due from me missing a subltle change while merging the mgsv 1.09 patch in April 2016, ouch.
It got lost in the noise of variable name changes due to the minified lua files. Thanks elquinto for the belated report.

New for r234
Added: In-Cutscene IH menu can be opened while cutscene playing.
Fixed: Quick menu not working while in cutscenes.
Change: Pause cutscene bind changed from EVADE (dive button) to STANCE (crouch button)

Change: Mother Base - Additional NPCs changed to a sub menu where you can individually set which additional npcs you want to appear - thanks Muffins for the suggestion.

Fix: Completion percentage dropping to 99% and completed tasks counting higher than max - thanks AsiaSkyly and badbard99 for the reports.

Fix: MB staff died message should appear in Mission 43 - thanks GrimreaperIII3 for the report.
Was being overzealous in TppHero.SetAndAnnounceHeroicOgrePoint, still may need attention.
Also a longstanding errant character I added (the curse of binding an easily pressed mouse button to a keyboard character) in s10240_sequence Damage message may have been causing an issue.

Fix: Wildcard Soldiers causing some sideops to have missing enemies or soldiers and a resulting infinite load on reload or exit free roam.
This seems to be a very long standing bug that I wasn't able to reproduce till recently.
Unfortunately the fix comes at a cost of removing female soldiers from the wildcard feature as the bug is due to some fundamental problem with using the extend part system they use for their models in combination with sideops which was never used in the base game. 
Thanks TheIronIris for providing save files and information so I could reproduce the issue.

Shifted the IH sideops (mother base animals and Blackfoot down) out of IH installation to their own addon mod. This stays truer to IH's 'default by default' policy and helps the sideops count now that the community has made many sideops.

Various features to help community mods, thanks Cuba, placeholderthesteam for the prompts.


New for r233
More support for various data needed by addon missions.
Thanks to cap for working out some more of the needed data.
Check out his addon mission https://www.nexusmods.com/metalgearsolidvtpp/mods/918/

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
[#]: [Option name] : [Setting value or description] [menu item type symbol]
Example:
4: Mobility level : Grade 2

Menu item type symbols:
Sub-menu >
Command >>
Command that closes menu when done >]
[Option Name] <Action> : [Setting]
Selected setting is applied by pressing <Action> 

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
