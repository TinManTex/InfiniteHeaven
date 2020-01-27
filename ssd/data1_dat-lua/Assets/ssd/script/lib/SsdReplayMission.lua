local this={}
local StrCode32=Fox.StrCode32
local IsTypeTable=Tpp.IsTypeTable
function this.ReplayMission(id,difficulty,p3,storySequence,p5)
  TppMission.UpdateCheckPointAtCurrentPosition()
  TppSoundDaemon.PostEvent"Set_State_ppod_reset"
  local noLoadoutSave=nil
  local repopTutorialSheeps=nil--RETAILPATCH: 1.0.10.0
  if IsTypeTable(p5)then
    noLoadoutSave=p5.noLoadoutSave
    repopTutorialSheeps=p5.repopTutorialSheeps--RETAILPATCH: 1.0.10.0
  end
  if Mission.SetReplayMissionSetting then
    Mission.SetReplayMissionSetting{id=id,difficulty=difficulty,storySequence=storySequence,noLoadoutSave=noLoadoutSave,repopTutorialSheeps=repopTutorialSheeps}--RETAILPATCH: 1.0.10.0 added repopTutorialSheeps
  end
  local e=function(nextMissionCodeForAbort)
    if mvars.mis_missionAbortLoadingOption==nil then
      mvars.mis_missionAbortLoadingOption={}
    end
    mvars.mis_missionAbortLoadingOption.force=true
    mvars.mis_nextMissionCodeForAbort=nextMissionCodeForAbort
    mvars.mis_abortWithSave=false
    mvars.mis_abortForReplayMission=true
    TppMission.ExecuteMissionAbort()
  end
  if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
    e(p3)
  else
    local e=function()
      e(p3)
    end
    TppSave.AddServerSaveCallbackFunc(e)
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReplayMission",TppUI.FADE_PRIORITY.SYSTEM)
  end
end
function this.ClearReplayMissionSetting()
  local isReplayMission=Mission.IsReplayMission()
  Mission.ClearReplayMissionSetting()
  if isReplayMission then
    TppCrew.FinishReplayMission()
  end
end
local n={"s10010","k40040","k40060","k40070","k40015","k40020","k40030","k40035","k40075","k40077","k40080","k40090","k40130","k40140","k40150","k40155","s10035","k40160","k40180","k40170","k40230","s10050","k40220","k40250","k40260","s10060"}
local t={}
for n,e in ipairs(n)do
  t[StrCode32(e)]=e
