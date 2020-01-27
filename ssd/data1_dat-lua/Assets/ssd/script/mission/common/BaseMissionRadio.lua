local t={}
local e=Fox.StrCode32
local a=Tpp.StrCode32Table
function t.CreateInstance(n)
local e={}
e.missionName=n
e.radioList={{"f3000_rtrg0100",playOnce=true},{"f3000_rtrg0102",playOnce=true},{"f3000_rtrg0104",playOnce=true},{"f3000_rtrg0106",playOnce=true},{"f3000_rtrg0108",playOnce=true},{"f3000_rtrg0134",playOnce=true},{"f3000_rtrg0136",playOnce=true},{"f3000_rtrg0138",playOnce=true},{"f3000_rtrg0140",playOnce=true},{"f3000_rtrg0142",playOnce=true},{"f3000_rtrg0144",playOnce=true},{"f3000_rtrg0146",playOnce=true},{"f3000_rtrg0150",playOnce=true},{"f3000_rtrg0511",playOnce=true},{"f3000_rtrg0513",playOnce=true},{"f3000_rtrg0816",playOnce=true}}
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{Player={{msg="RemainingOxygenRate",func=function(a,n,t)
if e.GetCommonRadioPlayCheck()then
if t==0 then
if n<=.1 then
TppRadio.Play("f3000_rtrg0102",{delayTime="mid"})
elseif n>.4 and n<=.5 then
TppRadio.Play("f3000_rtrg0100",{delayTime="mid"})
end
end
end
end},{msg="RemainingLifeRate",func=function(t,n,t)
if e.GetCommonRadioPlayCheck()then
if n==0 then
TppRadio.Play("f3000_rtrg0104",{delayTime="mid"})
elseif n==1 then
TppRadio.Play("f3000_rtrg0106",{delayTime="mid"})
end
end
end},{msg="RemainingStaminaValue",func=function(t,n,t)
if e.GetCommonRadioPlayCheck()then
if n==0 then
TppRadio.Play("f3000_rtrg0108",{delayTime="mid"})
end
end
end},{msg="OnInjuryPlayer",func=function(t,t,t,n)
if e.GetCommonRadioPlayCheck()then
if n>=3 then
TppRadio.Play("f3000_rtrg0134",{delayTime="mid"})
end
end
end},{msg="RemainingHungerRate",func=function(a,n,t)
if e.GetCommonRadioPlayCheck()then
if t==0 then
if n==0 then
TppRadio.Play("f3000_rtrg0142",{delayTime="mid"})
elseif n<=.2 then
TppRadio.Play("f3000_rtrg0140",{delayTime="mid"})
elseif n>.4 and n<=.5 then
TppRadio.Play("f3000_rtrg0138",{delayTime="mid"})
end
end
end
end},{msg="RemainingThirstRate",func=function(a,n,t)
if e.GetCommonRadioPlayCheck()then
if t==0 then
if n<=.2 then
TppRadio.Play("f3000_rtrg0146",{delayTime="mid"})
elseif n>.4 and n<=.5 then
TppRadio.Play("f3000_rtrg0144",{delayTime="mid"})
end
end
end
end}},Sbm={{msg="OnWeightOverRate",func=function(n)
if e.GetCommonRadioPlayCheck()then
if n>=80 then
TppRadio.Play("f3000_rtrg0136",{delayTime="mid"})
end
end
end}},GameObject={{msg="ChangeFogAreaState",func=function()
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
local e=TppStory.GetCurrentStorySequence()
if e>=TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
if TppGameStatus.IsSet("","S_FOG_PASSAGE")and not TppGameStatus.IsSet("","S_NEED_OXYGEN_MASK")then
local e=GameObject.SendCommand({type="SsdCrew"},{id="GetCarriedCrew"})
if e then
local e=GameObject.SendCommand(e,{id="GetCrewType"})
local n=e==TppDefine.CREW_TYPE.UNIQUE_BOY
local t=e==TppDefine.CREW_TYPE.UNIQUE_PLC
local a=e==TppDefine.CREW_TYPE.UNIQUE_SETH
local i=e==TppDefine.CREW_TYPE.MOB_MALE
local e=e==TppDefine.CREW_TYPE.MOB_FEMALE
if(((n or t)or a)or i)or e then
TppRadio.Play("f3000_rtrg0816",{delayTime="mid"})
end
end
end
end
end
end,option={isExecFastTravel=true}}},UI={{msg="CraftMenuOpened",func=function(e)
if e==CraftMenu.ENTRY_CRAFT_FOOD then
local n=SsdSbm.GetCountResource{id="RES_Meat_A",inInventory=true,inWarehouse=true}
local t=SsdSbm.HasRecipe"RCP_FOD_Dish_A"local e=TppStory.GetCurrentStorySequence()
if((n>0 and t==true)and e>=TppDefine.STORY_SEQUENCE.BEFORE_k40040)and e<=TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
TppRadio.Play("f3000_rtrg0513",{delayTime="mid"})
end
end
end}}})
function e.Messages()
if e.messageTable then
return a(e.messageTable)
end
end
function e.GetCommonRadioPlayCheck()
if not TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
return true
end
return false
end
return e
end
return t
