local this={}
local e=ScriptBlock.GetCurrentScriptBlockId
local c=ScriptBlock.GetScriptBlockState
function this.OnAllocate()
TppScriptBlock.InitScriptBlockState()
end
function this.OnInitialize()
end
function this.OnUpdate()
local t=e()
local c=c(t)
if c==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
TppDemo.PlayOnDemoBlock()
return
end
if TppScriptBlock.IsRequestActivate(t)then
TppScriptBlock.ActivateScriptBlockState(t)
end
end
function this.OnTerminate()
TppDemo.FinalizeOnDemoBlock()
TppScriptBlock.FinalizeScriptBlockState()
end
return this
