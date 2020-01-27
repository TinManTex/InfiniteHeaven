LightUtility={
  CycleLightType=function()
    local editor=Editor.GetInstance()
    local entitySelector=editor.entitySelector
    local entities=entitySelector:GetEntities()
    local numEntities=#entities
    Command.StartGroup()
    for i=1,numEntities do
      local entity=entities[i]
      if entity:IsKindOf(PointLightBody)then
        LightUtility.ReplaceLight(entity.data,"SpotLight")
      elseif entity:IsKindOf(SpotLightBody)then
        LightUtility.ReplaceLight(entity.data,"Ambient")
      elseif entity:IsKindOf(AmbientBody)then
        LightUtility.ReplaceLight(entity.data,"DirectionalLight")
      elseif entity:IsKindOf(DirectionalLightBody)then
        LightUtility.ReplaceLight(entity.data,"PointLight")
      else
        print("Selected object is not a light, but a "..tostring(entity))
      end
    end
    Command.EndGroup()
  end,
  ReplaceLight=function(t,e)
    local editor=Editor.GetInstance()
    local o,e=Command.CreateData(e)
    LightUtility.CopyLightProperties(t,o)
    Command.DeleteData(t)
    Command.AddSelection(editor,e)
  end,
  CopyLightProperties=function(sourceEntity,destEntity)
    Command.SetProperty{entity=destEntity.transform,property="translation",value=sourceEntity.transform.translation}
    Command.SetProperty{entity=destEntity.transform,property="rotQuat",value=sourceEntity.transform.rotQuat}
    Command.SetProperty{entity=destEntity.transform,property="scale",value=sourceEntity.transform.scale}
    local color=Color(1,1,1,1)
    if sourceEntity:IsKindOf(Ambient)then
      color=sourceEntity.skyColor
    else
      color=sourceEntity.color
    end
    if destEntity:IsKindOf(Ambient)then
      Command.SetProperty{entity=destEntity,property="skyColor",value=color}
      Command.SetProperty{entity=destEntity,property="groundColor",value=color}
    else
      Command.SetProperty{entity=destEntity,property="color",value=color}
    end
    Command.SetProperty{entity=destEntity,property="isOn",value=sourceEntity.isOn}
    Command.SetProperty{entity=destEntity,property="showObject",value=sourceEntity.showObject}
  end}
