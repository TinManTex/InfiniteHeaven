local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.demoList = {	
	Demo_RecoverVolgin		= "p31_080110_000_final"
}

this.demoBlockList = {
}

function this.PlayRecoverVolgin( startFunc, endFunc )
	Fox.Log("***** f30250_demo:PlayRecoverVolgin *****")
	local trans, rotQuat = MotherBaseStage.GetDemoCenter( 7, 0 )
	local playerInitPos = { trans:GetX() + -4.338535, trans:GetY() + -7.999712, trans:GetZ() + -13.7774, }
	TppPlayer.Warp{ pos = playerInitPos, rotY = -0.740312}

	local demoId = "p31_080110_000_final"
	DemoDaemon.SetDemoTransform( demoId, rotQuat, trans )
	TppDemo.Play("Demo_RecoverVolgin",
		{
			onStart = function() startFunc() end,
			onEnd = function() endFunc() end,
		},
		{
			useDemoBlock = false,
			finishFadeOut = false
		}
	)
end

return this
