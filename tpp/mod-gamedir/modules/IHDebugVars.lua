--IHDebugVars.lua
--tex turnin on debug crud and running some quick test code on allmodulesload
--as well as supplying my dev menu

--tex GOTCHA: some modules have some debug logging gated behind a if this.debugModule condition.
--PostAllModulesLoad below will set debugModule to true for the modules named in this list.
--this however won't catch modules that use this.debugModule while loading,
--or stuff that the module has run before PostAllModulesLoad
--TODO: a runtime debugAllModules Ivar (don't forget vanilla modules too)
local debugModules={
  'InfWeaponIdTable',
  'InfCore',
  'InfExtToMgsv',
  'InfMgsvToExt',
  'InfMain',
  'InfMenu',
  'InfMenuDefs',
  'IvarProc',
  --  'InfNPC',
  'InfModelProc',--GOTCHA: is loaded before this module, so you'll have to manually set debugMode in the file
  'InfQuest',
  'TppQuest',
  --  'TppQuest',
  --  'InfInterrogation',
  --  'InfMBGimmick',
  'InfLookup',
  --  'InfMission',
  'InfEquip',
  --'InfWalkerGear',
  --'InfSoldier',
  'InfEneFova',
  --'InfMission',
  'InfNPC',
  'Ivars',
  'TppEnemy',
}

local this={}

this.packages={
  --[30010]="/Assets/tpp/pack/mission2/ih/ih_extra_sol_test.fpk",
  -- [30020]="/Assets/tpp/pack/mission2/ih/ih_extra_sol_test.fpk",
  }

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode < 5 then
    return
  end

  if this.packages[missionCode] then
    packPaths[#packPaths+1]=this.packages[missionCode]
  end
end

--DEBUGNOW
function this.DumpSomething()
  local lines={
    }

  local function AddLine(line)
    table.insert(lines,line)
  end

  local WriteLines = function(fileName,lines)
    local f,err = io.open(fileName,"w")
    if f==nil then
      InfCore.Log("ERROR: "..err)
      return
    else
      for i,line in ipairs(lines)do
        local t = f:write(line.."\n")
      end
      f:close()
    end
  end
  ---------
  local PEX={
    DEPLOYED=1,--Ex-- On when not in ACC or mission prepare
    UNK2=2,--UNKNOWN-- Always on, unknown meaning
    UNK3=3,--UNKNOWN-- Always on, unknown meaning
    STAND=4,-- standing; false if HORSE_STAND; true when ON_VEHICLE
    SQUAT=5,-- crouching or doing cbox slide
    CRAWL=6,-- prone or when CBOX_EVADE
    NORMAL_ACTION=7,-- true for most basic on-foot movement-related actions like walking; false when ON_VEHICLE or ON_HORSE or CBOX
    PARALLEL_MOVE=8,-- aiming
    IDLE=9,-- Never on (to my knowledge), unknown meaning
    GUN_READY=10,--Ex-- On when holding a weapon which can be fired but not currently firing
    GUN_FIRE=11,-- true even with suppressor; GUN_FIRE and GUN_FIRE_SUPPRESSOR not true with vehicle/static weapons
    GUN_FIRE_SUPPRESSOR=12,-- true when discharging with suppressor
    GUN_RELOAD=13,--Ex-- On when reloading a weapon but not when manually cycling rounds
    GUN_CYCLE=14,--Ex--   On when manually cycling rounds (e.g. pump-action, bolt-action weapons)
    STUN_ARM_READY=15,--Ex-- On when aiming (but not firing? - check) the stun-arm
    ROCKET_ARM_READY=16,--Ex-- On when aiming (but not firing? - check) the rocket-arm
    SHIELD_READY=17,--Ex-- On when aiming with a shield
    PLACEABLE_READY=18,--Ex-- On when aiming with a placeable item (e.g. C4)
    PLACEABLE_PLACE=19,--Ex-- On when placing a placeable item (e.g. C4)
    STOP=20,-- when idle on foot or cbox; true when CBOX_EVADE; always true if ON_VEHICLE;
    WALK=21,-- min speed
    RUN=22,--  mid speed (default when standing)
    DASH=23,-- max speed (default when stance is limited to two speeds)
    RUN_INTERPOLATE=24,--Ex-- On when in run state but animation below full run speed
    ON_HORSE=25,-- piloting D-Horse
    ON_VEHICLE=26,-- piloting vehicle
    ON_LIGHT_VEHICLE=27,--Ex-- On when piloting a light vehicle
    ON_TRUCK=28,--Ex-- On when piloting a truck
    ON_APC=29,--Ex-- On when piloting an armoured personnel carrier
    ON_TANK=30,--Ex-- On when piloting a tank
    TRUCK_HIDE=31,--Ex--    On when turning off the engine and hiding in a truck
    VEHICLE_ACCL=32,--Ex-- On when accelerating in a vehicle
    VEHICLE_REV=33,--Ex-- On when reversing in a vehicle
    VEHICLE_IDLE=34,--Ex-- On when reversing in a vehicle
    VEHICLE_FIRE=35,--Ex-- On when firing a weapon on a vehicle (I think?)
    VEHICLE_CRASH=36,--Ex-- On when crashing a vehicle
    ON_HELICOPTER=37,-- riding helicopter
    ON_WALKERGEAR=38,--Ex-- On when piloting walker gear (including D-Walker)
    UNK39=39,--UNKNOWN-- There is no code to set this flag?
    UNK40=40,--UNKNOWN-- There is no code to set this flag?
    HORSE_STAND=41,-- On when on a horse and not hiding
    HORSE_HIDE_R=42,-- hiding on right side of horse
    HORSE_HIDE_L=43,-- hiding on left side of horse
    HORSE_IDLE=44,-- HORSE_[speed] also used for D-Walker; can tell which with ON_HORSE check
    HORSE_TROT=45,-- slow speed
    HORSE_CANTER=46,-- mid speed (default)
    HORSE_GALLOP=47,-- fast speed
    HORSE_MOUNT=48,--Ex-- On while climbing on horse
    HORSE_STEP_DOWN=49,--Ex--  On when horse steps down from any height
    HORSE_AIR=50,--Ex--  On when horse is airborne during to a jump
    HORSE_LANDING=51,--Ex--  On when horse is landing during a jump
    HORSE_JUMP=52,--Ex-- On at all times during a horse jump
    HORSE_STEP_DOWN_CANTER=53,--Ex-- On when horse is stepping down from a height at a canter (special animation)
    HORSE_STEP_DOWN_GALLOP=54,--Ex-- On when horse is stepping down from a height at a gallop (special animation)
    WALKERGEAR_DRIVE_MODE=55,--Ex-- On when in D-Walker's drive mode
    SUBJECT=56,-- On when subjective camera is active (POV camera)
    BINOCLE=58,-- using int-scope
    INTRUDE=59,-- On when forced subjective camera is active in crawl-spaces
    LFET_STOCK=60,-- On when camera is behind player's right shoulder
    CUTIN=61,-- On when cutin camera is active (e.g. climbing on horse, entering vehicles, toilets, dumpsters, or putting enemies in things)
    DEAD=62,-- On when player is dead
    DEAD_FRESH=63,-- On during death animation?
    NEAR_DEATH=64,-- On when health is low? Perhaps during or recovering from serious injury?
    NEAR_DEAD=65,-- Despite being named, there is no code to set this flag?
    UNK66=66,--UNKNOWN-- There is no code to set this flag?
    FALL=67,-- On when falling
    CBOX=68,-- true while in cbox and not sliding and not CBOX_EVADE
    CBOX_EVADE=69,-- crawling out of cbox; CBOX false if true
    CBOX_STANCE=70,--Ex-- On when changing stance while in cardboard box
    TRASH_BOX=71,-- in trash box with closed lid
    TRASH_BOX_HALF_OPEN=72,-- in trash box and aiming weapon
    TRASH_BOX_OPEN=73,--Ex-- On when entering/exiting trash box
    SEARCH_LIGHT=74,--Ex-- On when using search lights
    MORTAR=75,--Ex-- On when using mortars
    MACHINE_GUN=76,--Ex--  On when using machine gun placements
    AA_GUN=77,--Ex-- On when using anti-air emplacements
    BUTTON_PRESS=78,--Ex-- On when pressing interactive buttons (e.g. power supplies)
    DOOR_PICKING=79,--Ex-- On when picking locks

    --TODO DOCUMENT: -v-
    INJURY_LOWER=80,--
    INJURY_UPPER=81,--
    UNK82=82,--
    CURE=83,--
    UNK84=84,--
    UNK85=85,--
    UNK86=86,--
    UNK87=87,--
    CQC_CONTINUOUS=88,--
    UNK89=89,--
    BEHIND=90,-- pressed against cover/wall
    UNK91=91,--
    UNK92=92,--
    UNK93=93,--
    UNK94=94,--
    UNK95=95,--
    UNK96=96,--
    UNK97=97,--
    UNK98=98,--
    UNK99=99,--
    UNK100=100,--
    UNK101=101,--
    UNK102=102,--
    UNCONSCIOUS=103,--
    UNK104=104,--
    UNK105=105,--
    UNK106=106,--
    UNK107=107,--
    UNK108=108,--
    UNK109=109,--
    UNK110=110,--
    UNK111=111,--
    UNK112=112,--
    UNK113=113,--
    UNK114=114,--
    UNK115=115,--
    UNK116=116,--
    UNK117=117,--
    UNK118=118,--
    UNK119=119,--
    UNK120=120,--
    UNK121=121,--
    VOLGIN_CHASE=122,--
    UNK123=123,--
    UNK124=124,--
    UNK125=125,--
    UNK126=126,--
    UNK127=127,--
    UNK128=128,--
    UNK129=129,--
    UNK130=130,--
    UNK131=131,--
    UNK132=132,--
    UNK133=133,--
    CARRY=134,-- player is carrying an AI (use with "Carried" FoxStrCode32 msg to check status and obj type)
    UNK135=135,--
    UNK136=136,--
    UNK137=137,--
    UNK138=138,--
    UNK139=139,--
    CURTAIN=140,--
    ENABLE_TARGET_MARKER_CHECK=141,--
    UNK142=142,--
    UNK143=143,--
    UNK144=144,--
    PARTS_ACTIVE=145,-- seems to always be true during gameplay
  }--this


  --  local addPEX={}
  --  for k,v in pairs(PEX)do
  --
  --    if k==nil then
  -- --     AddLine("k==nil")
  --    end
  --    if v==nil then
  --  --    AddLine("v==nil for key "..tostring(k))
  --    end
  --
  --    if string.find(k,"PLACEABLE_")then
  --     AddLine("hurrp: "..tostring(k)..":"..tostring(v))
  --    end
  --      if type(v)=="number"then
  --        addPEX[v]=k
  --      else
  --       -- AddLine("hurrp: "..tostring(k)..":"..tostring(v))
  --      end
  --   -- end
  --    if type(v)=="number"then
  --    --table.insert(PEX,v,k)
  --    else
  --    -- AddLine("hurrp: "..tostring(v))
  --    end
  --
  --  --  if PEX[v]==nil then
  --  --    AddLine("PEX["..tostring(v).."]==nil ")
  --  --  end
  --  end
  --
  --  for i,v in ipairs(addPEX)do
  --    PEX[i]=v
  --  end
  --
  --
  --
  --
  --
  --
  --
  --  --  AddLine("PlayerStatusEx ipairs")
  --  --  for enum,id in ipairs(PlayerStatusEx)do
  --  --    AddLine(tostring(enum).."="..tostring(id))
  --  --  end
  --  AddLine("--------------")
  --  AddLine("PEx2 pairs")
  --  for id,enum in pairs(PEX)do
  --    AddLine(tostring(id).."="..tostring(enum))
  --  end
  AddLine("PlayerStatusEx")
  local ins=InfInspect.Inspect(PlayerStatusEx)
  AddLine(ins)

  ------------
  local fileName=[[C:\Projects\MGS\InfiniteHeaven\tpp\mod-gamedir\dumpsomething.txt]]

  WriteLines(fileName,lines)
end--DumpSomething

--DEBUGNOW
--Mother base soldiers salute voice list
--With no salue list set all they will say is "Boss!"
--Can be re-called during in-mission with changes to test
--each salute id(?) has multiple variations (depending on the voice of the soldier I guess, dont know if theres multiple takes for same)
--tex TODO: figure out the saluteId is related to the multiple voice/subtitle lines
--example
--salute0080 =
--sltb1000_093528_0_eneb_enf
--sltb1000_093527_0_enea_enf
--sltb1000_093268_0_enec

--See debug_CallVoice / speechLabels for more notes

function this.SetSaluteVoiceList()
  --DEBUGNOW
  --  if mb_additionalSalueCommentsorsomething
  --      InfSolier.SetMBSaluteVoiceList()
  --      return
  --    end


  InfCore.LogFlow("SetSaluteVoiceList")--tex DEBUG
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end

  local highList={}
  local highOnceList={}
  local midList={}
  local midOnceList={}
  local lowList={}
  local lowOnceList={}


  --tex from DEBUGNOW ?? speechLabels
  lowList={
    --other voice labels that have nothing to do with salute but might be cool to include:
    --Enemy Voices Sneak (NORMAL/player not spotted status)
    --"EVS040",--"very soft Phew/Ahh",},-- Relaxing --OFF too soft
    "EVS060",--"(exersion) Hmph/Hup",},--Light exertion lines
    "EVS090",--"Rrrgh",},--Soldier gets something in his eye.
    "EVS100",--"(tired) sigh",},--
    "EVS110",--"(frustrated) Dammit",},--Irritated
    "EVS120",--"He's taking so long...",},--Waiting for comrade - General purpose
    "EVS130",--"(to self) I'm going.",},--Can't bear waiting any longer, goes alone

    --Enemy Voiced Notice
    "EVN060",--"soft huh?",},-- From nearby: Enemy spots something
    --"EVN070",--"real soft hmm",}, -- From nearby: Checking it out --OFF too soft
    "EVN080",--"you there!|hey!",}, -- From nearby: Spotted something suspicious

    --"EVN100",--"soft sigh",}, -- From nearby: Nothing spotted --OFF too soft
    --"EVN110",--"soft huh?!",}, -- Heard a knock, footsteps, or other unusual noise-- OFF too soft
    "EVN120",--"The hell?!|Wha-?!|What was that?!",},-- Reacting to an explosion or other loud noise
    "EVN130",--"soft Hm? Huh...",}, -- Checking last known position
    --"EVN140",--"He's here!",}, -- Spotting a suspicious person while searching/on guard, and engaging him
    --"EVN150",--"Contact!|Hostile!",}, --The suspicious person spotted has been identified as an enemy (the player) and is engaged.
    "EVN170",--"Hey - look over there.",},--Spotting something suspicious, and attracting a comrade's attention.

    "EVN311",--"Shoo, shoo! (to animal)",},--chasing away an animal
    "EVN312",--"Get Lost! (to animal angry)",},--
    "EVN350",--"cursing something (multi-purpose)",},--

    --Enemy Voices Reaction
    "EVR010",--"(shock) What the!",}, --
    "EVR011",--"(shock,extreme) Huh!",}, --
    "EVR012",--"(shock,little) Ah!",}, --
    --"EVR020",--"Shit! Enemy fire!",}, --Taking gunfire

    "EVR070",--"hahh! (Short outbursts to steel himself.)",}, --Taking gunfirePlayer has their gun on the enemy, threatening him. Bold reactions.
    "EVR180",--"The hell you doing? (spotted hold-up)",}, --Spotting a comrade in hold-up status
    "EVR220",--"(chuckles)",},--spotted Snake while he's wearing the chicken hat
    "EVR230",--"(chuckles)",},--spotted Snake while he's wearing the chicken hat

    --Enemy Voices Damage/Status changes
    --"EVD070",--"General coughs.",},--doesnt seem to trigger, needs condition?

    --Enemy Voices Battle
    "EVB010",--"Small psych-up shouts.",},
    "EVB030",--"Big psych-up shouts.",},
    --"EVB040",--"Mammoth psych-up shouts.",},--doesnt seem to trigger, needs condition?

    --Enemy Voices Comrades (Battle,Teamwork)
    --"EVC250",--"Go! (to comrades)",},
    "EVC260",--"Go go go! (to comrades)",},
    "EVC330",--"I'm OK (to comrades)",},
    "EVC340",--"You OK? (to comrades)",},

    --Enemy Voices E? Post-combat voices - Caution

    --Enemy Voices Fight?
    "EVF010",--"Boss!",},--default saluting boss.
    "EVF020",--"its an honor boss|dont pull any punches",}, ----no ref,  Greeting Boss before practice:
    "EVF030",--"boss, thats not quite right|boss, um with all due respect",}, --no ref,-- Multipurpose lines for when player fails to do something correctly:
    "EVF040",--"thank you boss!",}, --no ref, the standard cqc reaction

    --TODO: is there a last mission result var anywhere to drive this?
    "salute0010",--"great work on that mission",},--no ref, After completing a mission (score: high)
    "salute0020",--"nice job on that mission",}, --no ref, After completing a mission (score: medium)
    "salute0030",--"that was a pretty rough mission",}, --no ref, ・After completing a mission (score: low)
    --<
    -- already used "salute0040",--"good to have you back boss",}, -- After Boss returns (they"re happy to see him)
    -- already used "salute0050",--"long time no see",}, -- ・Boss returns after a long time away
    -- already used "salute0060",--"welcome home boss",}, --- with warmth ・General-purpose lines after Boss returns
    --!  "salute0070",--"boss? what is..? uhh never mind|thats a.. interesting hat youve got there",},-- spoken uncertainly. ----no ref, ・After Boss returns (when wearing chicken hat) (prep)
    -- already used "salute0080",--"welcome back boss",},-- often said with trepidation, other times sounds normal. -- ・Boss"s "demon level" has exceeded a certain point
    -- already used "salute0090",--"we need more personel",},
    -- already used "salute0100",--"we cant get by with so few staff",},
    --! "salute0110",--"thanks for bringing in more guys",},--no ref,
    -- already used "salute0120",--"starting to get a little crowded here",},
    --!  "salute0130",--"thanks for upgrading the base|for expanding",},--no ref,
    --!  "salute0140",--"that new weapon is just what we needed boss",},--no ref,
    -- already used "salute0150",--"boss, we still in the red?",},
    -- already used "salute0160",--"we're ready to develop new equipment",},
    -- already used "salute0170",--"do you think you can bring in more materials?",},
    "salute0180",--"train with me",},
    -- already used "salute0190",--"boss! you, me, mock battle, what do you say?",},
    -- already used "salute0200",--"i'm ready for a dispatch. send me on a mission",},
    --!  "salute0210",--"damage to the fob is getting serious, you need to review fob security",}, --no ref,  for after fob attack i guess
    "salute0220",--"whatever supplies you need, let us know",},
    -- already used "salute0230",--"we're here for you if you need combat support",},
    -- already used "salute0240",--"boss, thanks for saving that puppy",},
    -- already used "salute0250",--"i hope you keep that woman locked up boss",},
    -- already used "salute0260",--"do you think you could bring back more medicinal plants?",},
    -- already used "salute0270",--"you have to rescue our men",},
    -- already used "salute0280",--"you need to put an end to the infection boss",},
    -- already used "salute0290",--"thanks for taking in those children",},
    -- already used "salute0300",--"thank you for getting those animals out boss",},
    "salute0310",--"how's it going boss?",},
    "salute0320",--"boss good moring|have a good day boss",}, -- condition: must actually be morning ?
    -- already used "salute0330",--"thank you for rescuing our men boss",},
    -- already used "salute0340",--"thank you for ending the infection",},
    -- already used "salute0350",--"boss, now our guys can rest in peace. thank you for what you did with the diamonds",},
    -- already used "salute0360",--"thank you for stopping the infection boss",},--with more emotion
    -- already used  "salute0370",--"boss, whoever you are, youre still my CO",},
    -- already used "salute0380",--"happy birthday boss",},
    --!  "salute0390",--"congratulations on the decomissioning boss",}, -- no ref,  ・After abolishing nuclear weapons
    --!  "salute0400",--"congratulations",}, -- --no ref ・General-purpose congratulatory greeting
    "salute0410",--"uh, how about taking a shower after a mission?",},--When Boss stinks - requires condition
    "salute0420",--"thank you for letting me join diamond dogs",},--  New recruit who was just extracted? - requires condition?
  --! "salute0430",--"boss! I new you were alive!|its.. its you boss",},--no ref amazed -- ●NPC lines: when reuniting with soldiers who were at the old Mother Base (survivors of 9 years ago)
  --> anything higher is silence/no table
  }--lowList



  table.insert(lowList,"EVF010")--"Boss!",},--default saluting boss.
  table.insert(lowList,"salute0180")--'train with me'
  table.insert(lowList,"salute0220")--'whatever supplies you need, let us know'
  table.insert(lowList,"salute0310")--'how's it going boss?'
  table.insert(lowList,"salute0320")--"boss good moring|have a good day boss",}, -- condition: must actually be morning ?

  table.insert(midList,"salute0410")--"uh, how about taking a shower after a mission?",},--When Boss stinks - requires condition?
  table.insert(midList,"salute0420")--  New recruit who was just extracted - requires condition?

  local storySequence=gvars.str_storySequence
  if TppMotherBaseManagement.GetOgrePoint()>=5e4 then
    table.insert(highOnceList,"salute0080")--'welcome back boss', often said with trepidation, other times sounds normal.
  elseif Player.GetSmallFlyLevel()>=5 then
    table.insert(highOnceList,"salute0050")--'long time no see'
  elseif Player.GetSmallFlyLevel()>=3 then
    table.insert(highOnceList,"salute0040")--'good to have you back boss'
  else
    table.insert(highOnceList,"salute0060")--'welcome home boss', with warmth
  end
  local staffcount=TppMotherBaseManagement.GetStaffCount()
  local staffLimit=0
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_COMBAT}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_DEVELOP}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_BASE_DEV}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SUPPORT}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SPY}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_MEDICAL}
  staffLimit=staffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SECURITY}
  local percentageFull=staffcount/staffLimit
  if percentageFull<.2 then
    table.insert(lowList,"salute0100")--'we cant get by with so few staff'
  elseif percentageFull<.4 then
    table.insert(lowList,"salute0090")--'we need more personel'
  elseif percentageFull>.8 then
    table.insert(lowList,"salute0120")--'starting to get a little crowded here'
  end
  if TppMotherBaseManagement.GetGmp()<0 then
    table.insert(lowList,"salute0150")--'boss, we still in the red?'
  end
  if TppMotherBaseManagement.GetDevelopableEquipCount()>8 then
    table.insert(lowList,"salute0160")--'we're ready to develop new equipment'
  end
  if(TppMotherBaseManagement.GetResourceUsableCount{resource="CommonMetal"}<500 or TppMotherBaseManagement.GetResourceUsableCount{resource="FuelResource"}<200)or TppMotherBaseManagement.GetResourceUsableCount{resource="BioticResource"}<200 then
    table.insert(lowList,"salute0170")--'do you think you can bring in more materials?'
  end
  if TppMotherBaseManagement.IsBuiltFirstFob()then
    table.insert(lowList,"salute0190")--'boss! you, me, mock battle, what do you say?'
  end
  if TppTerminal.IsReleaseSection"Combat"then
    table.insert(lowList,"salute0200")--'i'm ready for a dispatch. send me on a mission'
  end
  if TppMotherBaseManagement.IsOpenedSectionFunc{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_BATTLE}then
    local n=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_BATTLE}
    if n>=TppMotherBaseManagementConst.SECTION_FUNC_RANK_E then
      table.insert(lowList,"salute0230")--'we're here for you if you need combat support'
    end
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.DOG)and not TppBuddyService.CanSortieBuddyType(BuddyType.DOG))and not TppBuddyService.IsDeadBuddyType(BuddyType.DOG)then
    table.insert(lowList,"salute0240")--'boss, thanks for saving that puppy'
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)and not TppBuddyService.CanSortieBuddyType(BuddyType.QUIET))and not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)then
    table.insert(lowList,"salute0250")--'i hope you keep that woman locked up boss'
  end
  if TppMotherBaseManagement.GetResourceUsableCount{resource="Plant2000"}<100 or TppMotherBaseManagement.GetResourceUsableCount{resource="Plant2005"}<100 then
    table.insert(lowList,"salute0260")--'do you think you could bring back more medicinal plants?'
  end
  if storySequence==TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
    table.insert(midList,"salute0270")--'you have to rescue our men'
  end
  if TppMotherBaseManagement.IsPandemicEventMode()or storySequence==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_MURDER_INFECTORS then
    table.insert(midList,"salute0280")--'you need to put an end to the infection boss'
  end
  if storySequence==TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
    table.insert(midList,"salute0290")--'thanks for taking in those children'
  end
  if TppTerminal.IsBuiltAnimalPlatform()then
    table.insert(lowList,"salute0300")--'thank you for getting those animals out boss'
  end
  if storySequence==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_INTEL_AGENTS then
    table.insert(midList,"salute0330")--'thank you for rescuing our men boss'
  end
  if storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA and storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    table.insert(midList,"salute0340")--'thank you for ending the infection'
  end
  if storySequence==TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    table.insert(midList,"salute0350")--'boss, now our guys can rest in peace. thank you for what you did with the diamonds'
    table.insert(midList,"salute0360")--'thank you for stopping the infection boss', with more emotion
  end
  if storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
    table.insert(lowList,"salute0370")--'boss, whoever you are, youre still my CO'
  end
  if TppUiCommand.IsBirthDay()then
    table.insert(highList,"salute0380")--'happy birthday boss'
  end
  local saluteVoiceList={high={normal=highList,once=highOnceList},mid={normal=midList,once=midOnceList},low={normal=lowList,once=lowOnceList}}
  local typeSoldier={type="TppSoldier2"}
  GameObject.SendCommand(typeSoldier,{id="SetSaluteVoiceList",list=saluteVoiceList})
