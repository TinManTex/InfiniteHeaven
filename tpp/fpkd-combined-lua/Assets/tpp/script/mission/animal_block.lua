local animal_block = {}





function animal_block.OnAllocate()
	TppAnimalBlock.OnAllocate( animal_block )
end

function animal_block.OnInitialize()
	TppAnimalBlock.OnInitializeAnimalBlock( animalTypeSetting )--ORPHAN?
end

function animal_block.OnTerminate()
	TppAnimalBlock.OnTerminate()
end

return animal_block
