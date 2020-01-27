--ssd MockFoxEngineGame.lua
--manualy created game specific subset of MockFoxEngine.lua
local this={}
--DEBUGNOW figure out why some functions arent being picked up for mockmodules (see TODOs below)

--tex TODO: figure out why this isn't picked up for mockmodules (from TppVarInit)
BaseDefenseManager={}
BaseDefenseManager.Reset=function()end

Gimmick={}
Gimmick.GetDataSetCode=function(encodeString)
  --TODO VERIFY, just guessing that its just PathFileNameCode32
  if HashingGzsTool then--tex MoonSharp userdata that redirects to GzsTool.Core Hashing
    return HashingGzsTool.PathFileNameCode32(encodeString)
  else
    return encodeString
  end
end

InvitationManagerController={}
--tex TODO: figure out why this isn't picked up for mockmodules (from TppMission)
InvitationManagerController.IsGoingCoopMission=function()end

Mission={}
--tex TODO: figure out why this isn't picked up for mockmodules
Mission.IsReadyGameSequence=function()end
--tex TODO: figure out why this isn't picked up for mockmodules (from TppGVars)
Mission.RegisterUserGvars=function()end
--tex TODO: figure out why this isn't picked up for mockmodules (from TppStory)
Mission.RequestOpenMissionToServer=function()end

--tex TODO: figure out why this isn't picked up for mockmodules (from TppUI)
SsdFadeManager={}
SsdFadeManager.RequestFadeIn=function()end
SsdFadeManager.RequestFadeOut=function()end

SsdNpc={}
--tex TODO: figure out why this isn't picked up for mockmodules
SsdNpc.GetGameObjectPackFilePathsFromPartsType=function()
return {}
end

return this