end--SetSaluteVoiceList

function this.PostAllModulesLoad()
  if isMockFox then
    InfCore.Log("isMockFox, returning:")
    return
  end

  --  TppEnemy.SetSaluteVoiceList=InfSoldier.SetMBSaluteVoiceList--DEBUGNOW
  --  InfSoldier.SetMBSaluteVoiceList()

  InfObjects.objectNames[1]="sol_ih_0135"
  --InfObjects.objectNames[2]="sol_ih_0128"
  --Ivars.selectSpeechObject:Set(0)
  --Ivars.selectSpeechObject2:Set(1)

  this.DumpSomething()


  --  TppEnemy.GetWeaponId=this.GetWeaponId
  --  TppEnemy.weaponIdTable.PF_A=weaponIdTable
  --  TppEnemy.weaponIdTable.PF_B=weaponIdTable
  --  TppEnemy.weaponIdTable.PF_C=weaponIdTable
  --  TppEnemy.weaponIdTable.DD=weaponIdTable
  --  TppEnemy.weaponIdTable.SOVIET_A=weaponIdTable
  --  TppEnemy.weaponIdTable.SOVIET_B=weaponIdTable
  --  TppEnemy.weaponIdTable.SKULL=weaponIdTable
  --  TppEnemy.weaponIdTable.MARINES_A=weaponIdTable
  --  TppEnemy.weaponIdTable.MARINES_B=weaponIdTable
  --  TppEnemy.weaponIdTable.MARINES_MIXED=weaponIdTable

  InfCore.PrintInspect("IHH")
  InfCore.PrintInspect(imgui,"imgui")

  this.SetDebugVars()

  -- InfCore.Log("IHDebugVars.PostAllModulesLoad:")
  -- print("testerino");

  --DEBUGNOW
  --https://www.lua.org/tests/
  local testPath="C:/Games/Steam/steamapps/common/MGS_TPP/mod/lua-test"
  _U=true--tex simple mode
  InfCore.PCallDebug(function()LoadFile(testPath.."/all.lua")end)

  -- winapi.shell_exec('open','C:/Games/Steam/steamapps/common/MGS_TPP/mod/')

  --= "currdirtest.lua"
  --  local f = loadfile(filename)
  -- return f(filename)
  --dofile()

  --DEBUGNOW
  local opentest = function(filename)
    local f,err = io.open(filename,"w")
    if f==nil then
      InfCore.Log("ERROR: "..err)
    else
      local t = f:write("blurgg")
      f:close()
    end
  end


  --tex relative paths cause an error 'Result too large',
  --I guess kjp has some kind of relative path==internal path? thing going on?
  --  InfCore.PCallDebug(opentest,"c:/temp/curredirtext1.txt")
  --  InfCore.PCallDebug(opentest,"/temp/curredirtext2.txt")
  --  InfCore.PCallDebug(opentest,"temp/curredirtext3.txt")
  --  InfCore.PCallDebug(opentest,"curredirtext4.txt")
  --  InfCore.PCallDebug(opentest,"./curredirtext5.txt")
  --  InfCore.PCallDebug(opentest,".curredirtext6.txt")
  --  InfCore.PCallDebug(opentest,"./temp/curredirtext7.txt")






  InfCore.PrintInspect(InfCore.ihFiles,"ihFiles")
  InfCore.PrintInspect(InfCore.paths,"paths")
  InfCore.PrintInspect(InfCore.files,"files")
  InfCore.PrintInspect(InfCore.filesFull,"filesFull")


  this.PrintUpdateTimes()

  --this.FileBenchMark()

  --
  -- InfCore.PrintInspect(_IHHook, "_IHHook")
  -- InfCore.PrintInspect(_GameDir, "_GameDir")
  -- InfCore.PrintInspect(_IHHook_TestTable,"_IHHook_TestTable");

  --

  InfCore.Log("TppEquip.IsExistFile test:")
  local fileNamesTest={
    "/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters.lua",
    "/Assets/tpp/script/lib/Tpp.lua",
    "/Assets/tpp/script/lib/InfInit.lua",
    "/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v000_eye0.fpk",
    "/Assets/tpp/pack/mission2/init/init.fpk",
    "/Assets/tpp/pack/blurgespurgen.fpk",
    "/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters",
    "hurrrg",
  }
  for i,fileName in ipairs(fileNamesTest)do
    local fileExists = TppEquip.IsExistFile(fileName)
    InfCore.Log(fileName.." : "..tostring(fileExists))
  end




  local blockNames={
    "mission_block",
    "quest_block",
    "demo_block",
    "reinforce_block",
    "npc_block",
    "animal_block",
    "TppResidentBlockGroup",
    "CommonStageBlockGroup",
  }
  for i,blockName in ipairs(blockNames)do
    local blockId=ScriptBlock.GetScriptBlockId(blockName)
    InfCore.Log(blockName.." blockId="..tostring(blockId))
  end

  local staffVarNames={
    "mbmStaffSvarsHeaders",
    "mbmStaffSvarsSeeds",
    "mbmStaffSvarsStatusesNoSync",
    "mbmStaffSvarsStatusesSync",
  }

  local staffVarsHex={}

  local arrayLength=3500
  for i,varName in ipairs(staffVarNames)do
    staffVarsHex[varName]={}
    for index=0,arrayLength-1 do
      staffVarsHex[varName][index+1]=bit.tohex(vars[varName][index])
    end
  end
  --InfCore.PrintInspect(staffVarsHex,"staffVarsHex")

  --

  --this.PrintStrCodes()

  --Quat shiz
  --
  --    local rotY=30
  --    local rotQuat=Quat.RotationY(TppMath.DegreeToRadian(rotY))
  --    InfCore.PrintInspect(rotQuat,"rotQuat")
  --    InfCore.PrintInspect(tostring(rotQuat),"rotQuat")
  --    InfCore.PrintInspect(rotQuat:ToString(),"rotQuat")

  --Ivars.customSoldierTypeFREE:Set"OFF"
  --Ivars.disableXrayMarkers:Set(1)