end
local s={
  s10010={func=function(i,n)
    this.ReplayMission(i,n,10010,TppDefine.STORY_SEQUENCE.STORY_START,{noLoadoutSave=true})
  end},
  k40040={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40040,{noLoadoutSave=true,repopTutorialSheeps=true})--RETAILPATCH: 1.0.10.0 added params
  end},
  k40060={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40060)
  end},
  k40070={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40070)
  end},
  k40015={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40015)
  end},
  k40020={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.CLEARED_k40015)
  end},
  k40030={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40030)
  end},
  k40035={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40035)
  end},
  k40075={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_DEFENSE_AREA_1)
  end},
  k40077={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40077)
  end},
  k40080={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40080)
  end},
  k40090={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40090)
  end},
  k40130={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40130)
  end},
  k40140={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40140)
  end},
  k40150={func=function(n,i)
    this.ReplayMission(n,i,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40150)
  end},
  k40155={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40155)
  end},
  s10035={func=function(i,n)
    this.ReplayMission(i,n,10035,TppDefine.STORY_SEQUENCE.BEFORE_AFGH_LAST)
  end},
  k40160={func=function(i,n)
    this.ReplayMission(i,n,30020,TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST)
  end},
  k40180={func=function(i,n)
    this.ReplayMission(i,n,30020,TppDefine.STORY_SEQUENCE.BEFORE_k40180)
  end},
  k40170={func=function(i,n)
    this.ReplayMission(i,n,30020,TppDefine.STORY_SEQUENCE.BEFORE_k40170)
  end},
  k40230={func=function(i,n)
    this.ReplayMission(i,n,30020,TppDefine.STORY_SEQUENCE.BEFORE_k40230)
  end},
  s10050={func=function(n,i)
    this.ReplayMission(n,i,10050,TppDefine.STORY_SEQUENCE.BEFORE_s10050)
  end},
  k40220={func=function(i,n)
    this.ReplayMission(i,n,30020,TppDefine.STORY_SEQUENCE.BEFORE_k40220)
  end},
  k40250={func=function(n,i)
    this.ReplayMission(n,i,30020,TppDefine.STORY_SEQUENCE.BEFORE_k40250)
  end},
  k40260={func=function(i,n)
    this.ReplayMission(i,n,30010,TppDefine.STORY_SEQUENCE.BEFORE_k40260)
  end},
  s10060={func=function(n,i)
    this.ReplayMission(n,i,10060,TppDefine.STORY_SEQUENCE.BEFORE_STORY_LAST)
  end}
}
function this.OnSelectReplayMission(n,i)
  local e=t[n]
  local e=s[e]
  if e and e.func then
    e.func(n,i)
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    UI={
      {msg="OnSelectReplayMission",func=function(n,i)
        this.OnSelectReplayMission(n,i)
      end}},
    DebugUi={
      {msg="OnSelectItem",func=function(n,t)
        if n==StrCode32"REPLAY MISSION SELECT"then
          DebugSelector.PopAll()
          local n=this.MENU_ITEM_LIST[t].title
          n=string.sub(n,1,6)
          local n=StrCode32(n)
          local i=2
          this.OnSelectReplayMission(n,i)
        end
      end}}}
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(n,l,a,s,o,t,i)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,n,l,a,s,o,t,i)
end
if(Tpp.IsQARelease())then
  this.MENU_ITEM_LIST={
    {title="Cancel"},
    {title="s10010 (Opening)"},
    {title="k40040 (Get Water&Meal)"},
    {title="k40060 (Get First MemoryBoard)"},
    {title="k40070 (Craft AirTank)"},
    {title="k40015 (FastTravel)"},
    {title="k40020 (Rescue Miranda)"},
    {title="k40030 (Dungeon 1)"},
    {title="k40035 (Get Digger)"},
    {title="k40075 (Defense BaseCamp 1)"},
    {title="k40077 (Salvage field)"},
    {title="k40080 (Rescue Chris)"},
    {title="k40090 (Dungeon 2)"},
    {title="k40130 (Rescue Nicholas)"},
    {title="k40140 (Salvage village) "},
    {title="k40150 (Build Catwalk)"},
    {title="k40155 (Defense BaseCamp 2)"},
    {title="s10035 (Climb MotherBase)"},
    {title="k40160 (First FOB Mission)"},
    {title="k40180 (Rescue Seth)"},
    {title="k40170 (Find Sahelan)"},
    {title="k40230 (Defense Sahelan)"},
    {title="s10050 (Seth Battle)"},
    {title="k40220 (Dungeon 3)"},
    {title="k40250 (Salvage diamond)"},
    {title="k40260 (Build Archaea Blade)"},
    {title="s10060 (Load of Dust)"}
  }
  function this.DEBUG_OnSelectReplayMission(e)
    if e then
      Mission.SendMessageToSubscribers("Mission","SelectReplayMission",e)
    end
    DebugSelector.PopAll()
  end
  function this.DEBUG_CreateDebugSelector(n,l,o)
    local e={GetItemCount=function(e)
      return#n
    end,GetItemTitle=function(i,e)
      return n[e].title
    end,DidSelectItem=function(o,i)
      local n=n[i]
      if Tpp.IsTypeTable(n)then
        local s=n.itemList
        local t=n.OnSelect
        if Tpp.IsTypeTable(s)then
          local n=n.title
          local e=this.DEBUG_CreateDebugSelector(s,n)
          DebugSelector.Push(e)
        elseif Tpp.IsTypeFunc(t)then
          t(o,i)
        end
      end
    end,
    DidSelectBack=function(e,e)
      if not o then
        DebugSelector.Pop()
      end
    end}
    return DebugSelector.Create(l,e)
  end
  function this.DEBUG_OpenReplayMissionSelectMenu()
    local e=this.DEBUG_CreateDebugSelector(this.MENU_ITEM_LIST,"REPLAY MISSION SELECT",true)
    DebugSelector.Push(e)
  end
end
return this
