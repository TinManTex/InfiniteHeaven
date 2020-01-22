-- DOBUILD: 1
-- DEP Ivars
local this={}

--this.hooks={
--  VarRestoreOnMissionStart=function()
--    TppSave.VarRestoreOnMissionStart()
--    --Ivars.OnLoadVarsFromSlot()--post-hook
--      local debugSplash=SplashScreen.Create("ooop","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--      SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
--      TppUiCommand.AnnounceLogView"Dooop"
--  end,
--  VarRestoreOnContinueFromCheckPoint=function()
--    TppSave.VarRestoreOnContinueFromCheckPoint()
--    --Ivars.OnLoadVarsFromSlot()--post-hook
--      local debugSplash=SplashScreen.Create("ooop","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--      SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
--      TppUiCommand.AnnounceLogView"Dooop"
--  end,
--}
--
--for name,hookFunction in ipairs(this.hooks)do
--  this[name]=TppSave[name]--tex save original function ref
--  TppSave[name]=hookFunction--tex override
--end

this.VarRestoreOnMissionStart=TppSave.VarRestoreOnMissionStart
this.VarRestoreOnContinueFromCheckPoint=TppSave.VarRestoreOnContinueFromCheckPoint

TppSave.VarRestoreOnMissionStart=function()
  this.VarRestoreOnMissionStart()
  Ivars.OnLoadVarsFromSlot()
end

TppSave.VarRestoreOnContinueFromCheckPoint=function()
  this.VarRestoreOnContinueFromCheckPoint()
  Ivars.OnLoadVarsFromSlot()
end

return this