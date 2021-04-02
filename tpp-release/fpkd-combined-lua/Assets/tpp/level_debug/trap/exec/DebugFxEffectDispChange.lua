






DebugFxEffectDispChange = {


VisibleRecursively = function( data, ref, disp, tree )
    	
    	local effect = data:GetDataBodyWithReferrer( ref )
		
	
	if effect:IsKindOf( FxLocator ) then
	
		
		if disp.isVisible == true then
			effect:Visible()
		elseif disp.isInVisible == true then
			effect:Invisible()
		elseif disp.isCreate == true then
			effect:Create()
		elseif disp.isDestroy == true then
			effect:Destroy()
		end
	end
	
	
	
	if tree == true then
		local children = data:GetChildren()
    		for n, child in pairs( children ) do
        		DebugFxEffectDispChange.VisibleRecursively( child, ref, disp, tree )
		end
	end
    	
end,



Exec = function( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		DebugFxEffectDispChange.VisibleRecursively( info.conditionHandle.TestFxData, info.trapBodyHandle, info.conditionHandle, info.conditionHandle.setAllChildren )
		
		
		info.conditionBodyHandle.isDone = true
		
	end
	
	return 1

end,



AddParam = function( condition )
	
	
	condition:AddConditionParam( 'bool', "setAllChildren" )
	condition.setAllChildren = true	

	
	condition:AddConditionParam( 'EntityLink', "TestFxData" )
	condition.TestFxData = nil
	
	
	condition:AddConditionParam( 'bool', "isVisible" )		
	condition:AddConditionParam( 'bool', "isInVisible" )	
	condition:AddConditionParam( 'bool', "isCreate" )		
	condition:AddConditionParam( 'bool', "isDestroy" )		
	condition.isVisible = false
	condition.isInVisible = false
	condition.isCreate = false
	condition.isDestroy = false

end,

}

