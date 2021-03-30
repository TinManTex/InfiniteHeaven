--InfMission.lua
-- tex implements various mission selection options
-- and IH location and mission addon systems

--REF location addon module <GameDir>\mod\locations\ >
--reference of all entries rather than a sane example
--local this={
--  description="Jade Forest",
--  locationName="AFC0",
--  locationId=101,
--  packs={"/Assets/mgo/pack/location/afc0/afc0.fpk"},-- TppMissionList.locationPackTable entry
--  locationMapParams={-- \Assets\tpp\pack\mbdvc\mb_dvc_top.fpkd \ mbdvc_map_location_parameter.lua entry
--    stageSize=556*1,
--    scrollMaxLeftUpPosition=Vector3(-255,0,-275),
--    scrollMaxRightDownPosition=Vector3(255,0,275),
--    highZoomScale=2,
--    middleZoomScale=1,
--    lowZoomScale=.5,
--    locationNameLangId="mgo_idt_Jungle",
--    stageRotate=0,
--    heightMapTexturePath="/Assets/mgo/ui/texture/map/afc0/afc0_iDroid_clp.ftex",
--    photoRealMapTexturePath="/Assets/mgo/ui/texture/map/afc0/afc0_jungle_sat_clp.ftex"
--  },
--  globalLocationMapParams={ --  see \Assets\tpp\pack\mbdvc\mb_dvc_top.fpkd \ mbdvc_map_location_parameter.lua GetGlobalLocationParameter
--    sectionFuncRankForDustBox = 4, 
--    sectionFuncRankForToilet  = 4, 
--    sectionFuncRankForCrack   = 6, 
--    isSpySearchEnable = true,
--    isHerbSearchEnable = true,
--    
--    spySearchRadiusMeter = {  40.0, 40.0, 35.0, 30.0, 25.0, 20.0, 15.0, 10.0, },
--    spySearchIntervalSec = {  420.0,  420.0,  360.0,  300.0,  240.0,  180.0,  120.0,  60.0, },
--    herbSearchRadiusMeter = { 0.0,  0.0,  10.0, 15.0, 20.0, 25.0, 30.0, 35.0, },
--  },
--  questAreas={--tex defines quest areas for location, see TppQuestList.questList .
--    {
--      areaName="tent",
--      --xMin,yMin,xMax,yMax, in smallblock coords. see Tpp.CheckBlockArea. debug menu ShowPosition will log GetCurrentStageSmallBlockIndex, or you can use whatever block visualisation in unity you have
--      loadArea={116,134,131,152},--load is the larger area, so -1 minx, -1miny, +1maxx,+1maxy vs active
--      activeArea={117,135,130,151},
--      invokeArea={117,135,130,151},--same size as active, but keeping here to stay same implementation as vanilla
--    },
--  },
--  requestTppBuddy2BlockController=true,--tex not sure, see TppLocation.SetBuddyBlock and its caller TppMissionList.GetLocationPackagePath
--}
--
--return this
--<

--REF mission addon module aka missionInfo, <GameDir>\mod\missions\ >
--reference of all entries rather than a sane example
--local this={
--  description="Jade Forest",-- Description for IH menu.
--  missionCode=12020,
--  location="AFC0",
--  packs=function(missionCode) -- TppMissionList.missionPackTable entry, can be table of fpk names or function of packlist adding calls.
--    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
--    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s13000/s13000_area.fpk"
--  end,
--  fovaSetupFunc=function(locationName,missionId)-- TppEneFova.fovaSetupFuncs entry
--    local faces={}
--    table.insert(faces,{TppEnemyFaceId.dds_balaclava2,10,10,0})
--    table.insert(faces,{TppEnemyFaceId.dds_balaclava6,2,2,0})
--    table.insert(faces,{TppEnemyFaceId.dds_balaclava7,2,2,0})
--
--    TppSoldierFace.OverwriteMissionFovaData{face=faces}}
--  end,
--  enableOOB=true,-- Enable the mission out of bound system
--  startPos={-11.788,8.483,165.559},--NO_HELICOPTER_MISSION_START_POSITION entry -  player spawn pos for non heli ride missions
--  missionGuaranteeGMP=120000, --TppResult.MISSION_GUARANTEE_GMP - base gmp for mission on mission clear
--  missionTaskList={0,2,3,4,5,6},--TppResult.MISSION_TASK_LIST - Haven't worked out exactly what this is
--  noArmorForMission=true,--TppEneFova.noArmorForMission - disallow heavy armor in the mission
--  missionArmorType={TppDefine.AFR_ARMOR.TYPE_RC},--TppEneFova.missionArmorType - Armor type for pfs in mafr
--  missionHostageInfos={count=1,lang=RENlang2,overlap=true},--TppEneFova.missionHostageInfos - for the mission hostage generation system
--  orderBoxList = { -- <mission>_sequence.missionStartPosition.orderBoxList -- TODO description
--    "box_s13000_00",
--    "box_s13000_01",
--  },
--  orderBoxBlockList = { "/Assets/tpp/pack/mission2/story/s13000/s13000_order_box.fpk" } --<free roam mission>_orderBoxList.lua TODO description
--  weaponIdTable={-- alternatively a string of the TppEnemy.weaponIdTable ex weaponIdTable="SOVIET_A",   IMPLEMENTATION: GetWeaponIdTable
--    NORMAL={
--      HANDGUN=TppEquip.EQP_WP_East_hg_010,
--      SMG=TppEquip.EQP_WP_East_sm_010,
--      ASSAULT=TppEquip.EQP_WP_East_ar_010,
--      SNIPER=TppEquip.EQP_WP_East_sr_011,
--      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
--      MG=TppEquip.EQP_WP_East_mg_010,
--      MISSILE=TppEquip.EQP_WP_East_ms_010,
--      SHIELD=TppEquip.EQP_SLD_SV
--    },
--  },
--  heliSpaceFlags={-- Sortie/mission prep screen feature flags
--    SkipMissionPreparetion=false,                        -- No sortie prep, like vanilla Mother Base.
--    NoBuddyMenuFromMissionPreparetion=true,              -- No buddy select in the sortie
--    NoVehicleMenuFromMissionPreparetion=true,            -- No vehicle select in the sortie
--    DisableSelectSortieTimeFromMissionPreparetion=true,  -- Only ASAP as deployment time option
--  },
--}
--
--return this
--<
--tex for Validate
local missionInfoFormat={
  description="string",
  missionCode="number",
  location="string",
  --packs={"table","function"},--tex OFF till I make validate support multiple data types for a key
  fovaSetupFunc="function",
  enableOOB="boolean",
  startPos="table",
  missionGuaranteeGMP="number",
  missionTaskList="table",
  noArmorForMission="boolean",
  missionArmorType="table",
  missionHostageInfos="table",
  orderBoxList="table",
  orderBoxBlockList="table",
  --weaponIdTable={"string","table"}
  heliSpaceFlags="table",
}

