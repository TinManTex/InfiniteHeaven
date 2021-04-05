local this = {}

this.orderBoxList = {
	"box_s10195_00",
	"box_s10195_01",
}

this.orderBoxTrapList = Tpp.StrCode32Table{
	trap_box_s10195_00 = "box_s10195_00",
	trap_box_s10195_01 = "box_s10195_01",
}

function this.OnAllocate()
	
	TppScriptBlock.InitScriptBlockState()
end

function this.OnInitialize()
	order_box_block.OnInitializeOrderBoxBlock( this, this.orderBoxTrapList )
end

function this.OnUpdate()
	order_box_block.OnUpdateOrderBoxBlock( this, this.orderBoxList )
end

function this.OnTerminate()
	order_box_block.OnTerminateOrderBoxBlock( this, this.orderBoxList )
end

return this