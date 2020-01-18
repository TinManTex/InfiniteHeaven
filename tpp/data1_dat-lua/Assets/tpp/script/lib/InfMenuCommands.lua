-- DOBUILD: 1

local this={}
--tex lines kinda blurry between Commands and Ivars, currently commands arent saved/have no gvar associated
--NOTE: tablesetup at end sets up every table in this with an OnChange as a menu command

--menu menu items
this.menuOffItem={
  OnChange=function()
    InfMenu.MenuOff()
    InfMenu.currentIndex=1
  end,
}
this.resetSettingsItem={
  OnChange=function()
    InfMenu.ResetSettingsDisplay()
    InfMenu.MenuOff()
  end,
}
this.resetAllSettingsItem={
  OnChange=function()
    InfMenu.PrintLangId"setting_all_defaults"
    InfMenu.ResetSettings()
    InfMenu.MenuOff()
  end,
}
this.goBackItem={
  settingNames="set_goBackItem",
  OnChange=function()
    InfMenu.GoBackCurrent()
  end,
}

--commands
this.showPositionItem={
  OnChange=function()
    TppUiCommand.AnnounceLogView(string.format("%.2f,%.2f,%.2f | %.2f",vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerRotY))
  end,
}

this.showMissionCodeItem={
  OnChange=function()
    TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--ADDLANG
  end,
}

this.showMbEquipGradeItem={
  OnChange=function()
    local soldierGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local infGrade = InfMain.GetMbsClusterSecuritySoldierEquipGrade()
    TppUiCommand.AnnounceLogView("Security Grade: "..soldierGrade)--ADDLANG
    TppUiCommand.AnnounceLogView("Inf Grade: "..soldierGrade)--ADDLANG
  end,
}

this.showLangCodeItem={
  OnChange=function()
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    TppUiCommand.AnnounceLogView(InfMenu.LangString"language_code"..": "..languageCode)
  end,
}

this.showQuietReunionMissionCountItem={
  OnChange=function()
    TppUiCommand.AnnounceLogView("quietReunionMissionCount: "..gvars.str_quietReunionMissionCount)
  end,
}

