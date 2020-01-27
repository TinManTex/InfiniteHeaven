function GetGenderEditEntry(t)
  local o=t+1 ..""
  local e=t..""
  local _={"id_C_Gender_Male","id_C_Gender_Female"}
  local layout=_[t+1]..".UI_ID_C_Gender_record"
  local n={"id_C_Gender_Female","id_C_Gender_Male"}
  local _=_[t+1]..".UI_ID_C_Gender_record"
  local a={".UI_ID_C_Gender_Female",".UI_ID_C_Gender_Male"}
  local langTags={"mgo_idt_female","mgo_idt_male"}
  local genderEditEntity={
    type="MgoUiMenuEntry",
    name="menu_entry_gender_edit_"..o,
    states={
      {type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=_..a[t+1]},
      {type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=layout..".UI_ID_C_Gender_FocusOut"},
      {type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=layout..".UI_ID_C_Gender_Focus"},
      {type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="stop",layout=layout..".UI_ID_C_Gender_FocusOut"},
      {type="MgoUiAnimationStateSwitch",name="stateHot",mode="exit",control="play",layout=layout..".UI_ID_C_Gender_FocusOut"},
      {type="MgoUiAnimationStateSwitch",name="stateHot",mode="exit",control="stop",layout=layout..".UI_ID_C_Gender_Focus"}
    },
    widgets={{type="MgoUiLabel",name="label_gender_edit_"..o,layout=_..".UI_ID_C_Gender_txt",shadow=_..".UI_ID_C_Gender_sdw_txt",langTag=langTags[t+1]}}}
  return genderEditEntity
end
CharacterModGenderEdit={
  widgets={
    {type="MgoUiMenu",
      name="menu_gender_edit",
      states={
        {type="MgoUiAnimationStateSwitch",name="stateHot",mode="exit",control="play",layout="UI_ID_Customize_PT1_layout.UI_ID_C_PT1_Gender_Off"},
        {type="MgoUiAnimationStateSwitch",name="stateHot",mode="exit",control="stop",layout="UI_ID_Customize_PT1_layout.UI_ID_C_PT1_Gender_On"},
        {type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout="UI_ID_Customize_PT1_layout.UI_ID_C_PT1_Gender_On"},
        {type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="stop",layout="UI_ID_Customize_PT1_layout.UI_ID_C_PT1_Gender_Off"},
        {type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout="UI_ID_Customize_PT1_layout.UI_ID_C_PT1_Chr_Bracket_Off"}
      },
      widgets={GetGenderEditEntry(0),GetGenderEditEntry(1)}}}}
