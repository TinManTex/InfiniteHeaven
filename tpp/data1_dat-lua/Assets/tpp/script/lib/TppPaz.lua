local e={}
local n=Fox.StrCode32
local Y=GameObject.SendCommand
local ne=GameObject.GetGameObjectId
local ee=GameObject.NULL_ID
e.START_TYPE_NO_PICTURE=0
e.START_TYPE_PICTURE=1
e.START_TYPE_DOWN=2
e.DEMO_END_TYPE_NONE=0
e.DEMO_END_TYPE_SIT=1
e.DEMO_END_TYPE_DOWN=2
local o="mtbs_uq0040_plnt0000|uq_00400000|uq_0040_asset|TppPazLocator"
local b={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_book_idl.gani"}
local t={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl.gani"}
local S={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_2.gani"}
local U={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_ver2.gani"}
local q={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_st.gani"}
local y={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_lp.gani"}
local F={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_ed.gani"}
local I={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic.gani"}
local R={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic2.gani"}
local G={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic1.gani"}
local E={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_pic_idl.gani"}
local m={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_come_snk.gani"}
local P={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_bed_dwn.gani"}
local s={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl1.gani"}
local A={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl2.gani"}
local l={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_drop_book.gani"}
local C={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_book.gani"}
local a={"PlayState","statePaz_q_sit_idl"}
local r={"PlayState","statePaz_q_sit_idl_f"}
local O={"PlayState","statePaz_q_sit_idl_ver2"}
local _={"PlayState","statePaz_q_come_snk"}
local k={"PlayState","statePaz_q_drop_book"}
local w={"PlayState","statePaz_q_take_pic1"}
local j={"PlayState","statePaz_q_take_pic2"}
local i={"PlayState","statePaz_q_pic_idl_f"}
local re="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_book.gani"
local oe="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_pic.gani"
local te={b}
local le={S}
local B={q}
local se={b,t,S,U,q,y,F,I,R,G,E,m,P,s,A,l,C,a,r,O,_,k,w,j,i}
local i={"paz_koi01","paz_koi02"}
local L={"paz_room01","paz_room03"}
local N="paz_room02"
local J="paz_room04"
local H={"paz_misete01"}
local x="paz_misete02"
local K={"paz_atama01","paz_atama02","paz_atama03","paz_atama04"}
local ie={"paz_misete01","paz_atama01","paz_atama03","paz_atama04"}
local W={"paz_photo01","paz_photo02","paz_photo03","paz_photo04","paz_photo05","paz_photo06","paz_photo07","paz_photo08","paz_photo09","paz_photo10"}
local ae="paz_room_book01"
local Z="paz_room_book02"
local Q="paz_photo_after04"
local X={"paz_photo_after01","paz_photo_after02","paz_photo_after03"}
local V={"paz_negoto01","paz_negoto02","paz_negoto03","paz_negoto04"}
local D={"paz_matane01","paz_matane02"}
local p="PazTimerSenderEnableSeeYou"
local m="PazTimerSenderEnableShowMe"
local v="PazTimerSenderPhotoAfter"
local u="PazTimerSenderDown"
local h="PazTimerSenderHumming"
local f="PazTimerSenderPerceive"
local l="PazTimerSenderSleep"
local T="PazTimerSenderConfusionOutAngle"
local g="PazTimerSenderAimDefault"
local z="PazTimerSenderCheckIdleAction"
local c="PazTimerSenderEnableIdleAction"
local d="PazTimerSenderIdleMonologue"
local t="PazTimerSenderEnableIdleMonologue"
local M="PazClockSenderEndWait"
function e.ActiveMessages()
  return Tpp.StrCode32Table{GameObject={{msg="SpecialActionEnd",sender=o,func=e.OnSpecialActionEnd},{msg="PazShowIcon",sender=o,func=e.OnPazShowIcon},{msg="PazHideIcon",sender=o,func=e.OnPazHideIcon},{msg="PazPerceiveSnake",sender=o,func=e.OnPazPerceiveSnake},{msg="MonologueEnd",sender=o,func=e.OnMonologueEnd},{msg="PazHasAimedDefault",sender=o,func=e.OnPazHasAimedDefault},{msg="PazRelaxEndTiming",sender=o,func=e.OnPazRelaxEndTiming},{msg="PazOutAngle",sender=o,func=e.OnPazOutAngle},{msg="PazInAngle",sender=o,func=e.OnPazInAngle},{msg="PazSnakeIsStopping",sender=o,func=e.OnPazSnakeIsStopping},{msg="PazSnakeIsMoving",sender=o,func=e.OnPazSnakeIsMoving}},Player={{msg="IconOk",func=e.OnIconOk},{msg="IconSwitchShown",func=e.OnIconSwitchShown}},Timer={{msg="Finish",sender=p,func=function()e.OnFinishTimer(p)
    end},{msg="Finish",sender=m,func=function()e.OnFinishTimer(m)
    end},{msg="Finish",sender=v,func=function()e.OnFinishTimer(v)
      end},{msg="Finish",sender=u,func=function()e.OnFinishTimer(u)
      end},{msg="Finish",sender=h,func=function()e.OnFinishTimer(h)
        end},{msg="Finish",sender=f,func=function()e.OnFinishTimer(f)
        end},{msg="Finish",sender=l,func=function()e.OnFinishTimer(l)
          end},{msg="Finish",sender=T,func=function()e.OnFinishTimer(T)
          end},{msg="Finish",sender=g,func=function()e.OnFinishTimer(g)
            end},{msg="Finish",sender=z,func=function()e.OnFinishTimer(z)
            end},{msg="Finish",sender=c,func=function()e.OnFinishTimer(c)
              end},{msg="Finish",sender=d,func=function()e.OnFinishTimer(d)
              end},{msg="Finish",sender=t,func=function()e.OnFinishTimer(t)
                end}}}
end
function e.InactiveMessages()
  return Tpp.StrCode32Table{Weather={{msg="Clock",sender=M,func=function()e.OnClock(M)
    end}}}
end
function e.OnAllocate(e)
end
function e.Init(e)
end
function e.OnReload()
  if mvars.paz_isActive then
    e.messageExecTable=Tpp.MakeMessageExecTable(e.ActiveMessages())
  else
    e.messageExecTable=Tpp.MakeMessageExecTable(e.InactiveMessages())
  end
  e.GetPazGameObjectId()
  if mvars.paz_currentAction~=nil then
    for n,e in ipairs(se)do
      if e[2]==mvars.paz_currentAction[2]then
        mvars.paz_currentAction=e
        break
      end
    end
  end
end
function e.OnMessage(o,t,a,n,l,s,i)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,o,t,a,n,l,s,i)
end
function e.SetDemoEndType(e)mvars.paz_demoEndType=e
end
function e.GetDemoEndType()
  if not mvars.paz_demoEndType then
    mvars.paz_demoEndType=e.DEMO_END_TYPE_NONE
  end
  return mvars.paz_demoEndType
end
function e.SetStartType(e)mvars.paz_startType=e
end
function e.GetStartType()
  if not mvars.paz_startType then
    mvars.paz_startType=e.START_TYPE_RANDOM
  end
  return mvars.paz_startType
end
function e.OnDemoEnter()mvars.paz_isActive=true
  local n=nil
  local t=nil
  local o=e.GetDemoEndType()
  if o==e.DEMO_END_TYPE_SIT then
    n=a
    t="Book"
  elseif o==e.DEMO_END_TYPE_DOWN then
    n=A
    t="Blood"
  end
  if n~=nil then
    e.SendCommandSpecialAction(n,t)
  end
  e.messageExecTable=Tpp.MakeMessageExecTable(e.ActiveMessages())e.InitUi()e.InitMusic()
end
function e.OnEnter(f)mvars.paz_isActive=true
  mvars.paz_lastMonologueLabel=""mvars.paz_takeActionPath=I
  mvars.paz_giveActionPath=oe
  mvars.paz_isSeeYouMonologueEnabled=false
  mvars.paz_isShowMeMonologueEnabled=true
  mvars.paz_isIdleActionEnabled=false
  mvars.paz_isIdleMonologueEnabled=false
  mvars.paz_isSpeeching=false
  mvars.paz_hasDroppedBook=false
  e.InitTimer()
  local u=e.GetPosition()
  local l=e.GetRotationY()
  local d=e.GetDemoEndType()
  local i=e.GetStartType()
  local n=nil
  local o=false
  local t=nil
  local r=nil
  local m=false
  if d==e.DEMO_END_TYPE_SIT then
    m=true
  elseif d==e.DEMO_END_TYPE_DOWN then
  else
    if i==e.START_TYPE_NO_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        n=a
      else
        n=e.GetItemInTableAtRandom(te)
      end
    elseif i==e.START_TYPE_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        n=a
      else
        n=e.GetItemInTableAtRandom(le)
      end
      m=true
    elseif i==e.START_TYPE_DOWN then
      n=s
    end
  end
  if n~=nil then
    local a=0
    if e.IsReal()then
      a=.8
    end
    if n[2]==S[2]or n[2]==_[2]then
      t=Vector3(.05535,.48294+a,-.1489)
      r=-foxmath.PI*.5
      o=true
    elseif n[2]==s[2]then
      t=Vector3(-.2,.5033+a,-.2)r=-foxmath.PI*.5
      o=true
    end
    if o then
      local a=u+Quat.RotationY(l-foxmath.PI*.5):Rotate(t)
      local n=l+r
      e.Warp(a,n)
    end
    e.SendCommandSpecialAction(n)
  end
  if n==a then
    if gvars.pazLookedPictureCount<7 then
      e.SendCommandCallMonologue(L)
    else
      e.SendCommandCallMonologue(N)
    end
  end
  e.messageExecTable=Tpp.MakeMessageExecTable(e.ActiveMessages())
  GkEventTimerManager.Start(p,30)
  GkEventTimerManager.Start(z,2)
  GkEventTimerManager.Start(c,10)
  mvars.paz_startPosition=u
  mvars.paz_startRotationY=l
  mvars.paz_doesSnakeHasPicture=m
  mvars.paz_demoEndType=e.DEMO_END_TYPE_NONE
  e.InitUi()
  if not f then
    e.InitPlayer()
  end
  e.InitMusic()
  TppRadio.Stop()
  e.UpdateIcon()
end
function e.OnLeave()
e.messageExecTable=Tpp.MakeMessageExecTable(e.InactiveMessages())
  TppClock.RegisterClockMessage(M,TppClock.GetTime"number"+(1*60)*60)
  mvars.paz_isActive=false
  mvars.paz_isIconEnabled=false
  e.InitTimer()
  e.UpdateIcon()
  e.TermMusic()
e.TermPlayer()
e.TermUi()
end
function e.NeedsToWaitLeave()
  return mvars.paz_isSpeeching and e.IsInTable(mvars.paz_lastMonologueLabel,D)
end
function e.OnSpecialActionEnd(o,o,t)
  if t==n(_[2])then
    e.SendCommandSpecialAction(a)
    e.SendCommandCallMonologue(H[math.random(#H)])
  elseif t==n(I[2])then
    e.SendCommandSpecialAction(E)
    e.SendCommandCallMonologue(W[gvars.pazLookedPictureCount])
  elseif t==n(R[2])or t==n(j[2])then
    e.SendCommandSpecialAction(E)
  elseif t==n(G[2])or t==n(w[2])then
    e.SendCommandSpecialAction(E)
  elseif t==n(k[2])then
    e.SendCommandSpecialAction(a)
    mvars.paz_takeActionPath=C
    mvars.paz_giveActionPath=re
  elseif t==n(C[2])then
    e.SendCommandSpecialAction(a)
    e.SendCommandCallMonologue(Z)
  elseif t==n(P[2])then
    e.SendCommandSpecialAction(s)
  elseif t==n(q[2])then
    e.SendCommandSpecialAction(y)
    e.SendCommandCallMonologue(i)
  elseif t==n(F[2])then
    e.SendCommandSpecialAction(a)
  elseif t==n(U[2])then
    e.SendCommandSpecialAction(a)
  elseif t==n(O[2])then
    e.SendCommandSpecialAction(a)
  end
end
function e.OnMonologueEnd(s,a,o)
  if e.IsMonologuePhotoSpeech(a)then
    if gvars.pazLookedPictureCount<7 then
      GkEventTimerManager.Start(u,2+foxmath.FRnd()*2)
    else
      GkEventTimerManager.Start(v,2+foxmath.FRnd()*2)
    end
  elseif e.IsInTable(a,L)then
    GkEventTimerManager.Start(t,60)
  elseif a==n(N)then
    GkEventTimerManager.Start(t,60)
  elseif a==n(J)then
    GkEventTimerManager.Start(t,60)
  elseif a==n(x)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif a==n(Z)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif e.IsInTable(a,D)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30
    )mvars.paz_isIdleMonologueEnabled=false
  elseif e.IsInTable(a,i)then
    GkEventTimerManager.Start(h,5+foxmath.FRnd()*5)
  elseif a==n(Q)then
    GkEventTimerManager.Start(u,2+foxmath.FRnd()*2)
  elseif e.IsInTable(a,V)then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  elseif e.IsInTable(a,K)then
    GkEventTimerManager.Start(g,2+foxmath.FRnd()*2)
  end
  if o~=0 then
    mvars.paz_isSpeeching=false
  end
end
function e.OnFinishTimer(n)
  if n==v then
    e.SendCommandCallMonologue(Q)
  elseif n==u then
    e.SendCommandSpecialAction(P)
  elseif n==h then
    if not mvars.paz_hasPerceivedSnake then
      e.SendCommandCallMonologue(i)
    elseif mvars.paz_currentAction==y then
      e.SendCommandCallMonologue(i)
    end
  elseif n==f then
    if mvars.paz_currentAction==S then
      e.SendCommandSpecialAction(_)
    elseif mvars.paz_currentAction==b then
      e.SendCommandSpecialAction(k)
    end
  elseif n==l then
    if mvars.paz_currentAction==s or mvars.paz_currentAction==A then
      e.SendCommandCallMonologue(V)
    end
  elseif n==p then
    mvars.paz_isSeeYouMonologueEnabled=true
  elseif n==m then
    mvars.paz_isShowMeMonologueEnabled=true
  elseif n==T then
    if mvars.paz_isOutAngle and mvars.paz_currentAction==r then
      e.SendCommandSpecialAction(a)e.SendCommandCallMonologue(K)
    end
  elseif n==g then
    if mvars.paz_isOutAngle then
      e.SendCommandSpecialAction(r)
    end
  elseif n==z then
    GkEventTimerManager.Start(z,2)
    if mvars.paz_isIdleActionEnabled and mvars.paz_currentAction==a then
      local a=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
      local n=e.GetPosition()
      if(a-n):GetLengthSqr()>3*3 then
        e.SendCommandSpecialAction(O)
        GkEventTimerManager.Start(c,10+foxmath.FRnd()*5)
        mvars.paz_isIdleActionEnabled=false
      end
    end
  elseif n==c then
    mvars.paz_isIdleActionEnabled=true
  elseif n==d then
    if not mvars.paz_isSpeeching then
      if mvars.paz_isSnakeStopping then
        if mvars.paz_currentAction==a then
          e.SendCommandSpecialAction(r)
        end
      elseif mvars.paz_isOutAngle then
      else
        if mvars.paz_isIdleMonologueEnabled then
          if mvars.paz_currentAction==a or mvars.paz_currentAction==O then
            e.SendCommandCallMonologue(ie)
          end
        end
      end
    end
    GkEventTimerManager.Start(d,10+foxmath.FRnd()*10)
  elseif n==t then
    mvars.paz_isIdleMonologueEnabled=true
    GkEventTimerManager.Stop(d)
    GkEventTimerManager.Start(d,2+foxmath.FRnd()*2)
  end
end
function e.OnPazPerceiveSnake()
  if mvars.paz_currentAction==S then
    e.SendCommandSpecialAction(_)
  elseif mvars.paz_currentAction==b then
    e.SendCommandSpecialAction(k)
  end
end
function e.OnPazHasAimedDefault()
  if mvars.paz_idleActionSameCount==nil then
    mvars.paz_idleActionSameCount=0
  end
  if mvars.paz_isSnakeStopping then
    local n=nil
    if mvars.paz_idleActionSameCount>=1 then
      n=e.GetItemInTableAtRandom(B)
    else
      n=e.GetItemInTableAtRandom(B)
    end
    if n==mvars.pazLastIdleAction then
      mvars.paz_idleActionSameCount=mvars.paz_idleActionSameCount+1
    else
      mvars.paz_idleActionSameCount=0
    end
    e.SendCommandSpecialAction(n)mvars.pazLastIdleAction=n
  elseif mvars.paz_isOutAngle then
    GkEventTimerManager.Start(T,2+foxmath.FRnd()*5)
  else
    e.SendCommandSpecialAction(a)
  end
end
function e.OnPazShowIcon()
mvars.paz_isIconEnabled=true
  e.UpdateIcon()
end
function e.OnPazHideIcon()
mvars.paz_isIconEnabled=false
  e.UpdateIcon()
end
function e.OnIconOk()e.SendCommandSpecialAction(mvars.paz_takeActionPath)
e.PlayPlayerMotion(mvars.paz_giveActionPath)
  if mvars.paz_takeActionPath[2]==C[2]then
    mvars.paz_isSeeYouMonologueEnabled=true
  end
end
function e.OnIconSwitchShown()
  if((((((mvars.paz_currentAction~=s and mvars.paz_currentAction~=A)and mvars.paz_currentAction~=P)and mvars.paz_currentAction~=E)and mvars.paz_currentAction~=I)and mvars.paz_currentAction~=G)and mvars.paz_currentAction~=R)and mvars.paz_isSeeYouMonologueEnabled then
    e.SendCommandCallMonologue(D)
    GkEventTimerManager.Stop(p)
    GkEventTimerManager.Start(p,30)
    GkEventTimerManager.Stop(m)
    GkEventTimerManager.Start(m,30)
    mvars.paz_isSeeYouMonologueEnabled=false
    mvars.paz_isShowMeMonologueEnabled=false
  end
end
function e.OnPazRelaxEndTiming()
  if not mvars.paz_isOutAngle and not mvars.paz_isSnakeStopping then
    e.SendCommandSpecialAction(F)
    if mvars.paz_isSpeeching and e.IsInTable(mvars.paz_lastMonologueLabel,i)then
      e.SendCommandCallMonologue""
    end
  end
end
function e.OnPazOutAngle()mvars.paz_isOutAngle=true
  if mvars.paz_currentAction==a then
    e.SendCommandSpecialAction(r)
  end
end
function e.OnPazInAngle()mvars.paz_isOutAngle=false
  if mvars.paz_currentAction==r then
    e.SendCommandSpecialAction(a)
  end
end
function e.OnPazSnakeIsStopping()
mvars.paz_isSnakeStopping=true
  if mvars.paz_currentAction==a and not mvars.paz_isSpeeching then
    e.SendCommandSpecialAction(r)
  end
end
function e.OnPazSnakeIsMoving()
mvars.paz_isSnakeStopping=false
end
function e.OnClock(e)
  if e==M then
    mvars.paz_hasPerceivedSnake=false
    TppClock.UnregisterClockMessage(M)
  end
end
function e.IsReal()
  return GameObject.SendCommand(e.GetPazGameObjectId(),{id="IsReal"})
end
function e.Warp(a,n)
GameObject.SendCommand(e.GetPazGameObjectId(),{id="Warp",position=a,rotationY=n})
end
function e.SendCommandSpecialAction(o,r)
  local t=o[2]if not r then
    r=t
  end
  local m=8
  if o[3]~=nil then
    m=o[3]end
  Y(e.GetPazGameObjectId(),{id="SpecialAction",action=o[1],path=t,state=t,autoFinish=false,enableMessage=true,commandId=n(r),enableGravity=false,enableCollision=false,interpFrame=m})mvars.paz_currentAction=o
  if t==a[2]then
    mvars.paz_hasPerceivedSnake=true
  elseif t==S[2]then
    if foxmath.FRnd()<.5 then
      e.SendCommandCallMonologue(e.GetItemInTableAtRandom(i))
    else
      GkEventTimerManager.Start(f,.5+foxmath.FRnd()*.5)
    end
  elseif t==b[2]then
    if foxmath.FRnd()<.5 then
      e.SendCommandCallMonologue(e.GetItemInTableAtRandom(i))
    else
      GkEventTimerManager.Start(f,.5+foxmath.FRnd()*.5)
    end
  elseif t==_[2]then
    local n=false
    for a,e in ipairs(i)do
      if e==mvars.paz_lastMonologueLabel then
        n=true
        break
      end
    end
    if n then
      e.SendCommandCallMonologue(J)
    else
      if gvars.pazLookedPictureCount<7 then
        e.SendCommandCallMonologue(L)
      else
        e.SendCommandCallMonologue(N)
      end
    end
    mvars.paz_hasPerceivedSnake=true
  elseif t==k[2]then
    mvars.paz_hasDroppedBook=true
    e.SendCommandCallMonologue(ae)mvars.paz_hasPerceivedSnake=true
  elseif t==C[2]then
    mvars.paz_hasDroppedBook=false
  elseif t==I[2]then
    mvars.paz_doesSnakeHasPicture=false
  elseif t==P[2]then
    e.SendCommandCallMonologue(X[math.random(#X)])
  elseif t==s[2]then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  elseif t==A[2]then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  end
  e.UpdateIcon()
end
function e.SendCommandCallMonologue(n)
  if not mvars.paz_monologueSameCount then
    mvars.paz_monologueSameCount=0
  end
  if type(n)=="table"then
    local a=#n
    if a==1 then
      n=e.GetItemInTableAtRandom(n)
    elseif a==2 then
      if mvars.paz_monologueSameCount==0 then
        n=e.GetItemInTableAtRandom(n)
      else
        n=e.GetItemInTableAtRandom(n,mvars.paz_lastMonologueLabel)
      end
    else
      n=e.GetItemInTableAtRandom(n,mvars.paz_lastMonologueLabel)
    end
  end
  Y(e.GetPazGameObjectId(),{id="CallMonologue",label=n,reset=true})
  if n==mvars.paz_lastMonologueLabel then
    mvars.paz_monologueSameCount=mvars.paz_monologueSameCount+1
  else
    mvars.paz_monologueSameCount=0
  end
  mvars.paz_lastMonologueLabel=n
  if n==""then
    mvars.paz_isSpeeching=false
  else
    mvars.paz_isSpeeching=true
  end
end
function e.GetPosition()
  return GameObject.SendCommand(e.GetPazGameObjectId(),{id="GetPosition"})
end
function e.GetRotationY()
  return GameObject.SendCommand(e.GetPazGameObjectId(),{id="GetRotationY"})
end
function e.InitTimer()GkEventTimerManager.Stop(p)GkEventTimerManager.Stop(m)GkEventTimerManager.Stop(v)GkEventTimerManager.Stop(u)GkEventTimerManager.Stop(h)GkEventTimerManager.Stop(f)GkEventTimerManager.Stop(l)GkEventTimerManager.Stop(T)GkEventTimerManager.Stop(g)GkEventTimerManager.Stop(z)GkEventTimerManager.Stop(c)GkEventTimerManager.Stop(d)GkEventTimerManager.Stop(t)
end
function e.InitUi()
  TppUI.OverrideFadeInGameStatus{EquipHud=false,EquipPanel=false,AnnounceLog=false}
  TppUiCommand.SetAllInvalidMbSoundControllerVoice()
end
function e.TermUi()
  TppUI.UnsetOverrideFadeInGameStatus()
  TppUiCommand.SetAllInvalidMbSoundControllerVoice(false)
  TppUiStatusManager.UnsetStatus("EquipHud","INVALID")
  TppUiStatusManager.UnsetStatus("EquipPanel","INVALID")
  TppUiStatusManager.UnsetStatus("AnnounceLog","INVALID_LOG")
  TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")
end
function e.InitPlayer()Player.SetAroundCameraManualMode(true)Player.SetAroundCameraManualModeParams{offset=Vector3(-.2,.7,0),distance=1.2,focalLength=21,focusDistance=8.175,target=Vector3(2,10,10),targetInterpTime=.2,targetIsPlayer=true,ignoreCollisionGameObjectName="Player",rotationLimitMinX=-50,rotationLimitMaxX=50,alphaDistance=.5}Player.UpdateAroundCameraManualModeParams()Player.RequestToSetCameraStock{direction="right"}Player.SetCurrentItemIndex{itemIndex=0}Player.RequestToSetTargetStance(PlayerStance.STAND)
end
function e.TermPlayer()Player.SetAroundCameraManualMode(false)
end
function e.InitMusic()
  TppMusicManager.StopMusicPlayer(500)
  TppMusicManager.StopHeliMusic()
  if TppMusicManager.DisableHeliNewPlay~=nil then
    TppMusicManager.DisableHeliNewPlay()
  end
end
function e.TermMusic()
  if TppMusicManager.EnableHeliNewPlay~=nil then
    TppMusicManager.EnableHeliNewPlay()
  end
end
function e.GetPazGameObjectId()
  if(not mvars.paz_gameObject)or(mvars.paz_gameObject==ee)then
    mvars.paz_gameObject=ne(o)
  end
  return mvars.paz_gameObject
end
function e.GetStartPosition()
  return mvars.paz_startPosition
end
function e.GetStartRotationY()
  return mvars.paz_startRotationY
end
function e.UpdateIcon()
  if(mvars.paz_isIconEnabled and mvars.paz_currentAction==a)and(mvars.paz_doesSnakeHasPicture or mvars.paz_hasDroppedBook)then
    if not mvars.paz_isIconVisible then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"IconOk",messageArg=""}mvars.paz_isIconVisible=true
      if((mvars.paz_doesSnakeHasPicture and mvars.paz_isShowMeMonologueEnabled)and not mvars.paz_isSpeeching)and mvars.paz_lastMonologueLabel~=x then
        e.SendCommandCallMonologue(x)GkEventTimerManager.Start(m,30)mvars.paz_isShowMeMonologueEnabled=false
      end
    end
  else
    if mvars.paz_isIconVisible then
      Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}mvars.paz_isIconVisible=false
    end
  end
end
function e.PlayPlayerMotion(e)Player.RequestToPlayDirectMotion{"handBookToPaz",{e,false,o,"Move","MTP_GLOBAL_C",false}}
end
function e.PlayCameraAnimation()Player.RequestToPlayCameraNonAnimation{characterId=e.GetPazGameObjectId(),isFollowPos=true,isFollowRot=true,followTime=6,followDelayTime=.5,candidateRots={{-10,110}},skeletonNames={"SKL_002_CHEST"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(.1,.1,.1)},offsetTarget=Vector3(0,.5,.5),offsetPos=Vector3(0,0,-1),focalLength=21,aperture=4,timeToSleep=6,interpTimeAtStart=1,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,isCollisionCheck=false}Player.RequestToSetCameraRotation{rotX=10,rotY=45,interpTime=1}
end
function e.IsMonologuePhotoSpeech(a)
  for t,e in ipairs(W)do
    if n(e)==a then
      return true
    end
  end
  return false
end
function e.GetItemInTableAtRandom(e,t)
  if t==nil then
    return e[math.random(#e)]else
    local n={}
    local a=0
    for o,e in ipairs(e)do
      if e~=t then
        a=a+1
        n[a]=e
      end
    end
    return n[math.random(#n)]end
end
function e.IsInTable(e,a)
  for t,a in ipairs(a)do
    if type(e)=="number"then
      if n(a)==e then
        return true
      end
    else
      if a==e then
        return true
      end
    end
  end
  return false
end
return e
