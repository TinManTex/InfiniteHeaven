local this={}
local HasRecipe=SsdSbm.HasRecipe
local AddRecipe=SsdSbm.AddRecipe
function this.UnlockConditionClearedRecipe(n)
  local n=SsdRecipeList.GetRecipeListByItemId[n]
  if not n then
    return
  end
  for i,n in ipairs(n)do
    this._UnlockConditionClearedRecipe(n)
  end
end
function this._UnlockConditionClearedRecipe(e)
  if HasRecipe(e)then
    return
  end
  local i=SsdRecipeList.GetStorySequenceByRecipeName[e]
  if i and(TppStory.GetCurrentStorySequence()<i)then
    return
  end
  local i=SsdRecipeList.GetBuildingNameByRecipeName[e]
  if i and(SsdBuilding.GetItemCount{id=i}<=0)then
    return
  end
  AddRecipe(e)
end
function this.UnlockRecipeOnAccessCockingFacility(n)
  local n=SsdRecipeList.GetRecipeNameByBuildingNameAndResourceName[n]
  for n,i in pairs(n)do
    this._UnlockRecipeOnAccessCockingFacility(n,i)
  end
end
function this._UnlockRecipeOnAccessCockingFacility(i,e)
  if HasRecipe(e)then
    return
  end
  if(SsdSbm.GetCountResource{id=i,inInventory=true,inWarehouse=true,inLostCbox=true}>0)then
    AddRecipe(e)
  end
end
return this
