-- DOBUILD: 0
local this={}

function this.Messages()
  return Tpp.StrCode32Table{
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=InfMain._FadeInOnGameStart},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

return this