--InfHostage.lua WIP
local this={}

--LOCALOPT
local InfMain=InfMain
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand

this.debugModule=false

this.numHostages=4--SYNC num locators

this.hostageNames=InfLookup.GenerateNameList("ih_hostage_%04d",this.numHostages)

this.packages={
  afgh={
    "/Assets/tpp/pack/mission2/ih/ih_hostage_prs3.fpk",
    "/Assets/tpp/pack/mission2/ih/ih_hostage_loc.fpk",
  },
  mafr={
    "/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
    "/Assets/tpp/pack/mission2/ih/ih_hostage_prs6_def.fpk",
    "/Assets/tpp/pack/mission2/ih/ih_hostage_loc.fpk",
  }
}

function this.AddMissionPacks(missionCode,packPaths)
  if not Ivars.enableWildCardHostageFREE:EnabledForMission() then
    return
  end

  local locationName=InfUtil.GetLocationName()
  for i,packpath in ipairs(this.packages[locationName])do
    packPaths[#packPaths+1]=packpath
  end
end

function this.PreMissionLoad(missionCode,currentMissionId)
  if not Ivars.enableWildCardHostageFREE:EnabledForMission(missionCode) then
    return
  end

  local settings={
    {type="hostage",name="ih_hostage_0000",faceId="female"},
    {type="hostage",name="ih_hostage_0001",faceId="female"},
    {type="hostage",name="ih_hostage_0002",faceId="female"},
    {type="hostage",name="ih_hostage_0003",faceId="female"},
  }
  TppEneFova.AddUniqueSettingPackage(settings)
end

function this.SetUpEnemy(missionTable)
  if not Ivars.enableWildCardHostageFREE:EnabledForMission() then
    return
  end

  InfMain.RandomSetToLevelSeed()

--  TppHostage2.SetHostageType{
--    gameObjectType="TppHostage2",
--    hostageType="NoStand",
--  }

  for i,hostageName in ipairs(this.hostageNames)do
    local hostageId=GetGameObjectId(hostageName)
    if hostageId==NULL_ID then
    else
      InfNPC.RegenerateStaffParams(hostageId)

      local voices={
        "hostage_a",
        "hostage_b",
        "hostage_c",
        "hostage_d",
      }
      local rndVoice=voices[math.random(#voices)]
      GameObject.SendCommand(hostageId,{id="SetVoiceType",voiceType=rndVoice})
      --REF
      --"pashto"
      --          local defaultLanguages={
      --            afgh="russian",
      --            mafr="afrikaans",
      --          }
      --          local locationName=InfUtil.GetLocationName()
      --          local langType=hostageInfo.langType or defaultLanguages[locationName] or "english"
      --          local isFemale=GameObject.SendCommand(gameId,{id="isFemale"})
      --          if isFemale then
      --            langType="english"
      --          end
      local langType="english"
      GameObject.SendCommand(hostageId,{id="SetLangType",langType=langType})

      
      --      local hostagePos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
      --          local hostagePos=Vector3(2,1,4)
      --
       --      local command={id="Warp",degRotationY=vars.playerRotY,position=hostagePos)}
      --      GameObject.SendCommand(hostageId,command)-
    end
  end

  local jeepsWithSeats={}

  local enemyTable=missionTable.enemy
  local soldierDefine=enemyTable.soldierDefine
  local patrolVehicleInfo=InfVehicle.inf_patrolVehicleInfo
  for cpName,cpDefine in pairs(soldierDefine)do
    local vehicleName=cpDefine.lrrpVehicle
    if vehicleName then
      if InfVehicle.inf_patrolVehicleInfo then
        local vehicleDef=patrolVehicleInfo[vehicleName]
        if vehicleDef then
          if vehicleDef.baseType=="LIGHT_VEHICLE" then--jeep
--            InfCore.Log("InfHostage.SetupEnemy found jeep")--DEBUG
--            InfCore.PrintInspect(cpDefine)--DEBUG
            local numSeats=InfNPC.GetNumSeats(vehicleName)

            if #cpDefine<numSeats then
              jeepsWithSeats[#jeepsWithSeats+1]=vehicleName
            end
          end
        end
      end
    end
  end

  if this.debugModule then
    InfCore.Log"jeepsWithSeats:"
    InfCore.PrintInspect(jeepsWithSeats)
  end

  for i,hostageName in ipairs(this.hostageNames)do
    if #jeepsWithSeats==0 then
      break
    end

    local hostageId=GetGameObjectId(hostageName)
    if hostageId==NULL_ID then
    else
      local vehicleName=InfUtil.GetRandomPool(jeepsWithSeats)
      if vehicleName==nil then
      else
        InfCore.Log("InfHostage.SetupEnemy: Adding "..hostageName.." to "..vehicleName)

        local vehicleId=GetGameObjectId(vehicleName)

         --TppEnemy.RegistHoldRecoveredState(vehicleName)

        local command={
          id="SetHostage2Flag",
          flag="unlocked",
          on=true,
        }
        SendCommand(hostageId,command)

        local vehiclePos=SendCommand(vehicleId,{id="GetPosition"})
        --InfCore.Log(vehiclePos:GetX()..","..vehiclePos:GetY()..","..vehiclePos:GetZ())--DEBUG

        local vehiclePos=Vector3(vehiclePos:GetX(),vehiclePos:GetY()+2,vehiclePos:GetZ())
        local command={id="Warp",position=vehiclePos,degRotationY=0}
        SendCommand(hostageId,command)
        --tex TODO no go for some reason, think it requires route
        local setVehicle={id="SetRelativeVehicle",targetId=vehicleId,rideFromBeginning=true}
        --SendCommand(hostageId,setVehicle)
      end
    end
  end

  InfMain.RandomResetToOsTime()
end

function this.DEBUG_WarpHostagesToPlayerPos()--
    local hostageNames={
      --"hos_quest_0000",
      "ih_hostage_0000",
      "ih_hostage_0001",
      "ih_hostage_0002",
      "ih_hostage_0003",
    }

    for i,hostageName in ipairs(hostageNames)do
  local hostageObject=GetGameObjectId(hostageName)

      if hostageObject==NULL_ID then
        InfCore.Log(hostageName.."==NULL_ID",true)
      else
        local playerPos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
        local command={id="Warp",degRotationY=vars.playerRotY,position=playerPos}
        GameObject.SendCommand(hostageObject,command)
      end
    end
end

function this.DEBUG_SomeHostageShiz()
 local hostageNames={
      --"hos_quest_0000",
      "ih_hostage_0000",
      "ih_hostage_0001",
      "ih_hostage_0002",
      "ih_hostage_0003",
    }
    for i,hostageName in ipairs(hostageNames)do
      local hostageId=GetGameObjectId(hostageName)
      
      
      TppEnemy.RegistHoldRecoveredState(hostageName)
      
      
      local command={
        id="SetHostage2Flag",
        flag="unlocked",
        on=true,
      }
      SendCommand(hostageId,command)
      --
      --                 TppHostage2.SetHostageType{
      --      gameObjectType  = "TppHostage2",
      --      hostageType   = "Mob",
      --    }


      --     GameObject.SendCommand( hostageId, { id = "SetFollowed", enable = true } )
      --     local command={id="SetHostage2Flag",flag="commonNpc",on=true}
      --     GameObject.SendCommand( hostageId,command)

      local command = { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_FLEE }
      SendCommand(hostageId,command)


      local vehicleId=GetGameObjectId("veh_lv_0002")
      local setVehicle={id="SetRelativeVehicle",targetId=vehicleId,rideFromBeginning=true}
      SendCommand(hostageId,setVehicle)
    end
end

return this
