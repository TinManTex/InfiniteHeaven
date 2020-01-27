local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
	
	cp_swamp_vip = {
		"sol_mis_0000",
		nil
	},
	
	cp_savannah = {
		"sol_mis_0004",
		"sol_mis_0005",
		"sol_mis_0006",
		nil
	},
	nil
}





this.routeSets = {
	
	cp_swamp_vip = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"route_swamp_vip",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"route_swamp_vip",
			},
			nil
		},
		caution = {
			groupA = {
				"route_swamp_vip",
			},
			nil
		},
		hold = {
			default = {
				"route_swamp_vip",
			},
		},
		nil
	},
	
	cp_savannah = {
		
		
		
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"savannah_route_d01_0000",
				"savannah_route_d01_0001",
				"savannah_route_d01_0002",
				"savannah_route_d01_0003",
			},
			groupB = {
				"savannah_route_d01_0004",
				"savannah_route_d01_0005",
				"savannah_route_d01_0006",
				"savannah_route_d01_0007",
			},
			groupC = {
				"savannah_route_d01_0008",
				"savannah_route_d01_0009",
				"savannah_route_d01_0010",
				"savannah_route_d01_0011",
			},
			groupD = {
				"savannah_route_d01_0012",
				"savannah_route_d01_0013",
			}
		},
		sneak_night= {
			groupA = {
				"savannah_route_d01_0000",
				"savannah_route_d01_0001",
				"savannah_route_d01_0002",
				"savannah_route_d01_0003",
			},
			groupB = {
				"savannah_route_d01_0004",
				"savannah_route_d01_0005",
				"savannah_route_d01_0006",
				"savannah_route_d01_0007",
			},
			groupC = {
				"savannah_route_d01_0008",
				"savannah_route_d01_0009",
				"savannah_route_d01_0010",
				"savannah_route_d01_0011",
			},
			groupD = {
				"savannah_route_d01_0012",
				"savannah_route_d01_0013",
			}
		},
		caution = {
			groupA = {
				"savannah_route_d01_0000",
				"savannah_route_d01_0001",
				"savannah_route_d01_0002",
				"savannah_route_d01_0003",
			},
			groupB = {
				"savannah_route_d01_0004",
				"savannah_route_d01_0005",
				"savannah_route_d01_0006",
				"savannah_route_d01_0007",
			},
			groupC = {
				"savannah_route_d01_0008",
				"savannah_route_d01_0009",
				"savannah_route_d01_0010",
				"savannah_route_d01_0011",
			},
			groupD = {
				"savannah_route_d01_0012",
				"savannah_route_d01_0013",
			}
		},
		hold = {
			
			
			default = {
				"savannah_route_d01_0000",
				"savannah_route_d01_0001",
				"savannah_route_d01_0002",
				"savannah_route_d01_0003",
			},
		},
		nil
	},
	nil
}





this.combatSetting = {
	cp_savannah = {
		"TppGuardTargetData0000",
		"TppCombatLocatorSetData0000",
	},
	cp_swamp = {
		"TppGuardTargetData0001",
		"TppCombatLocatorSetData0001",
	},
	nil
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )
end


this.OnLoad = function ()
	Fox.Log("*** s10211 onload ***")
end




return this