end

function this.Init()

  --  InfCore.Log("IHDebugVars")
  --    InfCore.PrintInspect(gvars.rev_revengeRandomValue, "rev_revengeRandomValue")
  --  for i=0,TppRevenge.REVENGE_TYPE.MAX-1 do
  --  --  gvars.rev_revengeLv[i] = 3
  --  end
  --
  --    for i=0,TppRevenge.REVENGE_TYPE.MAX-1 do
  --    InfCore.PrintInspect(gvars.rev_revengeLv[i], "rev_revengeLv "..i..":")
  --  end
  local gimMax=1025
  for i=1,gimMax do
  --InfCore.PrintInspect(gvars.gim_missionStartBreakableObjects[i],"Init gim_missionStartBreakableObjects["..i.."]:")
  end
end

function this.OnAllocate(missionTable)
  local gimMax=1025
  for i=1,gimMax do
  --InfCore.PrintInspect(gvars.gim_missionStartBreakableObjects[i],"Init gim_missionStartBreakableObjects["..i.."]:")
  end
end

function this.SetDebugVars()
  InfCore.LogFlow("IHDebugVars.PostAllModulesLoad: setting debug vars")

  Ivars.debugMode:Set(1)
  Ivars.debugMessages:Set(1)
  Ivars.debugFlow:Set(1)
  Ivars.debugOnUpdate:Set(1)

  Ivars.enableQuickMenu:Set(1)

  for i,moduleName in ipairs(debugModules)do
    _G[moduleName].debugModule=true
  end
  if IHH then
    IHH.Log_SetFlushLevel(InfCore.level_trace)
  end
end

