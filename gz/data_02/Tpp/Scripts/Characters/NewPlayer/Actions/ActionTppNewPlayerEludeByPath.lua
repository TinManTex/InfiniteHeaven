







ActionTppNewPlayerEludeByPath = {


__WakeUpStates = {
	"stateNewEludeIdle",
	"stateNewEludeMoveRight",
	"stateNewEludeMoveLeft",
	"stateNewEludeMoveRightIn90",
	"stateNewEludeMoveLeftIn90",
	"stateNewEludeMoveRightOut90",
	"stateNewEludeMoveLeftOut90",
	"stateNewEludeFallDown",
	"stateNewStandStepOn",
	"stateNewSquatStepOn",
	"stateNewStandStepOn75cm",
	"stateNewSquatStepOn75cm",
	"stateNewStandFenceElude",
	"stateNewSquatFenceElude",
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
