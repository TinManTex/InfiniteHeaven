-- InfUAV.lua
--DEBUGWIP
local this={}

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_uav.fpk",--DEBUGWIP
  "/Assets/tpp/pack/mission2/ih/ih_uav_ly013_set.fpk",--DEBUGWIP
}

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode~=30010 and missionCode~=30020 and missionCode~=30050 then--DEBUGWIP
    --  if not Ivars.enableUAVMB:EnabledForMission() then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

--WIP
function this.SetupUAV()
  local objectName="ih_uav_0000"
  local gameId=GameObject.GetGameObjectId(objectName)

  if gameId==GameObject.NULL_ID then
    InfCore.Log"gameId==GameObject.NULL_ID"
  else
    InfCore.Log"found uav gameobject"
    local route="rt_heli_quest_0000"--"rt_hltx_ly003_cl00"
    --route="ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0000"
    local developLevel=0
    developLevel=TppUav.DEVELOP_LEVEL_LMG_2

    SendCommand( gameId, {id = "SetEnabled", enabled = true } )
    SendCommand( gameId, {id = "SetPatrolRoute", route=route } )
    SendCommand( gameId, {id = "SetCombatRoute", route=route } )
    --local cp=mtbs_enemy.cpNameDefine
    local cp="mafr_flowStation_cp"
    SendCommand( gameId, {id = "SetCommandPost", cp=cp } )
    SendCommand( gameId, {id = "WarpToNearestPatrolRouteNode"} )
    SendCommand( gameId, {id = "SetDevelopLevel", developLevel = developLevel } )
  end

end

return this