function this.PrintUpdateTimes()
  InfCore.PrintInspect(InfMain.updateTimes,"updateTimes")

  local averageTimes={}
  for k,v in pairs(InfMain.updateTimes)do
    averageTimes[k]=0
  end
  for k,times in pairs(InfMain.updateTimes)do
    for i,timer in ipairs(times)do
      averageTimes[k]=averageTimes[k]+timer
    end
  end

  for k,times in pairs(InfMain.updateTimes)do
    averageTimes[k]=string.format("%.12f",averageTimes[k]/#times)
  end

  InfCore.PrintInspect(averageTimes,"averageTimes")


  local maxTimes={}
  for k,v in pairs(InfMain.updateTimes)do
    maxTimes[k]=0
  end
  for k,times in pairs(InfMain.updateTimes)do
    for i,timer in ipairs(times)do
      if timer>maxTimes[k] then
        maxTimes[k]=timer
      end
    end
  end

  InfCore.PrintInspect(maxTimes,"maxTimes")

  InfMain.updateTimes={}
end

function this.PrintStrCodes()
  InfCore.Log"IHDebugVars.PrintStrCodes---------------"
  local str32s={
    1500257626,
  --routeEvent types
  --      104983832,
  --      1500257626,
  --      4019510599,
  --      4258228081,
  --      1974185602,
  --      2265318157,
  --      4202868537,
  --      561913624,
  --      --reoute even params
  --      1004142592,
  --      889322046,
  --    6452720,
  --    1631872372,
  --    825241651,
  --    573317666,
  --    975332717,
  --    1936614772,
  --    741358114,
  --routeids
  --      132331158,
  --      205387598,
  --      587733603,
  --      2615639494,
  --      2763127077,
  --      3507759117,
  --      2265318157,
  --      1004142592,
  --      18529,
  --      889322046,
  --      574235246,
  --      104983832,
  --
  --   1631872372,
  }

  --AiRtEvSoldier
  --quest frts aparently have some corruption from json route or whatever they have and has 4 bytes of plain text

  for i,str32 in ipairs(str32s)do
    local str=InfLookup.StrCode32ToString(str32)
    InfCore.Log(str32.."="..str)
  end

  local strings={
    --'rt_heli_quest_0000',
    -- 'rt_quest_heli_d_0000',
    "Wait",
    "Stop",
    "stop",
    "hold",
    "look",
    "face",
    "aim",
    "walk",
    "Hold",
    "Point",
    "Look",
    "Face",
    "Aim",
    "AimPoint",
    "AimPoi",
    "Poi",
    "Walk",
  }

  for i,str in ipairs(strings)do
    local str32=Fox.StrCode32(str)
    InfCore.Log(str.."="..tostring(str32))
  end

end


function this.FileBenchMark()
  InfCore.Log("IHDebugVars: process toMgsvCmdsFilePath benchmark")
  local startTime=os.clock()
  local file,openError=io.open(InfCore.toMgsvCmdsFilePath,"r")
  local openTime=os.clock()-startTime
  local startTime=os.clock()
  local lines=file:read("*all")
  local readTime=os.clock()-startTime
  file:close()
  local startTime=os.clock()
  lines=InfUtil.Split(lines,"\n")
  local splitTime=os.clock()-startTime
  InfCore.Log("openTime:"..openTime)
  InfCore.Log("readTime:"..readTime)
  InfCore.Log("splitTime:"..splitTime)
  InfCore.Log("totalTime:"..openTime+readTime+splitTime)
end

function this.AnalyseUserDataShiz()
--REF init.lua
--  local mainApplication=Application{name="MainApplication"}
--  local game=Game{name="MainGame"}
--  mainApplication:AddGame(game)
--  mainApplication:SetMainGame(game)
--  local mainScene=game:CreateScene"MainScene"
--  local mainBucket=game:CreateBucket("MainBucket",mainScene)
--  game:SetMainBucket(mainBucket)
--REF start.lua
--local setupBucket=mainGame:CreateBucket("SetupBucket",mainScene)

--  local tppGameSequenceInstance=TppGameSequence:GetInstance()
--  tppGameSequenceInstance:SetPhaseController(TppPhaseController.Create())

--local phDaemon=PhDaemon.GetInstance()
--some phD setup

--REF gmpEarnMissions.lua
--local motherbaseManager=TppMotherBaseManager:GetInstance()
--local GmpEarn=motherbaseManager:GetGmpEarn()
--GmpEarn:CreateMissions{

--REF TppUI.lua
--UiCommonDataManager.GetInstance()

--REF start2nd.lua
--local subtitlesDaemon=SubtitlesDaemon.GetInstance()

--REF TppUiBootInit.lua
--UiCommonDataManager.Create()
--HudCommonDataManager.Create()
--local uiCommonDataManager=UiCommonDataManager.GetInstance()
--local uiDaemonInstance=UiDaemon.GetInstance()
--whole bunch of uiDaemonInstance usage

--_radio scripts
--RadioDaemon:GetInstance()

--o50050_sound
--  function this.PlayAlertSiren( switch )
--    local source = "asiren"
--    local tag  = "Loop"
--    local pEvent = "sfx_m_mtbs_siren"
--    local sEvent = "Stop_sfx_m_mtbs_siren"
--    local daemon = TppSoundDaemon.GetInstance()
--
--    if switch == true then
--      daemon:RegisterSourceEvent{
--        sourceName = source,
--        tag = tag,
--        playEvent = pEvent,
--        stopEvent = sEvent,
--      }
--    elseif switch == false then
--      daemon:UnregisterSourceEvent{
--        sourceName = source,
--        tag = tag,
--        playEvent = pEvent,
--        stopEvent = sEvent,
--      }
--    end
--  end



end


function this.AnalizeShiz()
  InfCore.ClearLog()

  local knownKeyNames={
    TppScriptVars={
      CATEGORY_CONFIG = true,
      CATEGORY_GAME_GLOBAL = true,
      CATEGORY_MB_MANAGEMENT = true,
      CATEGORY_MGO = true,
      CATEGORY_MISSION = true,
      CATEGORY_MISSION_RESTARTABLE = true,
      CATEGORY_PERSONAL = true,
      CATEGORY_QUEST = true,
      CATEGORY_RETRY = true,
      CopySlot = true,
      CreateSaveSlot = true,
      DeclareGVars = true,
      DeclareSVars = true,
      DeleteFile = true,
      FileExists = true,
      GROUP_BIT_ALL = true,
      GROUP_BIT_GVARS = true,
      GROUP_BIT_VARS = true,
      GetElapsedTimeSinceLastPlay = true,
      GetFileExistence = true,
      GetFreeStorageSpaceSize = true,
      GetLastResult = true,
      GetNecessaryStorageSpaceSize = true,
      GetProgramVersionTable = true,
      GetSaveState = true,
      GetScriptVersionFromSlot = true,
      GetTotalPlayTime = true,
      GetVarValueInSlot = true,
      InitForNewGame = true,
      InitForNewMission = true,
      IsSavingOrLoading = true,
      IsShowingNoSpaceDialog = true,
      LoadVarsFromSlot = true,
      PLAYER_AMMO_STOCK_TYPE_COUNT = true,
      READ_FAILED = true,
      RESULT_ERROR_FILE_CORRUPT = true,
      RESULT_ERROR_INVALID_STORAGE = true,
      RESULT_ERROR_LOAD_BACKUP = true,
      RESULT_ERROR_NOSPACE = true,
      RESULT_ERROR_OWNER = true,
      RESULT_OK = true,
      ReadSlotFromAreaFile = true,
      ReadSlotFromFile = true,
      RequestAreaFileExistence = true,
      RequestFileExistence = true,
      RequestNecessaryStorageSpace = true,
      STATE_LOADING = true,
      STATE_PROCESSING = true,
      STATE_SAVING = true,
      SVarsIsSynchronized = true,
      SaveVarsToSlot = true,
      SetFileSizeList = true,
      SetSVarsNotificationEnabled = true,
      SetUpSlotAsCompositSlot = true,
      SetVarValueInSlot = true,
      ShowNoSpaceDialog = true,
      StoreUtcTimeToScriptVars = true,
      TYPE_BOOL = true,
      TYPE_FLOAT = true,
      TYPE_INT32 = true,
      TYPE_INT8 = true,
      TYPE_UINT16 = true,
      TYPE_UINT32 = true,
      TYPE_UINT8 = true,
      WRITE_FAILED = true,
      WriteSlotToFile = true
    }
  }

  local moduleName="TppScriptVars"
  local module=_G[moduleName]

  local str32Keys={}
  for key,exists in pairs(knownKeyNames[moduleName])do
    str32Keys[key]=Fox.StrCode32(key)
  end
  InfCore.PrintInspect(str32Keys,moduleName.." str32Keys")

  local moduleValues={}
  for key,exists in pairs(knownKeyNames[moduleName])do
    moduleValues[key]=InfInspect.Inspect(module[key])
  end
  InfCore.PrintInspect(moduleValues,moduleName.." moduleValues")

  local arrayValues={}
  local arrayCountIdent=-285212672
  local arrayCount=module[arrayCountIdent]
  InfCore.PrintInspect(arrayCount,moduleName.." arrayCount")
  if arrayCount then
    for i=0,arrayCount do--tex not sure if index from 0 or 1
      arrayValues[i]=InfInspect.Inspect(module[i])
    end
  end
  InfCore.PrintInspect(arrayValues,moduleName.." arrayValues")


  local tableInfo={
    stringKeys={},
    numberKeys={},
  }
  local function GetTableKeys(checkTable,tableInfo)
    for key,value in pairs(checkTable)do
      if type(key)=="string" then
        tableInfo.stringKeys[key]=true
      elseif type(key)=="number" then
        tableInfo.numberKeys[key]=true
        if type(value)=="table" then
          GetTableKeys(value,tableInfo)
        end
      end
    end
  end

  GetTableKeys(module,tableInfo)
  InfCore.PrintInspect(tableInfo,moduleName.." tableInfo")


  InfCore.PrintInspect(module,moduleName)


  for knownKeyName,str32 in pairs(str32Keys)do
    local foundKey=tableInfo.numberKeys[str32]
    InfCore.Log(knownKeyName.." "..str32.." key in module:"..tostring(foundKey))
  end
end

--tex from IHTearDown
function this.DumpVars()
  local vars=vars

  local rootArrayIdent=-285212671

  local arrayIdent=-285212665
  local arrayCountIdent=-285212666

  local varsTable={}

  for k,v in pairs(vars[rootArrayIdent])do
    varsTable[k]=vars[k]
  end

  local skipKeys={
    __index=true,
    __newindex=true,
  }

  for k,foxTable in pairs(vars)do
    --tex is actually a foxTable
    if type(foxTable)=="table" then
      if foxTable[arrayCountIdent] then
        --InfCore.Log("found foxTable "..k)--DEBUGNOW
        if type(k)=="string" then
          if not skipKeys[k] then
            local foxTableArray=foxTable[arrayIdent]
            if foxTableArray then
              varsTable[k]={}
              local arrayCount=foxTable[arrayCountIdent]
              --InfCore.Log("arrayCount="..arrayCount)--DEBUGNOW
              for i=0,arrayCount-1 do
                varsTable[k][i]=vars[k][i]
              end
            end--if foxTableArray
          end--not skipKeys
        end--k==type string
      end--if foxTable[arrayCountIndex]
    end--foxTable==type table
  end--for vars

  return varsTable
end--DumpVars

--tex dumped vars (via DumpVars()) are key, var, with var either being int or float, or indexed from 0 list of int or float
local nl="\n"
function this.PrintVars(dumpedVars)
  InfCore.Log("PrintVars:")
  local outputPath=[[C:\Projects\MGS\ToolOutput\dump-vars.txt]]

  local printLines={}

  local namesSorted={}

  for varName, var in pairs(dumpedVars)do
    namesSorted[#namesSorted+1]=varName
  end

  table.sort(namesSorted)

  local file,error=io.open(outputPath,"w")
  if not file then
    InfCore.Log(error)
    return
  end
  file:write("--Dumped vars via IHDebugVars.DumpVars,PrintVars",nl)
  file:write("--Note: arrays are indexed from 0",nl)
  for i, varName in ipairs(namesSorted)do
    local line=varName
    local var = dumpedVars[varName]
    if type(var)=="table"then
      line=line.."["..#var.."]"
      line=line.."= { "
      for j=0, #var do
        local currentVar=var[j]
        line=line..tostring(currentVar)..", "
      end
      line=line.."},"
    else
      line=line.." = "..tostring(var)..","
    end
    file:write(line,nl)
  end

  file:close()
end

function this.Dump_ui_isTaskLastCompleted()
  local taskCompletedInfo={}
  local maxMissionTasks={}
  for missionCodeStr,missionEnum in pairs(TppDefine.MISSION_ENUM)do
    local missionCode=tonumber(missionCodeStr)
    local maxMissionTask=TppUI.GetMaxMissionTask(missionCode) or 0
    local info={}
    taskCompletedInfo[missionCode]=info
    maxMissionTasks[missionCode]=maxMissionTask
    InfCore.Log(missionCode..": maxMissionTask: "..maxMissionTask..", isTaskCompleted:")
    local ui_isTaskLastComletedStr="["
    for taskIndex=0,TppDefine.MAX_MISSION_TASK_COUNT-1 do
      local missionTaskIndex=missionEnum*TppDefine.MAX_MISSION_TASK_COUNT+taskIndex

      local isTaskLastCompleted=0
      if gvars.ui_isTaskLastComleted[missionTaskIndex] then
        isTaskLastCompleted=1
      end
      info[taskIndex+1]=isTaskLastCompleted
      ui_isTaskLastComletedStr=ui_isTaskLastComletedStr..tostring(isTaskLastCompleted)..","
    end
    ui_isTaskLastComletedStr=ui_isTaskLastComletedStr.."]"
    InfCore.Log(ui_isTaskLastComletedStr)
  end
  InfCore.PrintInspect(taskCompletedInfo,"taskCompletedInfo")--DEBUG
  InfCore.PrintInspect(maxMissionTasks,"maxMissionTasks")--DEBUG

  --tex dumped from a 100% completed using above
  --alternatively could hand compile from <mission>_sequence .missionObjectiveDefine s
  --    local vanillaTasks={
  --      [10010] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [10020] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10030] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10033] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10036] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10040] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10041] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10043] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10044] = { 1, 0, 1, 1, 1, 1, 1, 1 },
  --      [10045] = { 0, 1, 1, 1, 1, 1, 1, 0 },
  --      [10050] = { 1, 1, 1, 0, 0, 1, 0, 0 },
  --      [10052] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10054] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10070] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10080] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10081] = { 0, 1, 1, 1, 0, 0, 0, 0 },
  --      [10082] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10085] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10086] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10090] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10091] = { 0, 1, 0, 1, 1, 1, 1, 1 },
  --      [10093] = { 1, 0, 1, 1, 1, 1, 1, 0 },
  --      [10100] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10110] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10115] = { 1, 0, 0, 0, 0, 0, 0, 0 },
  --      [10120] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10121] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10130] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10140] = { 1, 1, 1, 1, 0, 0, 0, 0 },
  --      [10150] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10151] = { 1, 1, 1, 0, 0, 0, 0, 0 },
  --      [10156] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10171] = { 1, 1, 0, 1, 1, 1, 1, 1 },
  --      [10195] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10200] = { 0, 0, 1, 1, 1, 1, 1, 1 },
  --      [10211] = { 1, 0, 1, 1, 1, 1, 1, 0 },
  --      [10230] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [10240] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [10260] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10280] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [11033] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [11036] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11041] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11043] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11044] = { 1, 0, 1, 1, 1, 1, 1, 1 },
  --      [11050] = { 1, 1, 1, 0, 0, 1, 0, 0 },
  --      [11052] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11054] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11080] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11082] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [11085] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11090] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11091] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11115] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11121] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11130] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11140] = { 1, 1, 1, 1, 0, 0, 0, 0 },
  --      [11151] = { 1, 1, 1, 0, 0, 0, 0, 0 },
  --      [11171] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11195] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11200] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11211] = { 0, 0, 0, 0, 0, 0, 0, 0 }
  --    }
