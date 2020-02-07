--EquipDevSetting-CSV.lua
--Convert EquipDevelopment*Setting tables to and from (not yet complete) comma seperated values

local this={}

--returns list of csv line strings for each entry, to output just write each line in list to file
--ASSUMPTION: passing in the deminified version of EquipDevelopment<Const||Flow>Setting that does not have equipDevTable nilled
--equipDevTable = EquipDevelopment<Const||Flow>Setting.equipDevTable
--dParam = EquipDevelopment<Const||Flow>Setting.descriptiveParamToParamName
--ASSUMPTION: parameters named 'p<nn>', though this is only the case for TPP, MGO has named parameters
--TODO: crushed mode where p08 is just texture name and TppEquip.,TppMbDev etc are stripped (verify there arent any float values in params then you can just strip before '.')
--REF DevConst  {p00=1000,p01=TppEquip.EQP_WP_10101,p02=TppMbDev.EQP_DEV_TYPE_Handgun,p03=0,p04=0,p05=65535,p06="name_wp_1000",p07="info_wp_1000",p08="/Assets/tpp/ui/texture/EquipIcon/weapon/ui_wp_hg01_00_10_alp",p09=TppMbDev.EQP_DEV_GROUP_WEAPON_010,p10="ability_0300",p30="real_wp_1000",p31=0,p32=1,p33=1,p34=1,p35=0,p36=0},
--REF DevFlow   {p50=0,p51=0,p52=1,p53=0,p54=100,p55=0,p56=0,p57=0,p58="",p59=0,p60="",p61=0,p62=1,p63=0,p64=0,p65="",p66=0,p67="",p68=0,p69=0,p70=0,p71=0,p72=0,p73=0,p74=1},
function this.DevSettingToCSV(equipDevTable,dParam)
  local lines={}
  
  --tex lua doesn't order key,values (but it does index,values), 
  --See param names ASSUMPTION above
  local paramOrder={}
  for pName,param in pairs(equipDevTable[1]) do
    paramOrder[#paramOrder+1]=pName
  end
  table.sort(paramOrder)
  
  --TODO: add descriptive param names as first line
  local columnNames=""
  for j,pName in pairs(paramOrder) do
    columnNames=columnNames..pName..","
  end
  lines[#lines+1]=columnNames
  
  for i,devEntry in ipairs(equipDevTable)do
    local line=""
    for j,pName in pairs(paramOrder) do
      --tex value only
      line=line..devEntry[pName]..","
    end
    lines[#lines+1]=line
  end
  return
end--DevSettingToCSV

return this