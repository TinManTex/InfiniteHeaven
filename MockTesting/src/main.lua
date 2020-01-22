InfMenu={}
local this=InfMenu
function this.DebugPrint(message)
  print(message)
end

gvars={}

---
Tpp={}
local this=Tpp
function this.IsTypeFunc(e)
  return type(e)=="function"
end
local IsTypeFunc=this.IsTypeFunc
function this.IsTypeTable(e)
  return type(e)=="table"
end
local IsTypeTable=this.IsTypeTable
function this.IsTypeString(e)
  return type(e)=="string"
end
local IsTypeString=this.IsTypeString
function this.IsTypeNumber(e)
  return type(e)=="number"
end
local IsTypeNumber=this.IsTypeNumber


gvars.soldierSightDistScale=1

InfSoldierParams={}
local this=InfSoldierParams

local IsTable=Tpp.IsTypeTable
local IsFunc=Tpp.IsTypeFunc

this.soldierParametersDefaults={--tex  SYNC: soldierParametersMod. actually using my slight tweaks rather than true default
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=35,verticalAngle=60,horizontalAngle=60},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}
    },
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}
    },
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}
    },
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}
    },
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight={distanceRate=.6,angleRate=.8},
    rainSight={distanceRate=1,angleRate=1},
    cloudySight={distanceRate=1,angleRate=1},
    foggySight={distanceRate=.5,angleRate=.6}
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60},
  zombieParameterTable={highHeroicValue=1e3}
}

this.soldierParameters={--tex SYNC: soldierParametersDefault. Ugly, but don't want to blow out the stack by doing table copies at runtime
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=35,verticalAngle=60,horizontalAngle=60},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}
    },
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}
    },
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}
    },
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}
    },
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight={distanceRate=.6,angleRate=.8},
    rainSight={distanceRate=1,angleRate=1},
    cloudySight={distanceRate=1,angleRate=1},
    foggySight={distanceRate=.5,angleRate=.6}
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable=this.lifeParameterTable,
  zombieParameterTable={highHeroicValue=1e3}
}


function this.ApplySightIvarsToSoldierParams()
  local sightParamsMod=this.soldierParameters.sightFormParameter
  local sightParamsDefaults=this.soldierParametersDefaults.sightFormParameter
  
  for name,item in pairs(sightParamsMod) do
    if item.distance and item.distance>0 then
      
      if sightParamsDefaults[name]==nil then--
        InfMenu.DebugPrint"woh"--DEBUGNOW
        return
      end   
      if sightParamsDefaults[name].distance==nil then--
        InfMenu.DebugPrint"wuh"--DEBUGNOW
        return
      end         
      
      local default=sightParamsDefaults[name].distance
      item.distance=default*gvars.soldierSightDistScale
      --InfMenu.DebugPrint(name)--DEBUGNOW
      --InfMenu.DebugPrint(name..".distance="..default)--DEBUGNOW
    else
      for childName,item in pairs(item) do
        if IsTable(item) and item.distance and item.distance>0 then
          
          if sightParamsDefaults[name]==nil then
          InfMenu.DebugPrint"weh"--DEBUGNOW
          return
          end
          if sightParamsDefaults[name][childName]==nil then
            InfMenu.DebugPrint"wah"--DEBUGNOW
            return
          end
          local default=sightParamsDefaults[name][childName].distance
          item.distance=default*gvars.soldierSightDistScale
          --InfMenu.DebugPrint(name.."."..childName..".distance="..default)--DEBUGNOW
          --InfMenu.DebugPrint(name.."."..childName)--DEBUGNOW
        end
      end
      --]]
    end--if else
  end--for sightmod
  InfMenu.DebugPrint"doop"--DEBUGNOW
end

SplashScreen={}
local this=SplashScreen
function SplashScreen.Create(name,texturePath,width,height)
  print(name,texturePath,width,height)
  return "asplash"
end
function SplashScreen.Show(splashScreen,fadeIn,showTime,fadeOut)
  print(splashScreen,fadeIn,showTime,fadeOut)
end

