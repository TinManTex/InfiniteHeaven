local e={}
local l=Fox.StrCode32
local t=Tpp.IsTypeFunc
local c=Tpp.IsTypeTable
local r=ScriptBlock.GetCurrentScriptBlockId
local t=ScriptBlock.GetScriptBlockState
local t=8
if ScriptBlock.SCRIPT_BLOCK_COUNT_MAX then
t=ScriptBlock.SCRIPT_BLOCK_COUNT_MAX
end
local n=-127
function e.DeclareSVars()
return{{name="sbl_scriptBlockName",type=TppScriptVars.TYPE_UINT32,arraySize=t,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="sbl_scriptBlockPack",type=TppScriptVars.TYPE_UINT32,arraySize=t,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="sbl_isActive",type=TppScriptVars.TYPE_BOOL,arraySize=t,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.GetCurrentPackListName(e)
local t=ScriptBlock.GetScriptBlockId(e)
if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
local e=mvars.sbl_scriptBlockPackList[e]
if not e then
return
end
local t=svars.sbl_scriptBlockPack[t]
if t==0 then
return
end
for e,c in pairs(e)do
if t==Fox.StrCode32(e)then
return e
end
end
else
return false
end
end
function e.OnAllocate(t)
mvars.sbl_scriptBlockPackList={}
mvars.sbl_scriptBlockStrCode32PackList={}
mvars.sbl_scriptBlockState={}
mvars.sbl_preloadRequestTable={}
if t.demo and t.demo.demoBlockList then
e.RegisterCommonBlockPackList("demo_block",t.demo.demoBlockList)
end
end
function e.RegisterCommonBlockPackList(e,t)
if type(e)~="string"then
return
end
if c(t)then
mvars.sbl_scriptBlockPackList[e]={}
mvars.sbl_scriptBlockStrCode32PackList[e]={}
for t,c in pairs(t)do
mvars.sbl_scriptBlockPackList[e][t]=c
end
else
return
end
end
function e.InitScriptBlockState(t)
e.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.ALLOCATED)
end
function e.FinalizeScriptBlockState(t)
e.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.EMPTY)
end
function e.ActivateScriptBlockState(t)
local e=e.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.ACTIVATED)
if e then
svars.sbl_isActive[t]=true
ScriptBlock.Activate(t)
end
end
function e.DeactivateScriptBlockState(t)
local e=e.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.INITIALIZED)
if e then
svars.sbl_isActive[t]=false
ScriptBlock.Deactivate(t)
end
end
function e.RequestActivate(t)
local t=ScriptBlock.GetScriptBlockId(t)
e.RequestActivateByBlockId(t)
end
function e.RequestActivateByBlockId(t)
if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
local c=ScriptBlock.GetScriptBlockState(t)
if c<=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
return
end
if mvars.sbl_scriptBlockState[t]<TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED then
e.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED)
end
end
end
function e.IsRequestActivate(e)
local e=e or r()
if mvars.sbl_scriptBlockState[e]==TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED then
return true
else
return false
end
end
function e.SetScriptBlockState(c,e)
local c=c or r()
if c==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return false
end
if c>=t then
return false
end
if(e>=TppDefine.SCRIPT_BLOCK_STATE.MIN)or(e<TppDefine.SCRIPT_BLOCK_STATE.MAX)then
mvars.sbl_scriptBlockState[c]=e
return true
else
return false
end
end
function e.LoadDemoBlock(t,c)
e.Load("demo_block",t,true,c)
end
function e.Load(c,n,i,t)
if gvars.exc_processingForDisconnect then
return
end
local r=true
if t==false then
r=false
end
local t=ScriptBlock.GetScriptBlockId(c)
if t~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
e.SaveScriptBlockId(c,t)
local c=e.FindPackList(c,n)
if c then
svars.sbl_scriptBlockPack[t]=l(n)
if r then
ScriptBlock.Load(t,c)
end
if i then
e.ActivateScriptBlockState(t)
end
else
return false
end
else
return false
end
end
function e.Unload(e)
local e=ScriptBlock.GetScriptBlockId(e)
if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
svars.sbl_scriptBlockPack[e]=0
ScriptBlock.Load(e,"")
else
return false
end
end
function e.UnloadAll()
for e=0,t-1 do
svars.sbl_scriptBlockPack[e]=0
ScriptBlock.Load(e,"")
end
end
function e.SaveScriptBlockId(t,e)
local t=Fox.StrCode32(t)svars.sbl_scriptBlockName[e]=t
end
function e.FindPackList(e,t)
if Tpp.IsTypeTable(mvars.sbl_scriptBlockPackList)then
if mvars.sbl_scriptBlockPackList[e]then
return mvars.sbl_scriptBlockPackList[e][t]
end
end
end
function e.PreloadRequestOnMissionStart(e)
if not c(e)then
return
end
local c=mvars.sbl_preloadRequestTable
for t,e in pairs(e)do
local l,t=next(e)
local e={}e[l]=t
table.insert(c,e)
end
end
function e.DEBUG_PreloadRequest(t)
if not c(t)then
return
end
e.DEBUG_preloadRequestTable=t
end
function e.DEBUG_ClearPreloadRequest()
e.DEBUG_preloadRequestTable=nil
end
function e.PreloadSettingOnMissionStart()
local t=mvars.sbl_preloadRequestTable
if(Tpp.IsQARelease()or nil)and c(e.DEBUG_preloadRequestTable)then
for c,e in pairs(e.DEBUG_preloadRequestTable)do
local c
local l,r=next(e)
for e,t in pairs(t)do
local t,r=next(t)
if t==l then
c=e
end
end
local e={}e[l]=r
if c then
t[c]=e
else
table.insert(t,e)
end
end
end
if not next(t)then
return
end
for t,e in pairs(t)do
if next(e)then
for e,t in pairs(e)do
local e=ScriptBlock.GetScriptBlockId(e)
if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
svars.sbl_scriptBlockPack[e]=l(t)svars.sbl_isActive[e]=true
end
end
end
end
end
function e.ReloadScriptBlock()
if gvars.exc_processingForDisconnect then
return
end
mvars.sbl_currentScriptBlockPackInfo={}
for t=0,(t-1)do
e.ResolveSavedScriptBlockInfo(t)
end
for t,e in pairs(mvars.sbl_currentScriptBlockPackInfo)do
svars.sbl_scriptBlockPack[t]=e.packListKeyHash
svars.sbl_scriptBlockName[t]=e.scriptBlockNameHash
end
for e,t in pairs(mvars.sbl_scriptBlockPackList)do
local e=ScriptBlock.GetScriptBlockId(e)
if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
mvars.sbl_scriptBlockStrCode32PackList[e]={}
for c,t in pairs(t)do
mvars.sbl_scriptBlockStrCode32PackList[e][l(c)]=t
end
end
end
for t=0,(t-1)do
local c=svars.sbl_scriptBlockPack[t]
if c>0 then
if mvars.sbl_scriptBlockStrCode32PackList[t]then
local c=mvars.sbl_scriptBlockStrCode32PackList[t][c]
if c then
ScriptBlock.Load(t,c)
if svars.sbl_isActive[t]then
e.ActivateScriptBlockState(t)
end
end
end
end
end
end
function e.ResolveSavedScriptBlockInfo(t)
local l=svars.sbl_scriptBlockName[t]
local n=svars.sbl_scriptBlockPack[t]
if l==0 then
return
end
if n==0 then
return
end
local c
for e,t in pairs(mvars.sbl_scriptBlockPackList)do
if Fox.StrCode32(e)==l then
c=e
break
end
end
if not c then
e.ClearSavedScriptBlockInfo(t)
return
end
local r=ScriptBlock.GetScriptBlockId(c)
if r~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
mvars.sbl_currentScriptBlockPackInfo[r]={scriptBlockNameHash=l,packListKeyHash=n}
else
e.ClearSavedScriptBlockInfo(t,c)
end
end
function e.ClearSavedScriptBlockInfo(e,t)svars.sbl_scriptBlockName[e]=0
svars.sbl_scriptBlockPack[e]=0
end
return e
