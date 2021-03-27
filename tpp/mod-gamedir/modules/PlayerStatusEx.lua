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
  UNK57=57,--UNKNOWN-- There is no code to set this flag?
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
