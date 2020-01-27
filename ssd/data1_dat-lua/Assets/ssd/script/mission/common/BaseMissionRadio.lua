-- DOBUILD: 1
-- BaseMissionRadio.lua
local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
function this.CreateInstance(missionName)
  local instance={}
  instance.missionName=missionName
  instance.radioList={
    {"f3000_rtrg0100",playOnce=true},
    {"f3000_rtrg0102",playOnce=true},
    {"f3000_rtrg0104",playOnce=true},
    {"f3000_rtrg0106",playOnce=true},
    {"f3000_rtrg0108",playOnce=true},
    {"f3000_rtrg0134",playOnce=true},
    {"f3000_rtrg0136",playOnce=true},
    {"f3000_rtrg0138",playOnce=true},
    {"f3000_rtrg0140",playOnce=true},
    {"f3000_rtrg0142",playOnce=true},
    {"f3000_rtrg0144",playOnce=true},
    {"f3000_rtrg0146",playOnce=true},
    {"f3000_rtrg0150",playOnce=true},
    {"f3000_rtrg0511",playOnce=true},
    {"f3000_rtrg0513",playOnce=true},
    {"f3000_rtrg0816",playOnce=true}
  }
  instance.messageTable=Tpp.MergeMessageTable(instance.messageTable,{
    Player={
      {msg="RemainingOxygenRate",func=function(unkP1,unkP2,unkP3)
        if instance.GetCommonRadioPlayCheck()then
          if unkP3==0 then
            if unkP2<=.1 then
              TppRadio.Play("f3000_rtrg0102",{delayTime="mid"})
            elseif unkP2>.4 and unkP2<=.5 then
              TppRadio.Play("f3000_rtrg0100",{delayTime="mid"})
            end
          end
        end
      end},
      {msg="RemainingLifeRate",func=function(unkP1,unkP2,unkP3)
        if instance.GetCommonRadioPlayCheck()then
          if unkP2==0 then
            TppRadio.Play("f3000_rtrg0104",{delayTime="mid"})
          elseif unkP2==1 then
            TppRadio.Play("f3000_rtrg0106",{delayTime="mid"})
          end
        end
      end},
      {msg="RemainingStaminaValue",func=function(unkP1,unkP2,unkP3)
        if instance.GetCommonRadioPlayCheck()then
          if unkP2==0 then
            TppRadio.Play("f3000_rtrg0108",{delayTime="mid"})
          end
        end
      end},
      {msg="OnInjuryPlayer",func=function(unkP1,unkP2,unkP3,unkP4)
        if instance.GetCommonRadioPlayCheck()then
          if unkP4>=3 then
            TppRadio.Play("f3000_rtrg0134",{delayTime="mid"})
          end
        end
      end},
      {msg="RemainingHungerRate",func=function(unkP2,unkP2,unkP3)
        if instance.GetCommonRadioPlayCheck()then
          if unkP3==0 then
            if unkP2==0 then
              TppRadio.Play("f3000_rtrg0142",{delayTime="mid"})
            elseif unkP2<=.2 then
              TppRadio.Play("f3000_rtrg0140",{delayTime="mid"})
            elseif unkP2>.4 and unkP2<=.5 then
              TppRadio.Play("f3000_rtrg0138",{delayTime="mid"})
            end
          end
        end
      end},
      {msg="RemainingThirstRate",func=function(a,n,t)
        if instance.GetCommonRadioPlayCheck()then
          if t==0 then
            if n<=.2 then
              TppRadio.Play("f3000_rtrg0146",{delayTime="mid"})
            elseif n>.4 and n<=.5 then
              TppRadio.Play("f3000_rtrg0144",{delayTime="mid"})
            end
          end
        end
      end}},
    Sbm={
      {msg="OnWeightOverRate",func=function(unkP1)
        if instance.GetCommonRadioPlayCheck()then
          if unkP1>=80 then
            TppRadio.Play("f3000_rtrg0136",{delayTime="mid"})
          end
        end
      end}},
    GameObject={
      {msg="ChangeFogAreaState",func=function()
        if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
          local storySequence=TppStory.GetCurrentStorySequence()
          if storySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
            if TppGameStatus.IsSet("","S_FOG_PASSAGE")and not TppGameStatus.IsSet("","S_NEED_OXYGEN_MASK")then
              local carriedCrewId=GameObject.SendCommand({type="SsdCrew"},{id="GetCarriedCrew"})
              if carriedCrewId then
                local crewType=GameObject.SendCommand(carriedCrewId,{id="GetCrewType"})
                local isBoy=crewType==TppDefine.CREW_TYPE.UNIQUE_BOY
                local isPLC=crewType==TppDefine.CREW_TYPE.UNIQUE_PLC
                local isSeth=crewType==TppDefine.CREW_TYPE.UNIQUE_SETH
                local isMobMale=crewType==TppDefine.CREW_TYPE.MOB_MALE
                local isMobFemale=crewType==TppDefine.CREW_TYPE.MOB_FEMALE
                if(((isBoy or isPLC)or isSeth)or isMobMale)or isMobFemale then
                  TppRadio.Play("f3000_rtrg0816",{delayTime="mid"})
                end
              end
            end
          end
        end
      end,option={isExecFastTravel=true}}},
    UI={
      {msg="CraftMenuOpened",func=function(craftTab)
        if craftTab==CraftMenu.ENTRY_CRAFT_FOOD then
          local meatCount=SsdSbm.GetCountResource{id="RES_Meat_A",inInventory=true,inWarehouse=true}
          local hashDishA=SsdSbm.HasRecipe"RCP_FOD_Dish_A"
          local storySequence=TppStory.GetCurrentStorySequence()--tex NMC would be better performance to test storySequence first and only then countresource
          if((meatCount>0 and hashDishA==true)and storySequence>=TppDefine.STORY_SEQUENCE.BEFORE_k40040)and storySequence<=TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
            TppRadio.Play("f3000_rtrg0513",{delayTime="mid"})
          end
        end
      end}}
  })
  function instance.Messages()
    if instance.messageTable then
      return StrCode32Table(instance.messageTable)
    end
  end
  function instance.GetCommonRadioPlayCheck()
    if Ivars.disableCommonRadio:Get()==1 then--tex>
      return false
    end--<
    if not TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
      return true
    end
    return false
  end
  return instance
end
return this
