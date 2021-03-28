--PlayerStatusEx.lua
--Extended version of PlayerStatus since that doesnt provide lua side enum for all its entries
--You should assume notes on wiki are more up-to-date than the ones in this file
--https://metalgearmodding.fandom.com/wiki/PlayerStatus

--Usage:
--if PlayerInfo.OrCheckStatus{PlayerStatusEx.NORMAL_ACTION}then
--if not PlayerInfo.AndCheckStatus{ PlayerStatusEx.DEAD } then

--Ex comment means the entry isnt in the vanilla PlayerStatus module, so the name is something we've chosen

--GOTCHA: only covers TPP. MGO and SSD have additions/changes.
--really just could have done a string-to-enum, but this way makes it clearer when comparing to wiki/actual values
local this={
  UNK0=0,--NOCODE-- There is no code to set this flag? Probably litterally baseline nothing set.
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
  UNK39=39,--NOCODE-- There is no code to set this flag?
  UNK40=40,--NOCODE-- There is no code to set this flag?
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
  UNK57=57,--NOCODE-- There is no code to set this flag?
  BINOCLE=58,-- using int-scope
  INTRUDE=59,-- On when forced subjective camera is active in crawl-spaces
  LFET_STOCK=60,-- On when camera is behind player's right shoulder
  CUTIN=61,-- On when "cut-in" camera is active (e.g. climbing on horse, entering vehicles, toilets, dumpsters, or putting enemies in things)
  DEAD=62,-- On when player is dead
  DEAD_FRESH=63,-- On during death animation?
  NEAR_DEATH=64,-- On when health is low? Perhaps during or recovering from serious injury?
  NEAR_DEAD=65,-- Despite being named, there is no code to set this flag?
  UNK66=66,--NOCODE-- There is no code to set this flag?
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
  INJURY_LOWER=80,-- On when player has a leg injury 
  INJURY_UPPER=81,-- On when player has an arm injury 
  INJURY_BODY=82,--Ex -- On when player has an injury other than of the leg or arm 
  CURE=83,-- On during cure animation (injury flags remain on until animation is finished) 
  CQC_LOCK_ON=84,--Ex-- On when using CQC moves with tracking (CQC on standing enemy within range, holding enemies, throwing enemies) 
  CQC_MANUAL=85,--Ex-- On when using CQC moves without tracking (whiffed CQC, CQC on prone enemies) 
  CQC_MANUAL_HOLD=86,--Ex-- On when holding CQC moves without tracking (whiffed grabs) 
  CQC_HOLD=87,--Ex-- On while holding enemies 
  CQC_CONTINUOUS=88,-- On during consecutive CQC (high speed camera throw loops on enemies)
  UNK89=89,--UNKNOWN-- Flag exists but unknown conditions and meaning. Possibly being held in CQC by another player on FOBs but untested 
  BEHIND=90,-- pressed against cover/wall
  BEHIND_CAMERA_SHIFT=91,--Ex-- On when camera has shifted to see around edge 
  BEHIND_SIDE_CQC_ENABLED=92,--Ex-- On when behind a wall and at edge where CQC around corner is allowed? 
  BEHIND_FORCE_CROUCH=93,--Ex-- On when behind a wall where crouching is forced 
  CLIMB_CRACK=94,--Ex-- On when climbing cracks in walls and cliff faces (note: movement flags don't apply) 
  ELUDE=95,--Ex-- On when hanging from edge (note: movement flags don't apply) 
  PIPE=96,--Ex-- On when climbing pipes (note: movement flags don't apply) 
  CLAMBER=97,--Ex-- On when climbing up or over edges with action button 
  JUMP=98,--Ex-- On when jumping using action button 
  EVADE=99,--Ex-- On when diving 
  FULTON=100,--Ex-- On when using the fulton recovery device 
  DAMAGE=101,--Ex-- On when sustaining damage (not tested for sleep and stun damage?)
  SLIDE=102,--Ex-- On when sliding on a steep incline 
  UNCONSCIOUS=103,-- On when rendered unconscious by sleep or stun weapons (includes animation?) 
  UNCONSCUOUS_START=104,--Ex-- On during animation where player falls unconscious
  UNCONSCIOUS_END=105,--Ex-- On when player can wiggle stick to wake faster and when waking 
  DAMAGE_SLEEP=106,--Ex-- On when sustaining sleep damage 
  DAMAGE_STUN=107,--Ex-- On when sustaining stun damage 
  FULTONED=108,--Ex-- On when player is fultoned by another player or enemies on FOBs 
  LADDER=109,--Ex-- On when climbing ladder (note: movement flags *do* apply) 
  TOILET=110,--Ex-- On when hiding in toilet 
  TOILET_DOOR=111,--Ex-- On when entering and exiting toilet/shower (excludes diving out) 
  SHOWER=112,--Ex-- On when taking a shower
  SPECIAL_ACTION=113,--Ex-- On during special animations involving NPCs (e.g. grabbed by or countering, zombies, dogs, Liquid, Volgin, but not regular soldiers) 
  COUNTER=114,--Ex-- On when successfully countering enemies including those above?
  LUNGE=115,--Ex-- On during dog/zombie lunge animation, regardless of successful counter 
  LUNGE_ZOMBIE=116,--Ex-- On during zombie lunge animation only, regardless of successful counter 
  COUNTER_PROJECTILE=117,--Ex-- On when countering Liquid's thrown bottles 
  MAUL_ZOMBIE=118,--Ex-- On when being mauled by zombie after unsuccessful counter (115, 113 remain on too) 
  MAUL_DOG=119,--Ex-- On when being mauled by dog after unsuccessful counter (115, 113 remain on too) 
  PET_DD=120,--Ex-- On when petting DD 
  ROCKET_ARM_PILOT=121,--Ex-- On when piloting rocket arm 
  VOLGIN_CHASE=122,-- On during prologue's horseback fight with Volgin 
  KILL_QUIET=123,--Ex-- On when player can choose to kill Quiet in mission 11 (not on when player can choose to shoot Skull Face) 
  STEALTH_CAMO=124,--Ex-- On when stealth camo is active 
  UNDETECTABLE=125,--Ex-- On when stealth camo is active and player is not doing things which enable enemies to notice them (e.g. holding enemies, shooting, diving) 
  NVG=126,--Ex-- On when using NVGs (includes mission 43?) 
  PARASITE_ARMOUR=127,--Ex-- On when using parasite suit with armour parasites active 
  STEALTH_MODE=128,--Ex-- On when using action button to hide while prone 
  EXIT_HELICOPTER=129,--Ex-- On when exiting helicopter (but not entering) 
  CHICKEN_CAP=130,--Ex-- On when chicken cap is on 
  CHICK_CAP=131,--Ex-- On when lil' chicken cap is on 
  UNK132=132,--NOCODE-- There is no code to set this flag? 
  UNK133=133,--NOCODE-- There is no code to set this flag? 
  CARRY=134,-- player is carrying an AI (use with "Carried" FoxStrCode32 msg to check status and obj type)
  UNK135=135,--NOCODE-- There is no code to set this flag? 
  CARRY_HORSE_ACTION=136,--Ex-- On when putting an NPC on D-horse or taking them off 
  MB_TERMINAL=137,--Ex-- On when using the iDroid 
  UNK138=138,--UNKNOWN-- Flag exists but unknown conditions and meaning 
  UNK139=139,--UNKNOWN-- Flag exists but unknown conditions and meaning - seems related to 138 
  CURTAIN=140,-- On when playing animation to pass through curtain in Prologue 
  ENABLE_TARGET_MARKER_CHECK=141,-- Unknown meaning. Probably on when some UI element is on. 
  FLARE_LIGHT=142,--Ex-- On when player's visibility is increased due to enemy flares 
  STATIC_LIGHT=143,--Ex--   On when player's visibility is increased due to environmental light (does not include search lights or flashlights) 
  VEHICLE_ARMOUR=144,--Ex-- On when piloted vehicle's armour is intact (reduces damage) 
  PARTS_ACTIVE=145,-- seems to always be true during gameplay
  FOB_WORMHOLE=146,--EX-- On when travelling from helicopter to FOB by wormhole 
  UNK147=147,--NOCODE-- There is no code to set this flag?
  UNK148=148,--NOCODE-- There is no code to set this flag?
  UNK149=149,--NOCODE-- There is no code to set this flag?
  UNK150=150,--NOCODE-- There is no code to set this flag?
  UNK151=151,--NOCODE-- There is no code to set this flag?
}--this

--tex build reverse lookup (but cant add to table your iterating without trouble, so put in temp)
local arr={}
for name,enum in pairs(this)do
  arr[enum]=name
end
--then fold back in
for enum,name in ipairs(arr)do
  this[enum]=name
end

return this
