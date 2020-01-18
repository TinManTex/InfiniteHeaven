-- DOBUILD: 1
--tex lines kinda blurry between Commands and Ivars
local this={}

this.switchRange={max=1,min=0,increment=1}

--menu menu items
this.menuOffItem={
  range=this.switchRange,
  settingNames="set_menu_off",
  OnChange=function()
    InfMenu.MenuOff()
    InfMenu.currentIndex=1
  end,
}
this.resetSettingsItem={
  range=this.switchRange,
  settingNames="set_menu_reset",
  OnChange=function()
    InfMenu.ResetSettingsDisplay()
    InfMenu.MenuOff()
  end,
}
this.resetAllSettingsItem={
  range=this.switchRange,
  settingNames="set_menu_reset",
  OnChange=function()
    InfMenu.PrintLangId"setting_all_defaults"
    InfMenu.ResetSettings()
    InfMenu.MenuOff()
  end,
}
this.goBackItem={
  range=this.switchRange,
  settingNames="set_goBackItem",
  OnChange=function()
    InfMenu.GoBackCurrent()
  end,
}

--menu items
this.showPositionItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView(string.format("%.2f,%.2f,%.2f | %.2f",vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerRotY))
  end,
}

this.showMissionCodeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--ADDLANG
  end,
}

this.showMbEquipGradeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    local soldierGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local infGrade = InfMain.GetMbsClusterSecuritySoldierEquipGrade()
    TppUiCommand.AnnounceLogView("Security Grade: "..soldierGrade)--ADDLANG
    TppUiCommand.AnnounceLogView("Inf Grade: "..soldierGrade)--ADDLANG
  end,
}

this.showLangCodeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    TppUiCommand.AnnounceLogView(InfMenu.LangString"language_code"..": "..languageCode)
  end,
}

this.showQuietReunionMissionCountItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView("quietReunionMissionCount: "..gvars.str_quietReunionMissionCount)
  end,
}

--[[--DEBUGNOW
this.giveOgrePoint={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function(self)
    local ogrePointChange=Ivars.ogrePointChange.setting
    if ogrePointChange > 0 then
      InfMenu.Print(InfMenu.LangString("adding_ogre_points"))--DEBUGNOW ADDLANG
    elseif ogrePointChange < 0 then
      InfMenu.Print(InfMenu.LangString("subtracting_ogre_points"))--DEBUGNOW ADDLANG
    end
    TppHero.SetOgrePoint(ogrePointChange) 
  end,
}
--]]
this.printCurrentAppearanceItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.Print("playerType: " .. tostring(vars.playerType))
    InfMenu.Print("playerCamoType: " .. tostring(vars.playerCamoType))
    InfMenu.Print("playerPartsType: " .. tostring(vars.playerPartsType))
    InfMenu.Print("playerFaceEquipId: " .. tostring(vars.playerFaceEquipId))
    InfMenu.Print("playerFaceId: " .. tostring(vars.playerFaceId))
  end,
}

this.DEBUG_ShowRevengeConfigItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("RevRandomValue): "..gvars.rev_revengeRandomValue)
    InfMenu.DebugPrint("RevengeType:")
    local revengeType=InfInspect.Inspect(mvars.revenge_revengeType)
    InfMenu.DebugPrint(revengeType)  
  
    InfMenu.DebugPrint("RevengeConfig:")
    local revengeConfig=InfInspect.Inspect(mvars.revenge_revengeConfig)
    InfMenu.DebugPrint(revengeConfig)
  end,
}


local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID

this.DEBUG_ChangePhaseItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("Changephase b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.ChangePhase(cpName,gvars.maxPhase)
    end
    InfMenu.DebugPrint("Changephase e")
  end
  
  --[[CULL
       for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
    else   local phase=Ivars.maxPhase.settingsTable[gvars.maxPhase+1]
      local command={id="SetPhase",phase=phase}
      GameObject.SendCommand(cpId,command)
  --]]
}

this.DEBUG_KeepPhaseOnItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOnItem b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.SetKeepAlert(cpName,true)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOnItem e")
  end
}

this.DEBUG_KeepPhaseOffItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOffItem b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.SetKeepAlert(cpName,false)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOffItem e")
  end
}

this.printPlayerPhase={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("vars.playerPhase=".. vars.playerPhase ..":".. Ivars.phaseSettings[vars.playerPhase+1])
  end,
}

this.DEBUG_SetPlayerPhaseToIvar={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    vars.playerPhase=gvars.maxPhase
  end,
}

this.DEBUG_ShowPhaseEnums={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    for n, phaseName in ipairs(Ivars.maxPhase.settings) do
      InfMenu.DebugPrint(phaseName..":".. Ivars.maxPhase.settingsTable[n])
    end
  end,
}


this.DEBUG_Item2={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    
    
    InfMenu.DebugPrint("EnemyTypes:")
    InfMenu.DebugPrint("TYPE_DD:"..EnemyType.TYPE_DD)
    InfMenu.DebugPrint("TYPE_SKULL:"..EnemyType.TYPE_SKULL )
    InfMenu.DebugPrint("TYPE_SOVIET:"..EnemyType.TYPE_SOVIET)
    InfMenu.DebugPrint("TYPE_PF:"..EnemyType.TYPE_PF )
    InfMenu.DebugPrint("TYPE_CHILD:".. EnemyType.TYPE_CHILD )
    --InfMenu.DebugPrint("bef")
   -- local strout=InfInspect.Inspect(gvars.soldierTypeForced)
   -- InfMenu.DebugPrint(strout)
   -- InfMenu.DebugPrint("aft")
  end,
}

this.DEBUG_ClearAnnounceLogItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")--pretty sure this is disable
    --TppUiStatusManager.ClearStatus"AnnounceLog"
  end,
}

this.returnQuietItem={
  range=this.switchRange,
  settingNames="set_quiet_return",
  OnChange=function()
    if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
      InfMenu.PrintLangId"quiet_already_returned"--"Quiet has already returned."
    else
      --InfPatch.QuietReturn()
      TppStory.RequestReunionQuiet()
    end
  end,
}

this.resetRevenge={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    Ivars.revengeMode:Set(0)
    TppRevenge.ResetRevenge()
    TppRevenge._SetUiParameters()
    InfMenu.PrintLangId("revenge_reset")
  end,
}

--TABLESETUP: MenuCommands
local IsTable=Tpp.IsTypeTable
for name,item in pairs(this) do
  if IsTable(item) then   
    if item.range or item.settings then
      item.name=name
      item.default=item.default or 0
      if item.options then
        item.parent=nil
      end
    end
  end
end

return this