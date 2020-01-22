function GetRoundEndMenuEntry(n,l,o,t,i)
local t=t..".UI_roundResult_PList_record"local e=(o+0)..""local a=(o+1)..""local o="Team"..(l.."Score")
local _="label_"..(n..("_score_row_"..a))
local o={type="MgoUiMenuEntry",name="menu_entry_"..(n..("_"..a)),states={{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=t..".UI_RR_PList_Focus_Off"},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t..".UI_RR_PList_Focus_On"},{type="MgoUiAnimationStateSwitch",name="stateIdle",mode="enter",control="play",layout=t..".UI_RR_PList_Focus_Off"}},widgets={{type="MgoUiAnimation",name="anim_"..(n..("_voice_"..a)),source="mgo_ruleset_score_team_"..(l.."_voice"),index=e,layout="",options={{key="0",layout=t..".UI_RR_PList_SPK_Invis"},{key="1",layout=t..".UI_RR_PList_SPK_On"},{key="2",layout=t..".UI_RR_PList_SPK_Talk"}}},{type="MgoUiLabel",name=_.."_col_1",source=o.."0",index=e,layout=t..".UI_Result_PList_Number1_txt",default="."},{type="MgoUiLabel",name=_.."_col_2",source=o.."1",index=e,layout=t..".UI_Result_PList_Number2_txt",default="."},{type="MgoUiLabel",name=_.."_col_3",source=o.."2",index=e,layout=t..".UI_Result_PList_Number3_txt",default="."},{type="MgoUiLabel",name=_.."_col_4",source=o.."3",index=e,layout=t..".UI_Result_PList_Number4_txt",default="."},{type="MgoUiLabel",name=_.."_col_5",source=o.."4",index=e,layout=t..".UI_Result_PList_Number5_txt",default="."},{type="MgoUiLabel",name=_.."_col_6",source=o.."5",index=e,layout=t..".UI_Result_PList_Number6_txt",default="."},{type="MgoUiLabel",name=_.."_col_7",source=o.."6",index=e,layout=t..".UI_Result_PList_Number7_txt",default="."},{type="MgoUiLabel",name="label_"..(n..("_player_rank_"..a)),source="PlayerLevelTeam"..l,index=e,layout=t..".UI_Res_Rank_txt",default="."},{type="MgoUiAnimation",name="anim_"..(n..("_class_"..a)),source="mgo_ruleset_score_team_"..(l.."_class"),index=e,layout=t,options={{key="0",layout=t..".UI_RR_PList_REC"},{key="1",layout=t..".UI_RR_PList_INF"},{key="2",layout=t..".UI_RR_PList_TEC"},{key="",layout=t..".UI_RR_PList_Class_Off"}}}}}
if i then
table.insert(o.widgets,{type="MgoUiLabel",name="label_"..(n..("_player_name_"..a)),source="",index="",layout=t..".UI_Result_PList_PName_txt",default="Total"})
else
table.insert(o.widgets,{type="MgoUiLabel",name="label_"..(n..("_player_name_"..a)),source="mgo_team_"..(l.."_player_names"),index=e,layout=t..".UI_Result_PList_PName_txt",default="."})
end
return o
end
function GetRoundStateMenuTransitions(t,o,n,e)
local _=(t+0)..""local a=(t+1)..""local _="UI_roundResult_layout"local t="UI_roundResult_layout."..o
local t="ui_RR_round1_record.UI_roundResult_Round_record"local o="ui_RR_round2_record.UI_roundResult_Round_record"local t={type="MgoUiMenuEntry",name="menu_entry_result_"..a,states={{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=_..("."..n)},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t..("."..e)},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=o..("."..e)}}}
return t
end
function GetRoundStateWinnerMenuTransition(e,o)
local t="UI_roundResult_layout"local n=(e+0)..""local e=(e+1)..""local t={type="MgoUiMenuEntry",name="menu_entry_result_"..e,states={{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t..("."..o)},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t..".UI_RR_WL_Setin"}}}
return t
end
function GetTopAnimMenuTransition(t,o)
local e="UI_roundResult_layout"local n=(t+0)..""local t=(t+1)..""local t={type="MgoUiMenuEntry",name="menu_entry_result_"..t,states={{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=e..("."..o)},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=e..".UI_RR_WL_Setin"}}}
return t
end
function GetDeathMatchTeamIcon(t)
local t=(t+1)..""local e="ui_RR_round"..(t..("_record"..".UI_roundResult_Round_record"))
local t={type="MgoUiAnimation",name="anim_death_match_team_icon_"..t,source="mgo_ruleset_team_1_name",layout="",options={{key="Liquid",layout=e..".UI_RR_TDM_Liquid_Blue"},{key="Solid",layout=e..".UI_RR_TDM_Solid_Blue"}}}
return t
end
function GetSabotageMissionAccomplishedAnim(t,e,_)
local o=(t)..""local n=(t+1)..""local t="ui_RR_round"..(_..("_record"..".UI_roundResult_Round_record"))
local t={type="MgoUiAnimation",name="anim_sab_mis_accomplished_"..n,source="mission_objective_state",index=o,layout="",options={{key="_yes_",layout=t..(".UI_RR_SAB"..(e.."_Got"))},{key="_no_",layout=t..(".UI_RR_SAB"..(e.."_Lost"))}}}
return t
end
function GetSabotagePlayerAttackAnim(t)
local e="UI_roundResult_layout"local o=(t)..""local e=(t+1)..""local t="ui_RR_round"..(e..("_record"..".UI_roundResult_Round_record"))
local t={type="MgoUiAnimation",name="anim_sab_player_attack_"..e,source="mission_local_player_attack",index=o,layout="",options={{key="_yes_",layout=t..".UI_RR_SAB_Atc"},{key="_no_",layout=t..".UI_RR_SAB_Def"}}}
return t
end
function GetMatchResultStatScroll(t,e)
local o="UI_roundResult_layout"local n=(t)..""local t=(t+1)..""local t={type="MgoUiProgress",name="prog_stat_scroll_"..t,source="mgo_result_stat_scroll",index=0,layout=o..("."..e),options={}}
return t
end
function GetNavigationButton(e)
local t=(e)..""local o=(e+1)..""local t="id_customize_control_record000"..(t..".UI_ID_Customize_Control")
local t={type="MgoUiLabel",layout=t..".UI_keyhelp_txt",name="label_button_"..o,source="",default="",pos={x=""..(30+(100*e)),y="600",w="80",h="30"},textUnitCount="4",states={{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=t..".mb_cmn_keyhelp_on"},{type="MgoUiAnimationStateSwitch",name="stateShow",mode="enter",control="play",layout=t..".mb_cmn_keyhelp_on"},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t..".mb_cmn_keyhelp_setin"},{type="MgoUiAnimationStateSwitch",name="stateIdle",mode="enter",control="play",layout=t..".mb_cmn_keyhelp_setout"},{type="MgoUiAnimationStateSwitch",name="stateHide",mode="enter",control="play",layout=t..".mb_cmn_keyhelp_off"}}}
return t
end
RoundResult={widgets={GetNavigationButton(0),GetNavigationButton(1),GetNavigationButton(2),GetNavigationButton(3),{type="MgoUiMenu",name="menu_result_score_1",states={},widgets={GetRoundEndMenuEntry("left",1,0,"ui_RR_PList_record_B1",false),GetRoundEndMenuEntry("left",1,1,"ui_RR_PList_record_B2",false),GetRoundEndMenuEntry("left",1,2,"ui_RR_PList_record_B3",false),GetRoundEndMenuEntry("left",1,3,"ui_RR_PList_record_B4",false),GetRoundEndMenuEntry("left",1,4,"ui_RR_PList_record_B5",false),GetRoundEndMenuEntry("left",1,5,"ui_RR_PList_record_B6",false),GetRoundEndMenuEntry("left",1,6,"ui_RR_PList_record_B7",false),GetRoundEndMenuEntry("left",1,7,"ui_RR_PList_record_B8",false),GetRoundEndMenuEntry("left",1,8,"ui_RR_PList_record_B9",true)}},{type="MgoUiMenu",name="menu_result_score_2",states={},widgets={GetRoundEndMenuEntry("right",2,0,"ui_RR_PList_record_R1",false),GetRoundEndMenuEntry("right",2,1,"ui_RR_PList_record_R2",false),GetRoundEndMenuEntry("right",2,2,"ui_RR_PList_record_R3",false),GetRoundEndMenuEntry("right",2,3,"ui_RR_PList_record_R4",false),GetRoundEndMenuEntry("right",2,4,"ui_RR_PList_record_R5",false),GetRoundEndMenuEntry("right",2,5,"ui_RR_PList_record_R6",false),GetRoundEndMenuEntry("right",2,6,"ui_RR_PList_record_R7",false),GetRoundEndMenuEntry("right",2,7,"ui_RR_PList_record_R8",false),GetRoundEndMenuEntry("right",2,8,"ui_RR_PList_record_R9",true)}}}}
