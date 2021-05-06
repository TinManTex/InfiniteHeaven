







ActionTppNewPlayerStepOnByPath = {


__WakeUpStates = {
	"stateNewStandStepOn",
	"stateNewSquatStepOn",
	"stateNewStandStepOn75cm",
	"stateNewSquatStepOn75cm",
},




__OnWakeUp = function( plugin )
	local chara = plugin:GetCharacter()
	local plgAdjust = chara:FindPlugin( "ChHumanAdjustPlugin" )
	plgAdjust:LegsIkOff()
end,




__OnSleep = function( plugin )
	local chara = plugin:GetCharacter()
	local plgAdjust = chara:FindPlugin( "ChHumanAdjustPlugin" )
	plgAdjust:LegsIkOn()
end,





__OnPreControl = function( plugin )
end,

}
