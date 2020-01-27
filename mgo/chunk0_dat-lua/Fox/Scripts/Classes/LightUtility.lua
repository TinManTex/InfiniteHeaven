LightUtility={
  CycleLightType=function()
    local t=Editor.GetInstance()
    local t=t.entitySelector
    local t=t:GetEntities()
    local e=#t
    Command.StartGroup()
    for e=1,e do
      local t=t[e]
      if t:IsKindOf(PointLightBody)then
        LightUtility.ReplaceLight(t.data,"SpotLight")
      elseif t:IsKindOf(SpotLightBody)then
        LightUtility.ReplaceLight(t.data,"Ambient")
      elseif t:IsKindOf(AmbientBody)then
        LightUtility.ReplaceLight(t.data,"DirectionalLight")
      elseif t:IsKindOf(DirectionalLightBody)then
        LightUtility.ReplaceLight(t.data,"PointLight")
      else
        print("Selected object is not a light, but a "..tostring(t))
      end
    end
    Command.EndGroup()
  end,
  ReplaceLight=function(t,e)
    local i=Editor.GetInstance()
    local o,e=Command.CreateData(e)
    LightUtility.CopyLightProperties(t,o)
    Command.DeleteData(t)
    Command.AddSelection(i,e)
  end,
  CopyLightProperties=function(e,t)Command.SetProperty{entity=t.transform,property="translation",value=e.transform.translation}
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
  end
}
