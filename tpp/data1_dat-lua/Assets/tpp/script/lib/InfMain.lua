-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion = "r48"
this.modName = "Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum

local SUBSISTENCE_SECONDARY_INITIAL_WEAPON_TABLE={{primaryHip="EQP_None"},{primaryBack="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}}--tex, simply leaves out secondary none
this.subsistenceLoadouts={--tex pure,secondary.
  TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE,
  SUBSISTENCE_SECONDARY_INITIAL_WEAPON_TABLE
}

this.numQuests=157--tex added SYNC: number of quests REFACTOR: better place, but hangs modsettings if in tppdefine or tppquest
this.disallowSideOps={[144]=true};

this.SETTING_SUBSISTENCE_PROFILE=Enum{"OFF","PURE","BOUNDER"}--SYNC: isManualSubsistence setting names
this.SETTING_UNLOCK_SIDEOPS=Enum{"OFF","REPOP","OPEN","MAX"}--SYNC: unlocksideops setting names TODO: overhaul, rectify with sliders
this.SETTING_MB_EQUIPGRADE=Enum{"DEFAULT","MBDEVEL","RANDOM","GRADE1","GRADE2","GRADE3","GRADE4","GRADE5","GRADE6","GRADE7","GRADE8","GRADE9","GRADE10","MAX"}--SYNC: mbSoldierEquipGrade
this.SETTING_MB_EQUIPRANGE=Enum{"DEFAULT","SHORT","MEDIUM","LONG","RANDOM","MAX"}--SYNC: mbSoldierEquipRange
this.SETTING_MB_WARGAMES=Enum{"OFF","NONLETHAL","HOSTILE","MAX"}--SYNC: mbWarGames
this.SETTING_MB_DD_SUITS=Enum{--SYNC: TppEnemy
  "EQUIPGRADE",
  "FOB_DD_SUIT_ATTCKER",
  "FOB_DD_SUIT_SNEAKING",
  "FOB_DD_SUIT_BTRDRS",
  "FOB_PF_SUIT_ARMOR",
  "MAX",
}

function this.IsMbWarGames()
  return gvars.mbWarGames>0 and vars.missionCode == 30050
end
function this.IsMbPlayTime()
  return gvars.mbPlayTime>0 and vars.missionCode == 30050
end
function this.GetMbsClusterSecuritySoldierEquipGrade()--SYNC: mbSoldierEquipGrade
  local grade = 1
  
  if this.IsMbPlayTime() and gvars.mbSoldierEquipGrade>InfMain.SETTING_MB_EQUIPGRADE.MBDEVEL then
    if gvars.mbSoldierEquipGrade==InfMain.SETTING_MB_EQUIPGRADE.RANDOM then
      grade = math.random(1,10)
    else
      grade = gvars.mbSoldierEquipGrade-InfMain.SETTING_MB_EQUIPGRADE.RANDOM
    end
  else
    TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  end
  --TppUiCommand.AnnounceLogView("DBG: GetMbsClusterSecuritySoldierEquipGrade="..grade)--tex DEBUG: CULL:
  return grade
end
function this.GetMbsClusterSecuritySoldierEquipRange() 
  --[[
  local range = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
      if gvars.mbSoldierEquipRange==InfMain.SETTING_MB_EQUIPRANGE.RANDOM then
        range = math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
      elseif gvars.mbSoldierEquipRange>0 then
        range = gvars.mbSoldierEquipRange-1
      end
      return range
--]]
end
function this.GetMbsClusterSecurityIsNoKillMode()
    local isNoKillMode=TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
    if InfMain.IsMbPlayTime() then--tex PrepareDDParameter mbwargames, mbsoldierequipgrade
      isNoKillMode=(gvars.mbWarGames==InfMain.SETTING_MB_WARGAMES.NONLETHAL)
    end
    return isNoKillMode
end

return this