local heliSpaceFlagNames={
  "SkipMissionPreparetion",
  "NoBuddyMenuFromMissionPreparetion",
  "NoVehicleMenuFromMissionPreparetion",
  "DisableSelectSortieTimeFromMissionPreparetion",
}

local this={}

this.debugModule=true--DEBUGNOW

this.locationInfo={}--locationInfo[locationId]=locationInfo
this.missionInfo={}--missionInfo[missionCode]=missionInfo
this.missionNames={}--tex see LoadMissionDefs
this.missionIds={}--tex used by Ivar loadAddonMission and OpenMissions()
this.missionListSlotIndices={}--tex need it for OpenMissions, setup in RegisterMissions

--tex addon mission added in LoadLibraries,
this.freeMissionForLocation={
  [TppDefine.LOCATION_ID.AFGH]=30010,
  [TppDefine.LOCATION_ID.MAFR]=30020,
--DEBUGNOW the mission<>freemisson functions where it was originally used for don't have MTBS
--OFF [TppDefine.LOCATION_ID.MTBS]=30050,
}
--this.heliMissionForLocation={} --unimplmented, see ReserveMissionClearOnRideOnHelicopter,AbortForRideOnHelicopter, anyting that wants AFGH_HELI etc really . not really needed I think
this.registerIvars={
  "manualMissionCode",
  "manualSequence",
  "loadAddonMission",
  "ihMissionsPercentageCount",
}

this.manualMissionCode={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings={},--DYNAMIC
  OnSelect=function(self)
    self.settingNames=self.settings--DEBUGNOW settingnames?
    IvarProc.SetSettings(self,this.GetMissionCodes())
  end,
  OnActivate=function(self,setting)
    local settingStr=self.settings[setting+1]
    local missionCode=tonumber(settingStr)
    InfCore.Log("manualMissionCode "..settingStr)

    this.LoadMissionManual(missionCode)
  end,
}

this.manualSequence={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  OnSelect=function(self)
    self.settingNames={}
    --tex also mvars.seq_demoSequneceList (a subset)
    for sequenceName,enum in pairs(mvars.seq_sequenceNames)do
      self.settingNames[enum]=sequenceName
    end
    --InfCore.PrintInspect(self.settingNames)--DEBUG
    self.range.max=#self.settingNames-1
  end,
  OnActivate=function(self,setting)
    local settingStr=self.settingNames[setting+1]
    --InfCore.DebugPrint(tostring(settingStr))--DEBUG
    TppSequence.SetNextSequence(settingStr)
  end,
}

this.loadAddonMission={
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings={},
  OnSelect=function(self)
    InfUtil.ClearArray(self.settings)
    for i,missionCode in pairs(InfMission.missionIds)do
      self.settings[#self.settings+1]=tostring(missionCode)
    end
    table.sort(self.settings)
    IvarProc.SetMaxToList(self,self.settings)
  end,
  GetSettingText=function(self,setting)
    if #self.settings==0 then
      return "No addon missions installed"--TODO langid
    end

    local missionCodeStr=self.settings[setting+1]
    local missionCode=tonumber(missionCodeStr)
    local missionInfo=InfMission.missionInfo[missionCode]
    if missionInfo then
      local location=missionInfo.location
      return "["..missionCodeStr.."]["..location.."] "..(missionInfo.description or "")
    else
      return "No missionInfo for "..missionCodeStr --TODO langid
    end
  end,
  OnActivate=function(self,setting)
    if #self.settings==0 then
      return
    end

    local settingStr=self.settings[setting+1]
    local missionCode=tonumber(settingStr)
    InfCore.Log("manualMissionCode "..settingStr)

    this.LoadMissionManual(missionCode)
  end,
}

this.ihMissionsPercentageCount={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function()
    TppMission.SetPlayRecordClearInfo()
  end,
}
--< Ivars

function this.PostModuleReload(prevModule)
  this.locationInfo=prevModule.locationInfo
  this.missionNames=prevModule.missionNames
  this.missionIds=prevModule.missionIds
  this.missionInfo=prevModule.missionInfo
  this.missionListSlotIndices=prevModule.missionListSlotIndices
  this.freeMissionForLocation=prevModule.freeMissionForLocation
end


--WIP
this.femaleFaceIdList={394,351,373,456,463,455,511,502}
this.maleFaceIdList={195,144,214,6,217,83,273,60,87,71,256,201,290,178,102,255,293,165,85,18,228,12,65,134,31,132,161,342,107,274,184,226,153,247,344,242,56,183,54,126,223}

local MAX_REALIZED_COUNT=255--EnemyFova.MAX_REALIZED_COUNT
local fovaSetupFuncs={}
function fovaSetupFuncs.basic(locationName,missionId)
  local faces={}
  local faceCounts={}

  for i,faceId in ipairs(this.maleFaceIdList)do
    if faceCounts[faceId]==nil then
      faceCounts[faceId]=2
    else
      faceCounts[faceId]=faceCounts[faceId]+1
    end
  end
  for i,faceId in ipairs(this.femaleFaceIdList)do
    if faceCounts[faceId]==nil then
      faceCounts[faceId]=2
    else
      faceCounts[faceId]=faceCounts[faceId]+1
    end
  end


  for faceId,faceCount in pairs(faceCounts)do
    table.insert(faces,{faceId,faceCount,faceCount,0})
  end
  table.insert(faces,{623,1,1,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava2,10,10,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava6,2,2,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava7,2,2,0})

  local bodies={
    {146,MAX_REALIZED_COUNT},
  }
  --TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00.parts"}
  TppSoldierFace.OverwriteMissionFovaData{face=faces}--,body=bodies}
end

--this.locationInfo[45].locationMapParams=this.locationMapParams.MBA0--