this.loadMissionItem={
  OnChange=function()
    local settingStr=Ivars.manualMissionCode.settings[gvars.manualMissionCode+1]
    InfMenu.DebugPrint("TppMission.Load "..settingStr)
    --TppMission.Load( tonumber(settingStr), vars.missionCode, { showLoadingTips = false } )
    --TppMission.RequestLoad(tonumber(settingStr),vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
    --TppMission.RequestLoad(10036,vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
    gvars.mis_nextMissionCodeForMissionClear=tonumber(settingStr)
    mvars.mis_showLoadingTipsOnMissionFinalize=false
    --mvars.heli_missionStartRoute
    --mvars.mis_nextLayoutCode
    --mvars.mis_nextClusterId
    --mvars.mis_ignoreMtbsLoadLocationForce
   
    TppMission.ExecuteMissionFinalize()
  end,
}

--[[CULL
this.giveOgrePoint={
  OnChange=function(self)
    local ogrePointChange=Ivars.ogrePointChange.setting
    if ogrePointChange > 0 then
      InfMenu.Print(InfMenu.LangString("adding_ogre_points"))--DEBUGNOW ADDLANG
    elseif ogrePointChange < 0 then
      InfMenu.Print(InfMenu.LangString("subtracting_ogre_points"))--DEBUGNOW ADDLANG
    end
    TppHero.SetOgrePoint(ogrePointChange) 
  end,
}--]]

this.printCurrentAppearanceItem={
  OnChange=function()
    InfMenu.Print("playerType: " .. tostring(vars.playerType))
    InfMenu.Print("playerCamoType: " .. tostring(vars.playerCamoType))
    InfMenu.Print("playerPartsType: " .. tostring(vars.playerPartsType))
    InfMenu.Print("playerFaceEquipId: " .. tostring(vars.playerFaceEquipId))
    InfMenu.Print("playerFaceId: " .. tostring(vars.playerFaceId))
  end,
}

this.DEBUG_ShowRevengeConfigItem={
  OnChange=function()
    --InfMenu.DebugPrint("RevRandomValue: "..gvars.rev_revengeRandomValue)
    InfMenu.DebugPrint("RevengeType:")
    local revengeType=InfInspect.Inspect(mvars.revenge_revengeType)
    InfMenu.DebugPrint(revengeType)  
  
    InfMenu.DebugPrint("RevengeConfig:")
    local revengeConfig=InfInspect.Inspect(mvars.revenge_revengeConfig)
    InfMenu.DebugPrint(revengeConfig)
  end,
}

this.DEBUG_PrintSoldierDefineItem={
  OnChange=function()
    InfMenu.DebugPrint("SoldierDefine:")
    local soldierDefine=InfInspect.Inspect(mvars.ene_soldierDefine)
    InfMenu.DebugPrint(soldierDefine)  
  end,
}

this.DEBUG_ChangePhaseItem={
  OnChange=function()
    InfMenu.DebugPrint("Changephase b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.ChangePhase(cpName,gvars.maxPhase)
    end
    InfMenu.DebugPrint("Changephase e")
  end
}

this.DEBUG_KeepPhaseOnItem={
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOnItem b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.SetKeepAlert(cpName,true)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOnItem e")
  end
}

this.DEBUG_KeepPhaseOffItem={
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOffItem b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do      
      InfMain.SetKeepAlert(cpName,false)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOffItem e")
  end
}

this.printPlayerPhase={
  OnChange=function()
    InfMenu.DebugPrint("vars.playerPhase=".. vars.playerPhase ..":".. Ivars.phaseSettings[vars.playerPhase+1])
  end,
}

this.DEBUG_SetPlayerPhaseToIvar={
  OnChange=function()
    vars.playerPhase=gvars.maxPhase
  end,
}

this.DEBUG_ShowPhaseEnums={
  OnChange=function()
    for n, phaseName in ipairs(Ivars.maxPhase.settings) do
      InfMenu.DebugPrint(phaseName..":".. Ivars.maxPhase.settingsTable[n])
    end
  end,
}


this.DEBUG_Item2={
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
  OnChange=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")--pretty sure this is disable
    --TppUiStatusManager.ClearStatus"AnnounceLog"
  end,
}

this.warpPlayerCommand={
  OnChange=function()
   --[[ local playerId={type="TppPlayer2",index=0}
    local position=Vector3(9,.8,-42.5)
    GameObject.SendCommand(playerId,{id="Warp",position=position})--]]
    
    --local pos={8.647,.8,-28.748}
    --local rotY=-25
    --pos,rotY=mtbs_cluster.GetPosAndRotY("Medical","plnt0",pos,rotY)
    local rotY=0
    --local pos={9,.8,-42.5}--command helipad
    local pos={-139,-3.20,-975}
    
    
    TppPlayer.Warp{pos=pos,rotY=rotY}
    --Player.RequestToSetCameraRotation{rotX=0,rotY=rotY}
    
    --TppPlayer.SetInitialPosition(pos,rotY)
  end,
}

this.returnQuietItem={
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
  OnChange=function()
    Ivars.revengeMode:Set(0)
    TppRevenge.ResetRevenge()
    TppRevenge._SetUiParameters()
    InfMenu.PrintLangId("revenge_reset")
  end,
}

--game progression unlocks

this.unlockPlayableAvatarItem={
  OnChange=function()
    if vars.isAvatarPlayerEnable==1 then
      InfMenu.PrintLangId"allready_unlocked"
    else
      vars.isAvatarPlayerEnable=1
    end
  end,
}
this.unlockWeaponCustomizationItem={
  OnChange=function()
    if vars.mbmMasterGunsmithSkill==1 then
      InfMenu.PrintLangId"allready_unlocked"
    else
      vars.mbmMasterGunsmithSkill=1
    end
  end,
}

--TABLESETUP: MenuCommands
local IsTable=Tpp.IsTypeTable
local switchRange={max=1,min=0,increment=1}
for name,item in pairs(this) do
  if IsTable(item) then
    if item.OnChange then--TYPEID
      item.name=name
      item.default=item.default or 0
      item.setting=item.default
      item.range=item.range or switchRange
      item.settingNames=item.settingNames or "set_do"
    end
  end
end

return this