local carnivore_block = {}





function carnivore_block.OnAllocate()
	TppAnimalBlock.OnAllocate( carnivore_block )
end

function carnivore_block.OnInitialize()
	TppAnimalBlock.OnInitializeAnimalBlock( animalTypeSetting )
end

function carnivore_block.OnTerminate()
	TppAnimalBlock.OnTerminate()
end

return carnivore_block
