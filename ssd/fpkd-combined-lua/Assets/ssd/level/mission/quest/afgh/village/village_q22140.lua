



local this = DefenseQuest.CreateInstance( "village_q22140" )	

this.waveName = "wave_fast_afgh09"
this.fasttravelPointName = "fast_afgh09"

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22140"
this.defenseGameArea = "trap_defenseGameArea_q22140"




this.WatcherAlertRoute = function( locatorName, route, point, lookRotationX,isUseNav, isStopEndPoint )
	local gameObjectId = GameObject.GetGameObjectId( "SsdInsect1", locatorName )
	local command = { id="SetAlertRoute", route=route, point=0, lookRotationX = 0, isUseNav = false, isStopEndPoint = true }
GameObject.SendCommand( gameObjectId, command )
end

this.WatcherRoute = function( locatorName, route, point, lookRotationX,isUseNav )
	local gameObjectId = GameObject.GetGameObjectId( "SsdInsect1", locatorName )
	local command = { id="SetSneakRoute", route=route, point= point, lookRotationX = lookRotationX, isUseNav = isUseNav }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetWaveWalkSpeed = function( locatorName, speed )
	if speed == nil then
		speed = "speed"
	end
	local gameObjectId = { type="SsdZombie" } 
	local command = { id="SetWaveWalkSpeed", speed=speed, locatorName=locatorName }
	GameObject.SendCommand( gameObjectId, command )
end


this.questStep.Quest_Main.OnEnterSub = function( self )
	Fox.Log( "village_q54040.questStep.Quest_Main.OnEnterSub()" )
	
	this.WatcherRoute("cam_k40080_0122", "rt_cam_k40080_0122", 0, 0 , false )
	this.WatcherRoute("cam_q22140_0132", "rt_cam_q22140_0132", 0, 0 , false )
	this.WatcherRoute("cam_q22140_0134", "rt_cam_q22140_0134", 0, 0 , false )
	
	this.WatcherRoute("cam_q22140_0001", "rt_cam_q22140_0001", 0, 0 , true )
	this.WatcherRoute("cam_q22140_0002", "rt_cam_q22140_0002", 0, 0 , true )
	
	TppEnemy.SetBreakBody( "zmb_k40080_0000", "SsdZombie", 0, 0, 0,1 )
	TppEnemy.SetBreakBody( "zmb_k40080_0011", "SsdZombie", 0, 0, 1,0 )
	TppEnemy.SetBreakBody( "zmb_k40080_0001", "SsdZombie", 0, 0, 1,0 )
	TppEnemy.SetBreakBody( "zmb_k40080_0002", "SsdZombie", 1, 0, 1,0 )
	TppEnemy.SetBreakBody( "zmb_k40080_0012", "SsdZombie", 1, 0, 1,0 )
end


this.questStep.Quest_Defense.OnEnterSub = function( self )
	Fox.Log( "q22140.questStep.Quest_Defense.OnEnterSub()" )
	
	this.WatcherAlertRoute( "cam_k40080_0122", "rt_cam_q22140_df0001", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_q22140_0002", "rt_cam_q22140_df0002", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_q22140_0001", "rt_cam_q22140_df0003", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_q22140_0134", "rt_cam_q22140_df0004", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_q22140_0132", "rt_cam_q22140_df0005", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0011", "rt_cam_q22140_df0006", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0012", "rt_cam_q22140_df0007", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0015", "rt_cam_q22140_df0008", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0016", "rt_cam_q22140_df0009", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0032", "rt_cam_q22140_df0010", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0112", "rt_cam_q22140_df0011", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0113", "rt_cam_q22140_df0012", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0000", "rt_cam_q22140_df0013", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0003", "rt_cam_q22140_df0014", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0009", "rt_cam_q22140_df0015", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0130", "rt_cam_q22140_df0016", 0, 0, false, true )
	this.WatcherAlertRoute( "cam_k40080_0008", "rt_cam_q22140_df0017", 0, 0, false, true )
	
	this.SetWaveWalkSpeed("zmb_k40080_0003", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0004", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0005", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0006", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0007", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0008", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0009", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0013", "walk")
	this.SetWaveWalkSpeed("zmb_k40080_0014", "walk")
end



return this
