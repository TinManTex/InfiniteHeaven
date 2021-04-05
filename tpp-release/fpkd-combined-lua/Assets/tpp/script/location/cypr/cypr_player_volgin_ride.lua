

local self = {}
local bnot = bit.bnot
local BAnd, BOr, BXor = bit.band, bit.bor, bit.bxor
dummy = function(var)
end

local DLog = dummy




local WorkInfo = {
	version = 0,
	next = 0,
}

local Type = {
	T_TOP = 0,
	T_FLAG = 4,
}

self.Notify = {
}

local F_ACTIVE = 1
local POS_FLAG = Type.T_FLAG

valid  = function()
	local version = Player.ReadSequenceWork( Type.T_TOP, "b")
	if version == nil then return false end
	DLog(tostring(version))
	if version == WorkInfo.version then
		return true
	else
		if version > WorkInfo.version then
			Fox.Error("cypr_player_volgin_ride.lua is newer vestion.")
		else
			Fox.Error("cypr_player_volgin_ride.lua is old vestion.")
		end
		return false
	end
end

get_flag = function()
	local val =  Player.ReadSequenceWork( POS_FLAG, "s" )
	return val
end

set_flag = function( flagset )
	local f = get_flag()
	f = BOr(f, flagset )
	Player.WriteSequenceWork( POS_FLAG, "s", {f} )
end

reset_flag = function( flagset )
	local f = get_flag()
	flagset = bnot( flagset )
	f = BAnd(f, flagset )
	Player.WriteSequenceWork( POS_FLAG, "s", {f} )
end







function self.Init()
	Player.RequestChangeSequenceWork{2}
	return valid()
end




function self.StartAction()
	if not valid() then return end
	set_flag( F_ACTIVE )
end




function self.ForceEnd()
	if not valid() then return end
	reset_flag( F_ACTIVE )
end

return self
