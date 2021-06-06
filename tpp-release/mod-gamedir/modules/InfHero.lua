--InfHero.lua
--Ivars and commands in this module are in playerSettingsMenu
--TODO: there's a couple of calls to SetHeroicPoint directly (for mission clear and abort), and SetOgrePoint that I'm missing by only modding SetAndAnnounceHeroicOgrePoint
local this={}

this.registerIvars={
  "hero_dontSubtractHeroPoints",  
  "hero_dontAddOgrePoints",
  "hero_heroPointsSubstractOgrePoints",
}--registerIvars

this.hero_dontSubtractHeroPoints={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hero_dontAddOgrePoints={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hero_heroPointsSubstractOgrePoints={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.ogrePointChange=90000
--tex see https://www.gamefaqs.com/boards/718564-metal-gear-solid-v-the-phantom-pain/72466130 for breakdown of the demon points levels.
this.SetDemon=function()
  --tex why aren't I using this again? not usable in tpp release build?
  --TppMotherBaseManagement.SetOgrePoint{ogrePoint=99999999}

  TppHero.SetOgrePoint(this.ogrePointChange)
  InfMenu.Print("-"..this.ogrePointChange .. InfLangProc.LangString"set_demon")
end
this.RemoveDemon=function()
  --TppMotherBaseManagement.SetOgrePoint{ogrePoint=1}
  --TppMotherBaseManagement.SubOgrePoint{ogrePoint=-999999999}
  TppHero.SetOgrePoint(-this.ogrePointChange)
  InfMenu.Print(this.ogrePointChange .. InfLangProc.LangString"removed_demon")
end

this.langStrings={
  eng={
    ogrePointChange="Set demon snake",
    ogrePointChangeSettings={"Default","Normal","Demon"},
    setDemon="Add demon points",
    set_demon=" demon points subtracted, visual will refresh on mission start or retry command.",
    removeDemon="Subtract demon points",
    removed_demon=" demon points subtracted, visual should refresh on mission start or retry command.",
    hero_dontSubtractHeroPoints="Don't subtract hero points",  
    hero_dontAddOgrePoints="Don't add demon points",
    hero_heroPointsSubstractOgrePoints="Hero points subtract demon points",
  },
  help={
    eng={
      setDemon="Adds 999999 points to demon score",--SYNC
      removeDemon="Subtracts 999999 points from demon score",--SYNC
      hero_dontSubtractHeroPoints="Actions that usually subtract hero points don't.",  
      hero_dontAddOgrePoints="Actions that usually add demon points don't.",
      hero_heroPointsSubstractOgrePoints="Actions that add hero points subtract the same amount of demon points",
    },
  },
}--langStrings

return this