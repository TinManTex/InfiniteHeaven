local this={}
local OnAllocate=TppDemoBlock.OnAllocate
local OnInitialize=TppDemoBlock.OnInitialize
local OnUpdate=TppDemoBlock.OnUpdate
local OnTerminate=TppDemoBlock.OnTerminate
function this.OnAllocate()
  OnAllocate()
end
function this.OnInitialize()
  OnInitialize()
end
function this.OnUpdate()
  OnUpdate()
end
function this.OnTerminate()
  OnTerminate()
end
return this
