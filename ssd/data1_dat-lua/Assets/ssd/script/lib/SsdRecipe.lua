-- SsdRecepie.lua
local this={}
local HasRecipe=SsdSbm.HasRecipe
local AddRecipe=SsdSbm.AddRecipe
function this.UnlockConditionClearedRecipe(itemId)
  local recipieList=SsdRecipeList.GetRecipeListByItemId[itemId]
  if not recipieList then
    return
  end
  for i,recepieName in ipairs(recipieList)do
    this._UnlockConditionClearedRecipe(recepieName)
  end
end
function this._UnlockConditionClearedRecipe(recipeName)
  if HasRecipe(recipeName)then
    return
  end
  local recepieStorySequence=SsdRecipeList.GetStorySequenceByRecipeName[recipeName]
  if recepieStorySequence and(TppStory.GetCurrentStorySequence()<recepieStorySequence)then
    return
  end
  local buildingId=SsdRecipeList.GetBuildingNameByRecipeName[recipeName]
  if buildingId and(SsdBuilding.GetItemCount{id=buildingId}<=0)then
    return
  end
  AddRecipe(recipeName)
end
function this.UnlockRecipeOnAccessCockingFacility(productionName)
  local recepiesForProduct=SsdRecipeList.GetRecipeNameByBuildingNameAndResourceName[productionName]
  for resourceName,recepieName in pairs(recepiesForProduct)do
    this._UnlockRecipeOnAccessCockingFacility(resourceName,recepieName)
  end
end
function this._UnlockRecipeOnAccessCockingFacility(resourceId,recipeId)
  if HasRecipe(recipeId)then
    return
  end
  if(SsdSbm.GetCountResource{id=resourceId,inInventory=true,inWarehouse=true,inLostCbox=true}>0)then
    AddRecipe(recipeId)
  end
end
return this
