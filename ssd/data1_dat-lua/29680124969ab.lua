local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local e=1
local this={}
function this.CreateInstance(a)
  local instance=BaseFlagMission.CreateInstance(a)
  table.insert(instance.stepList,4,"GameDefense")
  instance.saveVarsList={{name=tostring(a).."isClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}}
  function instance.ClearCondition()
    return fvars[tostring(a).."isClear"]
  end
  function instance.ClearDefense()SsdFlagMission.SetNextStep"GameEscape"fvars[tostring(a).."isClear"]=true
    SsdFastTravel.UnlockFastTravelPoint(instance.fasttravelPointName)
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{GameObject={{msg="BreakGimmick",func=function(t,a,t,t)
    if instance.targetName and a==Fox.StrCode32(instance.targetName)then
      TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.TARGET_DEAD,TppDefine.GAME_OVER_RADIO.TARGET_DEAD)
    end
  end}}})
  instance.flagStep.GameMain.commonMessageTable=instance.AddMessage(instance.flagStep.GameMain.commonMessageTable,{GameObject={{msg="SwitchGimmick",func=function(t,n,n,a)
    if a~=0 then
      local a=SsdFastTravel.GetFastTravelPointNameFromGimmick(t)
      if a==instance.fasttravelPointName then
        SsdFlagMission.SetNextStep"GameDefense"end
    end
  end}}})
  function instance.flagStep.GameMain:OnEnter()
    instance.baseStep.OnEnter(self)SsdFastTravel.UnlockFastTravelPointGimmick(instance.fasttravelPointName)
  end
  instance.flagStep.GameDefense=instance.CreateStep"GameDefense"instance.flagStep.GameDefense.commonMessageTable=instance.AddMessage(instance.flagStep.GameDefense.commonMessageTable,{GameObject={{msg="FinishWave",func=function(a,a)
    instance.ClearDefense()
  end},{msg="FinishDefenseGame",func=function()
    instance.ClearDefense()
  end}}})
  function instance.flagStep.GameDefense:OnEnter()
    instance.baseStep.OnEnter(self)
    local n=instance.waveName
    local t=instance.waveAttackerPos or nil
    local s=instance.waveAttackerRadius or 30
    if n then
      local n=instance.targetIdentifier
      local i=instance.targetKey
      local a,o
      if n and i then
        a,o=Tpp.GetLocator(n,targetkey)
        if a then
          TppMission.SetDefensePosition(a)t=a
        end
      end
      local a=instance.waveLimitTime
      local a=instance.waveAnnihilation
      if not a then
        a=DEFAULT_ANNIHILATION
      end
      GameObject.SendCommand({type="TppCommandPost2"},{id="SetWaveAnnihilation",targetCount=a})
      GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=true})
      if Tpp.IsTypeTable(t)then
        GameObject.SendCommand({type="SsdZombie"},{id="SetWaveAttacker",pos=t,radius=s})
      end
      if instance.waveStartEffectId and Tpp.IsTypeTable(instance.waveStartEffectId)then
        for a,e in ipairs(instance.waveStartEffectId)do
          TppDataUtility.CreateEffectFromGroupId(e)
        end
      end
    end
    TppMission.StartDefenseGame(instance.defenseTime,instance.defenseTime/10)Mission.StartWave{waveName=n,waveLimitTime=waveLimitTime}
  end
  function instance.flagStep.GameDefense:OnLeave()
    instance.baseStep.OnLeave(self)
    TppMission.OnClearDefenseGame()
    TppMission.StopDefenseGame()
    GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})
    GameObject.SendCommand({type="SsdZombie"},{id="ResetWaveAttacker"})
    GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy"})
    local a=instance.waveEndEffectId or"explosion"TppDataUtility.CreateEffectFromGroupId(a)
    TppSoundDaemon.PostEvent"sfx_s_waveend_plasma"if instance.waveStartEffectId and Tpp.IsTypeTable(instance.waveStartEffectId)then
      for a,e in ipairs(instance.waveStartEffectId)do
        TppDataUtility.DestroyEffectFromGroupId(e)
      end
    end
  end
  return instance
end
return this
