local npc_block = {}





function npc_block.OnAllocate()
	Fox.Log("!!!!! npc_block.OnAllocate !!!!!")

	
	
	TppScriptBlock.InitScriptBlockState()

end

function npc_block.OnInitialize()
	Fox.Log("!!!!! npc_block.OnInitialize !!!!!")

	

end

function npc_block.OnUpdate()
	

	


end

function npc_block.OnTerminate()
	Fox.Log("!!!!! npc_block.OnTerminate !!!!!")

	
	TppScriptBlock.FinalizeScriptBlockState()
end

return npc_block
