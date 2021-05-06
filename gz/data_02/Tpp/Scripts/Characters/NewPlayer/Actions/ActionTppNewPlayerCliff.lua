


ActionTppNewPlayerCliff = {



__WakeUpStates = {
	"stateNewStandCliff",
	"stateNewSquatCliff",
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

}
