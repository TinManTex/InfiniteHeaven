local this={}
function this.OnAllocate()
  TppAnimalBlock.OnAllocate(this)
end
function this.OnInitialize()
  TppAnimalBlock.OnInitializeAnimalBlock(animalTypeSetting)--RETAILBUG: ORPHAN: param unused anyway
end
function this.OnTerminate()
  TppAnimalBlock.OnTerminate()
end
return this
