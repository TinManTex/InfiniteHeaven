local self = {}
local bnot = bit.bnot
local BAnd, BOr, BXor = bit.band, bit.bor, bit.bxor
dummy = function(var)
end

local DLog = dummy

WorkInfo = {
	version = 0,
	next = 0,
}

Type = {
	T_TOP = 0,
	T_FLAG = 4,
	T_RAIL_STEP = 6,
	T_STATE = 10,
}

self.RailIndex = {
	FIRST = 0,
	SECOND = 1,
}


self.Notify = {
	FORWARD_START = -1,
	FORWARD_END = -2,
}

local POS_TOP = Type.T_TOP
local POS_FLAG = Type.T_FLAG
local POS_RAIL_STEP = Type.T_RAIL_STEP
local POS_RAIL_PATH_INDEX = 7

local F_RAIL_ON = 1

valid  = function()
	if Player == nil then
		Fox.Error("Player is nil.")
	end
	local version = Player.ReadSequenceWork( POS_TOP, "b")
	if version == nil then return false end
	DLog(tostring(version))
	if version == WorkInfo.version then
		return true
	else
		if version > WorkInfo.version then
			Fox.Error("cypr_player_rail.lua is newer vestion.")
		else
			Fox.Error("cypr_player_rail.lua is old vestion.")
		end
		return false
	end
end

get_rail_index = function()
	return Player.ReadSequenceWork( POS_RAIL_STEP, "b" )
end

get_flag = function()
	DLog(tostring(POS_FLAG))
	local val =  Player.ReadSequenceWork( POS_FLAG, "s" )
	DLog(tostring(val))
	return val
end

set_flag = function( flagset )
	local f = get_flag()
	DLog(tostring(f))
	DLog(tostring(flagset))
	DLog(tostring(POS_FLAG))
	f = BOr(f, flagset )
	Player.WriteSequenceWork( POS_FLAG, "s", {f} )
end

reset_flag = function( flagset )
	local f = get_flag()
	flagset = bnot( flagset )
	f = BAnd(f, flagset )
	Player.WriteSequenceWork( POS_FLAG, "s", {f} )
end

set_rail_path_index = function( index )
	Player.WriteSequenceWork( POS_RAIL_PATH_INDEX, "b", {index} )
end








function self.Init()
	if Player == nil then
		Fox.Error("Player is nil.")
	end
	Player.RequestChangeSequenceWork{0}
	return valid()
end




function self.StartAction()
	if not valid() then return end
	set_flag( F_RAIL_ON )
end





function self.StartAction2( railPathIndex )
	if not valid() then return end
	set_rail_path_index(railPathIndex)
	set_flag( F_RAIL_ON )
end




function self.ForceEnd()
	if not valid() then return end
	reset_flag( F_RAIL_ON )
end




function self.GetRailIndex()
	if not valid() then return 0 end
	return get_rail_index()
end

return self
