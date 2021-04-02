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
	T_TOP 			= 0,
	T_ACTIVE 		= 1,
	T_ACTION_STATE 	= 2,
	T_EYELID_STATE	= 3,
	T_EYELID_FADEIN	= 4,
	T_EYELID_FADEOUT	= 5,
	T_EYELID_DELETE	= 6,
	T_EYELID_BLINK_AVERAGE_TIME	= 8,
	T_APERTURE		= 12,
	T_APERTURE_INTERP_TIME	= 16,
	T_FOCUSDISTANCE_LIMIT	= 20,
	T_FOCUSDISTANCE_LIMIT_INTERP_TIME	= 24,
	T_CAMERA_ROTATION_SPEED_RATE 		= 28,
	T_FOCALLENGTH				= 36,
	T_FOCALLENGTH_INTERP_TIME 	= 40,
}

local POS_TOP = Type.T_TOP
local POS_ACTIVE = Type.T_ACTIVE
local POS_ACTION_STATE = Type.T_ACTION_STATE
local POS_EYELID_STATE = Type.T_EYELID_STATE
local POS_EYELID_FADEIN	= Type.T_EYELID_FADEIN
local POS_EYELID_FADEOUT = Type.T_EYELID_FADEOUT
local POS_EYELID_DELETE = Type.T_EYELID_DELETE
local POS_EYELID_BLINK_AVERAGE_TIME	= Type.T_EYELID_BLINK_AVERAGE_TIME
local POS_APERTURE = Type.T_APERTURE
local POS_APERTURE_INTERP_TIME = Type.T_APERTURE_INTERP_TIME
local POS_FOCUSDISTANCE_LIMIT = Type.T_FOCUSDISTANCE_LIMIT
local POS_FOCUSDISTANCE_LIMIT_INTERP_TIME = Type.T_FOCUSDISTANCE_LIMIT_INTERP_TIME
local POS_CAMERA_ROTATION_SPEED_RATE = Type.T_CAMERA_ROTATION_SPEED_RATE
local POS_FOCALLENGTH = Type.T_FOCALLENGTH
local POS_FOCALLENGTH_INTERP_TIME = Type.T_FOCALLENGTH_INTERP_TIME
	
self.ActionState = {
	BED_FLAT			= 0,
	BED_INCLINED		= 1,
	VOLGIN_CORRIDOR		= 2
}

self.EyelidFilterState = {
	DEMO_CONTROL		= 0,
	IDLING				= 1,
	OPEN				= 2,
	CLOSE				= 3
}

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
			Fox.Error("cypr_player_bed_and_corridor.lua is newer vestion.")
		else
			Fox.Error("cypr_player_bed_and_corridor.lua is old vestion.")
		end
		return false
	end
end







function self.Init()
	if Player == nil then
		Fox.Error("Player is nil.")
	end
	Player.RequestChangeSequenceWork{1}
	return valid()
end




function self.Start( actionState )
	if not valid() then return end
	Player.WriteSequenceWork( POS_ACTIVE, "b", {1})
	Player.WriteSequenceWork( POS_ACTION_STATE, "b", {actionState})
end




function self.End()
	if not valid() then return end
	Player.WriteSequenceWork( POS_ACTIVE, "b", {0})	
end




function self.SetEyelidFilterState( state )
	Player.WriteSequenceWork( POS_EYELID_STATE, "b", {state})
end
	

function self.FadeInEyelidFilter()
	Player.WriteSequenceWork( POS_EYELID_FADEIN, "b", {1})
end


function self.FadeOutEyelidFilter()
	Player.WriteSequenceWork( POS_EYELID_FADEOUT, "b", {1})
end	


function self.DeleteEyelidFilter()
	Player.WriteSequenceWork( POS_EYELID_DELETE, "b", {1})
end	


function self.SetEyelidFilterAverageTime( time )
	Player.WriteSequenceWork( POS_EYELID_BLINK_AVERAGE_TIME, "f", {time})
end


function self.SetAperture( aperture, interpTime )
	Player.WriteSequenceWork( POS_APERTURE, "ff", {aperture, interpTime})
end


function self.SetFocalLength( focalLength, interpTime )
	Player.WriteSequenceWork( POS_FOCALLENGTH, "ff", {focalLength, interpTime})
end


function self.SetFocusDistanceLimit( distance, interpTime )
	Player.WriteSequenceWork( POS_FOCUSDISTANCE_LIMIT, "ff", {distance, interpTime})
end	


function self.SetCameraRotationSpeedRate( rate )
	Player.WriteSequenceWork( POS_CAMERA_ROTATION_SPEED_RATE, "f", {rate})
end		
	
return self
