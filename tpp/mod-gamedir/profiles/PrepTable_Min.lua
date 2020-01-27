--
local this={
    description="Min",
    prep={
      --tex percentages, though the distribution competes with other equipment when being applied
      SNIPER=0,
      MISSILE=0,
      MG=0,
      SHOTGUN=0,
      MG_OR_SHOTGUN=0,
      SMG=0,
      ASSAULT=0,
      GUN_LIGHT=0,
      ARMOR=0,
      SOFT_ARMOR=0,
      SHIELD=0,
      HELMET=0,
      NVG=0,
      GAS_MASK=0,
      DECOY=0,
      MINE=0,
      CAMERA=0,
      STEALTH="NONE",
      COMBAT="NONE",
      HOLDUP="NONE",
      FULTON="NONE",
      STRONG_WEAPON=1,
      STRONG_SNIPER=1,
      STRONG_MISSILE=1,
      ACTIVE_DECOY=1,
      GUN_CAMERA=1,
      REINFORCE_LEVEL="NONE",
      IGNORE_BLOCKED=0,--tex ignore blocking of equipment via dispatch missions
      REINFORCE_COUNT=0,--tex number of reinforce calls before 'no more reinforcements available'
    },
}
return this


