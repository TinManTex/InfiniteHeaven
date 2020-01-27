local mafr_travelPlans = {}








mafr_travelPlans.lrrpNumberDefine = Tpp.Enum{--travel#
	"mafr_outlandNorth_ob",--1
	"mafr_swampWest_ob",--2
	"mafr_outlandEast_ob",--3
	"mafr_bananaSouth_ob",--4
	"mafr_swampSouth_ob",--5
	"mafr_swampEast_ob",--6
	"mafr_savannahWest_ob",--7
	"mafr_bananaEast_ob",--8
	"mafr_savannahNorth_ob",--9
	"mafr_diamondWest_ob",--10
	"mafr_diamondSouth_ob",--11
	"mafr_hillNorth_ob",--12
	"mafr_savannahEast_ob",--13
	"mafr_hillWest_ob",--14
	"mafr_pfCampEast_ob",--15
	"mafr_pfCampNorth_ob",--16
	"mafr_factorySouth_ob",--17
	"mafr_diamondNorth_ob",--18
	"mafr_labWest_ob",--19
	"mafr_outland_cp",--20
	"mafr_flowStation_cp",--21
	"mafr_swamp_cp",--22
	"mafr_pfCamp_cp",--23
	"mafr_savannah_cp",--24
	"mafr_banana_cp",--25
	"mafr_diamond_cp",--26
	"mafr_hill_cp",--27
	"mafr_factory_cp",--28
	"mafr_lab_cp",--29
	"mafr_hillWestNear_ob",--30
	"mafr_hillSouth_ob",--31
	"mafr_swampWestNear_ob",--32
	"mafr_chicoVilWest_ob",--33
	"mafr_chicoVil_cp",--34
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
