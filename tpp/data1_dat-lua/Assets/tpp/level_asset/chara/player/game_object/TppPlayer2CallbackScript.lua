TppPlayer2CallbackScript={StartCameraAnimation=function(e,t,r,n,n,n,n,n,a,n,n)
TppPlayer2CallbackScript._StartCameraAnimation(e,t,a,true,false,r,false,true)
end,StartCameraAnimationNoRecover=function(e,t,a,n,n,n,n,n,r,n,n)
TppPlayer2CallbackScript._StartCameraAnimation(e,t,r,false,false,a,true)
end,StartCameraAnimationNoRecoverNoCollsion=function(t,r,e,n,n,n,n,n,a,n,n)
TppPlayer2CallbackScript._StartCameraAnimation(t,r,a,false,true,e)
end,StartCameraAnimationForSnatchWeapon=function(e,e,e,e,e,e,e,e,e,e,e)
end,StopCameraAnimation=function(a,a,a,a,a,a,a,a,e,a,a)Player.RequestToStopCameraAnimation{fileSet=e}
end,StartCureDemoEffectStart=function(e,e,e,e,e,e,e,e,e,e,e)
end,SetCameraNoise=function(t,t,t,t,t,e,a,t,t,t,t)
TppPlayer2CallbackScript._SetCameraNoise(e,e,a)
end,SetCameraNoiseLadder=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
end,SetCameraNoiseElude=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
end,SetCameraNoiseDamageBend=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
end,SetCameraNoiseDamageBlow=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
end,SetCameraNoiseDamageDeadStart=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.45,.45,.52)
end,SetCameraNoiseFallDamage=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(1,.4,.5)
end,SetCameraNoiseDashToWallStop=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
end,SetCameraNoiseStepOn=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.3,.3,.1)
end,SetCameraNoiseStepDown=function(e,e,e,e,e,t,e,e,e,e,e)
local a=0
local e=0
if(t>0)then
a=t
e=t*.25
else
a=.225
e=.057
end
TppPlayer2CallbackScript._SetCameraNoise(a,e,.11)
end,SetCameraNoiseStepJumpEnd=function(a,a,a,a,a,e,a,a,a,a,a)
local a=0
local t=0
if(e>0)then
a=e
t=e*.25
else
a=.225
t=.057
end
TppPlayer2CallbackScript._SetCameraNoise(a,t,.2)
end,SetCameraNoiseStepJumpToElude=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.4,.4,.4)
end,SetCameraNoiseVehicleCrash=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
end,SetCameraNoiseCqcHit=function(e,e,e,e,e,e,e,e,e,e,e)
TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.4)
end,SetCameraNoiseEndCarry=function(e,e,e,e,e,e,e,e,e,e,e)
local r=.25
local t=.25
local e=.15
local a=.05
Player.RequestToSetCameraNoise{levelX=r,levelY=t,time=e,decayRate=a}
end,SetCameraNoiseOnMissileFire=function(e,e,e,e,e,e,e,e,e,e,e)
local r=.5
local t=.5
local a=.75
local e=.08
Player.RequestToSetCameraNoise{levelX=r,levelY=t,time=a,decayRate=e}
end,SetCameraNoiseOnRideOnAntiAircraftGun=function(e,e,e,e,e,e,e,e,e,e,e)
local e=.2
local a=.2
local t=.3
local r=.08
Player.RequestToSetCameraNoise{levelX=e,levelY=a,time=t,decayRate=r}
end,SetNonAnimationCutInCameraFallDeath=function()
end,SetHighSpeeCameraOnCQCDirectThrow=function()
end,SetHighSpeeCameraOnCQCComboFinish=function()
TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"TppPlayer2CallbackScript._SetHighSpeedCamera(.6,.03)
end,SetHighSpeeCameraAtCQCSnatchWeapon=function()
TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"TppPlayer2CallbackScript._SetHighSpeedCamera(1,.1)
end,defaultStopPlayingByCollision=false,defaultEnableCamera={PlayerCamera.Around,PlayerCamera.Vehicle},defaultInterpTimeToRecoverOrientation=.24,defaultStopRecoverInterpByPadOperation=true,defaultInterpType=2,_StartCameraAnimation=function(r,a,e,t,i,l,n,o)
local a=(a-r)+l
local t=t
if(((StringId.IsEqual(e,"CureGunShotWoundBodyLeft")or StringId.IsEqual(e,"CureGunShotWoundBodyRight"))or StringId.IsEqual(e,"CureGunShotWoundBodyCrawl"))or StringId.IsEqual(e,"CureGunShotWoundBodySupine"))then
Player.SetFocusParamForCameraAnimation{aperture=3,focusDistance=.6}
end
Player.RequestToPlayCameraAnimation{fileSet=e,startFrame=a,ignoreCollisionCheckOnStart=i,recoverPreOrientation=t,isRiding=n,stopPlayingByCollision=true,enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,interpType=TppPlayer2CallbackScript.defaultInterpType}
end,_StartCameraAnimationUseFileSetName=function(t,n,e,a,r)
local t=n-t
local a=a
if(e=="CqcSnatchAssaultRight"or e=="CqcSnatchAssaultLeft")then
Player.SetFocusParamForCameraAnimation{aperture=20}
end
Player.RequestToPlayCameraAnimation{fileSetName=e,startFrame=t,ignoreCollisionCheckOnStart=r,recoverPreOrientation=a,stopPlayingByCollision=TppPlayer2CallbackScript.defaultStopPlayingByCollision,enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,interpType=TppPlayer2CallbackScript.defaultInterpType}
end,_SetCameraNoise=function(t,a,e)
local t=t
local a=a
local e=e
local r=.15
Player.RequestToSetCameraNoise{levelX=t,levelY=a,time=e,decayRate=r}
end,_SetHighSpeedCamera=function(a,e)HighSpeedCamera.RequestEvent{continueTime=a,worldTimeRate=e,localPlayerTimeRate=e,timeRateInterpTimeAtStart=0,timeRateInterpTimeAtEnd=0,cameraSetUpTime=0}
end}
