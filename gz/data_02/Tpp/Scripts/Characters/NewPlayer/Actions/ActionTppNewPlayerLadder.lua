






ActionTppNewPlayerLadder = {



__WakeUpStates = {
	"stateNewStandLadderIdle",
	"stateNewSquatLadderMove",
	"stateNewStandLadderFallDown",
},




__OnLoad = function( plugin )
end,




__WakeUpCheck = function( plugin )
end,




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




__OnPreAnim = function( plugin )
end,




__OnPreControl = function( plugin )
end,

}