Ivars={}
local this=Ivars
this.switchRange={max=1,min=0,increment=1}
this.phaseUpdate={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  execChecks={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function()end,
  --profile=this.subsistenceProfile,
}

this.phaseUpdateRate={--seconds
  save=MISSION,
  default=3,
  range={min=1,max=255},
}
this.phaseUpdateRange={--seconds
  save=MISSION,
  range={min=0,max=255},
}

InfMain={}
local this=InfMain

local emblemTypes={
  {"base",{01,50}},
  {"front",{01,85}},
  {"front",{5001,5027}},
  {"front",{7008,7063}},
  {"front",{
    100,
    110,
    120,
    200,
    210,
    220,
    300,
    400,
    410,
    500,
    510,
    600,
    610,
    700,
    720,
    730,
    800,
    810,
    900,
    1000,
    1100,
    1200,
    1210,
    1220,
    1300,
    1310,
    1410,
    1420,
    1430,
    1500,
    1700,
    1710,
    1800,
    1900,
    1920,
    1940,
    1960,
    2000,
    2010,
    2100,
    2200,
    2210,
    2240,
    2241,  
  }},
}

this.currentRandomSplash=nil
--IN: emblemTypes
--OUT: this.oneOffSplashes, this.currentRandomSplash, SplashScreen - a splashscreen
--ASSUMPTION: heavy on emblemTypes data layout assumptions, so if you change it, this do break
function this.RandomEmblemSplash()
  if this.currentRandomSplash~=nil then
  --  if SplashScreen.GetSplashScreenWithName(this.currentRandomSplash) then
      return
  --  end
  end
  
  local groupNumber=math.random(#emblemTypes)
  local group=emblemTypes[groupNumber]
  local emblemType=group[1]
  local emblemRanges=group[2]
  local emblemNumber
  if #emblemRanges>2 then--tex collection of numbers rather than range
    local randomIndex=math.random(#emblemRanges)
    emblemNumber=emblemRanges[randomIndex]
  else
    emblemNumber=math.random(emblemRanges[1],emblemRanges[2])
  end
  
  local lowOrHi="h"
  local name=emblemType..emblemNumber

  local path="/Assets/tpp/ui/texture/Emblem/"..emblemType.."/ui_emb_"..emblemType.."_"..emblemNumber.."_"..lowOrHi.."_alp.ftex"
  local randomSplash=SplashScreen.Create(name,path,640,640)

 -- this.currentRandomSplash=name
 -- this.AddOneOffSplash(name)
  
  SplashScreen.Show(randomSplash,.2,0.5,.2)
  return name
end

this.execChecks={
  inGame=false,--tex actually loaded game, ie at least 'continued' from title screen
  inHeliSpace=false,
  inMission=false,
  inMissionOnGround=false,--tex mission actually started/reached ground, triggers on checkpoint save so might not be valid for some uses
  inGroundVehicle=false,
  inSupportHeli=false,
  onBuddy=false,--tex sexy
  inMenu=false,
}

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if execState.nextUpdate > currentTime then
    return
  end  
  
  for check,ivarCheck in ipairs(execChecks) do
    if currentChecks[check]~=ivarCheck then
      return
    end
  end
  
  if not IsFunc(ExecUpdate) then
    InfMenu.DebugPrint"ExecUpdate is not a function"
    return
  end
  
  ExecUpdate()
  
  --tex set up next update time GOTCHA: wont reflect changes to rate and range till next update
  if not updateRate or not updateRange then
    execState.nextUpdate=currentTime+updateRate
  else
    local updateMin=updateRate-updateRange*0.5
    local updateMax=updateRate+updateRange*0.5
    if updateMin<0 then
      updateMin=0
    end

    local randomRange=math.random(updateMin,updateMax)
    execState.nextUpdate = currentTime + randomRange
  end
end


local function AddMissionPack(packPath,missionPackPath)
  if IsTypeString(packPath)then
    table.insert(missionPackPath,packPath)
  end
end

function this.AddVehiclePacks(missionCode,missionPackPath)
 

  for vehicleType,spawnInfo in pairs(this.vehicleSpawnInfoTable) do
    if spawnInfo.packPath then
     -- AddMissionPack(spawnInfo.packPath,missionPackPath)
    end
  end
end

local this={}
local function main()
  print"test"
  InfSoldierParams.ApplySightIvarsToSoldierParams()
  --while true do
  --InfMain.RandomEmblemSplash()
  --end
  
  this.currentTime=1
  
  local ivar=Ivars.phaseUpdate 
  
  ivar.name="phaseUpdate"
  --if ivar.setting==1 then
    local updateRateName=ivar.name.."Rate"
    local updateRate=ivar.updateRate or gvars[ivar.name.."Rate"]
    local updateRange=ivar.updateRange or gvars[ivar.name.."Range"]
    updateRate=updateRate or 0
    updateRange=updateRange or 0
    
    InfMain.ExecUpdate(InfMain.currentChecks,this.currentTime,ivar.execChecks,ivar.execState,updateRate,updateRange,ivar.ExecUpdate)
  --end
  
  InfMain.AddVehiclePacks(1111,"\some\pack\path")
end
main()
