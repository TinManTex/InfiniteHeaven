local this={
  {
    title="Infinite Heaven features",
    {link="https://www.youtube.com/playlist?list=PLSKlVTXYh6F_fmq0u9UmN2XTnfdfcHKJF","YouTube playlist demonstrating many features"},
    "All options in Infinite Heaven start set to game defaults and can be adjusted in the Infinite Heaven menus.",
  },
  {
    title="Discrete features",
    {
      featureDescription="Quick menu commands.",
      featureHelp="(Must be enabled via option in IH system menu, or by editing InfQuickMenuDefs.lua)\r\nShortcut key combinations to activate IH features. See Infinite Heaven readme or InfQuickMenuDefs.lua in mod folder."
    },
    {
      featureDescription="Settings save file.",
      featureHelp="IH writes its settings to ih_save.lua in the MGS_TPP\mod\saves folder.\r\nWhile the file is editable, editing an inMission save is likely to cause issues."
    },
    {
      featureDescription="Profiles.",
      featureHelp="Editable lists of options as an alternative to using the in game IH menu, see the \\mod\\profiles folder in your MGS_TPP game folder."
    },
    {
      featureDescription="Reload lua scripts in MGS_TPP without exiting game.",
      featureHelp="Hold <Stance>,<Action>,<Ready weapon>,<Binoculars> (Can also use the loadExternalModules command in the Debug menu)"
    },
    {
      featureDescription="IHExt overlay",
      featureHelp="IHExt is an overlay app that Infinite Heaven can launch to act as the menu when MGSV is in Borderless Fullscreen mode.\r\nThe normal IH activation and navigation of the menu remains the same, but if you alt-tab to the overlay you can use mouse and keyboard to more quickly navigate and change settings.\r\nEnable via the IH System menu.\r\nSource can be found at https://github.com/TinManTex/IHExt/"
    },
  },
  {
    title="Menu, Options and Settings",
[[Basic terms used in the Infinite Heaven menu:
[Option] : [Setting(s)] ]],
  },
}
return this
