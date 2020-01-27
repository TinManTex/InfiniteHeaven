-- DOBUILD: 1
-- InfInit.lua
local this={}
InfCore.LogFlow"Load InfInit.lua"

--CALLER start2nd
--tex messy, but lets user still use MbmCommonSetting/EquipDevelopConstSetting/EquipDevelopFlowSetting mods
function this.MBManagementSettings()
  --MbmCommonSetting
  TppMotherBaseManagement.RegisterMissionBaseStaffTypes{missionId=30050,staffTypes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}}--tex to give proper stats/skills spread on MB invasion
  --EquipDevelopConstSetting
  TppMotherBaseManagement.RegCstDev{p00=900,p01=TppEquip.EQP_None,p02=TppMbDev.EQP_DEV_TYPE_Handgun,p03=0,p04=0,p05=65535,p06="cmmn_wp_none",p07="cmmn_wp_none",p08="/Assets/tpp/ui/texture/EquipIcon/ui_dev_dummy_alp",p09=TppMbDev.EQP_DEV_GROUP_WEAPON_010,p10="cmmn_wp_none",p30="cmmn_wp_none",p31=0,p32=0,p33=0,p34=0,p35=0,p36=0}
  TppMotherBaseManagement.RegCstDev{p00=901,p01=TppEquip.EQP_None,p02=TppMbDev.EQP_DEV_TYPE_Assault,p03=0,p04=0,p05=65535,p06="cmmn_wp_none",p07="cmmn_wp_none",p08="/Assets/tpp/ui/texture/EquipIcon/ui_dev_dummy_alp",p09=TppMbDev.EQP_DEV_GROUP_WEAPON_010,p10="cmmn_wp_none",p30="cmmn_wp_none",p31=0,p32=0,p33=0,p34=0,p35=0,p36=0}
  --EquipDevelopFlowSetting
  --tex SYNC p50 to last EquipDevelopFlowSetting entry p50 +1, or to 0 - but that gives a 'Development requirements met' message each startup, even if item is developed.
  TppMotherBaseManagement.RegFlwDev{p50=876,p51=0,p52=1,p53=0,p54=0,p55=0,p56=0,p57=0,p58="",p59=0,p60="",p61=0,p62=1,p63=0,p64=0,p65="",p66=0,p67="",p68=0,p69=0,p70=0,p71=0,p72=0,p73=0,p74=1}
  TppMotherBaseManagement.RegFlwDev{p50=877,p51=0,p52=1,p53=0,p54=0,p55=0,p56=0,p57=0,p58="",p59=0,p60="",p61=0,p62=1,p63=0,p64=0,p65="",p66=0,p67="",p68=0,p69=0,p70=0,p71=0,p72=0,p73=0,p74=1}
end

--STATE
ivars={}--tex GLOBAL
evars={}--tex GLOBAL

--EXEC
if not InfCore.modDirFail then
  InfCore.LoadExternalModule"Ivars"
  if Ivars==nil then
    InfCore.Log"Ivars==nil"--DEBUG
  else
    IvarProc.LoadEvars()
  end
  
  --InfCore.PrintInspect(evars)--DEBUG
end

InfCore.LogFlow"InfInit.lua done"
return this