end

--menus
this.registerMenus={
  "devInAccMenu",
  "devInMissionMenu",
}

this.registerIvars={
  "playRadio",
  "setSTORY_MISSION_LAYOUT_CODE",
  "debug_CallVoice",
  "debug_CallConversation",
  "selectSpeechObject",
  "selectSpeechObject2",
}

this.devInAccMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "Ivars.setSTORY_MISSION_LAYOUT_CODE",
    "InfMenuCommands.RefreshPlayer",--DEBUGNOW
    "InfMenuCommands.ShowImguiDemo",
    "Ivars.quest_useAltForceFulton",--DEBUGNOW
    "Ivars.sys_increaseMemoryAlloc",--DEBUGNOW
    "IHDebugVars.DEBUG_SomeShiz",
    "IHDebugVars.DEBUG_SomeShiz2",
    "IHDebugVars.DEBUG_SomeShiz3",
    --"Ivars.customBodyTypeMB_ALL",--DEBUGNOW
    "Ivars.selectEvent",
    --"Ivars.customSoldierTypeMISSION",--TODO:
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "InfLookup.DumpValidStrCode",
    --TODO: debugmodeall command/profile
    --"Ivars.enableWildCardHostageFREE",--WIP
    --"Ivars.enableSecurityCamFREE",
    "InfMenuCommands.ForceRegenSeed",
    "Ivars.debugValue",
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "Ivars.log_SetFlushLevel",
  }
}--devInAccMenu

this.devInMissionMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "Ivars.selectSpeechObject",
    "Ivars.selectSpeechObject2",
    "Ivars.debug_CallConversation",
    "Ivars.debug_CallVoice",
    "Ivars.playRadio",
    "InfMenuCommands.ShowImguiDemo",
    "Ivars.cam_disableCameraAnimations",
    "IHDebugVars.DEBUG_SomeShiz",
    "IHDebugVars.DEBUG_SomeShiz2",
    "IHDebugVars.DEBUG_SomeShiz3",
    "InfMenuCommands.DEBUG_WarpToObject",
    "Ivars.warpToListPosition",
    "Ivars.warpToListObject",
    "InfHelicopter.RequestHeliLzToLastMarker",
    "InfHelicopter.RequestHeliLzToLastMarkerAlt",
    "InfHelicopter.ForceExitHeli",
    "InfHelicopter.ForceExitHeliAlt",
    "InfHelicopter.PullOutHeli",
    "InfHelicopter.ChangeToIdleStateHeli",
    "Ivars.disablePullOutHeli",
    --"Ivars.selectedCp",
    --"InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "Ivars.selectedCp",
    "InfUserMarker.PrintLatestUserMarker",
    "InfMenuCommands.SetAllZombie",
    "InfMenuCommands.CheckPointSave",
    "Ivars.manualMissionCode",
    "Ivars.setCamToListObject",
    "Ivars.dropLoadedEquip",
    "Ivars.dropTestEquip",
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.debugValue",
    "InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
    --"Ivars.parasitePeriod_MIN",
    --"Ivars.parasitePeriod_MAX",
    --"InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
    "InfLookup.DumpValidStrCode",
    "InfMenuCommands.SetAllFriendly",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfCore.ClearLog",
  }
}--devInMissionMenu

--DEBUGNOW CULL
local addedMenus=false
function this.AddDevMenus()
  if addedMenus then
    return
  end
  addedMenus=true

  InfCore.Log"AddDevMenus"
  local safeSpaceMenu=InfMenuDefs.safeSpaceMenu.options
  local inMissionMenu=InfMenuDefs.inMissionMenu.options
  if not isMockFox then
    table.insert(safeSpaceMenu,1,'IHDebugVars.devInAccMenu')
    table.insert(inMissionMenu,1,'IHDebugVars.devInMissionMenu')
  end
end--AddDevMenus
--< menus