--REF tpp
--REF from TppDefine RegisterMissionCodeList
--this.missionUiNumbers={
--  [10010]=0,
--  [10020]=1,
--  [10030]=2,
--  [10036]=3,
--  [10043]=4,
--  [10033]=5,
--  [10040]=6,
--  [10041]=7,
--  [10044]=8,
--  [10054]=9,
--  [10052]=10,
--  [10050]=11,
--  [10070]=12,
--  [10080]=13,
--  [10086]=14,
--  [10082]=15,
--  [10090]=16,
--  [10091]=17,
--  [10100]=18,
--  [10195]=19,
--  [10110]=20,
--  [10121]=21,
--  [10115]=22,
--  [10120]=23,
--  [10085]=24,
--  [10200]=25,
--  [10211]=26,
--  [10081]=27,
--  [10130]=28,
--  [10140]=29,
--  [10150]=30,
--  [10151]=31,
--  [10045]=32,
--  [11043]=33,
--  [11054]=34,
--  [10093]=35,
--  [11082]=36,
--  [11090]=37,
--  [10156]=38,
--  [11033]=39,
--  [11050]=40,
--  [10171]=41,
--  [11140]=42,
--  [10240]=43,
--  [11080]=44,
--  [10260]=45,
--  [10280]=46,
--  [11121]=47,
--  [11130]=48,
--  [11044]=49,
--  [11151]=50,
--}
--#51

this.highestUIMission=50--tex vanilla, indexed from 0

--tex Load Location addons
--OUT/SIDE: this.locationInfo
function this.LoadLocationDefs()
  local missionFiles=InfCore.GetFileList(InfCore.files.locations,".lua")
  for i,fileName in ipairs(missionFiles)do
    InfCore.Log("InfMission.LoadLocationsDefs: "..fileName)

    local locationInfo=InfCore.LoadSimpleModule(InfCore.paths.locations,fileName)
    if locationInfo then
      local locationId=locationInfo.locationId
      if not locationId then
        InfCore.Log("WARNING: could not find missionCode on "..fileName)
      else
        if this.locationInfo[locationId] then
          InfCore.Log("WARNING: Existing locationInfo already found for "..locationId)
        end
        this.locationInfo[locationId]=locationInfo
      end
    end
  end
end

