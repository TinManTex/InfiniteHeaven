ActionTppDemo = {


	















OnPreControl = function( plugin )

	if DemoPreference.GetInstance().isShowLocatorLabel then
		local chara = plugin:GetCharacter()
		local charaPos = chara:GetPosition() + Vector3(0,1.5,0)
		GrxDebug.Print3D{ pos=charaPos, args={ plugin:GetDemoName() } }
	end

end,

}
