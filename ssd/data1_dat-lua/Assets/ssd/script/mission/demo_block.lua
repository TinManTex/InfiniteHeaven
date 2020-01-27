local n={}
local e=TppDemoBlock.OnAllocate
local o=TppDemoBlock.OnInitialize
local l=TppDemoBlock.OnUpdate
local c=TppDemoBlock.OnTerminate
function n.OnAllocate()e()
end
function n.OnInitialize()o()
end
function n.OnUpdate()l()
end
function n.OnTerminate()c()
end
return n