--menuCommands
local toggle1=true
local index1Min=1
local index1Max=3
local index1=index1Min
local count=0
local increment=1
this.log=""
this.DEBUG_SomeShiz=function()
  count=count+1
  InfCore.Log("---------------------DEBUG_SomeShiz---------------------"..count)

  this.SetSaluteVoiceList()

  --  InfCore.Log("mbLayoutCode:"..vars.mbLayoutCode)
  --
  --gvars.mis_nextMissionCodeForEmergency=30050
  --gvars.mis_nextMissionStartRouteForEmergency=nil
  --gvars.mis_nextLayoutCodeForEmergency=30
  --gvars.mis_nextClusterIdForEmergency=0


  if true then return end

  InfCore.Log("vars.playerSkillId:"..tostring(vars.playerSkillId))

  InfCore.PrintInspect(PlayerStatus,"PlayerStatus")
  PlayerStatus.TEST=999
  InfCore.PrintInspect(PlayerStatusEx[PlayerStatusEx.DASH])

  InfCore.PrintInspect(PlayerStatusEx,"PlayerStatusEx")

  --mockmod gen ssd
  --  PlayerStatus = {
  --    CARRY = 148,
  --    CRAWL = 6,
  --    DEAD = 71,
  --    NORMAL_ACTION = 7,
  --    PARTS_ACTIVE = 158,
  --    SQUAT = 5,
  --    STAND = 4,
  --    __index = "<function>",
  --    __newindex = "<function>"
  --  }
  --
  --  --tpp
  --    PlayerStatus = {
  --    BINOCLE = 58,
  --    CARRY = 134,
  --    CRAWL = 6,
  --    CURTAIN = 140,
  --    DASH = 23,
  --    NORMAL_ACTION = 7,
  --    PARTS_ACTIVE = 145,
  --    SQUAT = 5,
  --    STAND = 4,
  --    __index = "<function>",
  --    __newindex = "<function>"
  --  },

  local testValues={
    "STAND",
    "SQUAT",
    "CRAWL",
    "NORMAL_ACTION",
    "DASH",
    "BINOCLE",
    "CARRY",
    "CURTAIN",
    "PARTS_ACTIVE",

    "DEAD",
    --
    --MGO ?
    "REALIZED",
    "UNCONSCIOUS",
    "CQC_HOLD_BY_ENEMY",
    "FULTONED",
    "CHARMED",
    --SSD
    "REQUEST_EMOTION_COMBINATION",
    --wiki bbb
    "PARALLEL_MOVE",
    "IDLE",
    "GUN_FIRE",
    "GUN_FIRE_SUPPRESSOR",
    "STOP",
    "WALK",
    "RUN",
    "ON_HORSE",
    "ON_VEHICLE",
    "ON_HELICOPTER",
    "HORSE_STAND",
    "HORSE_HIDE_R",
    "HORSE_HIDE_L",
    "HORSE_IDLE",
    "HORSE_TROT",
    "HORSE_CANTER",
    "HORSE_GALLOP",
    "SUBJECT",
    "INTRUDE",
    "LFET_STOCK",
    "CUTIN",
    "DEAD_FRESH",
    "NEAR_DEATH",
    "NEAR_DEAD",
    "FALL",
    "CBOX",
    "CBOX_EVADE",
    "TRASH_BOX",
    "TRASH_BOX_HALF_OPEN",
    --
    "INJURY_LOWER",
    "INJURY_UPPER",
    "CURE",
    "CQC_CONTINUOUS",
    "BEHIND",
    "ENABLE_TARGET_MARKER_CHECK",
    "VOLGIN_CHASE",
    "TEST",
  }

  local statuses={}

  for i,playerStatus in ipairs(testValues)do
    table.insert(statuses,"PlayerStatus."..playerStatus.."="..tostring(PlayerStatus[playerStatus]))
  end
  InfCore.PrintInspect(statuses,"statuses")

  if true then return end

  local NULL_ID=GameObject.NULL_ID
  local GetGameObjectId=GameObject.GetGameObjectId
  local GetTypeIndex=GameObject.GetTypeIndex
  local SendCommand=GameObject.SendCommand

  for n=1,#InfNPCHeli.heliList do
    local heliName=InfNPCHeli.heliList[n]
    local heliObjectId = GetGameObjectId(heliName)
    InfCore.Log("bluuurg "..heliName)--DEBUGNOW
    if heliObjectId==NULL_ID then
      InfCore.Log(heliName.."==NULL_ID")--DEBUG, will trigger in battlegear hangar since it's a different pack --DEBUG
    else
      InfCore.Log("blooorg "..heliName)--DEBUGNOW
      local typeIndex=GetTypeIndex(heliObjectId)
      if typeIndex==TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
        InfCore.Log("spuuurg "..heliName)--DEBUGNOW

        --DEBUGNOW
        local heliMeshTypes={
          "uth_v00",
          "uth_v02",
          "uth_v03",
        }
        --DEBUGNOW local meshType=heliMeshTypes[math.random(#heliMeshTypes)]
        local meshType=heliMeshTypes[index1]

        GameObject.SendCommand(heliObjectId,{id="SetMeshType",typeName=meshType})
      end--if GAME_OBJECT_TYPE_ENEMY_HELI
    end--if heliname
  end--for heliList


  if true then return end

  local customSoldierType=IvarProc.GetForMission("customSoldierType",vars.missionCode)
  InfCore.Log("customSoldierType:"..tostring(customSoldierType))

  --for i=1,100 do
  --InfCore.Log(i)
  ---InfExtToMgsv.GetPlayerPos()
  --end

  if true then return end

  local markerPos=InfUserMarker.GetMarkerPosition(0)
  InfCore.PrintInspect(markerPos,"markerPos")
  local markerPos=InfUserMarker.GetMarkerPosition(nil)
  InfCore.PrintInspect(markerPos,"markerPos 2nd")

  local markerIndex=0
  vars.userMarkerPosX[markerIndex]=0+index1
  vars.userMarkerPosY[markerIndex]=0+index1
  vars.userMarkerPosZ[markerIndex]=0+index1

  InfCore.PrintInspect(vars.userMarkerGameObjId[markerIndex],"userMarkerGameObjId")

  --local dumpedVars=IHDebugVars.DumpVars()
  --IHDebugVars.PrintVars(dumpedVars)


  if true then return end

  local scriptBlockNames={
    "animal_block",
    "demo_block",
    "quest_block",
    "mission_block",
    "npc_block",
    "reinforce_block",
    "cypr_small_mission_block_1",
    "cypr_small_mission_block_2",
    "cypr_small_mission_block_3",
    "cypr_demo_block",
  }

  for i,blockName in ipairs(scriptBlockNames)do
    InfCore.PrintInspect(ScriptBlock.GetScriptBlockId(blockName),blockName)
  end

  if true then return end


  InfCore.PrintInspect(Time,"Time")
  local timeResult={
    deltaGameTime=Time.GetDeltaGameTime(),
    gameTimeRate=Time.GetGameTimeRate(),
    frameTime=Time.GetFrameTime(),
    rawElapsedTimeSinceStartUp=Time.GetRawElapsedTimeSinceStartUp(),
    frameIndex=Time.GetFrameIndex(),
  }

  for name,result in pairs(timeResult)do
    InfCore.Log(name..":"..tostring(result))
  end

  if true then return end

  InfUAV.SetupUAV()
  if true then return end
  local fileList=File.GetFileListTable("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")
  InfCore.PrintInspect(fileList,"fileList")


  --    GetBlockPackagePath = "<function>",
  --    GetFileListTable = "<function>",
  --    GetReferenceCount = "<function>",

  local identifier="HelispaceLocatorIdentifier"
  --  local locatorName="BuddyQuietLocator"
  local key="BuddyDDogLocator"
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  local dataSet=Data.GetDataSet(data)
  local dataSetFile=DataSet.GetDataSetFile(dataSet)
  local  blockPackagePath=File.GetBlockPackagePath(dataSetFile)

  -- local  blockPackagePath=File.GetBlockPackagePath("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")

  -- local  blockPackagePath=File.GetBlockPackagePath(data)
  InfCore.PrintInspect(blockPackagePath,"blockPackagePath")

  --local  referenceCount=File.GetReferenceCount("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")
  local  referenceCount=File.GetReferenceCount("Tpp/Scripts/Equip/EquipMotionData.lua")
  InfCore.PrintInspect(referenceCount,"referenceCount")

  if true then return end

  InfCore.DebugPrint("index1:"..index1)
  index1=index1+increment
  if index1>index1Max then
    index1=index1Min
  end
  toggle1=not toggle1
end

local index2Min=300
local index2Max=334
local index2=index2Min
this.DEBUG_SomeShiz2=function()
  InfCore.Log("---DEBUG_SomeShiz2---")

  -- vars.missionCode=12345--

  local function PrintInfo(object,objectName)
    InfCore.Log("PrintInfo "..objectName..":")
    InfCore.PrintInspect(object,objectName.." Inspect")
    InfCore.PrintInspect(getmetatable(object),objectName.." Inspect metatable")
    InfCore.Log(objectName.." tostring:"..tostring(object))
  end

  --  --tex in helispace \chunk3_dat\Assets\tpp\pack\mission2\heli\h40050\h40050_area_fpkd\Assets\tpp\level\mission2\heli\h40050\h40050_sequence.fox2 (or equivalent h40010,h40020 fox2) is loaded
  --  --it has a DataIdentifier named HelispaceLocatorIdentifier
  --  --DataIdentifier have key / nameInfArchive paths to other Data / Entities, this is what DataIdentifier.GetDataWithIdentifier used to return a Data entity.
  --  local identifier="HelispaceLocatorIdentifier"
  --  --  local locatorName="BuddyQuietLocator"
  --  local key="BuddyDDogLocator"
  --  InfCore.Log("identifier: "..identifier)
  --  InfCore.Log("key: "..key)
  --  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  --  PrintInfo(data,"data")
  --  --OUTPUT
  --  --PrintInfo data:
  --  --data Inspect=<userdata 1>
  --  --data Inspect metatable={
  --  --  __index = <function 1>,
  --  --  __newindex = <function 2>,
  --  --  __tostring = <function 3>
  --  --}
  --  --data tostring:Locator: 0x000000011624FF40
  --
  --  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  --  --data:GetClassName()="Locator"
  --  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  --  --data:GetPropertyList()={ "name", "referencePath", "parent", "transform", "shearTransform", "pivotTransform", "inheritTransform", "visibility", "selection", "worldMatrix", "worldTransform", "size" }
  --  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  --  --data:GetPropertyInfo('name')={
  --  --  arraySize = 1,
  --  --  container = "StaticArray",
  --  --  dynamic = false,
  --  --  export = "RW",
  --  --  name = "name",
  --  --  storage = "Instance",
  --  --  type = "String"
  --  --}
  --  --tex as you can see the properties of entites can be accessed with dot notation
  --  InfCore.PrintInspect(data.name,"data.name")
  --  --data.name="BuddyDDogLocator"
  --  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --  --data.referencePath="BuddyDDogLocator"

  ---
  InfCore.Log("---------")
  local identifier="PlayerDataIdentifier"
  --  local locatorName="BuddyQuietLocator"
  local key="PlayerGameObject"
  InfCore.Log("identifier: "..identifier)
  InfCore.Log("key: "..key)

  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  PrintInfo(data,"data")
  --OUTPUT
  --PrintInfo data:
  --data Inspect=<userdata 1>
  --data Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --data tostring:Locator: 0x000000011624FF40

  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  --data:GetClassName()="GameObject"
  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  --data:GetPropertyList()={ "name", "referencePath", "typeName", "groupId", "totalCount", "realizedCount", "parameters" }
  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  --data:GetPropertyInfo('name')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --tex as you can see the properties of entites can be accessed with dot notation
  InfCore.PrintInspect(data.name,"data.name")
  --data.name="PlayerGameObject"
  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --data.referencePath="PlayerGameObject"

  ---
  InfCore.PrintInspect(data:GetPropertyInfo("parameters"),"data:GetPropertyInfo('parameters')")
  --data:GetPropertyInfo('parameters')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --tex as you can see the properties of entites can be accessed with dot notation
  InfCore.PrintInspect(data.parameters,"data.parameters")
  --data.parameters=
  local parameters=data.parameters
  InfCore.PrintInspect(tostring(parameters),"tostring(parameters)")


  -- InfCore.PrintInspect(parameters:GetPropertyList(),"parameters:GetPropertyList()")
  IHH.TestCallToIHHook(data)
  --DEBUGNOW

  InfCore.DebugPrint("index2:"..index2)
  index2=index2+1
  if index2>index2Max then
    index2=index2Min
  end
end

local index3Min=1
local index3Max=10
local index3=index3Min
local toggle3=false
this.DEBUG_SomeShiz3=function()
  InfCore.Log("---DEBUG_SomeShiz3---")



  local routes={
    --      "rt_slopedWest_d_0000_sub",
    --        "rt_slopedWest_d_0004",
    --        "rt_slopedWest_d_0003",
    "rt_slopedWest_d_0002",
    --        "rt_slopedWest_d_0001",
    "rt_slopedWest_d_0005",

    --        "rt_slopedWest_n_0000",
    "rt_slopedWest_n_0004",
    --        "rt_slopedWest_n_0003",
    --        "rt_slopedWest_n_0002",
    --        "rt_slopedWest_n_0001",
    --        "rt_slopedWest_n_0005",

    --        "rt_slopedWest_c_0000",
    --        "rt_slopedWest_c_0003",
    --        "rt_slopedWest_c_0001",
    --        "rt_slopedWest_c_0004",
    --        "rt_slopedWest_c_0002",
    "rt_slopedWest_c_0004",

    "rt_slopedWest_s_0000",
  --"rt_slopedWest_s_0001",
  }
  index3Max=#routes

  local soldierName="sol_slopedWest_0000"
  local routeName=routes[index3]
  InfCore.DebugPrint(routeName)
  InfSoldier.WarpSetRoute(soldierName,routeName)

  --  local objectName = "sol_slopedWest_0000"
  --  local gameId=GetGameObjectId(objectName)
  --  local objectPos=GameObject.SendCommand(gameId,{id="GetPosition"})
  --  if objectPos==nil then
  --    InfCore.Log("GetPosition nil for "..objectName,true)
  --  else
  --    InfCore.Log(objectName.." pos:".. objectPos:GetX()..",".. objectPos:GetY().. ","..objectPos:GetZ(),true)
  --  end
  --
  --  if true then return end
  --
  --  InfCore.PrintInspect(TppLandingZone.assaultLzs,"assaultLzs")
  --  InfCore.PrintInspect(TppLandingZone.missionLzs,"missionLzs")
  --
  --  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  --  local closestRoute
  --  if lastMarkerIndex==nil then
  --    InfMenu.PrintLangId"no_marker_found"
  --    return
  --  else
  --    local markerPostion=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
  --    markerPostion={markerPostion:GetX(),markerPostion:GetY(),markerPostion:GetZ()}
  --
  --    closestRoute=InfLZ.GetClosestLz(markerPostion)
  --  end
  --
  --  InfCore.PrintInspect(closestRoute,"closestRoute")

  InfCore.DebugPrint("index3:"..index3)
  index3=index3+1
  if index3>index3Max then
    index3=index3Min
  end
  toggle3=not toggle3
end
--< menuCommands


--see PlayMusicFromQuietRoom
local quietRadioNames={
  "[Autoplay]",
  "Heavens Divide",
  "Koi no Yokushiryoku",
  "Gloria",
  "Kids In America",
  "Rebel Yell",
  "The Final Countdown",
  "Nitrogen",
  "Take On Me",
  "Ride A White Horse",
  "Maneater",
  "A Phantom Pain",
  "Only Time Will Tell",
  "Behind the Drapery",
  "Love Will Tear Us Apart",
  "All the Sun Touches",
  "TRUE",
  "Take The DW",
  "Friday Im In Love",
  "Midnight Mirage",
  "Dancing With Tears In My Eyes",
  "The Tangerine",
  "Planet Scape",
  "How 'bout them zombies ey",
  "Snake Eater",
  "204863",
  "You Spin Me Round",
  "Quiet Life",
  "She Blinded Me With Science",
  "Dormant Stream",
  "Too Shy",
  "Peace Walker",--not in QUIET_RADIO_TELOP_LANG_LIST
}--quietRadioNames

this.playRadio={
  save=IvarProc.CATEGORY_EXTERNAL,
  --range={min=0,max=31},
  --range = 0=OFF,#list
  settings=quietRadioNames,
  OnChange=function(self,setting,previousSetting)
    --if setting>0 or previousSetting~=0 then
    if f30050_sequence and mvars.f30050_quietRadioName then
      f30050_sequence.PlayMusicFromQuietRoom()
    end
    --end
  end,
}--quietRadioMode

--REF
--this.OFFLINE_MOHTER_BASE_LAYOUT_CODE=0
--this.STORY_MISSION_LAYOUT_CODE={
--  [10030]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [10115]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [11115]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [10240]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [30050]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [30051]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
--  [30150]=500,
--  [30250]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE
--}
--this.INVALID_LAYOUT_CODE=65535
--this.STORY_MISSION_CLUSTER_ID={
--  [10030]=0,
--  [10115]=2,
--  [11115]=2,
--  [10240]=7,
--  [30050]=0,
--  [30150]=0,
--  [30250]=7
--}

function this.AddFOBLayoutPack(missionCode)
  local missionTypeName,missionCodeName=this.GetMissionTypeAndMissionName(missionCode)
  if missionCode==50050 then
  end
  if(missionCode==50050)or(missionCode==10115)or(missionCode==30050 and vars.mbLayoutCode>3)then--tex DEBUGNOW added or 30050 passthrough
    local layoutPath="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionCodeName..("/"..(missionCodeName..string.format("_area_ly%03d",vars.mbLayoutCode))))))
    local layoutPack=layoutPath..".fpk"
    local clusterId=vars.mbClusterId
    if(missionCode==10115)then
      clusterId=TppDefine.CLUSTER_DEFINE.Develop
    end
    local clusterLayoutPack=layoutPath..(string.format("_cl%02d",clusterId)..".fpk")
    this.AddMissionPack(layoutPack)
    this.AddMissionPack(clusterLayoutPack)
  elseif missionCode==30050 then
    local layoutPack="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionCodeName..("/"..(missionCodeName..string.format("_ly%03d",vars.mbLayoutCode))))))
    local fpkPath=layoutPack..".fpk"
    this.AddMissionPack(fpkPath)
  end
end

function this.GoToEmergencyMission()
  local emergencyMissionCode=gvars.mis_nextMissionCodeForEmergency
  local startRoute
  if emergencyMissionCode~=TppDefine.SYS_MISSION_ID.FOB then
    if gvars.mis_nextMissionStartRouteForEmergency~=0 then
      startRoute=gvars.mis_nextMissionStartRouteForEmergency
      --tex DEBUGNOW HACK OFF
      --    else
      --      return
    end
  end
  local mbLayoutCode
  if gvars.mis_nextLayoutCodeForEmergency~=TppDefine.INVALID_LAYOUT_CODE then
    mbLayoutCode=gvars.mis_nextLayoutCodeForEmergency
  else
    mbLayoutCode=TppDefine.STORY_MISSION_LAYOUT_CODE[vars.missionCode]or TppDefine.OFFLINE_MOHTER_BASE_LAYOUT_CODE--RETAILBUG: since day0, was TppDefine.STORY_MISSION_LAYOUT_CODE[missionCode]
  end
  local clusterId=2
  if gvars.mis_nextClusterIdForEmergency~=TppDefine.INVALID_CLUSTER_ID then
    clusterId=gvars.mis_nextClusterIdForEmergency
  end
  this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,nextMissionId=emergencyMissionCode,nextHeliRoute=startRoute,nextLayoutCode=mbLayoutCode,nextClusterId=clusterId}
end

this.setSTORY_MISSION_LAYOUT_CODE={
  --save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},
  OnChange=function(self,setting,previousSetting)

    InfCore.DebugPrint"terrible hack"
    InfCore.Log("setSTORY_MISSION_LAYOUT_CODE")
    TppPackList.AddFOBLayoutPack=this.AddFOBLayoutPack
    TppMission.GoToEmergencyMission=this.GoToEmergencyMission
    TppDefine.STORY_MISSION_LAYOUT_CODE[10115]=setting
    TppDefine.STORY_MISSION_LAYOUT_CODE[30050]=setting

    gvars.mis_nextMissionCodeForEmergency=30050
    gvars.mis_nextMissionStartRouteForEmergency=nil
    gvars.mis_nextLayoutCodeForEmergency=setting
    gvars.mis_nextClusterIdForEmergency=0
    InfCore.Log("setSTORY_MISSION_LAYOUT_CODE done")
  end,
}--setSTORY_MISSION_LAYOUT_CODE

