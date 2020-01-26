local o={}
local a={afc0={deathmatch={dynamicblock=1024,commonblock=18680,overflow=1800},deathmatchBase={dynamicblock=1024,commonblock=18680,overflow=1800},domination={dynamicblock=1024,commonblock=18680,overflow=1800},dominationBase={dynamicblock=1024,commonblock=18680,overflow=1800},sabotage={dynamicblock=1024+200,commonblock=18680,overflow=1800},teamsneak={dynamicblock=1024,commonblock=18680,overflow=1800},teamsneakBase={dynamicblock=1024,commonblock=18680,overflow=1800},freeplay={dynamicblock=1024,commonblock=18680,overflow=1800}},afn0={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024+200,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},afda={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024+200,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},afc1={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024+200,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19085,overflow=1536}},cuba={deathmatch={dynamicblock=1024,commonblock=19085,overflow=1536},deathmatchBase={dynamicblock=1024,commonblock=19085,overflow=1536},domination={dynamicblock=1024,commonblock=19085,overflow=1536},dominationBase={dynamicblock=1024,commonblock=19085,overflow=1536},sabotage={dynamicblock=1024+200,commonblock=19085,overflow=1536},teamsneak={dynamicblock=1024,commonblock=19085,overflow=1536},teamsneakBase={dynamicblock=1024,commonblock=19085,overflow=1536},freeplay={dynamicblock=1024,commonblock=19058,overflow=1536}},rma0={deathmatch={dynamicblock=1024,commonblock=13641+100,overflow=3136},deathmatchBase={dynamicblock=1024,commonblock=13641+100,overflow=3136},domination={dynamicblock=1024,commonblock=13641+100,overflow=3136},dominationBase={dynamicblock=1024,commonblock=13641+100,overflow=3136},sabotage={dynamicblock=1024+200,commonblock=13641+100,overflow=3136},teamsneak={dynamicblock=1024,commonblock=13641+100,overflow=3136},teamsneakBase={dynamicblock=1024,commonblock=13641+100,overflow=3136},freeplay={dynamicblock=1024,commonblock=13641+100,overflow=3136}},sva0={deathmatch={dynamicblock=1024,commonblock=13620+650,overflow=3686},deathmatchBase={dynamicblock=1024,commonblock=13620+650,overflow=3686},domination={dynamicblock=1024,commonblock=13620+650,overflow=3686},dominationBase={dynamicblock=1024,commonblock=13620+650,overflow=3686},sabotage={dynamicblock=1024+200,commonblock=13620+650,overflow=3686},teamsneak={dynamicblock=1024,commonblock=13620+650,overflow=3686},teamsneakBase={dynamicblock=1024,commonblock=13620+650,overflow=3686},freeplay={dynamicblock=1024,commonblock=13620+650,overflow=3686}},mba0={deathmatch={dynamicblock=1024,commonblock=17085,overflow=3536},deathmatchBase={dynamicblock=1024,commonblock=17085,overflow=3536},domination={dynamicblock=1024,commonblock=17085,overflow=3536},dominationBase={dynamicblock=1024,commonblock=17085,overflow=3536},sabotage={dynamicblock=1024+200,commonblock=17085,overflow=3536},teamsneak={dynamicblock=1024,commonblock=17085,overflow=3536},teamsneakBase={dynamicblock=1024,commonblock=17085,overflow=3536},freeplay={dynamicblock=1024,commonblock=17085,overflow=3536}}}
local c={[1]="domination",[2]="deathmatch",[3]="teamsneak",[4]="freeplay",[5]="deathmatchBase",[6]="teamsneakBase",[7]="dominationBase",[8]="sabotage"}
local l={[101]="afc0",[102]="afn0",[103]="afda",[104]="afc1",[105]="cuba",[113]="rma0",[112]="sva0",[111]="mba0"}
local e={Player2NewInstanceBlock=5342,RulesetCommonBlock=2048,RulesetMapBlock=10,ActorPartsBlock=2,MissionSystems=3073,AvatarScriptBlockData=0}
function o.GetLocationString()
if(l[vars.locationCode])~=nil then
return l[vars.locationCode]
end
return"afc0"end
function o.GetRulesetString()
if(c[vars.rulesetId])~=nil then
return c[vars.rulesetId]
end
return"freeplay"end
function o.GetData(l)
local e=o.GetLocationString()
local o=o.GetRulesetString()
if(a[e][o][l])~=nil then
local c=Fox.GetPlatformName()
local o=(a[e][o][l])
if c=="PS3"or c=="Xbox360"then
return o
else
return o+512
end
end
return 0
end
function o.GetAdjustedBlockSize(l)
local c=0
if(l=="mission_block")then
c=4*1024
elseif(l=="SimpleStageBlockController")then
c=o.GetSimpleStageBlockSize()
elseif(l=="TppSimpleMissionBlockControllerData0000")then
c=o.GetTppSimpleMissionBlock()
elseif(l=="commonblock")then
c=o.GetCommonBlock()
elseif(l=="dynamicblock")then
c=o.GetData(l)
if Fox.GetPlatformName()=="XboxOne"then
c=c+512
end
else
c=o.GetData(l)
end
return c*1024
end
function o.GetSimpleStageBlockSize()
return 35061
end
function o.GetTppSimpleMissionBlock()
local c=o.GetLocationString()
if(a[c])~=nil then
local c=o.GetData"dynamicblock"local o=((((e.Player2NewInstanceBlock+e.RulesetCommonBlock)+e.RulesetMapBlock)+e.ActorPartsBlock)+e.MissionSystems)+e.AvatarScriptBlockData
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
