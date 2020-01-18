local e={}
function e.OnMissionCanStart()
  if TppLocation.IsMiddleAfrica()and TppQuest.IsActive"outland_q60113"==true then
    e.RepopCountOperation("SetAt","col_develop_GunCamera",0)
  else
    e.RepopCountOperation("SetAt","col_develop_GunCamera",1)
  end
  if TppLocation.IsMiddleAfrica()and TppQuest.IsActive"pfCamp_q60114"==true then
    e.RepopCountOperation("SetAt","col_develop_UAV",0)
  else
    e.RepopCountOperation("SetAt","col_develop_UAV",1)
  end
  if TppLocation.IsAfghan()and TppQuest.IsActive"sovietBase_q60110"==true then
    e.RepopCountOperation("SetAt","col_develop_Stungun",0)
  else
    e.RepopCountOperation("SetAt","col_develop_Stungun",1)
  end
  if TppLocation.IsAfghan()and TppQuest.IsActive"sovietBase_q60111"==true then
    e.RepopCountOperation("SetAt","col_develop_Infraredsensor",0)
  else
    e.RepopCountOperation("SetAt","col_develop_Infraredsensor",1)
  end
  if TppLocation.IsAfghan()and TppQuest.IsActive"citadel_q60112"==true then
    e.RepopCountOperation("SetAt","col_develop_Theftprotection",0)
  else
    e.RepopCountOperation("SetAt","col_develop_Theftprotection",1)
  end
end
return e
