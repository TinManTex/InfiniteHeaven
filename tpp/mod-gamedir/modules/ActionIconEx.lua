--ActionIconEx.lua
--Extended version of ActionIcon since that doesnt provide lua side enum for all its entries
--based on rlcs documentation
--REF usage
--Player.RequestToShowIcon{type=actionIconType,icon=actionIcon,message=Fox.StrCode32"IconOk",messageArg=""}
--Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING,message=StrCode32"QuestStarted",messageInDisplay=StrCode32"QuestIconInDisplay",messageArg=questName}

--sends message with messageArg when player does action, and messageInDisplay when icon on screen
--still not sure where it gets the positioning/trigger bounds from, guessing either a trap or marker, see trap_shootingPractice_start, Marker_shootingPractice

--Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}

--vanilla uses only ever set actionIconType to ActionIcon.ACTION, but rlcs experimentation suggests its not ActionIcon but button for action type

local this={
  ACTION = 0,
  ELUDE_CLIMB_UP = 1,--rlc hands let go
  ELUDE_CLIMB_DOWN = 2,--rlc hands let go
  LADDER_DOWN = 3,--rlc
  HUMAN_PUTDOWN = 4,--rlc
  HUMAN_PUTDOWN_TRUCK = 5,--rlc
  SEARCHLIGHT_DISMOUNT = 6,--rlc
  TRUCK_DISMOUNT = 7,--rlc
  ARMORED_VEHICLE_DISMOUNT = 8,--rlc
  ANTI_AIR_DISMOUNT = 9,--rlc
  LADDER_DOWN_2 = 10,--rlc IDENTICAL TO 3
  CQC_OUTLINE_RIGHT = 11,--rlc outline cqc icon with right arrow
  BIKKURI = 12,--rlc !
  LADDER = 13,--rlc
  JUMP = 14,--rlc LEFT STICK
  CRACK = 15,--rlc
  STEPON = 16,--rlc
  ELUDE_HOLD_UP = 17,--rlc hands holding ledge
  ELUDE_HOLD_UP_2 = 18,--rlc IDENTICAL TO 17
  ELUDE_HOLD_UP_3 = 19,--rlc IDENTICAL TO 17
  ELUDE = 20,--rlc holding ledge no arrow
  PIPE_CLIMB = 21,--rlc
  HEAL = 22,--rlc
  CQC = 23,--rlc filled cqc icon no arrow
  HELI_DROP = 24,--rlc
  ANTI_AIR = 25,--rlc
  ANTI_AIR_2 = 26,--rlc IDENTICAL TO 25
  SEARCH_LIGHT = 27,--rlc
  UNLOCK = 28,--rlc
  UNLOCK_NG = 29,--rlc crossed out with red box
  BIKKURI_2 = 30,--rlc IDENTICAL TO 12
  RIDE_MGM = 31,
  RIDE_MGM_NG = 32,--rlc
  RIDE_MGM_DISMOUNT = 33,--rlc
  ARMORED_VEHICLE = 34,--rlc
  ARMORED_VEHICLE_NG = 35,--rlc
  HELI = 36,--rlc
  HELI_NG = 37,--rlc
  BIKKURI_3 = 38,--rlc IDENTICAL TO 12
  HUMAN_PICKUP = 39,--rlc
  -- EMPTY
  CBOX = 44,--rlc
  HUMAN_PICKUP_2 = 45,--rlc IDENTICAL TO 39
  HUMAN_PICKUP_3 = 46,--rlc IDENTICAL TO 39
  HUMAN_PUTON_HELI = 47,--rlc
  HUMAN_PUTON_HELI_NG = 48,--rlc
  FULTON = 49,
  FULTON_NG = 50,--rlc
  HUMAN_PICKUP_4 = 51,--rlc IDENTICAL TO 39
  SWITCH = 52,--rlc
  INTEL = 53,
  INTEL_NG = 54,
  ANTI_AIR_NG = 55,--rlc
  ANTI_AIR_3 = 56,--rlc identical to 25
  ANTI_AIR_DISMOUNT_2 = 57,--rlc IDENTICAL TO 9
  MORTAR = 58,--rlc
  MORTAR_NG = 59,--rlc
  MORTAR_DISMOUNT = 60,--rlc
  HEAVYMG = 61,--rlc
  HEAVYMG_NG = 62,--rlc
  HEAVYMG_DISMOUNT = 63,--rlc
  HUMAN = 64,--rlc
  TAPE = 65,--rlc
  CQC_FULTON = 66,--rlc
  BIKKURI_4 = 67,--rlc IDENTICAL TO 12
  SHOWER = 68,--rlc
  RIDE_MILITALY_VEHICLE = 69,
  DISMOUNT_TRUCK = 70,--rlc
  TRUCK_PUTON = 71,--rlc
  TRUCK_PULLOUT = 72,--rlc
  RIDE_VEHICLE = 73,
  JEEP_DISMOUNT = 74,--rlc
  JEEP_PUTON = 75,--rlc
  JEEP_PULLOUT = 76,--rlc
  ARMORED_VEHICLE_2 = 77,--rlc IDENTICAL TO 34
  ARMORED_VEHICLE_DISMOUNT_2 = 78,--rlc INTEICAL TO 8
  TANK = 79,--rlc
  TANK_DISMOUNT = 80,--rlc
  WORMHOLE = 81,--rlc
  DD_PET = 82,--rlc
  HORSE = 83,--rlc
  HORSE_DISMOUNT = 84,--rlc
  HORSE_PUTON = 85,--rlc
  HORSE_PULLOFF = 86,--rlc
  TRASH = 87,--rlc
  TRASH_LEAVE = 88,--rlc
  TRASH_LEAVE_2 = 89,--rlc
  TRASH_PUTIN = 90,--rlc
  TRASH_PULLOUT = 91,--rlc
  CQC_2 = 92,--rlc IDENTICAL TO 23
  WAKEUP = 93,--rlc wiggling left stick, bikkuri icon
  WAKEUP_2 = 94,--rlc IDENTICAL TO 23
  PICKLOCK = 95,--rlc tap y
  PIPE_DROP = 96,--rlc
  DROPDOWN = 97,--rlc
  HELI_MACHINEGUN = 98,--rlc
  HELI_MACHINEGUN_NG = 99,--rlc
  HELI_MACHINEGUN_DISMOUNT = 100,--rlc
  HELI_TAXI = 101,--rlc
  TOILET = 102,--rlc
  TOILET_LEAVE = 103,--rlc
  TOILET_PUTIN = 104,--rlc
  TOILET_PULLOUT = 105,--rlc
  TAKE_INVOICE = 106,--rlc
  CBOX_INVOICE = 107,--rlc
  CBOX_INVOICE_NG = 108,--rlc
  TAPE_2 = 109,--rlc IDENTICAL TO 65
  WORMHOLE_2 = 110,--rlc IDENTICAL TO 81, shows tip
  WORMHOLE_NG = 111,--rlc
  STEALTH = 112,--rlc
  BIKKURI_FLASH = 113,--rlc flashing !, also a bit higher than usual
  AI_POD = 114,
  UNLOCKED = 115,--rlc open lock
  SWITCH_2 = 116,--rlc IDENTICAL TO 52
  BIKKURI_5 = 117,--rlc IDENTICAL TO 12
  TRAINING = 118,
  PILL = 119,--rlc
  QUIET_DASH = 120,--rlc
  HEARTS = 121,--rlc
  --Everything beyond 121 is broken; random flashes, random NG overlay, etc.
}--this

return this
