mbdvc_pause_help_table = {

	
	
	
	GetHelpTable = function( HelpID )
		print("GetHelpTable script")

		local X_LEFT_SHORT = 100
		local X_LEFT_LONG = 100
		local X_RIGHT_SHORT = 850
		local X_RIGHT_LONG = 700

		local Y_LEFT = 200
		local Y_RIGHT = 100
		local Y_LEFT_BOTTOM = 570
		local Y_RIGHT_BOTTOM = 570

		local Y_INTERVAL = 20

		local TEXT_SHORT = 0
		local TEXT_LONG = 1
		local COORD_REL = 0
		local COORD_ABS = 1
		local ALIGN_TOP = 0
		local ALIGN_BOTTOM = 1

		local MbMenuCommonHeader = Fox.StrCode("mbhelp_name_245")
		local MbMenuCommonHeaderInfo = Fox.StrCode("mbhelp_info_245")
		local StaffManagerSectionHeader = Fox.StrCode("mbhelp_name_039")
		local StaffManagerSectionHeaderInfo = Fox.StrCode("mbhelp_info_039")

		local GetMbMenuCommonPage = function()
			return {	
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_249"), helpMessageId = Fox.StrCode("mbhelp_info_249"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_247"), helpMessageId = Fox.StrCode("mbhelp_info_247"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 755, iconPosY = 358 },
				{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_247_2"), helpMessageId = Fox.StrCode("mbhelp_info_247_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 755, iconPosY = 140 },
				{ type = 1, textAreaType = TEXT_SHORT },
			}
		end

		local GetStaffManagerSectionCommonPage = function()
			return {	
				{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_041"), helpMessageId = Fox.StrCode("mbhelp_info_041"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 815, iconPosY = 310 },
				{ type = 1, textAreaType = TEXT_SHORT },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_043"), helpMessageId = Fox.StrCode("mbhelp_info_016"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			} 
		end

		local GetSentoKeibiPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_sento_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_sento_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_bttl_deploy"), helpMessageId = Fox.StrCode("func_bttl_deploy_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_bttl_defence"), helpMessageId = Fox.StrCode("func_bttl_defence_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_keibi_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_keibi_info"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_sec_base_defence"), helpMessageId = Fox.StrCode("func_sec_base_defence_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_sec_base_blockade"), helpMessageId = Fox.StrCode("func_sec_base_blockade_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetSentoPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_sento_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_sento_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_bttl_deploy"), helpMessageId = Fox.StrCode("func_bttl_deploy_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_bttl_defence"), helpMessageId = Fox.StrCode("func_bttl_defence_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetKeibiPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_keibi_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_keibi_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_sec_base_defence"), helpMessageId = Fox.StrCode("func_sec_base_defence_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_sec_base_blockade"), helpMessageId = Fox.StrCode("func_sec_base_blockade_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetKenkyuPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_kenkyu_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_kenkyu_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_dev_weapon"), helpMessageId = Fox.StrCode("func_dev_weapon_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_dev_heli"), helpMessageId = Fox.StrCode("func_dev_heli_help"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_dev_dhorse"), helpMessageId = Fox.StrCode("func_dev_dhorse_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },




				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetKyotenPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_kyoten_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_kyoten_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_fob_mining"), helpMessageId = Fox.StrCode("func_fob_mining_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_fob_processing"), helpMessageId = Fox.StrCode("func_fob_processing_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_fob_extention"), helpMessageId = Fox.StrCode("func_fob_extention_help"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_fob_construct"), helpMessageId = Fox.StrCode("func_fob_construct_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_sec_machine_defence"), helpMessageId = Fox.StrCode("func_sec_machine_defence_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetSienPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_sien_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_sien_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_spprt_fulton"), helpMessageId = Fox.StrCode("func_spprt_fulton_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_spprt_supply"), helpMessageId = Fox.StrCode("func_spprt_supply_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_spprt_battle"), helpMessageId = Fox.StrCode("func_spprt_battle_help"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_spprt_artillery"), helpMessageId = Fox.StrCode("func_spprt_artillery_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },



			



				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_spprt_trans_rus"), helpMessageId = Fox.StrCode("func_spprt_trans_rus_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },



				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetCyohoPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_cyoho_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_cyoho_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_intel_info"), helpMessageId = Fox.StrCode("func_intel_info_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_intel_search_ene1"), helpMessageId = Fox.StrCode("func_intel_search_ene1_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_intel_search_plant"), helpMessageId = Fox.StrCode("func_intel_search_plant_help"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_intel_weather_info"), helpMessageId = Fox.StrCode("func_intel_weather_info_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_intel_fob_sec"), helpMessageId = Fox.StrCode("func_intel_fob_sec_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		local GetIryoPage = function()
			return {
			
				{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_func_skill_iryo_name"), helpMessageId = Fox.StrCode("mbhelp_func_skill_iryo_info"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_med_emergency"), helpMessageId = Fox.StrCode("func_med_emergency_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 0, number = 0, titleLangId = Fox.StrCode("h_func_med_treatment"), helpMessageId = Fox.StrCode("func_med_treatment_help"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
				{ type = 1, textAreaType = TEXT_LONG },
			}
		end

		print( "HelpID=" .. HelpID )

if HelpID == MbPauseHelp.HELP_ID_DEFAULT then	
return {
headerLangId = Fox.StrCode("mbhelp_name_default"), headerInfoLangId = Fox.StrCode("mbhelp_info_default"),	
pages = {	



} 
}

	
elseif HelpID == MbPauseHelp.HELP_ID_RESCUE_KAZ_MISSION then
return {		
headerLangId = Fox.StrCode("mbhelp_rescue_kaz_mission"),
}

	
elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_TOP then			
return {
headerLangId = Fox.StrCode("mbhelp_name_003"), headerInfoLangId = Fox.StrCode("mbhelp_info_003"),	
pages = {	
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_007"), helpMessageId = Fox.StrCode("mbhelp_info_007"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 590, iconPosY = 353 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_006"), helpMessageId = Fox.StrCode("mbhelp_info_006"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 470, iconPosY = 250 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_005"), helpMessageId = Fox.StrCode("mbhelp_info_005"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 470, iconPosY = 118 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_011"), helpMessageId = Fox.StrCode("mbhelp_info_011"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_010"), helpMessageId = Fox.StrCode("mbhelp_info_010"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_009"), helpMessageId = Fox.StrCode("mbhelp_info_009"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_013"), helpMessageId = Fox.StrCode("mbhelp_info_013"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_014"), helpMessageId = Fox.StrCode("mbhelp_info_014"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_015"), helpMessageId = Fox.StrCode("mbhelp_info_015"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_016"), helpMessageId = Fox.StrCode("mbhelp_info_016"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
} 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_MOVE_STAFF then
return {
headerLangId = Fox.StrCode("mbhelp_name_020"), headerInfoLangId = Fox.StrCode("mbhelp_info_020"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_022"), helpMessageId = Fox.StrCode("mbhelp_info_022"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 520, iconPosY = 278 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_023"), helpMessageId = Fox.StrCode("mbhelp_info_023"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 750, iconPosY = 278 },
	{ type = 1, textAreaType = TEXT_LONG },
} 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_STAFF_DETAIL then
return {	
headerLangId = Fox.StrCode("mbhelp_name_027"), headerInfoLangId = Fox.StrCode("mbhelp_info_027"),	
pages = {	


	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_033"), helpMessageId = Fox.StrCode("mbhelp_info_033"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 547, iconPosY = 540 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_032"), helpMessageId = Fox.StrCode("mbhelp_info_032"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 547, iconPosY = 510 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_031"), helpMessageId = Fox.StrCode("mbhelp_info_031"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 497 },
	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_035"), helpMessageId = Fox.StrCode("mbhelp_info_035"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 410 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_034"), helpMessageId = Fox.StrCode("mbhelp_info_034"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 7, titleLangId = Fox.StrCode("mbhelp_name_029"), helpMessageId = Fox.StrCode("mbhelp_info_029"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 547, iconPosY = 236 },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_030"), helpMessageId = Fox.StrCode("mbhelp_info_030"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 748, iconPosY = 470 },
	{ type = 1, textAreaType = TEXT_SHORT },


}
}	

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION then
return {	
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,	
pages = GetStaffManagerSectionCommonPage()
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_SENTO then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetSentoPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_KEIBI then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetKeibiPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_KENKYU then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetKenkyuPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_KYOTEN then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetKyotenPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_SIEN then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetSienPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_CYOHO then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetCyohoPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_STAFF_MANAGER_SECTION_IRYO then
local commonPage = GetStaffManagerSectionCommonPage()
local sectionPage = GetIryoPage()
for i, ver in ipairs(sectionPage) do
	table.insert( commonPage, ver )
end
return {		
headerLangId = StaffManagerSectionHeader, headerInfoLangId = StaffManagerSectionHeaderInfo,
pages = commonPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_DEVELOP_TOP then
return {	
headerLangId = Fox.StrCode("mbhelp_name_047"), headerInfoLangId = Fox.StrCode("mbhelp_info_047"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_050"), helpMessageId = Fox.StrCode("mbhelp_info_050"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 600, iconPosY = 350 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_049"), helpMessageId = Fox.StrCode("mbhelp_info_049"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 600, iconPosY = 97 },
	{ type = 1, textAreaType = TEXT_LONG },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 367 },



	{ type = 1, textAreaType = TEXT_SHORT },










	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_059"), helpMessageId = Fox.StrCode("mbhelp_info_059"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_061"), helpMessageId = Fox.StrCode("mbhelp_info_061"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_058"), helpMessageId = Fox.StrCode("mbhelp_info_058"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_062"), helpMessageId = Fox.StrCode("mbhelp_info_062"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_063"), helpMessageId = Fox.StrCode("mbhelp_info_063"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_064"), helpMessageId = Fox.StrCode("mbhelp_info_064"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_065"), helpMessageId = Fox.StrCode("mbhelp_info_065"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_066"), helpMessageId = Fox.StrCode("mbhelp_info_066"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_067"), helpMessageId = Fox.StrCode("mbhelp_info_067"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_068"), helpMessageId = Fox.StrCode("mbhelp_info_068"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_069"), helpMessageId = Fox.StrCode("mbhelp_info_069"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_070"), helpMessageId = Fox.StrCode("mbhelp_info_070"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
} 
}

elseif HelpID == MbPauseHelp.HELP_ID_DEVELOP_TOP_NOT_WEAPON then
return {	
headerLangId = Fox.StrCode("mbhelp_name_047"), headerInfoLangId = Fox.StrCode("mbhelp_info_047"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_050"), helpMessageId = Fox.StrCode("mbhelp_info_050"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 600, iconPosY = 350 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_049"), helpMessageId = Fox.StrCode("mbhelp_info_049"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 600, iconPosY = 97 },
	{ type = 1, textAreaType = TEXT_LONG },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 367 },



	{ type = 1, textAreaType = TEXT_SHORT },








} 
}

elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_TOP then
return {	
headerLangId = Fox.StrCode("mbhelp_name_074"), headerInfoLangId = Fox.StrCode("mbhelp_info_074"),	
pages = {	
	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_079"), helpMessageId = Fox.StrCode("mbhelp_info_079"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 540 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_077"), helpMessageId = Fox.StrCode("mbhelp_info_077"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 273 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_076"), helpMessageId = Fox.StrCode("mbhelp_info_076"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 200, iconPosY = 111 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_080"), helpMessageId = Fox.StrCode("mbhelp_info_080"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_081"), helpMessageId = Fox.StrCode("mbhelp_info_081"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },




	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_add_1"), helpMessageId = Fox.StrCode("mbhelp_name_add_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 1010, iconPosY = 580 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_078"), helpMessageId = Fox.StrCode("mbhelp_info_078"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 950, iconPosY = 400 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_087"), helpMessageId = Fox.StrCode("mbhelp_info_087"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_SECURITY then
return {		
headerLangId = Fox.StrCode("mbhelp_name_091"), headerInfoLangId = Fox.StrCode("mbhelp_info_091"),	
pages = {	

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_094"), helpMessageId = Fox.StrCode("mbhelp_info_094"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 300 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_093"), helpMessageId = Fox.StrCode("mbhelp_info_076"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 130 },
	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_095"), helpMessageId = Fox.StrCode("mbhelp_info_095"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 270 },
	{ type = 1, textAreaType = TEXT_LONG },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_098"), helpMessageId = Fox.StrCode("mbhelp_info_098"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 500 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_100"), helpMessageId = Fox.StrCode("mbhelp_info_100"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_102"), helpMessageId = Fox.StrCode("mbhelp_info_102"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101"), helpMessageId = Fox.StrCode("mbhelp_info_101"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_2"), helpMessageId = Fox.StrCode("mbhelp_info_101_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_3"), helpMessageId = Fox.StrCode("mbhelp_info_101_3"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_SECURITY_CHANGE then
return {		
headerLangId = Fox.StrCode("mbhelp_name_091"), headerInfoLangId = Fox.StrCode("mbhelp_info_091"),	
pages = {	
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096_2"), helpMessageId = Fox.StrCode("mbhelp_info_096_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 430, iconPosY = 580 },
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096"), helpMessageId = Fox.StrCode("mbhelp_info_096"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 250 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_095_2"), helpMessageId = Fox.StrCode("mbhelp_info_095_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 980, iconPosY = 240 },
	{ type = 1, textAreaType = TEXT_SHORT },






	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_100"), helpMessageId = Fox.StrCode("mbhelp_info_100"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_102"), helpMessageId = Fox.StrCode("mbhelp_info_102"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101"), helpMessageId = Fox.StrCode("mbhelp_info_101"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_2"), helpMessageId = Fox.StrCode("mbhelp_info_101_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_3"), helpMessageId = Fox.StrCode("mbhelp_info_101_3"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_SECURITY_CHANGE_EASY then
return {		
headerLangId = Fox.StrCode("mbhelp_name_091"), headerInfoLangId = Fox.StrCode("mbhelp_info_091"),	
pages = {	
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096_2"), helpMessageId = Fox.StrCode("mbhelp_info_096_2"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 430, iconPosY = 580 },
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096_3"), helpMessageId = Fox.StrCode("mbhelp_info_096_3"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 250 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_095_2"), helpMessageId = Fox.StrCode("mbhelp_info_095_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 980, iconPosY = 240 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_100"), helpMessageId = Fox.StrCode("mbhelp_info_100"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_102"), helpMessageId = Fox.StrCode("mbhelp_info_102"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },





} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_SECURITY_CHANGE_DIFFICULT then
return {		
headerLangId = Fox.StrCode("mbhelp_name_091"), headerInfoLangId = Fox.StrCode("mbhelp_info_091"),	
pages = {	
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096_2"), helpMessageId = Fox.StrCode("mbhelp_info_096_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 430, iconPosY = 580 },
	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_096_4"), helpMessageId = Fox.StrCode("mbhelp_info_096_4"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 250 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_095_2"), helpMessageId = Fox.StrCode("mbhelp_info_095_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 980, iconPosY = 240 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_100"), helpMessageId = Fox.StrCode("mbhelp_info_100"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_102"), helpMessageId = Fox.StrCode("mbhelp_info_102"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101"), helpMessageId = Fox.StrCode("mbhelp_info_101"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_2"), helpMessageId = Fox.StrCode("mbhelp_info_101_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_3"), helpMessageId = Fox.StrCode("mbhelp_info_101_3"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

} 	
}



elseif HelpID == MbPauseHelp.HELP_ID_BASE_OPERATION_SECURITY_ZONE then
return {		
headerLangId = Fox.StrCode("mbhelp_name_106"), headerInfoLangId = Fox.StrCode("mbhelp_info_106"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_108"), helpMessageId = Fox.StrCode("mbhelp_info_108"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 250 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_100"), helpMessageId = Fox.StrCode("mbhelp_info_100"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_102"), helpMessageId = Fox.StrCode("mbhelp_info_102"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101"), helpMessageId = Fox.StrCode("mbhelp_info_101"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_2"), helpMessageId = Fox.StrCode("mbhelp_info_101_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_101_3"), helpMessageId = Fox.StrCode("mbhelp_info_101_3"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
	



} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_COMBAT_DEPLOYMENT_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_115"), headerInfoLangId = Fox.StrCode("mbhelp_info_115"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_118"), helpMessageId = Fox.StrCode("mbhelp_info_118"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 253 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_117"), helpMessageId = Fox.StrCode("mbhelp_info_117"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 104 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_119"), helpMessageId = Fox.StrCode("mbhelp_info_119"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 920, iconPosY = 500 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_120"), helpMessageId = Fox.StrCode("mbhelp_info_120"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 900, iconPosY = 200 },
	{ type = 1, textAreaType = TEXT_SHORT },
	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_122"), helpMessageId = Fox.StrCode("mbhelp_info_122"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_123"), helpMessageId = Fox.StrCode("mbhelp_info_123"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_124"), helpMessageId = Fox.StrCode("mbhelp_info_124"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_COMBAT_DEPLOYMENT_UNIT then
return {		
headerLangId = Fox.StrCode("mbhelp_name_128"), headerInfoLangId = Fox.StrCode("mbhelp_info_128"),	
pages = {	
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_RESOURCES then
return {		
headerLangId = Fox.StrCode("mbhelp_name_132"), headerInfoLangId = Fox.StrCode("mbhelp_info_132"),	
pages = {	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_137"), helpMessageId = Fox.StrCode("mbhelp_info_137"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_135"), helpMessageId = Fox.StrCode("mbhelp_info_135"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 314 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_134"), helpMessageId = Fox.StrCode("mbhelp_info_134"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 110 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_139"), helpMessageId = Fox.StrCode("mbhelp_info_139"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_140"), helpMessageId = Fox.StrCode("mbhelp_info_140"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_141"), helpMessageId = Fox.StrCode("mbhelp_info_141"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_142"), helpMessageId = Fox.StrCode("mbhelp_info_142"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_142_2"), helpMessageId = Fox.StrCode("mbhelp_info_142_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_143"), helpMessageId = Fox.StrCode("mbhelp_info_143"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_ENCYCLOPEDIA_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_147"), headerInfoLangId = Fox.StrCode("mbhelp_info_147"),	
pages = {	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_149"), helpMessageId = Fox.StrCode("mbhelp_info_149"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_ITEMS_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_153"), headerInfoLangId = Fox.StrCode("mbhelp_info_153"),	
pages = {
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CASSETTE_TAPES_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_157"), headerInfoLangId = Fox.StrCode("mbhelp_info_157"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_160"), helpMessageId = Fox.StrCode("mbhelp_info_160"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 350 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_159"), helpMessageId = Fox.StrCode("mbhelp_info_159"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 300, iconPosY = 160 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_164_4"), helpMessageId = Fox.StrCode("mbhelp_info_164_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_164_3"), helpMessageId = Fox.StrCode("mbhelp_info_164_3"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_164_2"), helpMessageId = Fox.StrCode("mbhelp_info_164_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_164"), helpMessageId = Fox.StrCode("mbhelp_info_164"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_161"), helpMessageId = Fox.StrCode("mbhelp_info_161"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 650, iconPosY = 450 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_165"), helpMessageId = Fox.StrCode("mbhelp_info_165"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 1070, iconPosY = 210 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_162"), helpMessageId = Fox.StrCode("mbhelp_info_162"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 650, iconPosY = 135 },
	{ type = 1, textAreaType = TEXT_SHORT },
	
}
}

elseif HelpID == MbPauseHelp.HELP_ID_LOG_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_169"), headerInfoLangId = Fox.StrCode("mbhelp_info_169"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_171"), helpMessageId = Fox.StrCode("mbhelp_info_171"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 111 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_WEAPON then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_178"), helpMessageId = Fox.StrCode("mbhelp_info_178"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_VEHICLE_ORG then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_178_2"), helpMessageId = Fox.StrCode("mbhelp_info_178_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_WEAPON_PARTS_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_179"), helpMessageId = Fox.StrCode("mbhelp_info_179"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_OBJ_PARTS_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_193"), helpMessageId = Fox.StrCode("mbhelp_info_193"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 250 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_WEAPON_PARTS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_180"), helpMessageId = Fox.StrCode("mbhelp_info_180"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_OBJ_PARTS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_194"), helpMessageId = Fox.StrCode("mbhelp_info_194"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_175_2"), helpMessageId = Fox.StrCode("mbhelp_info_175_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },



	{ type = 1, textAreaType = TEXT_SHORT },

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_WEAPON_SLOT or HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_OBJ_SLOT then
return {		
headerLangId = Fox.StrCode("mbhelp_name_189"), headerInfoLangId = Fox.StrCode("mbhelp_info_189"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_177"), helpMessageId = Fox.StrCode("mbhelp_info_177"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 490, iconPosY = 290 },

	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_EMBLEM then
return {		
headerLangId = Fox.StrCode("mbhelp_name_199"), headerInfoLangId = Fox.StrCode("mbhelp_info_199"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_201"), helpMessageId = Fox.StrCode("mbhelp_info_201"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 450, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CUSTOMIZE_AVATAR then
return {		
headerLangId = Fox.StrCode("mbhelp_name_205"), headerInfoLangId = Fox.StrCode("mbhelp_info_205"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_207"), helpMessageId = Fox.StrCode("mbhelp_info_207"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 323, iconPosY = 351 },


	

	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_MAP_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_215"), headerInfoLangId = Fox.StrCode("mbhelp_info_215"),	
pages = {	

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_218"), helpMessageId = Fox.StrCode("mbhelp_info_218"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 450 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_217"), helpMessageId = Fox.StrCode("mbhelp_info_217"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 640, iconPosY = 80 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_218_2"), helpMessageId = Fox.StrCode("mbhelp_info_218_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 1010, iconPosY = 240 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_220"), helpMessageId = Fox.StrCode("mbhelp_info_220"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 380, iconPosY = 359 },
	{ type = 1, textAreaType = TEXT_LONG },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_221"), helpMessageId = Fox.StrCode("mbhelp_info_221"), helpPosX = X_RIGHT_LONG, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 265, iconPosY = 571 },
	{ type = 1, textAreaType = TEXT_LONG },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_227"), helpMessageId = Fox.StrCode("mbhelp_info_227"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_229"), helpMessageId = Fox.StrCode("mbhelp_info_229"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_228"), helpMessageId = Fox.StrCode("mbhelp_info_228"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_224"), helpMessageId = Fox.StrCode("mbhelp_info_224"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_225"), helpMessageId = Fox.StrCode("mbhelp_info_225"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_MAP_NAVI then
return {		
headerLangId = Fox.StrCode("mbhelp_name_233"), headerInfoLangId = Fox.StrCode("mbhelp_info_233"),	
pages = {	

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_236"), helpMessageId = Fox.StrCode("mbhelp_info_236"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 487 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_235"), helpMessageId = Fox.StrCode("mbhelp_info_217"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 640, iconPosY = 70 },
	



	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU then
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = GetMbMenuCommonPage() 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_SENTO_KEIBI then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetSentoKeibiPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_KENKYU then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetKenkyuPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_KYOTEN then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetKyotenPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_SIEN then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetSienPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_CYOHO then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetCyohoPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MENU_IRYO then
local commonPage = GetMbMenuCommonPage()
local sectionPage = GetIryoPage()
for i, ver in ipairs(commonPage) do
	table.insert( sectionPage, ver )
end
return {		
headerLangId = MbMenuCommonHeader, headerInfoLangId = MbMenuCommonHeaderInfo,	
pages = sectionPage 
}

elseif HelpID == MbPauseHelp.HELP_ID_MB_MISSIONS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_255"), headerInfoLangId = Fox.StrCode("mbhelp_info_255"),	
pages = {	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_261_2"), helpMessageId = Fox.StrCode("mbhelp_info_261_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_261"), helpMessageId = Fox.StrCode("mbhelp_info_261"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258_2"), helpMessageId = Fox.StrCode("mbhelp_info_258_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 670, iconPosY = 240 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_257"), helpMessageId = Fox.StrCode("mbhelp_info_257"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 670, iconPosY = 150 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_259"), helpMessageId = Fox.StrCode("mbhelp_info_259"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 670, iconPosY = 500 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258"), helpMessageId = Fox.StrCode("mbhelp_info_258"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 670, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_SHORT },





} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_MISSION_LIST_TOP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_268"), headerInfoLangId = Fox.StrCode("mbhelp_info_268"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_271"), helpMessageId = Fox.StrCode("mbhelp_info_271"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 306 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_270"), helpMessageId = Fox.StrCode("mbhelp_info_270"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 114 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258"), helpMessageId = Fox.StrCode("mbhelp_info_258"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 700, iconPosY = 450 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_272"), helpMessageId = Fox.StrCode("mbhelp_info_272"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 700, iconPosY = 306 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258_2"), helpMessageId = Fox.StrCode("mbhelp_info_258_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 700, iconPosY = 120 },
	{ type = 1, textAreaType = TEXT_SHORT },
	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_274"), helpMessageId = Fox.StrCode("mbhelp_info_274"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },
} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_SIDEOPS_LIST_HELI then
return {		
headerLangId = Fox.StrCode("mbhelp_name_268_2"), headerInfoLangId = Fox.StrCode("mbhelp_info_268_2"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_271_2"), helpMessageId = Fox.StrCode("mbhelp_info_271_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 306 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_270"), helpMessageId = Fox.StrCode("mbhelp_info_270_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 114 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_258_4"), helpMessageId = Fox.StrCode("mbhelp_info_258_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258_3"), helpMessageId = Fox.StrCode("mbhelp_info_258_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 1000, iconPosY = 550 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_272_2"), helpMessageId = Fox.StrCode("mbhelp_info_272_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 306 },
	{ type = 1, textAreaType = TEXT_SHORT },
	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_274_2"), helpMessageId = Fox.StrCode("mbhelp_info_274_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },
} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_SIDEOPS_LIST_FIELD then
return {		
headerLangId = Fox.StrCode("mbhelp_name_268_2"), headerInfoLangId = Fox.StrCode("mbhelp_info_268_2"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_271_2"), helpMessageId = Fox.StrCode("mbhelp_info_271_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 306 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_270"), helpMessageId = Fox.StrCode("mbhelp_info_270_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 114 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_258_5"), helpMessageId = Fox.StrCode("mbhelp_info_258_5"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_258_3"), helpMessageId = Fox.StrCode("mbhelp_info_258_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 1000, iconPosY = 550 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_272_2"), helpMessageId = Fox.StrCode("mbhelp_info_272_2"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 306 },
	{ type = 1, textAreaType = TEXT_SHORT },
	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_274_2"), helpMessageId = Fox.StrCode("mbhelp_info_274_2"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_LONG },
} 	
}



elseif HelpID == MbPauseHelp.HELP_ID_EMERGENCIES then
return {		
headerLangId = Fox.StrCode("mbhelp_name_279"), headerInfoLangId = Fox.StrCode("mbhelp_info_279"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_271"), helpMessageId = Fox.StrCode("mbhelp_info_271"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 306 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_270"), helpMessageId = Fox.StrCode("mbhelp_info_270"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 530, iconPosY = 114 },
	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_272"), helpMessageId = Fox.StrCode("mbhelp_info_272"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 800, iconPosY = 306 },

	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_REWARDS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_290"), headerInfoLangId = Fox.StrCode("mbhelp_info_290"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_292"), helpMessageId = Fox.StrCode("mbhelp_info_292"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 598, iconPosY = 333 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_295"), helpMessageId = Fox.StrCode("mbhelp_info_295"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_294"), helpMessageId = Fox.StrCode("mbhelp_info_294"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPLY_WEAPON then
return {		
headerLangId = Fox.StrCode("mbhelp_name_299"), headerInfoLangId = Fox.StrCode("mbhelp_info_299"),	
pages = {	


	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_302"), helpMessageId = Fox.StrCode("mbhelp_info_302"), helpPosX =X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 350 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_301"), helpMessageId = Fox.StrCode("mbhelp_info_191"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 97 },
	{ type = 1, textAreaType = TEXT_SHORT },


	{ type = 0, number = 5, titleLangId = Fox.StrCode("mbhelp_name_051"), helpMessageId = Fox.StrCode("mbhelp_info_051"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 347 },
	{ type = 1, textAreaType = TEXT_SHORT },















	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_062"), helpMessageId = Fox.StrCode("mbhelp_info_062"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_063"), helpMessageId = Fox.StrCode("mbhelp_info_063"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_064"), helpMessageId = Fox.StrCode("mbhelp_info_064"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_065"), helpMessageId = Fox.StrCode("mbhelp_info_065"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_066"), helpMessageId = Fox.StrCode("mbhelp_info_066"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_067"), helpMessageId = Fox.StrCode("mbhelp_info_067"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_068"), helpMessageId = Fox.StrCode("mbhelp_info_068"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_069"), helpMessageId = Fox.StrCode("mbhelp_info_069"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_070"), helpMessageId = Fox.StrCode("mbhelp_info_070"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },




} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPLY_LOADOUT then
return {		
headerLangId = Fox.StrCode("mbhelp_name_320"), headerInfoLangId = Fox.StrCode("mbhelp_info_320"),	
pages = {	
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_324"), helpMessageId = Fox.StrCode("mbhelp_info_324"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 850, iconPosY = 340 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_323"), helpMessageId = Fox.StrCode("mbhelp_info_323"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 200 },

	{ type = 1, textAreaType = TEXT_SHORT },



	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_062"), helpMessageId = Fox.StrCode("mbhelp_info_062"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_063"), helpMessageId = Fox.StrCode("mbhelp_info_063"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_064"), helpMessageId = Fox.StrCode("mbhelp_info_064"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_065"), helpMessageId = Fox.StrCode("mbhelp_info_065"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_066"), helpMessageId = Fox.StrCode("mbhelp_info_066"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_067"), helpMessageId = Fox.StrCode("mbhelp_info_067"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPLY_VEHICLE then
return {		
headerLangId = Fox.StrCode("mbhelp_name_343"), headerInfoLangId = Fox.StrCode("mbhelp_info_343"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_346"), helpMessageId = Fox.StrCode("mbhelp_info_346"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 500, iconPosY = 310 },

	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CALL_BUDDY_QUIET then
return {		
headerLangId = Fox.StrCode("mbhelp_name_350"), headerInfoLangId = Fox.StrCode("mbhelp_info_350"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_352_2"), helpMessageId = Fox.StrCode("mbhelp_info_352_2"), helpPosX = X_LEFT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_354"), helpMessageId = Fox.StrCode("mbhelp_info_354"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CALL_BUDDY_QUIET_ATTACK then
return {		
headerLangId = Fox.StrCode("mbhelp_name_350_2"), headerInfoLangId = Fox.StrCode("mbhelp_info_350_2"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_352_3"), helpMessageId = Fox.StrCode("mbhelp_info_352_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_354"), helpMessageId = Fox.StrCode("mbhelp_info_354"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CALL_BUDDY_DOG then
return {		
headerLangId = Fox.StrCode("mbhelp_name_358"), headerInfoLangId = Fox.StrCode("mbhelp_info_358"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_352_4"), helpMessageId = Fox.StrCode("mbhelp_info_352_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_362"), helpMessageId = Fox.StrCode("mbhelp_info_362"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },




} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CALL_BUDDY_HORSE then
return {		
headerLangId = Fox.StrCode("mbhelp_name_366"), headerInfoLangId = Fox.StrCode("mbhelp_info_366"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_352_4"), helpMessageId = Fox.StrCode("mbhelp_info_352_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_370"), helpMessageId = Fox.StrCode("mbhelp_info_370"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },





} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CALL_BUDDY_WALKER then
return {		
headerLangId = Fox.StrCode("mbhelp_name_374"), headerInfoLangId = Fox.StrCode("mbhelp_info_374"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_352_4"), helpMessageId = Fox.StrCode("mbhelp_info_352_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_378"), helpMessageId = Fox.StrCode("mbhelp_info_378"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },







} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_ARTILLERY then
return {		
headerLangId = Fox.StrCode("mbhelp_name_382"), headerInfoLangId = Fox.StrCode("mbhelp_info_382"),	
pages = {
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_384"), helpMessageId = Fox.StrCode("mbhelp_info_384"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_SMOKE then
return {		
headerLangId = Fox.StrCode("mbhelp_name_388"), headerInfoLangId = Fox.StrCode("mbhelp_info_388"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_390"), helpMessageId = Fox.StrCode("mbhelp_info_384"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_GAS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_394"), headerInfoLangId = Fox.StrCode("mbhelp_info_394"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_396"), helpMessageId = Fox.StrCode("mbhelp_info_384"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_CHAFF then
return {		
headerLangId = Fox.StrCode("mbhelp_name_400"), headerInfoLangId = Fox.StrCode("mbhelp_info_400"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_402"), helpMessageId = Fox.StrCode("mbhelp_info_384"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_HELI then
return {		
headerLangId = Fox.StrCode("mbhelp_name_406"), headerInfoLangId = Fox.StrCode("mbhelp_info_406"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_408"), helpMessageId = Fox.StrCode("mbhelp_info_408"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_HELI_ATTACK then
return {		
headerLangId = Fox.StrCode("mbhelp_name_412"), headerInfoLangId = Fox.StrCode("mbhelp_info_412"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_414"), helpMessageId = Fox.StrCode("mbhelp_info_384"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 620, iconPosY = 360 },
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS or HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_EM then
return {		
headerLangId = Fox.StrCode("mbhelp_name_418"), headerInfoLangId = Fox.StrCode("mbhelp_info_418"),	
pages = {	


	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_421_2"), helpMessageId = Fox.StrCode("mbhelp_info_421_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 330 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_420"), helpMessageId = Fox.StrCode("mbhelp_info_420"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 135 },
	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_426"), helpMessageId = Fox.StrCode("mbhelp_info_426"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_247_3"), helpMessageId = Fox.StrCode("mbhelp_info_247_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 830, iconPosY = 170 },
	{ type = 1, textAreaType = TEXT_SHORT },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_098_2"), helpMessageId = Fox.StrCode("mbhelp_info_098"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 500 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_422"), helpMessageId = Fox.StrCode("mbhelp_info_422"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_LONG },
} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_SEL_FOB or HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_EM_SEL_FOB then
return {		
headerLangId = Fox.StrCode("mbhelp_name_418"), headerInfoLangId = Fox.StrCode("mbhelp_info_418"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_421"), helpMessageId = Fox.StrCode("mbhelp_info_421"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 520, iconPosY = 300 },

	


	{ type = 1, textAreaType = TEXT_SHORT },






} 	
}



elseif HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_SEL_PF or HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_EM_SEL_PF then
return {		
headerLangId = Fox.StrCode("mbhelp_name_418"), headerInfoLangId = Fox.StrCode("mbhelp_info_418"),	
pages = {	


	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_422_3"), helpMessageId = Fox.StrCode("mbhelp_info_422_3"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 550 },
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_421_3"), helpMessageId = Fox.StrCode("mbhelp_info_421_3"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 330 },

	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_426"), helpMessageId = Fox.StrCode("mbhelp_info_426"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_095_3"), helpMessageId = Fox.StrCode("mbhelp_info_095_3"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 220 },


	{ type = 1, textAreaType = TEXT_LONG },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_098_2"), helpMessageId = Fox.StrCode("mbhelp_info_098"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 500 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_422"), helpMessageId = Fox.StrCode("mbhelp_info_422"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_LONG },
} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_SEL_LZ or HelpID == MbPauseHelp.HELP_ID_FOB_MISSIONS_EM_SEL_LZ then
return {		
headerLangId = Fox.StrCode("mbhelp_name_418"), headerInfoLangId = Fox.StrCode("mbhelp_info_418"),	
pages = {	





	
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_426_2"), helpMessageId = Fox.StrCode("mbhelp_info_426_2"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },



	{ type = 0, number = 4, titleLangId = Fox.StrCode("mbhelp_name_095_4"), helpMessageId = Fox.StrCode("mbhelp_info_095_4"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 980, iconPosY = 240 },


	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}




elseif HelpID == MbPauseHelp.HELP_ID_CHANGE_LOCATION then
return {		
headerLangId = Fox.StrCode("mbhelp_name_431"), headerInfoLangId = Fox.StrCode("mbhelp_info_431"),	
pages = {	
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_433"), helpMessageId = Fox.StrCode("mbhelp_info_433"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 686, iconPosY = 321 },
	
	{ type = 1, textAreaType = TEXT_SHORT },
} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_FRIENDS_RIVALS then
return {		
headerLangId = Fox.StrCode("mbhelp_name_438"), headerInfoLangId = Fox.StrCode("mbhelp_info_438"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_441"), helpMessageId = Fox.StrCode("mbhelp_info_441"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 330 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_440"), helpMessageId = Fox.StrCode("mbhelp_info_440"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 135 },


	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_444"), helpMessageId = Fox.StrCode("mbhelp_info_444"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
	



	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_247_3"), helpMessageId = Fox.StrCode("mbhelp_info_247_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 830, iconPosY = 170 },
	{ type = 1, textAreaType = TEXT_SHORT },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_098_2"), helpMessageId = Fox.StrCode("mbhelp_info_098"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 500 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_422_4"), helpMessageId = Fox.StrCode("mbhelp_info_422_4"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_447"), helpMessageId = Fox.StrCode("mbhelp_info_447"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_448"), helpMessageId = Fox.StrCode("mbhelp_info_448"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },
} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_FRIENDS_RIVALS_ENEMY then
return {		
headerLangId = Fox.StrCode("mbhelp_name_438"), headerInfoLangId = Fox.StrCode("mbhelp_info_438"),	
pages = {	
	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_441"), helpMessageId = Fox.StrCode("mbhelp_info_441"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 330 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_440"), helpMessageId = Fox.StrCode("mbhelp_info_440"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 135 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_445"), helpMessageId = Fox.StrCode("mbhelp_info_445"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_444"), helpMessageId = Fox.StrCode("mbhelp_info_444"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },
	



	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_247_3"), helpMessageId = Fox.StrCode("mbhelp_info_247_3"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 830, iconPosY = 170 },
	{ type = 1, textAreaType = TEXT_SHORT },
	{ type = 0, number = 6, titleLangId = Fox.StrCode("mbhelp_name_098_2"), helpMessageId = Fox.StrCode("mbhelp_info_098"), helpPosX = X_LEFT_LONG, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 500 },
	{ type = 0, number = 3, titleLangId = Fox.StrCode("mbhelp_name_422"), helpMessageId = Fox.StrCode("mbhelp_info_422"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 933, iconPosY = 350 },
	{ type = 1, textAreaType = TEXT_LONG },

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_PF_RATING then
return {		
headerLangId = Fox.StrCode("mbhelp_name_add_33"), headerInfoLangId = Fox.StrCode("mbhelp_name_add_34"),	
pages = {	

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_add_39"), helpMessageId = Fox.StrCode("mbhelp_name_add_40"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 570 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_add_37"), helpMessageId = Fox.StrCode("mbhelp_name_add_38"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 330 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_add_35"), helpMessageId = Fox.StrCode("mbhelp_name_add_36"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 550, iconPosY = 135 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_add_43"), helpMessageId = Fox.StrCode("mbhelp_name_add_44"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_add_41"), helpMessageId = Fox.StrCode("mbhelp_name_add_42"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 820, iconPosY = 300 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_add_45"), helpMessageId = Fox.StrCode("mbhelp_name_add_46"), helpPosX = X_RIGHT_LONG, helpPosY = Y_LEFT, coordType = COORD_ABS, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_add_47"), helpMessageId = Fox.StrCode("mbhelp_name_add_48"), helpPosX = 0, helpPosY = Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_TOP, iconPosX = 0, iconPosY = 0 },
	{ type = 1, textAreaType = TEXT_LONG },

} 	
}



elseif HelpID == MbPauseHelp.HELP_ID_SORTIE_PREP then
return {		
headerLangId = Fox.StrCode("mbhelp_name_add_17"), headerInfoLangId = Fox.StrCode("mbhelp_name_add_18"),	
pages = {	

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_add_21"), helpMessageId = Fox.StrCode("mbhelp_name_add_22"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 530 },
	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_add_19"), helpMessageId = Fox.StrCode("mbhelp_name_add_20"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 250 },
	{ type = 1, textAreaType = TEXT_SHORT },

	{ type = 0, number = 2, titleLangId = Fox.StrCode("mbhelp_name_add_25"), helpMessageId = Fox.StrCode("mbhelp_name_add_26"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 400, iconPosY = 610 },
	{ type = 1, textAreaType = TEXT_SHORT },



	{ type = 0, number = 1, titleLangId = Fox.StrCode("mbhelp_name_add_23"), helpMessageId = Fox.StrCode("mbhelp_name_add_24"), helpPosX = X_LEFT_SHORT, helpPosY = Y_LEFT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 820, iconPosY = 300 },

	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_add_31"), helpMessageId = Fox.StrCode("mbhelp_name_add_32"), helpPosX = X_RIGHT_SHORT, helpPosY = Y_RIGHT_BOTTOM, coordType = COORD_ABS, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },
	{ type = 0, number = 0, titleLangId = Fox.StrCode("mbhelp_name_add_29"), helpMessageId = Fox.StrCode("mbhelp_name_add_30"), helpPosX = 0, helpPosY = -Y_INTERVAL, coordType = COORD_REL, verticalAlign = ALIGN_BOTTOM, iconPosX = 0, iconPosY = 0 },

	{ type = 1, textAreaType = TEXT_SHORT },




} 	
}


elseif HelpID == MbPauseHelp.HELP_ID_SORTIE_PREP_SUB then
return {		
headerLangId = Fox.StrCode("mbhelp_sortie_0_name"), headerInfoLangId = Fox.StrCode("mbhelp_sortie_0_info"),	
pages = {	

} 	
}

elseif HelpID == MbPauseHelp.HELP_ID_CHANGE_EQUIPMENT then
return {		
headerLangId = Fox.StrCode("mbhelp_name_add_5"), headerInfoLangId = Fox.StrCode("mbhelp_name_add_6"),	
pages = {	

} 	
}



elseif HelpID == MbPauseHelp.HELP_ID_SUPPORT_HELI_RETURN then
return {		
headerLangId = Fox.StrCode("mbhelp_name_452"), headerInfoLangId = Fox.StrCode("mbhelp_info_452"),	
pages = {	
} 
}


end

	end,
}