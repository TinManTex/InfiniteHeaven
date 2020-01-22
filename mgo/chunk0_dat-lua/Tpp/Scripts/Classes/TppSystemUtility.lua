TppSystemUtility={SetSquadEnableState=function(e,t)
if(e:IsKindOf"ChCharacterLocator"==false)then
return false
end
local e=e.charaObj
if(Entity.IsNull(e))then
return true
end
if(e:IsKindOf"AiSquadObject"==false)then
return false
end
e:SetMembersEnable(t)
return true
end}
