local npc_block = {}






function npc_block.OnAllocate()
	Fox.Log("!!!!! npc_block.OnAllocate !!!!!")

	
	
	TppScriptBlock.InitScriptBlockState()

end

function npc_block.OnInitialize()
	Fox.Log("!!!!! npc_block_Plh.OnInitialize !!!!!")

	
	coroutine.yield()
	coroutine.yield()
	
	local gameObjectId = GameObject.GetGameObjectId( "TppHostage2GameObjectLocator" )
	GameObject.SendCommand( gameObjectId, {
		id="SpecialAction",
		action="PlayMotion",
		path="/Assets/tpp/motion/SI_game/fani/bodies/plh3/plh3/plh3_p_bed_idl.gani",
		autoFinish=false,
		enableMessage=true,
		enableGravity=false,
		enableCollision=false,
	} )	
				
	
	local gameObjectId = GameObject.GetGameObjectId( "TppHostage2GameObjectLocator0000" )
	GameObject.SendCommand( gameObjectId, {
		id="SpecialAction",
		action="PlayMotion",
		path="/Assets/tpp/motion/SI_game/fani/bodies/plh2/plh2/plh2_p_bed_idl.gani",
		autoFinish=false,
		enableMessage=true,
		enableGravity=false,
		enableCollision=false,
	} )	
						
	
	local NaedokoDefine = {
		"TppHostage2GameObjectLocator0001",
		"TppHostage2GameObjectLocator0002",
		"TppHostage2GameObjectLocator0003",
		"TppHostage2GameObjectLocator0004",
		"TppHostage2GameObjectLocator0005",
		"TppHostage2GameObjectLocator0006",
		"TppHostage2GameObjectLocator0007",
		"TppHostage2GameObjectLocator0008",
		"TppHostage2GameObjectLocator0009",
		"TppHostage2GameObjectLocator0010",
	}
	for i, NaedokoId in ipairs( NaedokoDefine ) do
		local gameObjectId = GameObject.GetGameObjectId( NaedokoId )
		GameObject.SendCommand( gameObjectId, {
			id="SpecialAction",
			action="PlayMotion",
			path="/Assets/tpp/motion/SI_game/fani/bodies/plh0/plh0/plh0_p_bed_idl1.gani",
			autoFinish=false,
			enableMessage=true,
			enableGravity=false,
			enableCollision=false,
		} )	
	end	
	
end

function npc_block.OnUpdate()
	

	


end

function npc_block.OnTerminate()
	Fox.Log("!!!!! npc_block.OnTerminate !!!!!")

	
	TppScriptBlock.FinalizeScriptBlockState()
end

return npc_block
