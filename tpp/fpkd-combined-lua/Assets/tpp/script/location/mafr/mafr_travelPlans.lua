local mafr_travelPlans = {}








mafr_travelPlans.lrrpNumberDefine = Tpp.Enum{
	"mafr_outlandNorth_ob",
	"mafr_swampWest_ob",
	"mafr_outlandEast_ob",
	"mafr_bananaSouth_ob",
	"mafr_swampSouth_ob",
	"mafr_swampEast_ob",
	"mafr_savannahWest_ob",
	"mafr_bananaEast_ob",
	"mafr_savannahNorth_ob",
	"mafr_diamondWest_ob",
	"mafr_diamondSouth_ob",
	"mafr_hillNorth_ob",
	"mafr_savannahEast_ob",
	"mafr_hillWest_ob",
	"mafr_pfCampEast_ob",
	"mafr_pfCampNorth_ob",
	"mafr_factorySouth_ob",
	"mafr_diamondNorth_ob",
	"mafr_labWest_ob",
	"mafr_outland_cp",
	"mafr_flowStation_cp",
	"mafr_swamp_cp",
	"mafr_pfCamp_cp",
	"mafr_savannah_cp",
	"mafr_banana_cp",
	"mafr_diamond_cp",
	"mafr_hill_cp",
	"mafr_factory_cp",
	"mafr_lab_cp",
	"mafr_hillWestNear_ob",
	"mafr_hillSouth_ob",
	"mafr_swampWestNear_ob",
	"mafr_chicoVilWest_ob",
	"mafr_chicoVil_cp",
}




mafr_travelPlans.cpLinkMatrix = {
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	1	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	1	0	0",
"0	0	0	0	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0",
"0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0",
"0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	1	0	0	0	1	0	0	1	1	0	0	0",
"0	0	0	0	1	1	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0",
"1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0",
"0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0",
"0	0	0	0	0	1	1	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	1	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0",
"0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0",
"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
}











mafr_travelPlans.reinforceTravelPlan = {
	mafr_flowStation_cp = {
		"mafr_swampWest_ob",
	},
	mafr_outland_cp = {
		"mafr_outlandNorth_ob",
		"mafr_outlandEast_ob",
	},
	mafr_swamp_cp = {
		"mafr_swampWest_ob",
		"mafr_swampEast_ob",
	},
	mafr_pfCamp_cp = {
		"mafr_pfCampNorth_ob",
	},
	mafr_savannah_cp = {
		"mafr_swampEast_ob",
		"mafr_savannahEast_ob",
	},
	mafr_banana_cp = {
		"mafr_bananaEast_ob",
	},
	mafr_diamond_cp = {
		"mafr_diamondWest_ob",
		"mafr_diamondNorth_ob",
	},
	mafr_hill_cp = {
		"mafr_factorySouth_ob",
		"mafr_hillWestNear_ob",
	},
	mafr_lab_cp = {
		"mafr_labWest_ob",
	},
}

return mafr_travelPlans
