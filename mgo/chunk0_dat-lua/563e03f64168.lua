local e={}
e.friendlyBase=nil
e.enemyBase=nil
local r={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base8_present.fox2"},[9]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base9_present.fox2"}}
local m={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base8_present.fox2"},[9]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc0/block_ruleset/base9_present.fox2"}}
local d={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base5_present.fox2"}}
local n={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afc1/block_ruleset/base5_present.fox2"}}
local g={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base6_present.fox2"}}
local l={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afn0/block_ruleset/base6_present.fox2"}}
local f={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base8_present.fox2"},[9]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base9_present.fox2"}}
local a={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base8_present.fox2"},[9]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/afda/block_ruleset/base9_present.fox2"}}
local p={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base8_present.fox2"}}
local t={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base7_present.fox2"},[8]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/cuba/block_ruleset/base8_present.fox2"}}
local b={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base5_present.fox2"}}
local s={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base3_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/rma0/block_ruleset/base5_present.fox2"}}
local i={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base1/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base2/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base11/base11_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base4/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base5/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base6/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base13/base13_present.fox2"},[8]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base9/base9_present.fox2"},[9]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base10/base10_present.fox2"},[10]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base8/base8_present.fox2"},[11]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base7/base7_present.fox2"}}
local o={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base1/base1_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base2/base2_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base11/base11_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base4/base4_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base5/base5_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base6/base6_present.fox2"},[7]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base13/base13_present.fox2"},[8]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base9/base9_present.fox2"},[9]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base10/base10_present.fox2"},[10]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/sva0/block_base/base8/base8_present.fox2"},[11]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/sva0/block_base/base7/base7_present.fox2"}}
local c={[1]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/deathmatch/base4_present.fox2"},[2]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/deathmatch/base9_present.fox2"},[3]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/domination/base1_present.fox2"},[4]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/domination/base2_present.fox2"},[5]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/teamsneak/base1_present.fox2"},[6]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/teamsneak/base2_present.fox2"},[7]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/attack/base1_present.fox2"},[8]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/attack/base2_present.fox2"}}
local _={[1]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/deathmatch/base4_present.fox2"},[2]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/deathmatch/base9_present.fox2"},[3]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/domination/base1_present.fox2"},[4]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/domination/base2_present.fox2"},[5]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/teamsneak/base1_present.fox2"},[6]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/teamsneak/base2_present.fox2"},[7]={type=-1,name="mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/attack/base1_present.fox2"},[8]={type=-1,name="mgor_flag002_gim_n0000|srt_mgor_flag002",dataset="/Assets/mgo/level/location/mba0/block_ruleset/attack/base2_present.fox2"}}
function e.DEBUG_NotExistLog(e,e,e)
end
function e.SwapFlags(v,k)
if v=="afc0"then
if k==1 then
for t=1,#m do
local a=Gimmick.DoesGimmickExist(m[t].type,m[t].name,m[t].dataset)
if a then
Gimmick.InvisibleGimmick(m[t].type,m[t].name,m[t].dataset,true)
else
e.DEBUG_NotExistLog(m[t].type,m[t].name,m[t].dataset)
end
end
else
for t=1,#r do
local a=Gimmick.DoesGimmickExist(r[t].type,r[t].name,r[t].dataset)
if a then
Gimmick.InvisibleGimmick(r[t].type,r[t].name,r[t].dataset,true)
else
e.DEBUG_NotExistLog(r[t].type,r[t].name,r[t].dataset)
end
end
for t=1,#m do
local a=Gimmick.DoesGimmickExist(m[t].type,m[t].name,m[t].dataset)
if a then
Gimmick.InvisibleGimmick(m[t].type,m[t].name,m[t].dataset,false)
else
e.DEBUG_NotExistLog(m[t].type,m[t].name,m[t].dataset)
end
end
end
elseif v=="afc1"then
if k==1 then
for t=1,#n do
local a=Gimmick.DoesGimmickExist(n[t].type,n[t].name,n[t].dataset)
if a then
Gimmick.InvisibleGimmick(n[t].type,n[t].name,n[t].dataset,true)
else
e.DEBUG_NotExistLog(n[t].type,n[t].name,n[t].dataset)
end
end
else
for t=1,#d do
local a=Gimmick.DoesGimmickExist(d[t].type,d[t].name,d[t].dataset)
if a then
Gimmick.InvisibleGimmick(d[t].type,d[t].name,d[t].dataset,true)
else
e.DEBUG_NotExistLog(d[t].type,d[t].name,d[t].dataset)
end
end
for t=1,#n do
local a=Gimmick.DoesGimmickExist(n[t].type,n[t].name,n[t].dataset)
if a then
Gimmick.InvisibleGimmick(n[t].type,n[t].name,n[t].dataset,false)
else
e.DEBUG_NotExistLog(n[t].type,n[t].name,n[t].dataset)
end
end
end
elseif v=="afn0"then
if k==1 then
for t=1,#l do
local a=Gimmick.DoesGimmickExist(l[t].type,l[t].name,l[t].dataset)
if a then
Gimmick.InvisibleGimmick(l[t].type,l[t].name,l[t].dataset,true)
else
e.DEBUG_NotExistLog(l[t].type,l[t].name,l[t].dataset)
end
end
else
for t=1,#g do
local a=Gimmick.DoesGimmickExist(g[t].type,g[t].name,g[t].dataset)
if a then
Gimmick.InvisibleGimmick(g[t].type,g[t].name,g[t].dataset,true)
else
e.DEBUG_NotExistLog(g[t].type,g[t].name,g[t].dataset)
end
end
for t=1,#l do
local a=Gimmick.DoesGimmickExist(l[t].type,l[t].name,l[t].dataset)
if a then
Gimmick.InvisibleGimmick(l[t].type,l[t].name,l[t].dataset,false)
else
e.DEBUG_NotExistLog(l[t].type,l[t].name,l[t].dataset)
end
end
end
elseif v=="afda"then
if k==1 then
for t=1,#a do
local s=Gimmick.DoesGimmickExist(a[t].type,a[t].name,a[t].dataset)
if s then
Gimmick.InvisibleGimmick(a[t].type,a[t].name,a[t].dataset,true)
else
e.DEBUG_NotExistLog(a[t].type,a[t].name,a[t].dataset)
end
end
else
for t=1,#f do
local a=Gimmick.DoesGimmickExist(f[t].type,f[t].name,f[t].dataset)
if a then
Gimmick.InvisibleGimmick(f[t].type,f[t].name,f[t].dataset,true)
else
e.DEBUG_NotExistLog(f[t].type,f[t].name,f[t].dataset)
end
end
for t=1,#a do
local s=Gimmick.DoesGimmickExist(a[t].type,a[t].name,a[t].dataset)
if s then
Gimmick.InvisibleGimmick(a[t].type,a[t].name,a[t].dataset,false)
else
e.DEBUG_NotExistLog(a[t].type,a[t].name,a[t].dataset)
end
end
end
elseif v=="cuba"then
if k==1 then
for a=1,#t do
local s=Gimmick.DoesGimmickExist(t[a].type,t[a].name,t[a].dataset)
if s then
Gimmick.InvisibleGimmick(t[a].type,t[a].name,t[a].dataset,true)
else
e.DEBUG_NotExistLog(t[a].type,t[a].name,t[a].dataset)
end
end
else
for t=1,#p do
local a=Gimmick.DoesGimmickExist(p[t].type,p[t].name,p[t].dataset)
if a then
Gimmick.InvisibleGimmick(p[t].type,p[t].name,p[t].dataset,true)
else
e.DEBUG_NotExistLog(p[t].type,p[t].name,p[t].dataset)
end
end
for a=1,#t do
local s=Gimmick.DoesGimmickExist(t[a].type,t[a].name,t[a].dataset)
if s then
Gimmick.InvisibleGimmick(t[a].type,t[a].name,t[a].dataset,false)
else
e.DEBUG_NotExistLog(t[a].type,t[a].name,t[a].dataset)
end
end
end
elseif v=="rma0"then
if k==1 then
for t=1,#s do
local a=Gimmick.DoesGimmickExist(s[t].type,s[t].name,s[t].dataset)
if a then
Gimmick.InvisibleGimmick(s[t].type,s[t].name,s[t].dataset,true)
else
e.DEBUG_NotExistLog(s[t].type,s[t].name,s[t].dataset)
end
end
else
for t=1,#b do
local a=Gimmick.DoesGimmickExist(b[t].type,b[t].name,b[t].dataset)
if a then
Gimmick.InvisibleGimmick(b[t].type,b[t].name,b[t].dataset,true)
else
e.DEBUG_NotExistLog(b[t].type,b[t].name,b[t].dataset)
end
end
for t=1,#s do
local a=Gimmick.DoesGimmickExist(s[t].type,s[t].name,s[t].dataset)
if a then
Gimmick.InvisibleGimmick(s[t].type,s[t].name,s[t].dataset,false)
else
e.DEBUG_NotExistLog(s[t].type,s[t].name,s[t].dataset)
end
end
end
elseif v=="sva0"then
if k==1 then
for t=1,#o do
local a=Gimmick.DoesGimmickExist(o[t].type,o[t].name,o[t].dataset)
if a then
Gimmick.InvisibleGimmick(o[t].type,o[t].name,o[t].dataset,true)
else
e.DEBUG_NotExistLog(o[t].type,o[t].name,o[t].dataset)
end
end
else
for t=1,#i do
local a=Gimmick.DoesGimmickExist(i[t].type,i[t].name,i[t].dataset)
if a then
Gimmick.InvisibleGimmick(i[t].type,i[t].name,i[t].dataset,true)
else
e.DEBUG_NotExistLog(i[t].type,i[t].name,i[t].dataset)
end
end
for t=1,#o do
local a=Gimmick.DoesGimmickExist(o[t].type,o[t].name,o[t].dataset)
if a then
Gimmick.InvisibleGimmick(o[t].type,o[t].name,o[t].dataset,false)
else
e.DEBUG_NotExistLog(o[t].type,o[t].name,o[t].dataset)
end
end
end
elseif v=="mba0"then
if k==1 then
for t=1,#_ do
local a=Gimmick.DoesGimmickExist(_[t].type,_[t].name,_[t].dataset)
if a then
Gimmick.InvisibleGimmick(_[t].type,_[t].name,_[t].dataset,true)
else
e.DEBUG_NotExistLog(_[t].type,_[t].name,_[t].dataset)
end
end
else
for t=1,#c do
local a=Gimmick.DoesGimmickExist(c[t].type,c[t].name,c[t].dataset)
if a then
Gimmick.InvisibleGimmick(c[t].type,c[t].name,c[t].dataset,true)
else
e.DEBUG_NotExistLog(c[t].type,c[t].name,c[t].dataset)
end
end
for t=1,#_ do
local a=Gimmick.DoesGimmickExist(_[t].type,_[t].name,_[t].dataset)
if a then
Gimmick.InvisibleGimmick(_[t].type,_[t].name,_[t].dataset,false)
else
e.DEBUG_NotExistLog(_[t].type,_[t].name,_[t].dataset)
end
end
end
end
end
function e.AddObjectiveBlip(a)a=GameObject.GetGameObjectIdByIndex("TppPoiSystem",0)
local t=GameObject.SendCommand(a,{id="Search",criteria={type=TppPoi.POI_TYPE_GENERIC,tags={"BASE","TEAM_01"}}})
if(t.resultCount==0)then
else
e.addTeamIcons(0,t.results[1].posX,t.results[1].posY,t.results[1].posZ)
end
t=GameObject.SendCommand(a,{id="Search",criteria={type=TppPoi.POI_TYPE_GENERIC,tags={"BASE","TEAM_02"}}})
if(t.resultCount==0)then
else
e.addTeamIcons(1,t.results[1].posX,t.results[1].posY,t.results[1].posZ)
end
local t=GameObject.SendCommand(a,{id="Search",criteria={type=TppPoi.POI_TYPE_GENERIC,tags={"BASE","OBJECTIVE"}}})
if(t.resultCount==0)then
else
e.addTeamIcons(2,t.results[1].posX,t.results[1].posY,t.results[1].posZ)
end
end
function e.addTeamIcons(o,a,s,t)
local l=MpRulesetManager.GetActiveRuleset()
local l=l:GetLocalPlayerTeam()
if l==o then
if e.friendlyBase~=nil then
MgoMap.RemoveIcon(e.friendlyBase)
end
if MgoMap.AddIcon2~=nil then
e.friendlyBase=MgoMap.AddIcon2("FortFriendly",a,s,t,"Icons")
else
e.friendlyBase=MgoMap.AddIcon("FortFriendly",a,t,"Icons")
end
elseif o==2 then
if e.friendlyBase~=nil then
MgoMap.RemoveIcon(e.friendlyBase)
end
if MgoMap.AddIcon2~=nil then
e.friendlyBase=MgoMap.AddIcon2("FortFriendly",a,s,t,"Icons")
else
e.friendlyBase=MgoMap.AddIcon("FortFriendly",a,t,"Icons")
end
else
if e.enemyBase~=nil then
MgoMap.RemoveIcon(e.enemyBase)
end
if MgoMap.AddIcon2~=nil then
e.enemyBase=MgoMap.AddIcon2("FortEnemy",a,s,t,"Icons")
else
e.enemyBase=MgoMap.AddIcon("FortEnemy",a,t,"Icons")
end
end
end
function e.removeTeamIcons()
if e.friendlyBase~=nil then
MgoMap.RemoveIcon(e.friendlyBase)
end
if e.enemyBase~=nil then
MgoMap.RemoveIcon(e.enemyBase)
end
end
return e
