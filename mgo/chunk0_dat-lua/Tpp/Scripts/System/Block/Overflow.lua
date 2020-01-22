local o={}
local a={afc0={deathmatch={dynamicblock=1024,commonblock=18680,overflow=1800},deathmatchBase={dynamicblock=1024,commonblock=18680,overflow=1800},domination={dynamicblock=1024,commonblock=18680,overflow=1800},dominationBase={dynamicblock=1024,commonblock=18680,overflow=1800},sabotage={dynamicblock=1024,commonblock=18680,overflow=1800},teamsneak={dynamicblock=1024,commonblock=18680,overflow=1800},teamsneakBase={dynamicblock=1024,commonblock=18680,overflow=1800},freeplay={dynamicblock=1024,commonblock=18680,overflow=1800}},afn0={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},afda={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},afc1={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},cuba={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19058,overflow=1536}}}
local c={[1]="domination",[2]="deathmatch",[3]="teamsneak",[4]="freeplay",[5]="deathmatchBase",[6]="teamsneakBase",[7]="dominationBase",[8]="sabotage"}
local e={[101]="afc0",[102]="afn0",[103]="afda",[104]="afc1",[105]="cuba"}
local l={Player2NewInstanceBlock=5342,RulesetCommonBlock=2048,RulesetMapBlock=10,ActorPartsBlock=2,MissionSystems=3073,AvatarScriptBlockData=0}
function o.GetLocationString()
if(e[vars.locationCode])~=nil then
return e[vars.locationCode]
end
return"afc0"end
function o.GetRulesetString()
if(c[vars.rulesetId])~=nil then
return c[vars.rulesetId]
end
return"freeplay"end
function o.GetData(e)
local l=o.GetLocationString()
local o=o.GetRulesetString()
if(a[l][o][e])~=nil then
local c=Fox.GetPlatformName()
local o=(a[l][o][e])
if c=="PS3"or c=="Xbox360"then
return o
else
return o+512
end
end
return 0
end
function o.GetAdjustedBlockSize(e)
local c=0
if(e=="mission_block")then
c=4*1024
elseif(e=="SimpleStageBlockController")then
c=o.GetSimpleStageBlockSize()
elseif(e=="TppSimpleMissionBlockControllerData0000")then
c=o.GetTppSimpleMissionBlock()
elseif(e=="commonblock")then
c=o.GetCommonBlock()
elseif(e=="dynamicblock")then
c=o.GetData(e)
if Fox.GetPlatformName()=="XboxOne"then
c=c+512
end
else
c=o.GetData(e)
end
return c*1024
end
function o.GetSimpleStageBlockSize()
return 35061
end
function o.GetTppSimpleMissionBlock()
local c=o.GetLocationString()
if(a[c])~=nil then
local c=o.GetData"dynamicblock"local o=((((l.Player2NewInstanceBlock+l.RulesetCommonBlock)+l.RulesetMapBlock)+l.ActorPartsBlock)+l.MissionSystems)+l.AvatarScriptBlockData
return(o+c)
end
return 0
end
function o.GetCommonBlock()
local c=o.GetLocationString()
if(a[c])~=nil then
local c=o.GetTppSimpleMissionBlock()
local o=o.GetData"commonblock"return(c+o)
end
return 0
end
return o
