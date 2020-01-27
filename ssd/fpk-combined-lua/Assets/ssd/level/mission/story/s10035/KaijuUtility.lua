


local KaijuUtility = {}

local SEND_COMMAND_INSTANCE_MAX = {
	SetEnabled = 3,
	SetRail = 3,
}

function KaijuUtility.SendCommand( command )
	if not command then
		Fox.Error( "Kaiju", "KaijuUtility.SendCommand : command is nil" )
		return
	end
	local commandId = command.id
	if not commandId then
		Fox.Error( "Kaiju", "KaijuUtility.SendCommand : command.id is nil" )
		return
	end
	local commandInstanceMax = SEND_COMMAND_INSTANCE_MAX[commandId] or 0
	
	local tempArrayCommandOption = {}
	for optionName, value in pairs(command) do
		if Tpp.IsTypeTable( value )
		and ( #value == 3 ) then
			tempArrayCommandOption[optionName] = value
		end
	end
	
	
	for i = 0, commandInstanceMax do
		local baseGameObjectId = GameObject.GetGameObjectId( "SsdKaiju", "kij_0000" )
		local gameObjectId = baseGameObjectId + i
		for optionName, valueArray in pairs(tempArrayCommandOption) do
			command[optionName] = valueArray[i]
		end
		GameObject.SendCommand( gameObjectId, command )
	end
end

function KaijuUtility.SetEnabled( enable )
	Fox.Log( "Kaiju", "KaijuUtility.SetEnabled : " .. tostring(enable) )
	KaijuUtility.SendCommand( { id = "SetEnabled", enabled = enable, } )	
end

function KaijuUtility.SetUpBySequence( params )
	Fox.Log( "Kaiju", "KaijuUtility.SetUpBySequence" )
	if not params then
		KaijuUtility.SendCommand( { id = "SetEnabled", enabled = false, } )
		return
	end

	KaijuUtility.SendCommand( { id = "SetEnabled", enabled = true, } )

	local railSetting = params.rail
	if railSetting then
		local rail, startType, isOneArmed, isGroundIkOff
		if Tpp.IsTypeTable( railSetting ) then
			rail = railSetting[1]
			startType = railSetting.startType
			isOneArmed = railSetting.isOneArmed
			isGroundIkOff = railSetting.isGroundIkOff
		else
			rail = railSetting
		end
		Fox.Log( "Kaiju", "KaijuUtility : SetRail : rail = " .. tostring(rail) .. ", startType = " .. tostring(startType) .. ", isOneArmed = " .. tostring(isOneArmed) )
		KaijuUtility.SendCommand( { id = "SetRail", rail = rail, startType = startType, isOneArmed = isOneArmed, isGroundIkOff = isGroundIkOff } )	
	end
	
	local setCommandAction = params.setCommandAction
	if setCommandAction then
		Fox.Log( "Kaiju", "KaijuUtility : SetCommandAction : actionType = " .. tostring(setCommandAction.actionType) .. ", startType = " .. tostring(setCommandAction.startType) )
		KaijuUtility.SendCommand( { id = "SetCommandAction", actionType = setCommandAction.actionType, startType = setCommandAction.startType } )
	end
	
	local setSpecialState = params.setSpecialState
	if setSpecialState then
		Fox.Log( "Kaiju", "KaijuUtility : SetSpecialState : stateType = " .. tostring(setSpecialState.stateType) .. ", isEnable = " .. tostring(setSpecialState.isEnable) )
		KaijuUtility.SendCommand( { id = "SetSpecialState", stateType = setSpecialState.stateType, isEnable = setSpecialState.isEnable } )
	end
	local setSpecialState2 = params.setSpecialState2
	if setSpecialState2 then
		Fox.Log( "Kaiju", "KaijuUtility : SetSpecialState : stateType = " .. tostring(setSpecialState2.stateType) .. ", isEnable = " .. tostring(setSpecialState2.isEnable) )
		KaijuUtility.SendCommand( { id = "SetSpecialState", stateType = setSpecialState2.stateType, isEnable = setSpecialState2.isEnable } )
	end
end

function KaijuUtility.AttackShellToPlayer()
	KaijuUtility.SendCommand( { id = "SetCommandAction", actionType = "ShellAttack", targetPosition = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ) } )
end

function KaijuUtility.DisableMaterialControlInDemo()
	KaijuUtility.SendCommand( { id = "SetSpecialState", stateType = "DisableMaterialControlInDemo", isEnable = true, } )
end





local MAX_KAIJU_HATE_VALUE = 99999999.0

function KaijuUtility.SetDefenseTarget( locatorToGameObjectIdNameTable )
	Fox.Log("Kaiju", "KaijuUtility.SetDefenseTarget")
	mvars.kaijuUtility_getDefenseTargetGameObjectId = locatorToGameObjectIdNameTable
end

function KaijuUtility.EnableDefenseGameAI()
	KaijuUtility.SendCommand{
		id = "SetOENW",
		isEnable = true,
		attackHateValue = {
			player = 2000.0,
		},
		
		reduceHateValueAfterAttack = 0,
	}
end

function KaijuUtility.PauseDefenseGameAI()
	Fox.Log("Kaiju", "KaijuUtility.PauseDefenseGameAI.")
	KaijuUtility.SendCommand{
		id = "SetOENW",
		isEnable = true,
		attackReadyHateValue = MAX_KAIJU_HATE_VALUE,
		attackHateValue = {
			defenseTarget = MAX_KAIJU_HATE_VALUE,
		},
	}
end

function KaijuUtility.SetKaijuWaveSetting( targetName, attackReadyHate, attackDefenseTargetHate )
	if not mvars.kaijuUtility_getDefenseTargetGameObjectId then
		Fox.Error("Kaiju", "KaijuUtility.SetKaijuWaveSetting:mvars.kaijuUtility_getDefenseTargetGameObjectId is not initialized.")
		return
	end
	local gameObjectId = mvars.kaijuUtility_getDefenseTargetGameObjectId[targetName]
	if not gameObjectId then
		Fox.Error("Kaiju", "KaijuUtility.SetKaijuWaveSetting:Invalid targetName.")
		return
	end
	Fox.Log("Kaiju", "KaijuUtility.SetKaijuWaveSetting: targetName = " .. tostring(targetName) .. ", attackReadyHate = " .. tostring(attackReadyHate) .. ", attackDefenseTargetHate = " .. tostring(attackDefenseTargetHate) .. ", gameObjectId = " .. tostring(gameObjectId) )
	
	KaijuUtility.SendCommand{
		id = "SetOENW",
		isEnable = true,
		defenseTargetId = gameObjectId,
		attackReadyHateValue = attackReadyHate,
		attackHateValue = {
			defenseTarget = attackDefenseTargetHate,
		},
	}
end

function KaijuUtility.DisableDefenseGameAI()
	KaijuUtility.SendCommand{
		id = "SetOENW",
		isEnable = false,
	}
end

return KaijuUtility