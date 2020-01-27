local demo_block = {}

local TppDemoBlock_OnAllocate = TppDemoBlock.OnAllocate
local TppDemoBlock_OnInitialize = TppDemoBlock.OnInitialize
local TppDemoBlock_OnUpdate = TppDemoBlock.OnUpdate
local TppDemoBlock_OnTerminate = TppDemoBlock.OnTerminate

function demo_block.OnAllocate()
	TppDemoBlock_OnAllocate()
end

function demo_block.OnInitialize()
	TppDemoBlock_OnInitialize()
end

function demo_block.OnUpdate()
	TppDemoBlock_OnUpdate()
end

function demo_block.OnTerminate()
	TppDemoBlock_OnTerminate()
end

return demo_block