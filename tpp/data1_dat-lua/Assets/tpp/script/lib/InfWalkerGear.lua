-- DOBUILD: 0 --DEBUGNOW
-- InfWalkerGear.lua
local this={}

local walkerList={
  "wkr_WalkerGear_0000",
  "wkr_WalkerGear_0001",
  "wkr_WalkerGear_0002",
  "wkr_WalkerGear_0003",
  "wkr_WalkerGear_0004",
  "wkr_WalkerGear_0005",
  "wkr_WalkerGear_0006",
  "wkr_WalkerGear_0007",
  "wkr_WalkerGear_0008",
  "wkr_WalkerGear_0009",
}

--REF clusters {"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
--local mbWalkerStartPositions={
--  --command
--  {
--    {1.00,0.00,-29.00},
--    {117.00,0.00,-5.00},
--    {226.00,0.00,-52.00},
--    {323.00,0.00,-51.00},
--  },
--  --combat
--  {
--    {1149.00,0.00,-591.00},
--    {1139.00,0.00,-710.00},
--    {1253.00,4.00,-809.00},
--    {1360.00,0.00,-794.00},
--  },
--  --r and d
--  {
--    {1194.00,32.00,293.00},
--    {1317.00,0.00,339.00},
--    {1410.00,0.00,231.00},
--    {1526.00,0.00,229.00},
--  },
--  --base dev
--  {
--    {-754.00,8.00,-356.00},
--    {-821.00,0.00,-472.00},
--    {-952.00,0.00,-483.00},
--    {-1014.00,0.00,-569.00},
--  },
--  --support
--  {
--    {372.00,0.00,875.00},
--    {464.00,0.00,937.00},
--    {435.00,0.00,1074.00},
--    {348.00,0.00,1166.00},
--  },
--  --intel
--  {
--    {-656.00,4.00,538.00},
--    {-693.00,0.00,665.00},
--    {-794.00,0.00,740.00},
--    {-797.00,0.00,853.00},
--  },
--  --med
--  {
--    {-143.00,0.00,-973.00},
--    {-123.00,0.00,-1078.00},
--    {-230.00,0.00,-1170.00},
--    {-160.00,0.00,-1306.00},
--  },
--}


---
--DEBUGNOW
local mbWalkerStartPositionsA={

    {1.00,0.00,-29.00},
    {117.00,0.00,-5.00},
    {226.00,0.00,-52.00},
    {323.00,0.00,-51.00},

    {1149.00,0.00,-591.00},
    {1139.00,0.00,-710.00},
    {1253.00,4.00,-809.00},
    {1360.00,0.00,-794.00},

    {1194.00,32.00,293.00},
    {1317.00,0.00,339.00},
--    {1410.00,0.00,231.00},
--    {1526.00,0.00,229.00},
--
--    {-754.00,8.00,-356.00},
--    {-821.00,0.00,-472.00},
--    {-952.00,0.00,-483.00},
--    {-1014.00,0.00,-569.00},
--
--    {372.00,0.00,875.00},
--    {464.00,0.00,937.00},
--    {435.00,0.00,1074.00},
--    {348.00,0.00,1166.00},
--
--    {-656.00,4.00,538.00},
--    {-693.00,0.00,665.00},
--    {-794.00,0.00,740.00},
--    {-797.00,0.00,853.00},
--
--    {-143.00,0.00,-973.00},
--    {-123.00,0.00,-1078.00},
--    {-230.00,0.00,-1170.00},
--    {-160.00,0.00,-1306.00},

}

function this.SetupWalkerGearPositions()
  local numWalkerGears=10--DEBUGNOW

  for k, walkerName in ipairs( walkerList ) do
    local walkerId = GameObject.GetGameObjectId( "TppCommonWalkerGear2", walkerName )

    if walkerId ~= nil then

      local pos=mbWalkerStartPositionsA[#mbWalkerStartPositionsA]
      table.remove(mbWalkerStartPositionsA)
      local command = { id = "SetPosition", pos=pos, rotY=270 }--DEBUGNOW
      GameObject.SendCommand( walkerId, command )

    end
  end
end

return this
