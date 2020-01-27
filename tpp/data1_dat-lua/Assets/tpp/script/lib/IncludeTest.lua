--tex from FPS mod following MXMSTR's custom cam by guibillyboy http://www.nexusmods.com/metalgearsolidvtpp/mods/278

local this={}
local offset_x=0
local offset_y=0.8
local offset_z=0

local offset2_x,offset2_y,offset2_z,aim_correction,riding_horse,riding_car

local custom_distance=-0.5


--Vanilla focal offset value
local focal_offset=12
local focal_offset2=21
local custom_cam_auto=false

function this.OnAllocate()end
function this.OnInitialize()end
function this.Update()



    -- Enable Custom cam mode by pressing D-PAD DOWN & ZOOM_CHANGE to go into FPS mode
    -- This will cause the loading of a set of offsets to be applied to the game camera parametres
    if (not custom_cam_auto and (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.DOWN)==PlayerPad.DOWN) and (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE))then
        custom_cam_auto=true
                
    -- Disable Custom cam mode & return to original cam mode by pressing D-PAD UP & ZOOM_CHANGE
    -- One may have to press "AIM" once more to go back to OTS mode
    elseif (custom_cam_auto and (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.PRIMARY_WEAPON)==PlayerPad.PRIMARY_WEAPON) and (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.ZOOM_CHANGE)==PlayerPad.ZOOM_CHANGE))then
        custom_cam_auto=false
    end
    
    -- The following looks out for a "Precise aiming" event, another set of offets will be applied to compensate for the camera's zero position
    -- As always, the solution to a problem is often a simple call, here "PlayerStatus.SUBJECT" kept me away from suppressing an offset between regular aiming and precise aiming                     
    if(custom_cam_auto and PlayerInfo.AndCheckStatus{PlayerStatus.SUBJECT} and (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.HOLD)==PlayerPad.HOLD) ) then
            focal_offset = focal_offset2
            aim_correction=true       
    elseif ((custom_cam_auto and aim_correction and not PlayerInfo.AndCheckStatus{PlayerStatus.SUBJECT} )or not (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.HOLD)==PlayerPad.HOLD))then
            aim_correction=false
    end

    
  if(custom_cam_auto)then
  -- The following will check whether the player is riding a horse, with
  -- the same correction as "aiming down sights"  as the result 
  -- Found in s10020_sequence.lua 
  
    local gameObjectId    = {type="TppHorse2", group=0, index=0}
    local command       = { id = "GetRidePlayer", }
    local ridePlayer    = GameObject.SendCommand( gameObjectId, command )
    if ridePlayer == 1 then
      riding_horse=true
    elseif not(ridePlayer == 1) then 
      riding_horse=false
    end
      
    -- Same goes for vehicules
    -- Needs adjustments for differents car types
    -- Found in qest_bossQuiet_00.lua
    
    this.isPlayerRideVehicle = function()
      local ridingGameObjectId  = vars.playerVehicleGameObjectId
      if (Tpp.IsVehicle(ridingGameObjectId)) then
        return true
      else
        return false
      end
    end
    if(this.isPlayerRideVehicle())then
      riding_car=true
    else  
      riding_car=false
    end
  else  
    riding_car=false
    riding_horse=false
  end

  -- Here we can check the character's stance and adjust the viewpoint
    -- accordingly by adding another offset applied only when the corresponding
    -- PlayerStatus flags are active. 
   
    if(custom_cam_auto and not(aim_correction or riding_horse)  )then

                if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
                            offset2_x=offset_x
                            offset2_y=offset_y
                            offset2_z=offset_z
                elseif PlayerInfo.AndCheckStatus{PlayerStatus.SQUAT}then
                            offset2_x=offset_x
                            offset2_y=offset_y-0.4
                            offset2_z=offset_z
                elseif PlayerInfo.AndCheckStatus{PlayerStatus.CRAWL}then
                            offset2_x=offset_x
                            offset2_y=offset_y-0.6
                            offset2_z=offset_z
                end    
    
    elseif(custom_cam_auto and (aim_correction)  ) then
                    
          if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
                      offset2_x=offset_x
                      offset2_y=0
                      offset2_z=offset_z
                elseif PlayerInfo.AndCheckStatus{PlayerStatus.SQUAT}then
                      offset2_x=offset_x
                      offset2_y=-0.3
                      offset2_z=offset_z
                elseif PlayerInfo.AndCheckStatus{PlayerStatus.CRAWL}then
                      offset2_x=offset_x
                      offset2_y=-0.5
                      offset2_z=offset_z
                end     
    elseif(custom_cam_auto and (riding_horse)  ) then
          -- Here I tweaked the FPS while on a horse, while aiming I cant remain in FPS          
                            offset2_x=offset_x
                            offset2_y=0.5
                            offset2_z=offset_z
              if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.HOLD)==PlayerPad.HOLD)then
              offset2_x=offset_x+0.3
              else offset2_x=offset_x
              end
         
    end

                    
-- In the following function, don't forget commas, or the game will never start !

-- This will change the vanilla camera settings. Unlike mxmstr's update_manual_cam_settings function, this fiddle with the game main camera.
-- Thing is you must call permanently it or it will reset all settings to default at every event (such as stance changing, aiming...)

-- About the car detection: couldn't find a satisfactory workaround, so I just disabled the FPS mod while in a car/APC/tank

  if(custom_cam_auto and not riding_car) then
    Player.ChangeCameraParameter{
      offset=Vector3(offset2_x,offset2_y,offset2_z),
      distance=custom_distance,
      focalLength=focal_offset,
      focusDistance=8.75,
      targetInterpTime=0.4,
      targetIsPlayer=true,
      target="TppPlayer2",
      ignoreCollisionGameObjectName=ignoreCollision,
      rotationLimitMinX=-60,
      rotationLimitMaxX=80,
      alphaDistance=0.0,
      --cameraType = PlayerCamera.Subjective, -- useless
      --cameraType = PlayerCamera.Around,
    }
  elseif (custom_cam_auto and riding_car)then
      
  end    

end
function this.OnTerminate()end
return this



 
