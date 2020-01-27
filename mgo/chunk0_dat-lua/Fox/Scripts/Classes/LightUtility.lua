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
  CopyLightProperties=function(e,t)
    Command.SetProperty{entity=t.transform,property="translation",value=e.transform.translation}
    Command.SetProperty{entity=t.transform,property="rotQuat",value=e.transform.rotQuat}
    Command.SetProperty{entity=t.transform,property="scale",value=e.transform.scale}
    local o=Color(1,1,1,1)
    if e:IsKindOf(Ambient)then
      o=e.skyColor
    else
      o=e.color
    end
    if t:IsKindOf(Ambient)then
      Command.SetProperty{entity=t,property="skyColor",value=o}
      Command.SetProperty{entity=t,property="groundColor",value=o}
    else
      Command.SetProperty{entity=t,property="color",value=o}
    end
    Command.SetProperty{entity=t,property="isOn",value=e.isOn}
    Command.SetProperty{entity=t,property="showObject",value=e.showObject}
  end}