--tex Load Mission addons
--OUT/SIDE: this.missionInfo
function this.LoadMissionDefs()
  InfCore.LogFlow("InfMission.LoadMissionDefs")
  local missionNames={}
  local missionsInfo={}

  local missionFiles=InfCore.GetFileList(InfCore.files.missions,".lua")
  for i,fileName in ipairs(missionFiles)do
    InfCore.Log("InfMission.LoadMissionDefs: "..fileName)

    local missionName=InfUtil.StripExt(fileName)
    local missionInfo=InfCore.LoadSimpleModule(InfCore.paths.missions,fileName)
    if missionInfo then
      local missionCode=missionInfo.missionCode--TYPE
      if not missionCode then
        InfCore.Log("WARNING: could not find missionCode on "..fileName)
      else
        missionNames[#missionNames+1]=missionName

        if missionsInfo[missionCode] then
          InfCore.Log("WARNING: Existing missionInfo already found for "..missionCode)
        end
        missionsInfo[missionCode]=missionInfo
      end
    end
  end

  this.missionNames=missionNames
  this.missionInfo=missionsInfo
end

--tex Patch in locations to relevant TPP tables.
--OUT/SIDE: a whole bunch
function this.AddInLocations()
  if next(this.locationInfo)==nil then
    return
  end

  InfCore.Log("InfMission.AddInLocations: Adding locationInfos")
  for locationId,locationInfo in pairs(this.locationInfo)do
    local locationName=locationInfo.locationName
    if not locationName then
      InfCore.Log("WARNING: Could nof find locationName for "..locationId)
    else
      InfCore.Log("Adding location: "..locationName.." "..locationId)
      if TppDefine.LOCATION_ID[locationName] then
        InfCore.Log("WARNING: location already defined "..locationId)
      end
      TppDefine.LOCATION_ID[locationName]=locationId
      TppMissionList.locationPackTable[locationId]=locationInfo.packs

      InfQuest.AddLocationQuestAreas(locationId,locationInfo.questAreas)
    end
  end
  InfCore.LogFlow"Adding to TppLocation.locationIdForName for TppLocation.GetLocationName"
  for locationId,locationInfo in pairs(this.locationInfo)do
    local locationName=locationInfo.locationName
    if locationName then
      TppLocation.locationIdForName[string.lower(locationName)]=locationId
    end
  end
  for locationName,locationId in pairs(TppLocation.locationIdForName)do
    TppLocation.locationNames[locationId]=locationName
  end

  --TppDefine.LOCATION_CHUNK_INDEX_TABLE[location]=Chunkbleh --tex TODO see what requires LOCATION_CHUNK_INDEX_TABLE for addon missions, fallback to some default instead of nil?

  InfUtil.GetLocationName=TppLocation.GetLocationName--tex LEGACY

  if this.debugModule then
    InfCore.PrintInspect(this.locationInfo,"locationInfo")
  end
end

--tex Patch in misssions to relevant TPP tables.TppMissionList.missionPackTable
--OUT/SIDE: a whole bunch
function this.AddInMissions()
  if next(this.missionInfo)==nil then
    return
  end

  InfCore.Log("InfMission.AddInMissions: Adding missionInfos")
  for missionCode,missionInfo in pairs(this.missionInfo)do
    InfCore.Log("Adding mission: "..missionCode)

    if InfCore.Validate(missionInfoFormat,missionInfo,"mission addon for "..missionCode) then
      --tex TODO: expand Validate to validate sub tables

      local missionLocation=TppDefine.LOCATION_ID[missionInfo.location]
      if missionInfo.heliSpaceFlags then
        for flagName,set in pairs(missionInfo.heliSpaceFlags)do
          if type(set)~="boolean" then
            InfCore.Log("InfMission.AddInMissions: WARNING: missionInfo.heliSpaceFlags."..flagName.." should be boolean")
            missionInfo.heliSpaceFlags[flagName]=nil--tex could do fixup, convert 0,1 whatever, either way I like to validate up front rather than slathering code with type guards
          end
        end
      end

      --tex TODO: check it has a valid location

      TppMissionList.missionPackTable[missionCode]=missionInfo.packs

      --tex LOCATION_HAVE_MISSION_LIST is in a pretty bad layout of
      --{<location>={<missioncode>,<missioncode>,...}
      --Given how it's used it should have just been {[missioncode]=<location>,...} or {<location>={[missioncode]=true,...},}
      --Used by TppPackList.GetLocationNameFormMissionCode
      local locationMissions=TppDefine.LOCATION_HAVE_MISSION_LIST[missionInfo.location] or {}
      InfUtil.InsertUniqueInList(locationMissions,missionCode)
      TppDefine.LOCATION_HAVE_MISSION_LIST[missionInfo.location]=locationMissions

      TppDefine.NO_HELICOPTER_MISSION_START_POSITION[missionCode]=missionInfo.startPos

      --tex TODO: add to format
      --tex indicates that theres no free roam mission box start (there are 7 of these in vanilla)
      --see also AddOrderBoxInfoToFreeRoam
      if missionInfo.isNoOrderBoxMission then--tex these are awkwardly worded, it's alway a struggle to decide whether to chose a nicer new name or keep it closer to what it's called in the vanilla data.
        InfUtil.InsertUniqueInList(TppDefine.NO_ORDER_BOX_MISSION_LIST,tostring(missionCode))
        TppDefine.NO_ORDER_BOX_MISSION_ENUM=TppDefine.Enum(TppDefine.NO_ORDER_BOX_MISSION_LIST)
      end
      TppDefine.NO_BOX_MISSION_START_POSITION[missionCode]=missionInfo.noBoxMissionStartPosition

      --tex TODO
      --  TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE--tex only used for two missions (of the 7 no box mission starts)

      --tex pretty much just clears gvars.heli_missionStartRoute, TODO: how does this interact with NO_HELICOPTER_MISSION_START_POSITION?
      --tex TODO: add to (but allow via a param)
      --TppDefine.NO_HELICOPTER_ROUTE_MISSION_LIST
      --TppDefine.NO_HELICOPTER_ROUTE_ENUM=TppDefine.Enum(TppDefine.NO_HELICOPTER_ROUTE_MISSION_LIST)

      --tex base gmp for mission on mission clear
      TppResult.MISSION_GUARANTEE_GMP[missionCode]=missionInfo.missionGuaranteeGMP

      --tex TppResult.MISSION_TASK_LIST, but not totally sure what it is yet, passed to UI via TppUiCommand.RegisterMbMissionListFunction >> TppResult.GetMbMissionListParameterTable
      --TODO find when GetMbMissionListParameterTable actually called, I see I hooked it at some point, I presume to do just that lol
      TppResult.MISSION_TASK_LIST[missionCode]=missionInfo.missionTaskList

      --tex TODO: shouldn't be needed
      --TppTerminal.noAddVolunteerMissions

      TppEneFova.fovaSetupFuncs[missionCode]=missionInfo.fovaSetupFunc

      if missionInfo.noArmorForMission then
        TppEneFova.noArmorForMission[missionCode]=1
      end
      TppEneFova.missionArmorType[missionCode]=missionInfo.missionArmorType
      TppEneFova.missionHostageInfos[missionCode]=missionInfo.missionHostageInfos

      --tex add IH start-on-foot support
      --missionInfo.missionMapParams is mbdvc_map_mission_parameter entry
      if missionInfo.missionMapParams and missionInfo.missionMapParams.heliLandPoint then
        for n,heliLandPoint in ipairs(missionInfo.missionMapParams.heliLandPoint)do
          local routeIdStr32=InfCore.StrCode32(heliLandPoint.routeId)
          if InfLZ.groundStartPositions[1][routeIdStr32] then
            InfCore.Log("WARNING: entry for "..heliLandPoint.routeId.." already in InfLZ.groundStartPositions")
          end
          --tex heliLandPoint.point is ui point and .startPoint is the start of the route (according to caplag eyeballing a mission), as he's used it in gntn as the ground point without any issues I guess the game either doesn't use it, or it warps to route start which would make it moot anyhoo
          --using startPoint for custom missions to allow the author some more control over the startOnFoot point.
          InfLZ.groundStartPositions[1][routeIdStr32]={pos={heliLandPoint.startPoint:GetX(), heliLandPoint.startPoint:GetY(),heliLandPoint.startPoint:GetZ()}}
        end
      end--if missionInfo heliLandPoint
    end--if validate
  end--for missionInfo


  if this.debugModule then
    InfCore.PrintInspect(this.missionInfo,"missionInfo")
  end
end

--tex register missions with UI/TPP Mission system
--IN/SIDE: this.missionIds
--OUT/SIDE: this.missionListSlotIndices
--OUT/SIDE: TppDefine.MISSION_LIST, TppDefine.MISSION_ENUM
function this.RegisterMissions()
  --tex WORKAROUND exe/ui seems to have same limit as TppDefine.MISSION_COUNT_MAX
  --but there's issues with mission completed rank not matching and seemingly no lua>ui way to set it
  --unlike the rest of the information via Mission.RegisterMissionCodeList, the gmp and task completion via TppResult.GetMbMissionListParameterTable
  --so am reusing the MISSING_NUMBER_MISSION_LIST which is flyk and some uncompleted extreme/subsidence of other missions
  --
  --plus the 2 actual free missionlist slots
  this.missionListSlotIndices={}--tex need it for OpenMissions
  for i,missionCodeStr in ipairs(TppDefine.MISSING_NUMBER_MISSION_LIST)do
    local missionIndex=TppDefine.MISSION_ENUM[missionCodeStr]+1
    table.insert(this.missionListSlotIndices,missionIndex)
  end

  for i=#TppDefine.MISSION_LIST+1,TppDefine.MISSION_COUNT_MAX do
    table.insert(this.missionListSlotIndices,i)
  end
  table.sort(this.missionListSlotIndices)

  if this.debugModule then
    local numFreeMissions=TppDefine.MISSION_COUNT_MAX-(#TppDefine.MISSION_LIST-#TppDefine.MISSING_NUMBER_MISSION_LIST)
    --tex or just TppDefine.MISSION_COUNT_MAX-#this.missionListSlotIndices
    InfCore.Log("numFreeMissions="..numFreeMissions)
    InfCore.PrintInspect(this.missionListSlotIndices,"missionListSlotIndices")
    InfCore.PrintInspect(TppDefine.MISSION_LIST,"missionlist vanill")
  end

  local freeSlot=0
  for i,missionCode in ipairs(this.missionIds)do
    if freeSlot==#this.missionListSlotIndices then
      InfCore.Log("WARNING: No free MISSION_LIST slots")
      break
    elseif not TppMission.IsFreeMission(missionCode) then
      local missionIndex=this.missionListSlotIndices[freeSlot+1]
      freeSlot=freeSlot+1
      TppDefine.MISSION_LIST[missionIndex]=tostring(missionCode)
    end
  end
  TppDefine.MISSION_ENUM=TppDefine.Enum(TppDefine.MISSION_LIST)--tex DEBUGNOW TODO look at what else uses MISSION_ENUM and how it might be affected if it varies over sessions, MISSION_LIST too I guess

  if this.debugModule then
    InfCore.PrintInspect(TppDefine.MISSION_LIST,"missionlist modded")
    InfCore.PrintInspect(#TppDefine.MISSION_LIST,"#missionlist")
  end

  local highestMissionNum=this.highestUIMission
  for i,missionCode in ipairs(this.missionIds)do
    highestMissionNum=highestMissionNum+1
    InfCore.Log("RegistMissionEpisodeNo("..missionCode..","..highestMissionNum..")")
    TppUiCommand.RegistMissionEpisodeNo(missionCode,highestMissionNum)--TODO see if this is happy with being called more than once for a mission code (ie via reloadmodules)
  end

  --tex register modified list
  Mission.RegisterMissionCodeList{codeList=TppDefine.MISSION_LIST}--TODO see if this is happy with being called more than once for a mission code (ie via reloadmodules), it's already been called once anyway in vanilla in TppDefine
end

--CALLER: start2nd>InfMain.LoadLibraries
function this.LoadLibraries()
  if InfCore.gameId~="TPP" then
    return
  end

  InfCore.LogFlow("InfMission SetupMissions")

  this.LoadLocationDefs()
  this.LoadMissionDefs()

  this.AddInLocations()
  this.AddInMissions()


  this.missionIds={}--clear
  for missionCode,missionInfo in pairs(this.missionInfo)do
    table.insert(this.missionIds,missionCode)
  end
  table.sort(this.missionIds)


  this.freeMissionForLocation={
    [TppDefine.LOCATION_ID.AFGH]=30010,
    [TppDefine.LOCATION_ID.MAFR]=30020,
  --DEBUGNOW the mission<>freemisson functions where it was originally used for don't have MTBS
  --OFF [TppDefine.LOCATION_ID.MTBS]=30050,
  }
  for missionCode,missionInfo in pairs(this.missionInfo)do
    if TppMission.IsFreeMission(missionCode) then
      local locationId=TppDefine.LOCATION_ID[missionInfo.location]--DEBUGNOW
      if this.freeMissionForLocation[locationId] then
        if this.freeMissionForLocation[locationId]~=missionCode then
          InfCore.Log("WARNING: InfMission.LoadLibraries: freeMissionForLocation["..locationId.."] already has a different free mission defined")
        end
      else
        this.freeMissionForLocation[locationId]=missionCode
      end
    end
  end--for missionInfo

  this.RegisterMissions()

  this.UpdateChangeLocationMenu()

  if this.debugModule then
    InfCore.PrintInspect(this.missionIds,"missionIds")
    InfCore.PrintInspect(this.locationInfo,"locationInfo")
    InfCore.PrintInspect(this.missionInfo,"missionInfo")
    InfCore.PrintInspect(TppMissionList.locationPackTable,"TppMissionList.locationPackTable")
    InfCore.PrintInspect(TppMissionList.missionPackTable,"TppMissionList.missionPackTable")
    InfCore.PrintInspect(TppDefine.LOCATION_ID,"TppDefine.LOCATION_ID")
    InfCore.PrintInspect(TppDefine.LOCATION_HAVE_MISSION_LIST,"TppDefine.LOCATION_HAVE_MISSION_LIST")
    InfCore.PrintInspect(TppDefine.NO_HELICOPTER_MISSION_START_POSITION,"TppDefine.NO_HELICOPTER_MISSION_START_POSITION")
    --InfCore.PrintInspect(mbdvc_map_location_parameter,"mbdvc_map_location_parameter")
    InfCore.PrintInspect(this.freeMissionForLocation,"freeMissionForLocation")
  end
end--LoadLibraries

--CALLER: mbdvc_map_location_parameter.GetMapLocationParameter --tex cant patch in to script since it seems mbdvc_map_location_parameter is torn down/reloaded so instead called from mbdvc_map_location_parameter
function this.GetMapLocationParameter(locationId)
  InfCore.LogFlow("InfMission.GetMapLocationParameter "..tostring(locationId))
  local locationInfo=this.locationInfo[locationId]
  if locationInfo then
    return locationInfo.locationMapParams
  end
end
--CALLER: mbdvc_map_location_parameter.GetMapLocationParameter --tex cant patch in to script since it seems mbdvc_map_location_parameter is torn down/reloaded so instead called from mbdvc_map_location_parameter
--DEBUGNOW TEST PCallDebug these functions?-^--v-
function this.AddGlobalLocationParameters(globalLocationParameters)
  InfCore.LogFlow"InfMission.AddGlobalLocationParameters"
  local enableSpySearch=true--tex IH uses a different method to globally enable/disable, see disableSpySearch ivar
  local enableHerbSearch=Ivars.disableHerbSearch:Get()--tex
  for locationId,locationInfo in pairs(this.locationInfo)do
    local locationParams=locationInfo.globalLocationMapParams
    if locationParams then
      locationParams.locationId=locationId
      if locationParams.isSpySearchEnable~=nil then
        locationParams.isSpySearchEnable=enableSpySearch
      end
      if locationParams.isHerbSearchEnable ~=nil then
        locationParams.isHerbSearchEnable=enableSpySearch
      end
      table.insert(globalLocationParameters,locationParams)
    end
  end--for locationInfo
end--AddGlobalLocationParameters

--CALLER: mbdvc_map_mission_parameter.GetMissionParameter
function this.GetMapMissionParameter(missionCode)
  InfCore.LogFlow("InfMission.GetMapMissionParameter "..tostring(missionCode))
  --TODO mgo style map param for location
  --TODO see if mgo map params are useful
  local missionInfo=this.missionInfo[missionCode]
  if missionInfo then
    return missionInfo.missionMapParams
  end
end

--str_missionOpenPermission ? DEBUGNOW
local gvarFlagNames={
  "str_missionOpenFlag",
  "str_missionNewOpenFlag",
  "str_missionClearedFlag",
}

--CALLER: TppStory.UpdateStorySequence
--IN/SIDE: this.missionListSlotIndices
function this.OpenMissions()
  InfCore.LogFlow("InfMission.OpenMissions")

  --DEBUGNOW limit to only run once



  -- PATCHUP: BADDATA:
  --<r233 BUG:
  --for taskIndex=0,TppDefine.MAX_MISSION_TASK_COUNT-1 do
  --local missionTaskIndex=(missionListIndex-1)*TppDefine.MAX_MISSION_TASK_COUNT+taskIndex
  --tex this resulted in trashing some of the users ui_isTaskLastComleted data (the indices listed in badIndexes)
  --with the GOTCHA of TppScriptVars of TYPE_BOOL being set to 0 setting them to true
  --gvars.ui_isTaskLastComleted[missionListIndex-1]=0
  --end

  --tex fix is checking if missionTaskIndexes that aren't ever set in vanilla game have been set and clearing those
  --will still potentially leave some users with some valid tasks that they hadn't actually completed set as completed
  --but there's no heuristic I'm happy with to figure that out

  --tex from missionListSlotIndices (shifted-1 to gvar indices) at the time of the below bug
  --which was built from missing_number_missions, and #mission_list > max_mission (62,63)
  local badIndexes={
    39,--invalid task
    41,
    43,
    46,--invalid task
    49,
    50,
    51,
    53,
    55,--invalid task
    57,
    60,
    62,
    63,--invalid task
  }
  --tex Dump values at badIndexes
  for i,badIndex in ipairs(badIndexes)do
    local value=gvars.ui_isTaskLastComleted[badIndex]
    InfCore.Log("badIndex: "..badIndex..": "..tostring(value))
  end

  --tex actual fix, may need to be reconsidered if we start repurposing vanilla mission slots
  --notes on what is actual bad data (ie missionTaskIndexes set to true that aren't actually valid tasks for that mission in vanilla game)
  --figured out by diffing a normal 100% save with a corrupted 100% save
  local badTasksIndexes={
    39,
    46,
    55,
    63,
  }
  for i,badIndex in ipairs(badTasksIndexes)do
    gvars.ui_isTaskLastComleted[badIndex]=false
  end

  --tex close all missing number missions and > vanilla missions first so its ok if user uninstalls mission
  for i,missionListIndex in ipairs(this.missionListSlotIndices)do
    InfCore.Log("Clearing "..missionListIndex)
    gvars.str_missionOpenPermission[missionListIndex-1]=false
    gvars.str_missionOpenFlag[missionListIndex-1]=false
    gvars.str_missionNewOpenFlag[missionListIndex-1]=false
    gvars.str_missionClearedFlag[missionListIndex-1]=false

    --tex see _GetLastCompletedFlagIndex how to index ui_isTaskLastComleted
    for taskIndex=0,TppDefine.MAX_MISSION_TASK_COUNT-1 do
      local missionTaskIndex=(missionListIndex-1)*TppDefine.MAX_MISSION_TASK_COUNT+taskIndex
      gvars.ui_isTaskLastComleted[missionTaskIndex]=false
    end
  end

  --tex TODO: save/restore mission flags

  for i,missionCode in ipairs(this.missionIds)do
    InfCore.Log("Opening "..missionCode)
    TppStory.PermitMissionOpen(missionCode)
    TppStory.SetMissionOpenFlag(missionCode,true)
    --TppStory.MissionOpen(missionCode)
  end
end

--tex set missionCleared gvars from ih_save state
--IN/SIDE: ih_save
--REF ih_save
--this.missionStates={
--  <mission name>=<bitfield of mission cleared gvar states>,
--}
function this.ReadSaveStates()
  InfCore.LogFlow"InfMission.ReadSaveStates"

  if ih_save==nil then
    local errorText="ReadSaveStates Error: ih_save==nil"
    InfCore.Log(errorText,true,true)
    return
  end

  local saveStates=ih_save.missionStates

  if saveStates==nil then
    InfCore.Log"ReadSaveStates: ih_save.missionStates==nil"
    return {}
  end

  if type(saveStates)~="table" then
    local errorText="ReadSaveStates Error: ih_save.missionStates type~=table"
    InfCore.Log(errorText,true,true)
    return
  end

  for name,saveState in pairs(saveStates)do
  --DEBUGNOW
  end

  return saveStates
end

local saveStates={}--tex cache of last to compare against for isdirty
--CALLER: IvarProc.BuildSaveText
function this.GetCurrentSaveStates()

  local gvars=gvars
  local bor=bit.bor

  local isSaveDirty=false



  if isSaveDirty then
    return saveStates
  end

  return nil
end

function this.GetLocationInfo(locationCode)
  --locationCode=locationCode or vars.locationCode
  return this.locationInfo[locationCode]
end
--tex missionCode only needed for debug
function this.GetFreeMissionForLocation(locationCode,missionCode)
  InfCore.Log("InfMission.GetFreeMissionForLocation "..tostring(locationCode)..", "..tostring(missionCode))
  --locationCode=locationCode or vars.locationCode
  return this.freeMissionForLocation[locationCode]
end

--CALLER: TppTerminal.ReleaseFreePlay
--Enables the free roam entry
--but the issue is that name doesnt show
--despite there being a map_location_parameter - locationNameLangId = "tpp_loc_<whatever> (that matches tpp_common lng for vanilla free)
--however the above map does show
--given that there's a location icon I guess that's set up in engine
--TODO: find the names of the icons
--see IHHook GetFreeRoamLangIdHook and UpdateChangeLocationMenu below for fix
--CALLER: TppTerminal.Init > TppTerminal.ReleaseFreePlay
function this.EnableLocationChangeMissions()
  local skipLocations={
    [TppDefine.LOCATION_ID.AFGH]=true,
    [TppDefine.LOCATION_ID.MAFR]=true,
    [TppDefine.LOCATION_ID.MTBS]=true,
  }
  for locationCode,freeMissionCode in pairs(this.freeMissionForLocation)do
    if skipLocations[locationCode]~=true then
      InfCore.Log("EnableChangeLocationMenu{locationId="..locationCode..",missionId="..freeMissionCode.."}")
      TppUiCommand.EnableChangeLocationMenu{locationId=locationCode,missionId=freeMissionCode}
    end
  end
end--EnableLocationChangeMissions

--see above comment
function this.UpdateChangeLocationMenu()
  local locationLangIds={
    [10]="tpp_loc_afghan",
    [20]="tpp_loc_africa",
    [30]="tpp_loc_cyprus",--tex has langid, but wasn't referenced in the original function I found.
    [50]="tpp_loc_mb",
  }--locationLangIds
  for locationCode,locationInfo in pairs(this.locationInfo)do
    local langId
    if locationInfo.locationMapParams then
      langId=locationInfo.locationMapParams.locationNameLangId
    end
    langId=langId or "tpp_loc_"..string.lower(locationInfo.locationName)

    locationLangIds[locationCode]=langId--tex handle hashing on ihhook side since I'm unsure of lua number size Fox.StrCode(langId)--strcode64
  end
  if IHH then
    IHH.UpdateChangeLocationMenu(locationLangIds)
  end
end--UpdateChangeLocationMenu

--orig in TppResult.GetMbMissionListParameterTable
-- currently conflict with Anyones Improvements
--OFF CULL
function this.GetMbMissionListParameterTable()
  InfCore.LogFlow("InfMission.GetMbMissionListParameterTable")--tex DEBUG
  local missionListParameterTable={}
  for missionCodeStr,enum in pairs(TppDefine.MISSION_ENUM)do
    local missionCode=tonumber(missionCodeStr)
    local missionParameters={}
    missionParameters.missionId=missionCode
    if this.MISSION_GUARANTEE_GMP[missionCode]then
      missionParameters.baseGmp=101--DEBUGNOW setting to magic number to see if working--ORIG this.MISSION_GUARANTEE_GMP[missionCode]
      missionParameters.currentGmp=101--DEBUGNOW setting to magic number to see if working --ORIG this.GetMissionGuaranteeGMP(missionCode)
    end
    if this.MISSION_TASK_LIST[missionCode]then
      missionParameters.completedTaskNum=TppUI.GetTaskCompletedNumber(missionCode)
      missionParameters.maxTaskNum=#this.MISSION_TASK_LIST[missionCode]
      missionParameters.taskList=this.MISSION_TASK_LIST[missionCode]
    end

    --OFF tex DEBUGNOW TODO what was I trying to do here?
    --    local isMissingNumberMission=TppDefine.MISSING_NUMBER_MISSION_ENUM[missionCodeStr]--tex
    --    if isMissingNumberMission then
    --      InfCore.Log("---------- GetMbMissionListParameterTable "..missionCodeStr)
    --    end
    --    if not isMissingNumberMission then--tex added skip
    --      table.insert(missionListParameterTable,missionParameters)
    --    end
    --
  end

  return missionListParameterTable
end

--REF
--  weaponIdTable={
--    NORMAL={
--      HANDGUN=TppEquip.EQP_WP_East_hg_010,
--      SMG=TppEquip.EQP_WP_East_sm_010,
--      ASSAULT=TppEquip.EQP_WP_East_ar_010,
--      SNIPER=TppEquip.EQP_WP_East_sr_011,
--      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
--      MG=TppEquip.EQP_WP_East_mg_010,
--      MISSILE=TppEquip.EQP_WP_East_ms_010,
--      SHIELD=TppEquip.EQP_SLD_SV
--    },
--    STRONG={
--      HANDGUN=TppEquip.EQP_WP_East_hg_010,
--      SMG=TppEquip.EQP_WP_East_sm_020,
--      ASSAULT=TppEquip.EQP_WP_East_ar_030,
--      SNIPER=TppEquip.EQP_WP_East_sr_020,
--      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
--      MG=TppEquip.EQP_WP_East_mg_010,
--      MISSILE=TppEquip.EQP_WP_Com_ms_010,
--      SHIELD=TppEquip.EQP_SLD_SV
--    }
--  }
function this.ValidateWeaponIdTable(weaponIdTable)
  local valid=true
  for strength,weaponTable in pairs(weaponIdTable)do
    for weaponType,equipId in pairs(weaponTable)do
      if equipId==nil then
        InfCore.Log("WARNING: InfMission.ValidateWeaponIdTable: equipId nil for weaponTable category "..strength.." "..weaponType)
        return false
      else
      --local equipName=InfLookup.TppEquip.equipId[equipId]--DEBUG
      --InfCore.Log("ValidateWeaponIdTable "..strength.." "..weaponType.." "..equipName.." "..equipId)--DEBUG
      end
    end
  end
  return valid
end

--CALLER: TppEnemy.GetWeaponIdTable
--IN/SIDE vars.missionCode
--GOTCHA: this function is called a lot (on each soldier) so any logging will spam.
--GOTCHA: missioninfo weaponIdTable is a actually weaponIdTable soldier type sub table, not a full table like TppEnemy.weaponIdTable
function this.GetSoldierWeaponIdTable(soldierType,soldierSubType)
  local weaponIdTable
  local missionInfo=this.missionInfo[vars.missionCode]
  if missionInfo then
    weaponIdTable=missionInfo.weaponIdTable
    if type(weaponIdTable)=="string" then
      weaponIdTable=TppEnemy.weaponIdTable[weaponIdTable]
      if weaponIdTable==nil then
        InfCore.Log("WARNING: InfMission.GetWeaponIdTable: could not find weaponIdTable["..missionInfo.weaponIdTable.."]")
      end
    elseif type(weaponIdTable)=="table" then
      this.ValidateWeaponIdTable(weaponIdTable)--DEBUGNOW just do it on load instead, maybe set a valid flag to check so we can return nil, or just nil the entry on fail
      --tex pass through, it will return at the end
    else
      weaponIdTable=nil
    end
  end--if missionInfo
  --InfCore.PrintInspect(weaponIdTable,"InfMission weaponIdTable")--DEBUG
  return weaponIdTable
end--GetSoldierWeaponIdTable
--
--tex need to patch in some orderbox data into the free roam mission scripts.
--TppMission.OnAllocate (which is run before this?) sets mvars.mis_orderBoxList to .missionStartPosition.orderBoxList, but doesn't seem to be used till later in execution
--OnAllocate is just before <sequence>.MissionPrepare which in freeroam calls:
--TppScriptBlock.RegisterCommonBlockPackList( "orderBoxBlock", f30020_orderBoxList.orderBoxBlockList )
--REF
--<free roam>_sequence.missionStartPosition = {
--    orderBoxList = {
--      "box_s10033_00",
--      "box_s10033_01",
--      ...
--REF
--<free roam>_orderBoxList.orderBoxBlockList[10081] = { "/Assets/tpp/pack/mission2/story/s10081/s10081_order_box.fpk" }
--CALLER: this.OnAllocate
function this.AddOrderBoxInfoToFreeRoam(missionTable)
  InfCore.Log("InfMission.AddOrderBoxInfoToFreeRoam")--
  local currentMissionCode=vars.missionCode
  local currentLocationCode=var.locationCode
  local missionStartPosition=missionTable.sequence.missionStartPosition--tex such a strange name for what the table is used for. ASSUMPTION always exists (it should if the sequence script has been cribbed from a vanilla script)
  if not missionStartPosition then
    InfCore.Log("WARNING: InfMission.AddOrderBoxInfoToFreeRoam: missionTable.sequence.missionStartPositio==nil ")
  else
    --  local sequenceModule = _G["f"..missionCode.."_sequence] -- is just missionTable.sequence
    local orderBoxListModule=_G["f"..currentMissionCode.."_orderBoxList"]
    for missionCode,missionInfo in pairs(this.missionInfo)do
      local missionLocationCode=TppDefine.LOCATION_ID[missionInfo.location]
      if not missionLocationCode then
        InfCore.Log("ERROR: TppDefine.LOCATION_ID[missionInfo.location]==nil")
      elseif missionLocationCode==currentLocationCode then
        if missionInfo.orderBoxList then
          if not missionStartPosition.orderBoxList then
            InfCore.Log("WARNING: missionTable.sequence.missionStartPosition.orderBoxList==nil")
            missionStartPosition.orderBoxList={}
          end
          for i,boxName in ipairs(missionInfo.orderBoxList)do
            InfUtil.InsertUniqueInList(missionStartPosition.orderBoxList,boxName)
          end
        end--if missionInfo.orderBoxList

        if missionInfo.orderBoxBlockList then
          if not orderBoxListModule then
            InfCore.Log("WARNING: no _orderBoxList module for "..missionCode)
          else
            orderBoxListModule.orderBoxBlockList[missionInfo.missionCode]=missionInfo.orderBoxBlockList
          end
        end--missionInfo.orderBoxBlockList
      end--for this.missionInfo
    end--if missionLocation

    if this.debugModule then
      InfCore.PrintInspect(missionStartPosition.orderBoxList,"missionStartPosition.orderBoxList")
      InfCore.PrintInspect(orderBoxListModule,"orderBoxListModule")
    end
  end--if missionStartPosition
end--AddOrderBoxInfoToFreeRoam
function this.OnAllocate(missionTable)
  if TppMission.IsFreeMission(vars.missionCode)then
    this.AddOrderBoxInfoToFreeRoam(missionTable)
  end--if IsFreeMission
end--OnAllocate

function this.Init(missionTable)
  -- OFF
  --tex Original in TppResult.Init ,  TODO: log to see when this is called in relation to that
  --  if TppUiCommand.RegisterMbMissionListFunction then
  --    if TppUiCommand.IsTppUiReady()then
  --    InfCore.LogFlow("TppUiCommand.RegisterMbMissionListFunction InfMission.GetMbMissionListParameterTable")
  --    --TppUiCommand.RegisterMbMissionListFunction("InfMission","GetMbMissionListParameterTable")
  --    end
  --  end

  --tex TODO figure out zone system,
  local missionInfo=this.missionInfo[vars.missionCode]
  if missionInfo then
    --tex KLUDGE: this was originally when I was thrashing out the mission addons and messing with OMBS and mgo maps just to kill the out of bounds system,
    --but now it's kind of stuck since those are still being passed around.
    --So now you have to manually add the flag to the mission addon module so it 'enables' it,
    --when really it's just not-disabling it.
    if not missionInfo.enableOOB then
      --tex in tppmission.init
      mvars.mis_isAlertOutOfMissionArea=false

      --tex in tppui init
      TppUiCommand.HideInnerZone()
      TppUiCommand.HideOuterZone()
    end
  end
end--Init

function this.OnRestoreSvars()
  --tex sortie mvars per mission - see heli_common_sequence OnRestoreSvars
  for missionCode,missionInfo in pairs(this.missionInfo)do
    if missionInfo.heliSpaceFlags then--tex alway a question when choosing a name whether to make it friendly for user (sortiePrepFlags or somthin), or to use naming from existing code, missionInfo in general uses code derived naming
      InfTppUtil.SetHeliSpaceFlags(missionInfo.heliSpaceFlags,missionCode)
    end--if heliSpaceFlags
  end--for missionInfo
end

function this.LoadMissionManual(missionCode)
  local loadDirect=false--DEBUGNOW

  --TppMission.Load( tonumber(settingStr), vars.missionCode, { showLoadingTips = false } )
  --TppMission.RequestLoad(tonumber(settingStr),vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
  --TppMission.RequestLoad(10036,vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
  if loadDirect then
    gvars.mis_nextMissionCodeForMissionClear=missionCode
    mvars.mis_showLoadingTipsOnMissionFinalize=false
    --mvars.heli_missionStartRoute
    --mvars.mis_nextLayoutCode
    --mvars.mis_nextClusterId
    --mvars.mis_ignoreMtbsLoadLocationForce

    TppMission.ExecuteMissionFinalize()
  else
    TppMission.ReserveMissionClear{
      missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,
      nextMissionId=missionCode,
    }
  end
end

function this.GetMissionCodes()
  return {
    --LOC,TYPE,Notes
    --    "1",--INIT
    --    "5",--TITLE
    --storyMissions
    "10010",--CYPR
    "10020",
    "10030",
    "10036",
    "10043",
    "10033",
    "10040",
    "10041",
    "10044",
    "10052",
    "10054",
    "10050",
    "10070",
    "10080",
    "10086",
    "10082",
    "10090",
    "10195",
    "10091",
    "10100",
    "10110",
    "10121",
    "10115",
    "10120",
    "10085",
    "10200",
    "10211",
    "10081",
    "10130",
    "10140",
    "10150",
    "10151",
    "10045",
    "10156",
    "10093",
    "10171",
    "10240",
    "10260",
    "10280",--CYPR
    --hard missions
    "11043",
    "11041",--missingno
    "11054",
    "11085",--missingno
    "11082",
    "11090",
    "11036",--missingno
    "11033",
    "11050",
    "11091",--missingno
    "11195",--missingno
    "11211",--missingno
    "11140",
    "11200",--missingno
    "11080",
    "11171",--missingno
    "11121",
    "11115",--missingno
    "11130",
    "11044",
    "11052",--missingno
    "11151",
    --
    --"10230",--FLYK,missing completely, chap 3, no load
    --in PLAY_DEMO_END_MISSION, no other refs
    --    "11070",
    --    "11100",
    --    "11110",
    --    "11150",
    --    "11240",
    --    "11260",
    --    "11280",
    --    "11230",
    --free mission
    "30010",--AFGH,FREE
    "30020",--MAFR,FREE
    "30050",--MTBS,FREE
    "30150",--MTBS,MTBS_ZOO,FREE
    "30250",--MBQF,MBTS_WARD,FREE
    --heli space
    "40010",--AFGH,AFGH_HELI,HLSP
    "40020",--MAFR,MAFR_HELI,HLSP
    "40050",--MTBS
  --"40060",--HLSP,HELI_SPACE,--no load
  --online
  --"50050",--MTBS,FOB
  --select??
  --"60000",--SELECT --6e4
  --show demonstrations (not demos lol)
  --    "65020",--AFGH,e3_2014
  --    "65030",--MTBS,e3_2014
  --    "65050",--MAFR??,e3_2014
  --    "65060",--MAFR,tgs_2014
  --    "65414",--gc_2014
  --    "65415",--tgs_2014
  --    "65416",--tgs_2014
  }
end

return this
