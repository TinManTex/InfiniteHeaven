local herbivore_block = {}





function herbivore_block.OnAllocate()
	TppAnimalBlock.OnAllocate( herbivore_block )
end

function herbivore_block.OnInitialize()
	TppAnimalBlock.OnInitializeAnimalBlock( animalTypeSetting )
end

function herbivore_block.OnTerminate()
	TppAnimalBlock.OnTerminate()
end

return herbivore_block
