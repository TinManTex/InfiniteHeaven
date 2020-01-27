-- All_Options_Example.lua
-- Defaults / example of all profile options for IH r3
-- Profiles are lists of settings for IH options.
-- IH only reads this file/does not write to it.
-- You can load a profile through the IH system menu by pressing <Action> on the Selected profile.
-- Or by setting loadOnACCStart=true, below.
-- This profile lists all options, with their default settings.
-- See Features and Options.html for longer descriptions of some settings.
-- Options are added and sometimes changed as IH develops, use the defaults profile and compare with a prior version using a tool like WinMerge to see changes to make sure your own profiles are correct.
local this={
	description="Defaults/All disabled",
	firstProfile=false,--puts profile first for the IH menu option, only one profile should have this set.
	loadOnACCStart=false,--If set to true profile will be applied on first load of ACC (actual, not just title). Any profile can have this setting, profiles will be applied in same order as listed in IH menu (alphabetical, and firstProfile first)
	profile={
		--IH system menu
		enableIHExt=0,--{ 0-1 } -- Enable IHExt
		enableHelp=0,--{ 0-1 } -- Enable help text (IHExt)
		enableQuickMenu=0,--{ 0-1 } -- Enable Quick Menu
		--Camera menu
		moveScale=0.5,--{ 0.01-10 } -- Cam speed scale
		--Debug menu
		disableGameOver=0,--{ 0-1 } -- Disable game over
		disableOutOfBoundsChecks=0,--{ 0-1 } -- Disable out of bounds checks
		--Misc menu
		disableCommonRadio=0,--{ 0-1 } -- Disable common radio warnings
		avatar_enableGenderSelect=0,--{ 0-1 } -- Enable gender select
		--Time scale menu
		speedCamContinueTime=10,--{ 0-1000 } -- TSM length (seconds)
		speedCamWorldTimeScale=0.3,--{ 0-100 } -- TSM world time scale
		speedCamPlayerTimeScale=1,--{ 0-100 } -- TSM player time scale
		speedCamNoDustEffect=0,--{ 0-1 } -- No screen effect
		clockTimeScale=15,--{ 1-10000 } -- Clock time scale
		--dustControllerMenu
		dust_enableController=0,--{ 0-1 } -- 
		dust_requireOxygenMask=1,--{ 0-1 } -- 
		dust_wallVisible=1,--{ 0-1 } -- 
		dust_forceWeather="NONE",--{ NONE, FOGGY, SUNNY, RAINY, SANDSTORM } -- 
		dust_fogDensity=0,--{ 0-1 } -- 
		dust_fogType="NORMAL",--{ NORMAL, PARASITE, EERIE } -- 
		--gearMenu
		gear_Helmet=0,--{ 0-1 } -- 
		gear_Arm=0,--{ 0-1 } -- 
		gear_UpperBody=0,--{ 0-1 } -- 
		gear_LowerBody=0,--{ 0-1 } -- 
		gear_Inner=0,--{ 0-1 } -- 
	}
}


return this