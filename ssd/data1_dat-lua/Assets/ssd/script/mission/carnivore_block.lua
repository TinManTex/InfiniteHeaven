local n={}
function n.OnAllocate()
TppAnimalBlock.OnAllocate(n)
end
function n.OnInitialize()
TppAnimalBlock.OnInitializeAnimalBlock(animalTypeSetting)
end
function n.OnTerminate()
TppAnimalBlock.OnTerminate()
end
return n
