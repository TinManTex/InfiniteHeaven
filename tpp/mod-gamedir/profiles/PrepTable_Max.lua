--
local this={
    description="Max",
    prep={
      --tex percentages, though the distribution competes with other equipment when being applied
      SNIPER=100,
      MISSILE=100,
      MG=100,
      SHOTGUN=100,
      MG_OR_SHOTGUN=100,
      SMG=100,
      ASSAULT=100,
      GUN_LIGHT=100,
      ARMOR=100,
      SOFT_ARMOR=100,
      SHIELD=100,
      HELMET=100,
      NVG=100,
      GAS_MASK=100,
      DECOY=100,
      MINE=100,
      CAMERA=100,
      STEALTH="SPECIAL",
      COMBAT="SPECIAL",
      HOLDUP="SPECIAL",
      FULTON="SPECIAL",
      STRONG_WEAPON=1,
      STRONG_SNIPER=1,
      STRONG_MISSILE=1,
      ACTIVE_DECOY=1,
      GUN_CAMERA=1,
      REINFORCE_LEVEL="BLACK_SUPER_REINFORCE",
      IGNORE_BLOCKED=1,--tex ignore blocking of equipment via dispatch missions
      REINFORCE_COUNT=99,--tex number of reinforce calls before 'no more reinforcements available'
    },
}
return this