--DEBUGNOW hijack to experiment
--vox_ ?
--bgm_ ?
quietRadioNames={
  "sfx_m_mtbs_nature",
  "sfx_f_supply_flare",
  "bgm_mission_start",
  "tp_m_10100_01",
  "bgm_mission_clear_heli",
  "tp_bgm_10_01",
  "sfx_m_tp_10_01",
  "sfx_m_10_01",
  "sfx_tp_10_01",
}--quietRadioNames
this.playRadio.settings=quietRadioNames
this.playRadio.OnChange=function(self,setting,previousSetting)
  --local radioName=string.format("sfx_m_prison_radio_%02d",radioIndex)
  local radioName=self.settings[setting+1]
  local soundPos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  --    TppMusicManager.PlayPositionalMusic(radioName,soundPos)
  --TppSoundDaemon.PostEvent(radioName)
  TppSoundDaemon.PostEvent3D(radioName,soundPos)
end

--DEBUGNOW REF
function this.PlayMusicFromQuietRoom()
  local totalPlayTime = TppScriptVars.GetTotalPlayTime()
  local radioIndex = totalPlayTime%(#QUIET_RADIO_TELOP_LANG_LIST) + 1
  if Ivars.quietRadioMode:Is()>0 then--tex
    radioIndex=Ivars.quietRadioMode:Get()
  end--
  mvars.f30050_quietRadioName = string.format("sfx_m_prison_radio_%02d",radioIndex )
  mvars.f30050_requestShowUIQuietRadioName = QUIET_RADIO_TELOP_LANG_LIST[radioIndex]
  local position = Tpp.GetLocator("quiet_AssetIdentifier", "radio_pos")
  if position == nil then
    return
  end
  TppMusicManager.PlayPositionalMusic( mvars.f30050_quietRadioName, Vector3(position[1], position[2], position[3]) )

  mvars.f30050_requestShowUIQuietRadio = true
  InfCore.Log("PlayQuietRadio:"..tostring(mvars.f30050_quietRadioName) )
end
function this.StopMusicFromQuietRoom()
  if mvars.f30050_quietRadioName then
    TppMusicManager.StopPositionalMusic()
    mvars.f30050_quietRadioName = nil
    mvars.f30050_requestShowUIQuietRadioName = nil
  end
end

function this.ShowMusicTeropInQuietRoom( radioName )
  if mvars.f30050_requestShowUIQuietRadioName and mvars.f30050_isInQuietAudioTelopArea then

    if TppMusicManager.IsPlayingPositionalMusic( radioName ) then

      TppUiCommand.ShowMusicTelop( mvars.f30050_requestShowUIQuietRadioName, 10.0 )
      mvars.f30050_requestShowUIQuietRadioName = nil
      return
    end
  end
end

--TODO: search CallVoice
--TODO: find out exactly what soundbank(s) these are in
--assuming DD_vox_ene for now
this.speechLabels={
  --other voice labels that have nothing to do with salute but might be cool to include:
  --Enemy Voices Sneak (NORMAL/player not spotted status)
  {"EVS040","very soft Phew/Ahh",},-- Relaxing
  {"EVS060","(exersion) Hmph/Hup",},--Light exertion lines
  {"EVS090","Rrrgh",},--Soldier gets something in his eye.
  {"EVS100","(tired) sigh",},--
  {"EVS110","(frustrated) Dammit",},--Irritated
  {"EVS120","He's taking so long...",},--Waiting for comrade - General purpose
  {"EVS130","(to self) I'm going.",},--Can't bear waiting any longer, goes alone

  --Enemy Voiced Notice
  {"EVN060","soft huh?",},-- From nearby: Enemy spots something
  {"EVN070","real soft hmm",}, -- From nearby: Checking it out
  {"EVN080","you there!|hey!",}, -- From nearby: Spotted something suspicious

  {"EVN100","soft sigh",}, -- From nearby: Nothing spotted
  {"EVN110","soft huh?!",}, -- Heard a knock, footsteps, or other unusual noise
  {"EVN120","The hell?!|Wha-?!|What was that?!",},-- Reacting to an explosion or other loud noise
  {"EVN130","soft Hm? Huh...",}, -- Checking last known position
  {"EVN140","He's here!",}, -- Spotting a suspicious person while searching/on guard, and engaging him
  {"EVN150","Contact!|Hostile!",}, --The suspicious person spotted has been identified as an enemy (the player) and is engaged.
  {"EVN170","Hey - look over there.",},--Spotting something suspicious, and attracting a comrade's attention.
  {"EVN180","Hey, that guy over there - who is it?",},--Spotted an intruder, getting a comrade to check it out.
  {"EVN190","Fine, I'll check it out.",},--Responses to EV170, EV180.
  {"EVN200","Fine, I'll check it out.",},--Responses to EV170, EV180.
  {"EVN210","There's nothing there..",},--Responses to EV170, EV180.
  {"EVN220","You see somebody there?",},--Nearby comrade suddenly checks something out.
  {"EVN230","Gotta check it. Let's go.",},--Going in a pair to check it out.
  {"EVN240","Got it.",},--Responses to EVN230.
  {"EVN250","I'll go check it out.",},--Spotter goes to check it out himself.
  {"EVN260","Go for it, I'll wait here.",},--Responses to EV250.
  {"EVN270","My imagination, it's nothing.",},--
  {"EVN280","I'm relieving you.",},--not working, need condition? Relieving a sentry
  {"EVN290","Heeey, I'm relieving you!",},--not working, need condition? Relieving a sentry (shouted from a distance).
  {"EVN300","What's the matter, boy? (talking to dog)",},--Asking a barking dog what's up.
  {"EVN301","Calming the dog.",},--
  {"EVN310","Shut up, you stupid mutt.",},--Telling a barking dog to shut up.
  {"EVN320","S-Somebody get over here!",},--interrogate: "Call out"
  {"EVN330","Can I get a hand over here? One guy's fine!",},--not working, need condition? interrogation: 'Call one guy',--
  {"EVN331","Be right there.",},--Responding to being called.
  {"EVN340","Come here a second.",},--Calling comrades (close range)
  {"EVN341","Need a hand here!",},--Calling comrades (long range)
  --later in .xslt under ◆Enemy soldier lines_basic◆
  {"EVN311","Shoo, shoo! (to animal)",},--chasing away an animal
  {"EVN312","Get Lost! (to animal angry)",},--
  {"EVN350","cursing something (multi-purpose)",},--
  --TODO: continues up to EVN370

  --Enemy Voices Reaction
  {"EVR010","(shock) What the!",}, --
  {"EVR011","(shock,extreme) Huh!",}, --
  {"EVR012","(shock,little) Ah!",}, --
  {"EVR020","Shit! Enemy fire!",}, --Taking gunfire
  {"EVR050","(Surprised at the bullet impact) Ah",}, --not working--Takes fire and looks around to spot the player, but is unable to find him and is tense/shaken.
  {"EVR061","Aaaahh (player gun on enemy)",}, --Player has their gun on the enemy,
  {"EVR062","Huh? Interrogated, no english",},--
  {"EVR063","Wh-what does that mean? (Ru/Af)",},--doesnt work Interrogated, but unable to understand English
  {"EVR070","hahh! (Short outbursts to steel himself.)",}, --Taking gunfirePlayer has their gun on the enemy, threatening him. Bold reactions.
  --..TODO up to EVR100
  --!
  {"EVR110","(see sleeping comrade) You lazy son of a..."},--
  --TODO up to EVR123
  {"EVR130","Ew, Ughh etc (bad smell)"},--
  --.. TODO: up to EVR160
  {"EVR180","The hell you doing? (spotted hold-up)",}, --Spotting a comrade in hold-up status
  {"EVR190","Fucking kidding me!"},--Enemy responses when CP rejects their requests for reinforcement.

  {"EVR200","Ahhhhhhhhh!! (fultoned angry)"},--
  {"EVR201","Wha?! (fultoned surprised)"},--
  {"EVR202","Wa-hoo! (fultoned excited)"},--

  --..TODO: continues up to EVR211
  --..TODO: contines later in .xls from EVR084
  {"EVR220","(chuckles)",},--spotted Snake while he's wearing the chicken hat
  {"EVR230","(chuckles)",},--spotted Snake while he's wearing the chicken hat

  --Enemy Voices Damage/Status changes
  --TODO up to EVD60
  {"EVD070","General coughs.",},--doesnt seem to trigger, needs condition?
  --TODO:
  {"EVD110","Wh-whoah! (Near-misstep)"},--cliff
  --..TODO: up to EVD270
  --TODO later in .xsl from EVD171

  --Enemy Voices Battle
  {"EVB010","Small psych-up shouts.",},
  {"EVB030","Big psych-up shouts.",},
  {"EVB040","Mammoth psych-up shouts.",},--doesnt seem to trigger, needs condition?
  --TODO:
  {"EVB090","Ready!"},--not working Letting team know reload is complete.
  --..TODO: continues up to EVB100

  --Enemy Voices Comrades (Battle,Teamwork)
  --TODO
  {"EVC200","Watch out!",},--Warning calls.
  --TODO up to EVC240
  {"EVC250","Go! (to comrades)",},
  {"EVC260","Go go go! (to comrades)",},
  --TODO: up to EVC290
  {"EVC320","Check your ammo! (to comrades)",},
  {"EVC330","I'm OK (to comrades)",},
  {"EVC340","You OK? (to comrades)",},
  --TODO
  {"EVC400","(In battle, tense) Copy!",},

  --TODO: up to EVC440

  --Enemy Voices E? Post-combat voices - Caution
  --TODO EVE
  {"EVE030","Roger that!",},--Checking last known point of contact (response)
  {"EVE040"," Hold it.",},--Clearing. Halt orders.
  {"EVE050","Clear.",},--Clearing. Announcing clear
  --TODO
  {"EVE080","No...|I'll get that bastard...",},--When dying comrade passes.
  --TODO: later in .xls
  {"EVE110","Find 'em?!"},--
  {"EVE120","Not here."},-- post-combat_caution dialog answer to 110
  {"EVE130","I'll look over here."},
  {"EVE140","You try over that way."},--
  {"EVE150","Search complete! Search complete!"},--
  {"EVE160","Returning to post. Stay on the lookout."},--
  {"EVE170","All clear, all clear!"},
  {"EVE180","Get back to your post."},

  --Enemy Voises Sneak? Prisoner - Prisoner escort lines
  --TODO

  --Enemy soldier lines: EVSP
  {"EVSP100","Spill it!",}, --interrogation spill it
  --{"EVSP110","Don't lie to me!",}, --110 looks like its listed twice but its combined?
  --{"EVSP110","State your mission!",}, --
  {"EVSP120","Do you WANT to die",}, --
  {"EVSP130","Found it!",}, --found something they were looking for

  --TODO EVSP


  --EVSP: Slaughtering the infected
  --TODO: no ids

  --Enemy Voices Fight?
  {"EVF010","Boss!",},--default saluting boss.
  {"EVF020","its an honor boss|dont pull any punches",}, ----no ref,  Greeting Boss before practice:
  {"EVF030","boss, thats not quite right|boss, um with all due respect",}, --no ref,-- Multipurpose lines for when player fails to do something correctly:
  {"EVF040","thank you boss!",}, --no ref, the standard cqc reaction
  --> anything higher, silence/no table


  {"salute0010","great work on that mission",},--no ref, After completing a mission (score: high)
  {"salute0020","nice job on that mission",}, --no ref, After completing a mission (score: medium)
  {"salute0030","that was a pretty rough mission",}, --no ref, ・After completing a mission (score: low)
  {"salute0040","good to have you back boss",}, -- After Boss returns (they"re happy to see him)
  {"salute0050","long time no see",}, -- ・Boss returns after a long time away
  {"salute0060","welcome home boss",}, --- with warmth ・General-purpose lines after Boss returns
  {"salute0070", "boss? what is..? uhh never mind|thats a.. interesting hat youve got there",},-- spoken uncertainly. ----no ref, ・After Boss returns (when wearing chicken hat) (prep)
  {"salute0080","welcome back boss",},-- often said with trepidation, other times sounds normal. -- ・Boss"s "demon level" has exceeded a certain point
  {"salute0090","we need more personel",},
  {"salute0100","we cant get by with so few staff",},
  {"salute0110", "thanks for bringing in more guys",},--no ref,
  {"salute0120","starting to get a little crowded here",},
  {"salute0130","thanks for upgrading the base|for expanding",},--no ref,
  {"salute0140", "that new weapon is just what we needed boss",},--no ref,
  {"salute0150","boss, we still in the red?",},
  {"salute0160","we're ready to develop new equipment",},
  {"salute0170","do you think you can bring in more materials?",},
  {"salute0180","train with me",},
  {"salute0190","boss! you, me, mock battle, what do you say?",},
  {"salute0200","i'm ready for a dispatch. send me on a mission",},
  {"salute0210","damage to the fob is getting serious, you need to review fob security",}, --no ref,  for after fob attack i guess
  {"salute0220","whatever supplies you need, let us know",},
  {"salute0230","we're here for you if you need combat support",},
  {"salute0240","boss, thanks for saving that puppy",},
  {"salute0250","i hope you keep that woman locked up boss",},
  {"salute0260","do you think you could bring back more medicinal plants?",},
  {"salute0270","you have to rescue our men",},
  {"salute0280","you need to put an end to the infection boss",},
  {"salute0290","thanks for taking in those children",},
  {"salute0300","thank you for getting those animals out boss",},
  {"salute0310","how's it going boss?",},
  {"salute0320","boss good moring|have a good day boss",}, -- condition: must actually be morning ?
  {"salute0330","thank you for rescuing our men boss",},
  {"salute0340","thank you for ending the infection",},
  {"salute0350","boss, now our guys can rest in peace. thank you for what you did with the diamonds",},
  {"salute0360","thank you for stopping the infection boss",},--with more emotion
  {"salute0370","boss, whoever you are, youre still my CO",},
  {"salute0380","happy birthday boss",},
  {"salute0390","congratulations on the decomissioning boss",}, -- no ref,  ・After abolishing nuclear weapons
  {"salute0400","congratulations",}, -- --no ref ・General-purpose congratulatory greeting
  {"salute0410","uh, how about taking a shower after a mission?",},--When Boss stinks - requires condition
  {"salute0420","thank you for letting me join diamond dogs",},--  New recruit who was just extracted? - requires condition?
  {"salute0430", "boss! I new you were alive!|its.. its you boss",},--no ref amazed -- ●NPC lines: when reuniting with soldiers who were at the old Mother Base (survivors of 9 years ago)
--> anything higher is silence/no table
}--this.speechLabels


--  s10010_sequence
--    Player.CallVoice( "snak_down_normal_01", nil, "DD_vox_Snake_reaction" )--doesnt work, soundbank just for that mission?
--    Player.CallVoice( "PLA0130_001", "SNAK", "DD_Player" )--works
--heli_common_sequence
--Player.CallVoice( "OSAKA010","DD_Player") -- does subtitles, check if it does anything in jap
--tex works on soldier selected via selectListObject
this.debug_CallVoice={
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.speechLabels,
  GetSettingText=function(self,setting)
    local speechLabelT=self.settings[setting+1]
    local desc=speechLabelT[2] or ""
    return speechLabelT[1]..":"..desc
  end,
  OnActivate=function(self,setting,previousSetting)
    local speechLabelT=self.settings[setting+1]
    local soldierName=Ivars.selectListObject:GetSettingName()
    local gameObjectId=GameObject.GetGameObjectId(soldierName)
    if gameObjectId==GameObject.NULL_ID then
      return
    end
    --TODO: check if soldier?
    local command={id="CallVoice",dialogueName="DD_vox_ene",parameter=speechLabelT[1]}
    GameObject.SendCommand(gameObjectId,command)

    --DEBUGNOW
    --Player.CallVoice( "OSAKA010","DD_Player")
    -- Player.CallVoice(speechLabel,"DD_vox_ene")
    --Player.CallVoice( "snak_down_normal_01", nil, "DD_vox_Snake_reaction" )
  end,
}--debug_CallVoice
--DEBUGNOW
--TODO: search CallConversation
this.conversationSpeechLabels={
  "MB_story_01",--"You hear about this? The boss has completed most of his missions without killing anybody",--
  "MB_story_02",--"So, what do you think of how the boss has been acting, they say he's been killing left and right",--
  "MB_story_03",--"I tell ya, these guard shifts lately have been killers",--
  "MB_story_04",--"Hey how do you think those kids are doing",--talks as if they are still on mb
  "MB_story_05",--"That animal conservation platform has really taken off huh?",--
  "MB_story_06",--"Looks like resource opeations are going well. Yeah but I don't know why they call it a FOB",--
  "MB_story_07",--"Hey, you know why big boss is called big boss?",--
  "MB_story_08",--"So why'd the bosses old organisation get taken out?",--
  "MB_story_09",--"So.. who's that woman that doesn't talk that the boss brought back",--
  "MB_story_10",--"That puppy boss brought back is so cute",--
  "MB_story_11",--"Huh that dog's all grown up now",--
  "MB_story_12",--"What the hell could be causing this disease",--
  "MB_story_13",--"So, about the side effects of that shot",--the vaccine
  "MB_story_14",--"Things aren't so cozy around here these days are they?",--
  "MB_story_15",--"Hey what happened the other day, that was something huh? Yeah the boss killed my best buddy in there",--
  "MB_story_16",--"I hear the boss has been going to that area under construction a lot lately",--
  "MB_story_17",--"I guess the boss is weaker than I thought. You mean kicking that scientist out?",--
  "MB_story_18",--"You gotten used to this place?",--male to fem
  "MB_story_19",--"So.. who do you like? What do you mean? Are you team miller or team occelot",--fem to fem
}--conversationSpeechLabels

--DEBUGNOW
this.GetObjectSettingText=function(self,setting)
  if #self.settings==0 then
    return InfLangProc.LangString"list_empty"
  end
  local objectName=self.settings[setting+1]
  if objectName==nil then
    return InfLangProc.LangString"list_empty"
  end
  local gameObjectId=GameObject.GetGameObjectId(objectName)
  if gameObjectId==GameObject.NULL_ID then
    return objectName.."==NULL_ID"
  end

  return objectName
end

this.selectSpeechObject={
  settings={},--DYNAMIC
  OnSelect=function(self)
    IvarProc.SetSettings(self,InfObjects.objectNames)
  end,
  GetSettingText=this.GetObjectSettingText,
}

this.selectSpeechObject2={
  settings={},--DYNAMIC
  OnSelect=function(self)
    IvarProc.SetSettings(self,InfObjects.objectNames)
  end,
  GetSettingText=this.GetObjectSettingText,
}

this.debug_CallConversation={
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.conversationSpeechLabels,
  GetSettingText=function(self,setting)
    local speechLabel=self.settings[setting+1]
    local desc=speechLabel or ""
    return speechLabel
  end,
  OnActivate=function(self,setting,previousSetting)
    local speechLabel=self.settings[setting+1]
    local soldierName=Ivars.selectSpeechObject:GetSettingName()
    local gameObjectId=GameObject.GetGameObjectId(soldierName)
    if gameObjectId==GameObject.NULL_ID then
      return
    end
    local fiendName=Ivars.selectSpeechObject2:GetSettingName()
    local friendGameObjectId=GameObject.GetGameObjectId(soldierName)
    if friendGameObjectId==GameObject.NULL_ID then
      return
    end
    --TODO: check if soldier?

    local command={id="CallConversation",label=speechLabel,friend=friendGameObjectId,}
    GameObject.SendCommand(gameObjectId,command)
  end,
}--debug_CallConversation

return this
