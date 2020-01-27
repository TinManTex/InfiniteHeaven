-- DOBUILD: 0 --DEBUGWIP
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\mission2\free\f30050\f30050_ly003.fpkd


local this = {}



















































































































































































































































































































































this.enemyAssetTable = {
	{--0--1--command
	
		plnt0 = {
			soldierList = {
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0002",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0003",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0004",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0001",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0002",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0003",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0004",
							"ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0005",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			--tex was empty> DEBUGWIP
      uavList = {
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|uav_0000",
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|uav_0001",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|uav_0000",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|uav_0001",
      },
      uavSneakRoute = {
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|rt_ptl_0000",
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|rt_ptl_0001",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|rts_around_0to7_ptl_0000",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|rts_around_7to0_ptl_0000",
      },
      uavCombatRoute = {
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|rt_cbt_0000",
        "ly013_cl00_uav0000|cl00pl0_uq_0000_uav|rt_cbt_0001",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|rts_lower_cbt_0000",
        "ly013_cl00_uav0000|cl00pl0_mb_fndt_plnt_uav|rts_upper_cbt_0000",
      },
      --<
			mineList = {
			},
			decyList = {
			},
			--DEBUGWIP
      securityCameraList = {
         { camera = "ly013_cl00_camera0000|cl00pl0_mb_fndt_plnt_camera|scm_cp00",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_mb_fndt_plnt_camera|scm_cp01",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_mb_fndt_plnt_camera|scm_cp05",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_mb_fndt_plnt_camera|scm_cp07",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_uq_0000_camera|scm_0002",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_uq_0000_camera|scm_0003",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_uq_0000_camera|scm_0001",target = nil },
         { camera = "ly013_cl00_camera0000|cl00pl0_uq_0000_camera|scm_0000",target = nil },

      },
		},
		plnt1 = {
			soldierList = {
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl1_0_dv_0090_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl1_0_dv_0090_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl1_1_dv_0080_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl1_1_dv_0080_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl1_1_dv_0080_free|rt_free_d_0002",
							
							"ly003_cl00_route0000|cl00pl1_2_dv_0030_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl1_2_dv_0030_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl1_2_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl00_route0000|cl00pl1_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl1_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl1_0_dv_0090_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl1_0_dv_0090_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl1_1_dv_0080_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl1_1_dv_0080_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl1_2_dv_0030_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl1_2_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl1_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl00_route0000|cl00pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
      uavList = {
      },
      uavSneakRoute = {
      },
      uavCombatRoute = {
      },
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl2_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl00_route0000|cl00pl2_2_dv_0030_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_2_dv_0030_free|rt_free_d_0001",
							"ly003_cl00_route0000|cl00pl2_2_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl00_route0000|cl00pl2_3_dv_0040_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_3_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl2_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_n_0001",
							"ly003_cl00_route0000|cl00pl2_1_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl00_route0000|cl00pl2_2_dv_0030_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl2_2_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl2_3_dv_0040_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl2_3_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
      uavList = {
      },
      uavSneakRoute = {
      },
      uavCombatRoute = {
      },
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt3_0000",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt3_0001",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt3_0002",
				"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt3_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl3_0_dv_0100_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl3_0_dv_0100_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl3_1_dv_0110_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl3_1_dv_0110_free|rt_free_d_0001",
							
							
							"ly003_cl00_route0000|cl00pl3_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl3_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl00_route0000|cl00pl3_0_dv_0100_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl3_0_dv_0100_free|rt_free_n_0001",
							
							"ly003_cl00_route0000|cl00pl3_1_dv_0110_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl3_1_dv_0110_free|rt_free_n_0001",
							
							
							"ly003_cl00_route0000|cl00pl3_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl00_route0000|cl00pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
      uavList = {
      },
      uavSneakRoute = {
      },
      uavCombatRoute = {
      },
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0000",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0001",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0002",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0003",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0004",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt0_0005",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0002",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0003",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0004",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0001",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0002",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0003",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0004",
							"ly003_cl01_route0000|cl01pl0_uq_0010_free|rt_free_n_0005",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt1_0000",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt1_0001",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt1_0002",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt1_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl1_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl1_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl01_route0000|cl01pl1_1_dv_0020_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl1_1_dv_0020_free|rt_free_d_0001",
							
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl01_route0000|cl01pl1_3_dv_0070_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl1_3_dv_0070_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl1_3_dv_0070_free|rt_free_d_0002",
							
							"ly003_cl01_route0000|cl01pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl1_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl01_route0000|cl01pl1_1_dv_0020_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl1_1_dv_0020_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_n_0001",
							"ly003_cl01_route0000|cl01pl1_2_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl01_route0000|cl01pl1_3_dv_0070_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl1_3_dv_0070_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt2_0000",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt2_0001",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt2_0002",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt2_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl2_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl2_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl01_route0000|cl01pl2_1_dv_0100_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl2_1_dv_0100_free|rt_free_d_0001",
							
							"ly003_cl01_route0000|cl01pl2_2_dv_0060_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl2_2_dv_0060_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl2_2_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl01_route0000|cl01pl2_3_dv_0030_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl2_3_dv_0030_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl2_3_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl01_route0000|cl01pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl2_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl01_route0000|cl01pl2_1_dv_0100_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl2_1_dv_0100_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl2_2_dv_0060_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl2_2_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl2_3_dv_0030_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl2_3_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt3_0000",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt3_0001",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt3_0002",
				"ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|sol_plnt3_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl3_0_dv_0060_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl3_0_dv_0060_free|rt_free_d_0001",
							"ly003_cl01_route0000|cl01pl3_0_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl01_route0000|cl01pl3_1_dv_0110_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl3_1_dv_0110_free|rt_free_d_0001",
							
							
							"ly003_cl01_route0000|cl01pl3_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl3_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl01_route0000|cl01pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl01_route0000|cl01pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl01_route0000|cl01pl3_0_dv_0060_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl3_0_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl01_route0000|cl01pl3_1_dv_0110_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl3_1_dv_0110_free|rt_free_n_0001",
							
							
							"ly003_cl01_route0000|cl01pl3_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl01_route0000|cl01pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl01_route0000|cl01pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0000",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0001",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0002",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0003",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0004",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt0_0005",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0001",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0002",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0003",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0004",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_d_0005",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0001",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0002",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0003",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0004",
							"ly003_cl02_route0000|cl02pl0_uq_0020_free|rt_free_n_0005",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt1_0000",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt1_0001",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt1_0002",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt1_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl1_0_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_d_0001",
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl02_route0000|cl02pl1_2_dv_0040_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl1_2_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl1_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl1_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl1_0_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_n_0001",
							"ly003_cl02_route0000|cl02pl1_1_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl02_route0000|cl02pl1_2_dv_0040_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl1_2_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl02_route0000|cl02pl1_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl02_route0000|cl02pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt2_0000",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt2_0001",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt2_0002",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt2_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl2_0_dv_0070_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl2_0_dv_0070_free|rt_free_d_0001",
							"ly003_cl02_route0000|cl02pl2_0_dv_0070_free|rt_free_d_0002",
							
							"ly003_cl02_route0000|cl02pl2_1_dv_0030_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl2_1_dv_0030_free|rt_free_d_0001",
							"ly003_cl02_route0000|cl02pl2_1_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_d_0001",
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl02_route0000|cl02pl2_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl2_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl2_0_dv_0070_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl2_0_dv_0070_free|rt_free_n_0001",
							
							"ly003_cl02_route0000|cl02pl2_1_dv_0030_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl2_1_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_n_0001",
							"ly003_cl02_route0000|cl02pl2_2_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl02_route0000|cl02pl2_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl02_route0000|cl02pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt3_0003",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt3_0002",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt3_0001",
				"ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|sol_plnt3_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl3_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl3_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl3_1_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl02_route0000|cl02pl3_2_dv_0040_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl3_2_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl3_3_dv_0020_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl3_3_dv_0020_free|rt_free_d_0001",
							
							"ly003_cl02_route0000|cl02pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl02_route0000|cl02pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl02_route0000|cl02pl3_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl02_route0000|cl02pl3_1_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl02_route0000|cl02pl3_2_dv_0040_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl3_2_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl02_route0000|cl02pl3_3_dv_0020_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl3_3_dv_0020_free|rt_free_n_0001",
							
							"ly003_cl02_route0000|cl02pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl02_route0000|cl02pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0000",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0001",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0002",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0003",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0004",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt0_0005",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0001",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0002",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0003",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0004",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0001",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0002",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0003",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0004",
							"ly003_cl03_route0000|cl03pl0_uq_0030_free|rt_free_n_0005",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt1_0000",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt1_0001",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt1_0002",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt1_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl1_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl1_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl1_1_dv_0040_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl1_1_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl1_2_dv_0020_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl1_2_dv_0020_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_d_0001",
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl03_route0000|cl03pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl1_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl03_route0000|cl03pl1_1_dv_0040_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl1_1_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl1_2_dv_0020_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl1_2_dv_0020_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_n_0001",
							"ly003_cl03_route0000|cl03pl1_3_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl03_route0000|cl03pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt2_0000",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt2_0001",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt2_0002",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt2_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl2_0_dv_0100_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl2_0_dv_0100_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl2_1_dv_0060_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl2_1_dv_0060_free|rt_free_d_0001",
							"ly003_cl03_route0000|cl03pl2_1_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl03_route0000|cl03pl2_2_dv_0030_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl2_2_dv_0030_free|rt_free_d_0001",
							"ly003_cl03_route0000|cl03pl2_2_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl03_route0000|cl03pl2_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl2_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl2_0_dv_0100_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl2_0_dv_0100_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl2_1_dv_0060_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl2_1_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl2_2_dv_0030_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl2_2_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl2_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl03_route0000|cl03pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt3_0000",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt3_0001",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt3_0002",
				"ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|sol_plnt3_0003",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl3_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl3_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl3_1_dv_0080_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl3_1_dv_0080_free|rt_free_d_0001",
							"ly003_cl03_route0000|cl03pl3_1_dv_0080_free|rt_free_d_0002",
							
							"ly003_cl03_route0000|cl03pl3_2_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl03_route0000|cl03pl3_3_dv_0090_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl3_3_dv_0090_free|rt_free_d_0001",
							
							"ly003_cl03_route0000|cl03pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl03_route0000|cl03pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl03_route0000|cl03pl3_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl03_route0000|cl03pl3_1_dv_0080_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl3_1_dv_0080_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl3_2_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl03_route0000|cl03pl3_3_dv_0090_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl3_3_dv_0090_free|rt_free_n_0001",
							
							"ly003_cl03_route0000|cl03pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl03_route0000|cl03pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0005",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0004",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0003",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0002",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0001",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0000",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0001",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0002",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0003",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0004",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0001",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0002",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0003",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0003",
							"ly003_cl04_route0000|cl04pl0_uq_0040_free|rt_free_n_0003",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt1_0003",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt1_0002",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt1_0001",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt1_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl1_0_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl04_route0000|cl04pl1_1_dv_0060_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl1_1_dv_0060_free|rt_free_d_0001",
							"ly003_cl04_route0000|cl04pl1_1_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl04_route0000|cl04pl1_2_dv_0070_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl1_2_dv_0070_free|rt_free_d_0001",
							"ly003_cl04_route0000|cl04pl1_2_dv_0070_free|rt_free_d_0002",
							
							"ly003_cl04_route0000|cl04pl1_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl1_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl1_0_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl04_route0000|cl04pl1_1_dv_0060_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl1_1_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl1_2_dv_0070_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl1_2_dv_0070_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl1_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl04_route0000|cl04pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt2_0003",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt2_0002",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt2_0001",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt2_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl2_0_dv_0020_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl2_0_dv_0020_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl2_1_dv_0060_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl2_1_dv_0060_free|rt_free_d_0001",
							"ly003_cl04_route0000|cl04pl2_1_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl04_route0000|cl04pl2_2_dv_0100_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl2_2_dv_0100_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl2_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl2_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl2_0_dv_0020_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl2_0_dv_0020_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl2_1_dv_0060_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl2_1_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl2_2_dv_0100_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl2_2_dv_0100_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl2_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl04_route0000|cl04pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt3_0003",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt3_0002",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt3_0001",
				"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt3_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl3_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl3_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl3_1_dv_0090_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl3_1_dv_0090_free|rt_free_d_0001",
							
							"ly003_cl04_route0000|cl04pl3_2_dv_0080_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl3_2_dv_0080_free|rt_free_d_0001",
							"ly003_cl04_route0000|cl04pl3_2_dv_0080_free|rt_free_d_0002",
							
							"ly003_cl04_route0000|cl04pl3_3_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl04_route0000|cl04pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl04_route0000|cl04pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl04_route0000|cl04pl3_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl04_route0000|cl04pl3_1_dv_0090_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl3_1_dv_0090_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl3_2_dv_0080_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl3_2_dv_0080_free|rt_free_n_0001",
							
							"ly003_cl04_route0000|cl04pl3_3_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl04_route0000|cl04pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl04_route0000|cl04pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0005",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0004",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0003",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0002",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0001",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt0_0000",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0002",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0003",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0004",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0001",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0002",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0003",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0004",
							"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_free_n_0005",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt1_0003",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt1_0002",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt1_0001",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt1_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl1_0_dv_0080_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl1_0_dv_0080_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl1_0_dv_0080_free|rt_free_d_0002",
							
							"ly003_cl05_route0000|cl05pl1_1_dv_0060_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl1_1_dv_0060_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl1_1_dv_0060_free|rt_free_d_0002",
							
							"ly003_cl05_route0000|cl05pl1_2_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl05_route0000|cl05pl1_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl1_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl1_0_dv_0080_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl1_0_dv_0080_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl1_1_dv_0060_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl1_1_dv_0060_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl1_2_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl05_route0000|cl05pl1_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl05_route0000|cl05pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt2_0003",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt2_0002",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt2_0001",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt2_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl2_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl2_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl2_1_dv_0090_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl2_1_dv_0090_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl2_2_dv_0070_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl2_2_dv_0070_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl2_2_dv_0070_free|rt_free_d_0002",
							
							"ly003_cl05_route0000|cl05pl2_3_dv_0040_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl2_3_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl2_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl05_route0000|cl05pl2_1_dv_0090_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl2_1_dv_0090_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl2_2_dv_0070_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl2_2_dv_0070_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl2_3_dv_0040_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl2_3_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt3_0003",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt3_0002",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt3_0001",
				"ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|sol_plnt3_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl3_0_dv_0070_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl3_0_dv_0070_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl3_0_dv_0070_free|rt_free_d_0002",
							
							"ly003_cl05_route0000|cl05pl3_1_dv_0020_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl3_1_dv_0020_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl3_2_dv_0030_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl3_2_dv_0030_free|rt_free_d_0001",
							"ly003_cl05_route0000|cl05pl3_2_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl05_route0000|cl05pl3_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl3_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl05_route0000|cl05pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl05_route0000|cl05pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl05_route0000|cl05pl3_0_dv_0070_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl3_0_dv_0070_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl3_1_dv_0020_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl3_1_dv_0020_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl3_2_dv_0030_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl3_2_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl05_route0000|cl05pl3_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl05_route0000|cl05pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl05_route0000|cl05pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},
	{
	
	
		plnt0 = {
			soldierList = {
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0005",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0004",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0003",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0002",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0001",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt0_0000",
			},
			soldierRouteList = {
				Sneak = {
					{
						inPlnt = {
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0001",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0002",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0003",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0004",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_d_0005",
						},
						outPlnt = {
						}
					},
				},
				Night = {
					{
						inPlnt = {
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0001",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0002",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0003",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0004",
							"ly003_cl06_route0000|cl06pl0_uq_0060_free|rt_free_n_0005",
						},
						outPlnt = {
						}
					},
				},
				Caution = {
					{
						inPlnt = {
						},
						outPlnt = {
						}
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt1 = {
			soldierList = {
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt1_0003",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt1_0002",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt1_0001",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt1_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl1_0_dv_0040_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl1_0_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_d_0001",
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_d_0002",
							
							"ly003_cl06_route0000|cl06pl1_2_dv_0090_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl1_2_dv_0090_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl1_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl1_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl1_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl1_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl1_0_dv_0040_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl1_0_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_n_0001",
							"ly003_cl06_route0000|cl06pl1_1_dv_0010_free|rt_free_n_0002",
							
							"ly003_cl06_route0000|cl06pl1_2_dv_0090_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl1_2_dv_0090_free|rt_free_n_0001",
							
							"ly003_cl06_route0000|cl06pl1_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl06_route0000|cl06pl1_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl1_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt2 = {
			soldierList = {
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt2_0003",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt2_0002",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt2_0001",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt2_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl2_0_dv_0000_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl2_0_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl2_1_dv_0080_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl2_1_dv_0080_free|rt_free_d_0001",
							"ly003_cl06_route0000|cl06pl2_1_dv_0080_free|rt_free_d_0002",
							
							"ly003_cl06_route0000|cl06pl2_2_dv_0050_free|rt_free_d_0000",
							
							"ly003_cl06_route0000|cl06pl2_3_dv_0030_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl2_3_dv_0030_free|rt_free_d_0001",
							"ly003_cl06_route0000|cl06pl2_3_dv_0030_free|rt_free_d_0002",
							
							"ly003_cl06_route0000|cl06pl2_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl2_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl2_0_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl06_route0000|cl06pl2_1_dv_0080_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl2_1_dv_0080_free|rt_free_n_0001",
							
							"ly003_cl06_route0000|cl06pl2_2_dv_0050_free|rt_free_n_0000",
							
							"ly003_cl06_route0000|cl06pl2_3_dv_0030_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl2_3_dv_0030_free|rt_free_n_0001",
							
							"ly003_cl06_route0000|cl06pl2_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl2_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
		plnt3 = {
			soldierList = {
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt3_0003",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt3_0002",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt3_0001",
				"ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|sol_plnt3_0000",
			},
			soldierRouteList = {
				Sneak = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl3_0_dv_0120_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl3_0_dv_0120_free|rt_free_d_0001",
							
							
							"ly003_cl06_route0000|cl06pl3_2_dv_0040_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl3_2_dv_0040_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl3_3_dv_0000_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl3_3_dv_0000_free|rt_free_d_0001",
							
							"ly003_cl06_route0000|cl06pl3_mb_fndt_plnt_free|rt_free_d_0000",
							"ly003_cl06_route0000|cl06pl3_mb_fndt_plnt_free|rt_free_d_0001",
						},
						outPlnt = {
						},
					},
				},
				Night = {
					{ 
						inPlnt = {
							
							"ly003_cl06_route0000|cl06pl3_0_dv_0120_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl3_0_dv_0120_free|rt_free_n_0001",
							
							
							"ly003_cl06_route0000|cl06pl3_2_dv_0040_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl3_2_dv_0040_free|rt_free_n_0001",
							
							"ly003_cl06_route0000|cl06pl3_3_dv_0000_free|rt_free_n_0000",
							
							"ly003_cl06_route0000|cl06pl3_mb_fndt_plnt_free|rt_free_n_0000",
							"ly003_cl06_route0000|cl06pl3_mb_fndt_plnt_free|rt_free_n_0001",
						},
						outPlnt = {
						},
					},
				},
				Caution = {
					{ 
						inPlnt = {
						},
						outPlnt = {
						},
					},
				},
			},
			uavList = {
			},
			uavSneakRoute = {
			},
			uavCombatRoute = {
			},
			mineList = {
			},
			decyList = {
			},
			securityCameraList = {
			},
		},
	
	},

}

this.itemTable = {
	
	{
		stolenAlarms = {
			
			0, 1,	1, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 1,	2, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 1,	3, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			0, 1,	4, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 1,	5, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			0, 1,	6, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			0, 1,	7, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			0, 1,	8, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			0, 1,	9, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 1, 110, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 1,  11, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 1,  12, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			0, 2,	2, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 2,	3, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 2,	4, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			0, 2,	5, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 2,	6, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			0, 2,	7, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			0, 2,	8, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			0, 2,	9, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			0, 2,  10, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 2, 111, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 2,  12, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 2,  13, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			0, 3,	3, "ly003_cl00_item0000|cl00pl3_0_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 3,	4, "ly003_cl00_item0000|cl00pl3_0_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 3,	5, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 3,	6, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 3,	7, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			0, 3,	8, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 3,	9, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			0, 3,  10, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			0, 3,  11, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			0, 3,  12, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			0, 3,  13, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			0, 3, 114, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			0, 3,  15, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			0, 3,  16, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			0, 1,	1, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			0, 1,	2, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			0, 1,	3, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			0, 1,	4, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			0, 1,	5, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			0, 1,	6, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			0, 1,	7, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			0, 1,	8, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			0, 1, 109, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			0, 1, 110, "ly003_cl00_item0000|cl00pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			0, 2,	2, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			0, 2,	3, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			0, 2,	4, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			0, 2,	5, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			0, 2,	6, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			0, 2,	7, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			0, 2,	8, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			0, 2,	9, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			0, 2, 110, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			0, 2, 111, "ly003_cl00_item0000|cl00pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			0, 3,	3, "ly003_cl00_item0000|cl00pl3_0_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			0, 3,	4, "ly003_cl00_item0000|cl00pl3_0_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			0, 3,	5, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			0, 3,	6, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			0, 3,	7, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			0, 3,	8, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			0, 3,	9, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			0, 3,  10, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			0, 3,  11, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			0, 3,  12, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			0, 3, 113, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			0, 3, 114, "ly003_cl00_item0000|cl00pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			0, 0, 600, "ly003_cl00_item0000|cl00pl0_uq_0000_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			0, 0, 601, "ly003_cl00_item0000|cl00pl0_uq_0000_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			0, 1, -299, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			0, 1, -298, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			0, 2, -298, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			0, 2, -297, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			0, 3, -297, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			0, 3, -296, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			0, 1, -299, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			0, 1, -298, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			0, 2, -298, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			0, 2, -297, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			0, 3, -297, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			0, 3, -296, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		slideDoors = {
			
			0, 0, 900, "ly003_cl00_item0000|cl00pl0_uq_0000_gimmick2|mtbs_door006_door002_gim_n0000|srt_mtbs_door006_door002",
		},
		irsensors = {
			
			0, 1, -299, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			0, 1, -298, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			0, 1, -97, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			0, 1, -296, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			0, 1, -295, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			0, 2, -298, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			0, 2, -297, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			0, 2, -96, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			0, 2, -295, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			0, 2, -294, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			0, 3, -297, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			0, 3, -296, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			0, 3, -95, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			0, 3, -294, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			0, 3, -293, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			0, 1,	1, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			0, 1, 102, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			0, 2,	2, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			0, 2, 103, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			0, 3,	3, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			0, 3, 104, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			0, 1,	1, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			0, 1,	2, "ly003_cl00_item0000|cl00pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			0, 2,	2, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			0, 2,	3, "ly003_cl00_item0000|cl00pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			0, 3,	3, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			0, 3,	4, "ly003_cl00_item0000|cl00pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			1, 0,	0, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 0, 101, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 0,	2, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 0,	3, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 1,	1, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 1,	2, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 1,	3, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			1, 1,	4, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 1,	5, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 1,	6, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			1, 1,	7, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			1, 1,	8, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			1, 1,	9, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 1, 110, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 1,  11, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 1,  12, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 2,	2, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 2,	3, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 2,	4, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			1, 2,	5, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 2,	6, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 2,	7, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			1, 2,	8, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			1, 2,	9, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			1, 2,  10, "ly003_cl01_item0000|cl01pl2_1_dv_0100_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 2,  11, "ly003_cl01_item0000|cl01pl2_1_dv_0100_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 2, -88, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 2, -87, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 2, -86, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			1, 2,  15, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 2, 116, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 2,  17, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 2,  18, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 3, -97, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 3, -96, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 3, -95, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			1, 3,	6, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 3,	7, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 3,	8, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			1, 3,	9, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 3,  10, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			1, 3,  11, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			1, 3,  12, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			1, 3,  13, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			1, 3,  14, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			1, 3, 115, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			1, 3,  16, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			1, 3,  17, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			1, 1,	1, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 1,	2, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			1, 1,	3, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			1, 1,	4, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			1, 1,	5, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			1, 1,	6, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			1, 1,	7, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			1, 1,	8, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			1, 1, 109, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			1, 1, 110, "ly003_cl01_item0000|cl01pl1_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			1, 2,	2, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 2,	3, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			1, 2,	4, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			1, 2,	5, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			1, 2,	6, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			1, 2,	7, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			1, 2,	8, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			1, 2,	9, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			1, 2, 110, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			1, 2, 111, "ly003_cl01_item0000|cl01pl2_0_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			1, 2,  12, "ly003_cl01_item0000|cl01pl2_1_dv_0100_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 2,  13, "ly003_cl01_item0000|cl01pl2_1_dv_0100_gimmick0002|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			1, 2, -86, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 2, -85, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			1, 2, -84, "ly003_cl01_item0000|cl01pl2_2_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			1, 3, -97, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 3, -96, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			1, 3, -95, "ly003_cl01_item0000|cl01pl3_0_dv_0060_gimmick0002|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			1, 3,	6, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			1, 3,	7, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			1, 3,	8, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			1, 3,	9, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			1, 3,  10, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			1, 3,  11, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			1, 3,  12, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			1, 3,  13, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			1, 3, 114, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			1, 3, 115, "ly003_cl01_item0000|cl01pl3_3_dv_0000_gimmick0002|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			1, 0, 400, "ly003_cl01_item0000|cl01pl0_uq_0010_gimmick0002|hw00_gim_n0001|srt_hw00_main0_def",
			1, 0, 801, "ly003_cl01_item0000|cl01pl0_uq_0010_gimmick0002|hw00_gim_n0000|srt_hw00_main0_def",
		},
		westTurrets = {
			
			1, 0, -300, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|hw01_gim_n0000|srt_hw01_tpod0_def",
			1, 0, -299, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|hw01_gim_n0001|srt_hw01_tpod0_def",
			1, 1, -299, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|hw01_gim_n0000|srt_hw01_tpod0_def",
			1, 1, -298, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|hw01_gim_n0001|srt_hw01_tpod0_def",
			1, 2, -298, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|hw01_gim_n0000|srt_hw01_tpod0_def",
			1, 2, -297, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|hw01_gim_n0001|srt_hw01_tpod0_def",
			1, 3, -297, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|hw01_gim_n0000|srt_hw01_tpod0_def",
			1, 3, -296, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			1, 0, -300, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			1, 0, -299, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			1, 1, -299, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			1, 1, -298, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			1, 2, -298, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			1, 2, -297, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			1, 3, -297, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			1, 3, -296, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		slideDoors = {
			
			1, 0, 900, "ly003_cl01_item0000|cl01pl0_uq_0010_gimmick0002|mtbs_door006_door002_gim_n0000|srt_mtbs_door006_door002",
		},
		irsensors = {
			
			1, 0, -300, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			1, 0, -299, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			1, 0, -98, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			1, 0, -297, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			1, 0, -296, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			1, 1, -299, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			1, 1, -298, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			1, 1, -97, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			1, 1, -296, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			1, 1, -295, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			1, 2, -298, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			1, 2, -297, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			1, 2, -96, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			1, 2, -295, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			1, 2, -294, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			1, 3, -297, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			1, 3, -296, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			1, 3, -95, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			1, 3, -294, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			1, 3, -293, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			1, 0,	0, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			1, 0, 101, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			1, 1,	1, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			1, 1, 102, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			1, 2,	2, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			1, 2, 103, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			1, 3,	3, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			1, 3, 104, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			1, 0,	0, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			1, 0,	1, "ly003_cl01_item0000|cl01pl0_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			1, 1,	1, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			1, 1,	2, "ly003_cl01_item0000|cl01pl1_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			1, 2,	2, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			1, 2,	3, "ly003_cl01_item0000|cl01pl2_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			1, 3,	3, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			1, 3,	4, "ly003_cl01_item0000|cl01pl3_mb_fndt_plnt_gimmick0002|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			2, 0,	0, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 0, 101, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 0,	2, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 0,	3, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 1,	1, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 1,	2, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 1,	3, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			2, 1,	4, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 1,	5, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 1,	6, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			2, 1,	7, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			2, 1,	8, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			2, 1,	9, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 1, 110, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 1,  11, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 1,  12, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 2,	2, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 2,	3, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 2,	4, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			2, 2,	5, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 2,	6, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 2,	7, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			2, 2,	8, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			2, 2,	9, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			2, 2,  10, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 2, 111, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 2,  12, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 2,  13, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 3,	3, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 3,	4, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 3,	5, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			2, 3,	6, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 3,	7, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			2, 3,	8, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			2, 3,	9, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			2, 3,  10, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			2, 3,  11, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			2, 3, 112, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			2, 3,  13, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			2, 3,  14, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			2, 1,	1, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			2, 1,	2, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			2, 1,	3, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			2, 1,	4, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			2, 1,	5, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			2, 1,	6, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			2, 1,	7, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			2, 1,	8, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			2, 1, 109, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			2, 1, 110, "ly003_cl02_item0000|cl02pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			2, 2,	2, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			2, 2,	3, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			2, 2,	4, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			2, 2,	5, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			2, 2,	6, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			2, 2,	7, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			2, 2,	8, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			2, 2,	9, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			2, 2, 110, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			2, 2, 111, "ly003_cl02_item0000|cl02pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			2, 3,	3, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			2, 3,	4, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			2, 3,	5, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			2, 3,	6, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			2, 3,	7, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			2, 3,	8, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			2, 3,	9, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			2, 3,  10, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			2, 3, 111, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			2, 3, 112, "ly003_cl02_item0000|cl02pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			2, 0, 1200, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			2, 0, 1101, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			2, 0, -300, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			2, 0, -299, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			2, 1, -299, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			2, 1, -298, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			2, 2, -298, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			2, 2, -297, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			2, 3, -297, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			2, 3, -296, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			2, 0, -300, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			2, 0, -299, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			2, 1, -299, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			2, 1, -298, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			2, 2, -298, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			2, 2, -297, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			2, 3, -297, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			2, 3, -296, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		slideDoors = {
			
			2, 0, 1100, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|mtbs_door006_door002_gim_n0000|srt_mtbs_door006_door002",
			2, 0, 1101, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|mtbs_door006_door002_gim_n0001|srt_mtbs_door006_door002",
		},
		irsensors = {
			
			2, 0, -300, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			2, 0, -299, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			2, 0, -98, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			2, 0, -297, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			2, 0, -296, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			2, 0, 405, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			2, 0, 606, "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			2, 1, -299, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			2, 1, -298, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			2, 1, -97, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			2, 1, -296, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			2, 1, -295, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			2, 2, -298, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			2, 2, -297, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			2, 2, -96, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			2, 2, -295, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			2, 2, -294, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			2, 3, -297, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			2, 3, -296, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			2, 3, -95, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			2, 3, -294, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			2, 3, -293, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			2, 0,	0, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			2, 0, 101, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			2, 1,	1, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			2, 1, 102, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			2, 2,	2, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			2, 2, 103, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			2, 3,	3, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			2, 3, 104, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			2, 0,	0, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			2, 0,	1, "ly003_cl02_item0000|cl02pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			2, 1,	1, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			2, 1,	2, "ly003_cl02_item0000|cl02pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			2, 2,	2, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			2, 2,	3, "ly003_cl02_item0000|cl02pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			2, 3,	3, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			2, 3,	4, "ly003_cl02_item0000|cl02pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			3, 0,	0, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 0, 101, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 0,	2, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 0,	3, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 1,	1, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 1,	2, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 1,	3, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			3, 1,	4, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 1,	5, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 1,	6, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			3, 1,	7, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			3, 1,	8, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			3, 1,	9, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 1, 110, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 1,  11, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 1,  12, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 2,	2, "ly003_cl03_item0000|cl03pl2_0_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 2,	3, "ly003_cl03_item0000|cl03pl2_0_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 2, -96, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 2, -95, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 2, -94, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			3, 2,	7, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 2,	8, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 2,	9, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			3, 2,  10, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 2,  11, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 2,  12, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			3, 2,  13, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			3, 2,  14, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			3, 2,  15, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 2, 116, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 2,  17, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 2,  18, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 3,	3, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 3,	4, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 3,	5, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			3, 3,	6, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 3,	7, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			3, 3,	8, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			3, 3,	9, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			3, 3,  10, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			3, 3,  11, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			3, 3, 112, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			3, 3,  13, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			3, 3,  14, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			3, 1,	1, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			3, 1,	2, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			3, 1,	3, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			3, 1,	4, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			3, 1,	5, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			3, 1,	6, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			3, 1,	7, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			3, 1,	8, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			3, 1, 109, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			3, 1, 110, "ly003_cl03_item0000|cl03pl1_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			3, 2,	2, "ly003_cl03_item0000|cl03pl2_0_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			3, 2,	3, "ly003_cl03_item0000|cl03pl2_0_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			3, 2, -96, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			3, 2, -95, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			3, 2, -94, "ly003_cl03_item0000|cl03pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			3, 2,	7, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			3, 2,	8, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			3, 2,	9, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			3, 2,  10, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			3, 2,  11, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			3, 2,  12, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			3, 2,  13, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			3, 2,  14, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			3, 2, 115, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			3, 2, 116, "ly003_cl03_item0000|cl03pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			3, 3,	3, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			3, 3,	4, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			3, 3,	5, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			3, 3,	6, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			3, 3,	7, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			3, 3,	8, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			3, 3,	9, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			3, 3,  10, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			3, 3, 111, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			3, 3, 112, "ly003_cl03_item0000|cl03pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			3, 0, 400, "ly003_cl03_item0000|cl03pl0_uq_0030_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			3, 0, 401, "ly003_cl03_item0000|cl03pl0_uq_0030_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			3, 0, -300, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			3, 0, -299, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			3, 1, -299, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			3, 1, -298, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			3, 2, -298, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			3, 2, -297, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			3, 3, -297, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			3, 3, -296, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			3, 0, -300, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			3, 0, -299, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			3, 1, -299, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			3, 1, -298, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			3, 2, -298, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			3, 2, -297, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			3, 3, -297, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			3, 3, -296, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		irsensors = {
			
			3, 0, -300, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			3, 0, -299, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			3, 0, -98, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			3, 0, -297, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			3, 0, -296, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			3, 1, -299, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			3, 1, -298, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			3, 1, -97, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			3, 1, -296, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			3, 1, -295, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			3, 2, -298, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			3, 2, -297, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			3, 2, -96, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			3, 2, -295, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			3, 2, -294, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			3, 3, -297, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			3, 3, -296, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			3, 3, -95, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			3, 3, -294, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			3, 3, -293, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			3, 0,	0, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			3, 0, 101, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			3, 1,	1, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			3, 1, 102, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			3, 2,	2, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			3, 2, 103, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			3, 3,	3, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			3, 3, 104, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			3, 0,	0, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			3, 0,	1, "ly003_cl03_item0000|cl03pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			3, 1,	1, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			3, 1,	2, "ly003_cl03_item0000|cl03pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			3, 2,	2, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			3, 2,	3, "ly003_cl03_item0000|cl03pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			3, 3,	3, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			3, 3,	4, "ly003_cl03_item0000|cl03pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			4, 0,	0, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 0, 101, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 0,	2, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 0,	3, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 1, -99, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 1, -98, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 1, -97, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			4, 1,	4, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 1,	5, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 1,	6, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			4, 1,	7, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 1,	8, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 1,	9, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			4, 1,  10, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			4, 1,  11, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			4, 1,  12, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 1, 113, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 1,  14, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 1,  15, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 2, -98, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 2, -97, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 2, -96, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			4, 2,	5, "ly003_cl04_item0000|cl04pl2_2_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 2,	6, "ly003_cl04_item0000|cl04pl2_2_dv_0100_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 2,	7, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 2,	8, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 2,	9, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			4, 2,  10, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 2,  11, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 2,  12, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			4, 2,  13, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			4, 2,  14, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			4, 2,  15, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 2, 116, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 2,  17, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 2,  18, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 3,	3, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 3,	4, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 3,	5, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			4, 3,	6, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 3,	7, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			4, 3,	8, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			4, 3,	9, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			4, 3,  10, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			4, 3,  11, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			4, 3, 112, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			4, 3,  13, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			4, 3,  14, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			
			4, 1,9999, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 1,9998, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			4, 1,9997, "ly003_cl04_item0000|cl04pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			
			4, 1,	4, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 1,	5, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			4, 1,	6, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			4, 1,	7, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			4, 1,	8, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			4, 1,	9, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			4, 1,  10, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			4, 1,  11, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			4, 1, 112, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			4, 1, 113, "ly003_cl04_item0000|cl04pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			4, 2, -98, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 2, -97, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			4, 2, -96, "ly003_cl04_item0000|cl04pl2_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			4, 2,	5, "ly003_cl04_item0000|cl04pl2_2_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 2,	6, "ly003_cl04_item0000|cl04pl2_2_dv_0100_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			4, 2,	7, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 2,	8, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			4, 2,	9, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			4, 2,  10, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			4, 2,  11, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			4, 2,  12, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			4, 2,  13, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			4, 2,  14, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			4, 2, 115, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			4, 2, 116, "ly003_cl04_item0000|cl04pl2_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			4, 3,	3, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			4, 3,	4, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			4, 3,	5, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			4, 3,	6, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			4, 3,	7, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			4, 3,	8, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			4, 3,	9, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			4, 3,  10, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			4, 3, 111, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			4, 3, 112, "ly003_cl04_item0000|cl04pl3_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			4, 0, 300, "ly003_cl04_item0000|cl04pl0_uq_0040_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			4, 0, 401, "ly003_cl04_item0000|cl04pl0_uq_0040_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			4, 0, -300, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			4, 0, -299, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			4, 1, -299, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			4, 1, -298, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			4, 2, -298, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			4, 2, -297, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			4, 3, -297, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			4, 3, -296, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			4, 0, -300, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			4, 0, -299, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			4, 1, -299, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			4, 1, -298, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			4, 2, -298, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			4, 2, -297, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			4, 3, -297, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			4, 3, -296, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		irsensors = {
			
			4, 0, -300, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			4, 0, -299, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			4, 0, -98, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			4, 0, -297, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			4, 0, -296, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			4, 1, -299, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			4, 1, -298, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			4, 1, -97, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			4, 1, -296, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			4, 1, -295, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			4, 2, -298, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			4, 2, -297, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			4, 2, -96, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			4, 2, -295, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			4, 2, -294, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			4, 3, -297, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			4, 3, -296, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			4, 3, -95, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			4, 3, -294, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			4, 3, -293, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			4, 0,	0, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			4, 0, 101, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			4, 1,	1, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			4, 1, 102, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			4, 2,	2, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			4, 2, 103, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			4, 3,	3, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			4, 3, 104, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			4, 0,	0, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			4, 0,	1, "ly003_cl04_item0000|cl04pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			4, 1,	1, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			4, 1,	2, "ly003_cl04_item0000|cl04pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			4, 2,	2, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			4, 2,	3, "ly003_cl04_item0000|cl04pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			4, 3,	3, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			4, 3,	4, "ly003_cl04_item0000|cl04pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			5, 0,	0, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 0, 101, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 0,	2, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 0,	3, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 1, -99, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 1, -98, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 1, -97, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			5, 1,	4, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 1,	5, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 1,	6, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			5, 1,	7, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 1,	8, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 1,	9, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			5, 1,  10, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			5, 1,  11, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			5, 1,  12, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 1, 113, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 1,  14, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 1,  15, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 2,	2, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 2,	3, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 2,	4, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			5, 2,	5, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 2,	6, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 2,	7, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			5, 2,	8, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			5, 2,	9, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			5, 2,  10, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 2, 111, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 2,  12, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 2,  13, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 3,	3, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 3,	4, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 3,	5, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			5, 3,	6, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 3,	7, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			5, 3,	8, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			5, 3,	9, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			5, 3,  10, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			5, 3,  11, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			5, 3, 112, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			5, 3,  13, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			5, 3,  14, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			5, 1, -99, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			5, 1, -98, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			5, 1, -97, "ly003_cl05_item0000|cl05pl1_1_dv_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			5, 1,	4, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			5, 1,	5, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			5, 1,	6, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			5, 1,	7, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			5, 1,	8, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			5, 1,	9, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			5, 1,  10, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			5, 1,  11, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			5, 1, 112, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			5, 1, 113, "ly003_cl05_item0000|cl05pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			5, 2,	2, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			5, 2,	3, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			5, 2,	4, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			5, 2,	5, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			5, 2,	6, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			5, 2,	7, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			5, 2,	8, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			5, 2,	9, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			5, 2, 110, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			5, 2, 111, "ly003_cl05_item0000|cl05pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			5, 3,	3, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			5, 3,	4, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			5, 3,	5, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			5, 3,	6, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			5, 3,	7, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			5, 3,	8, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			5, 3,	9, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			5, 3,  10, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			5, 3, 111, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			5, 3, 112, "ly003_cl05_item0000|cl05pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			5, 0, 100, "ly003_cl05_item0000|cl05pl0_uq_0050_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			5, 0, 101, "ly003_cl05_item0000|cl05pl0_uq_0050_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			5, 0, -300, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			5, 0, -299, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			5, 1, -299, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			5, 1, -298, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			5, 2, -298, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			5, 2, -297, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			5, 3, -297, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			5, 3, -296, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			5, 0, -300, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			5, 0, -299, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			5, 1, -299, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			5, 1, -298, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			5, 2, -298, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			5, 2, -297, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			5, 3, -297, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			5, 3, -296, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		irsensors = {
			
			5, 0, -300, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			5, 0, -299, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			5, 0, -98, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			5, 0, -297, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			5, 0, -296, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			5, 1, -299, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			5, 1, -298, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			5, 1, -97, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			5, 1, -296, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			5, 1, -295, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			5, 2, -298, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			5, 2, -297, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			5, 2, -96, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			5, 2, -295, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			5, 2, -294, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			5, 3, -297, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			5, 3, -296, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			5, 3, -95, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			5, 3, -294, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			5, 3, -293, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			5, 0,	0, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			5, 0, 101, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			5, 1,	1, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			5, 1, 102, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			5, 2,	2, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			5, 2, 103, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			5, 3,	3, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			5, 3, 104, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			5, 0,	0, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			5, 0,	1, "ly003_cl05_item0000|cl05pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			5, 1,	1, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			5, 1,	2, "ly003_cl05_item0000|cl05pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			5, 2,	2, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			5, 2,	3, "ly003_cl05_item0000|cl05pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			5, 3,	3, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			5, 3,	4, "ly003_cl05_item0000|cl05pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
	
	{
		stolenAlarms = {
			
			6, 2,	2, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 2, 103, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 2,	4, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 2,	5, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 2,	6, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 2,	7, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 2,	8, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			6, 2,	9, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 2,  10, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 2,  11, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			6, 2,  12, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			6, 2,  13, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			6, 3,	3, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 3, 104, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 3,	5, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 3,	6, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 3,	7, "ly003_cl06_item0000|cl06pl3_0_dv_0120_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 3,	8, "ly003_cl06_item0000|cl06pl3_0_dv_0120_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 3,	9, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 3,  10, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 3,  11, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			6, 3,  12, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 3,  13, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 3,  14, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			6, 3,  15, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			6, 3,  16, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			6, 1,	1, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 1, 102, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 1,	3, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 1,	4, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 1,	5, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 1,	6, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 1,	7, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			6, 1,	8, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 1,	9, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 1,  10, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			6, 1,  11, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			6, 1,  12, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			6, 0,	0, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 0,	1, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 0,	2, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
			6, 0,	3, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0004|srt_alm0_main0_def_v00",
			6, 0,	4, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 0,	5, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0005|srt_alm0_main0_def_v00",
			6, 0,	6, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0006|srt_alm0_main0_def_v00",
			6, 0,	7, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0007|srt_alm0_main0_def_v00",
			6, 0,	8, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0008|srt_alm0_main0_def_v00",
			6, 0,	9, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0009|srt_alm0_main0_def_v00",
			6, 0, 210, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0010|srt_alm0_main0_def_v00",
			6, 0, 211, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0011|srt_alm0_main0_def_v00",
			6, 0, 212, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0012|srt_alm0_main0_def_v00",
			6, 0, 213, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0013|srt_alm0_main0_def_v00",
			6, 0,  14, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0014|srt_alm0_main0_def_v00",
			6, 0,  15, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0015|srt_alm0_main0_def_v00",
			6, 0,  16, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0016|srt_alm0_main0_def_v00",
			6, 0,  17, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|alm0_main0_def_v00_gim_n0017|srt_alm0_main0_def_v00",
			6, 0,  18, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0000|srt_alm0_main0_def_v00",
			6, 0, 119, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0001|srt_alm0_main0_def_v00",
			6, 0,  20, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0002|srt_alm0_main0_def_v00",
			6, 0,  21, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|alm0_main0_def_v00_gim_n0003|srt_alm0_main0_def_v00",
		},
		containers = {
			
			6, 2,	2, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			6, 2,	3, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			6, 2,	4, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			6, 2,	5, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			6, 2,	6, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			6, 2,	7, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			6, 2,	8, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			6, 2,	9, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			6, 2, 110, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			6, 2, 111, "ly003_cl06_item0000|cl06pl2_0_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			6, 3,	3, "ly003_cl06_item0000|cl06pl3_0_dv_0120_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			6, 3,	4, "ly003_cl06_item0000|cl06pl3_0_dv_0120_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			6, 3,	5, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			6, 3,	6, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			6, 3,	7, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			6, 3,	8, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			6, 3,	9, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			6, 3,  10, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			6, 3,  11, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			6, 3,  12, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			6, 3, 113, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			6, 3, 114, "ly003_cl06_item0000|cl06pl3_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			6, 1,	1, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			6, 1,	2, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			6, 1,	3, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			6, 1,	4, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			6, 1,	5, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			6, 1,	6, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			6, 1,	7, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			6, 1,	8, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			6, 1, 109, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			6, 1, 110, "ly003_cl06_item0000|cl06pl1_3_dv_0000_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			6, 0,	0, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001",
			6, 0,	1, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0001|srt_gntn_cntn001_vrtn001",
			6, 0,	2, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0002|srt_gntn_cntn001_vrtn001",
			6, 0,	3, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0003|srt_gntn_cntn001_vrtn001",
			6, 0,	4, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0004|srt_gntn_cntn001_vrtn001",
			6, 0,	5, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0005|srt_gntn_cntn001_vrtn001",
			6, 0,	6, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0006|srt_gntn_cntn001_vrtn001",
			6, 0,	7, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0007|srt_gntn_cntn001_vrtn001",
			6, 0,	8, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0008|srt_gntn_cntn001_vrtn001",
			6, 0,	9, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0009|srt_gntn_cntn001_vrtn001",
			6, 0,  10, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0010|srt_gntn_cntn001_vrtn001",
			6, 0,  11, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0011|srt_gntn_cntn001_vrtn001",
			6, 0, 112, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0012|srt_gntn_cntn001_vrtn001",
			6, 0, 113, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0013|srt_gntn_cntn001_vrtn001",
			6, 0, 114, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0014|srt_gntn_cntn001_vrtn001",
			6, 0, 115, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0015|srt_gntn_cntn001_vrtn001",
			6, 0, 116, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0016|srt_gntn_cntn001_vrtn001",
			6, 0, 217, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0017|srt_gntn_cntn001_vrtn001",
			6, 0, 218, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0018|srt_gntn_cntn001_vrtn001",
			6, 0, 219, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0019|srt_gntn_cntn001_vrtn001",
			6, 0, 220, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0020|srt_gntn_cntn001_vrtn001",
			6, 0,  21, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0021|srt_gntn_cntn001_vrtn001",
			6, 0, 122, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0022|srt_gntn_cntn001_vrtn001",
			6, 0, 123, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0023|srt_gntn_cntn001_vrtn001",
			6, 0,  24, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0024|srt_gntn_cntn001_vrtn001",
			6, 0,  25, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0025|srt_gntn_cntn001_vrtn001",
			6, 0, 126, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0026|srt_gntn_cntn001_vrtn001",
			6, 0, 127, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0027|srt_gntn_cntn001_vrtn001",
			6, 0,  28, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0028|srt_gntn_cntn001_vrtn001",
			6, 0,  29, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|gntn_cntn001_vrtn001_gim_n0029|srt_gntn_cntn001_vrtn001",
		},
		mortars = {
			
			6, 0, 400, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|hw00_gim_n0000|srt_hw00_main0_def",
			6, 0, 401, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|hw00_gim_n0001|srt_hw00_main0_def",
		},
		westTurrets = {
			
			6, 2, -298, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			6, 2, -297, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			6, 3, -297, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			6, 3, -296, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			6, 1, -299, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			6, 1, -298, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
			6, 0, -300, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0000|srt_hw01_tpod0_def",
			6, 0, -299, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|hw01_gim_n0001|srt_hw01_tpod0_def",
		},
		eastTurrets = {
			
			6, 2, -298, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			6, 2, -297, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			6, 3, -297, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			6, 3, -296, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			6, 1, -299, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			6, 1, -298, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
			6, 0, -300, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0003|srt_hw03_tpod0_def_v00",
			6, 0, -299, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|hw03_gim_n0001|srt_hw03_tpod0_def_v00",
		},
		slideDoors = {
			
			6, 0, 300, "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|mtbs_door006_door002_gim_n0000|srt_mtbs_door006_door002",
		},
		irsensors = {
			
			6, 2, -298, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			6, 2, -297, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			6, 2, -96, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			6, 2, -295, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			6, 2, -294, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			6, 3, -297, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			6, 3, -296, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			6, 3, -95, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			6, 3, -294, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			6, 3, -293, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			6, 1, -299, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			6, 1, -298, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			6, 1, -97, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			6, 1, -296, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			6, 1, -295, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
			6, 0, -300, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0001|srt_mtbs_trap003",
			6, 0, -299, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0003|srt_mtbs_trap003",
			6, 0, -98, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0004|srt_mtbs_trap003",
			6, 0, -297, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0002|srt_mtbs_trap003",
			6, 0, -296, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|mtbs_trap003_gim_n0000|srt_mtbs_trap003",
		},
		westAAGs = {
			
			6, 2,	2, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			6, 2, 103, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			6, 3,	3, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			6, 3, 104, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			6, 1,	1, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			6, 1, 102, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			6, 0,	0, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			6, 0, 101, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
		eastAAGs = {
			
			6, 2,	2, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			6, 2,	3, "ly003_cl06_item0000|cl06pl2_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			6, 3,	3, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			6, 3,	4, "ly003_cl06_item0000|cl06pl3_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			6, 1,	1, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			6, 1,	2, "ly003_cl06_item0000|cl06pl1_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
			6, 0,	0, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0000|srt_sad0_main0_def",
			6, 0,	1, "ly003_cl06_item0000|cl06pl0_mb_fndt_plnt_gimmick2|sad0_main0_def_gim_n0004|srt_sad0_main0_def",
		},
	},
}

this.gimmickIdentifierParamTable = {
	
	{
		powerPlant_mchn_cl00_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl00_item0000|cl00pl0_uq_0000_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 0, vars.mbLayoutCode, 0 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl01_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl01_item0000|cl01pl0_uq_0010_gimmick0002|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 1, vars.mbLayoutCode, 1 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl02_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl02_item0000|cl02pl0_uq_0020_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 2, vars.mbLayoutCode, 2 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl03_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl03_item0000|cl03pl0_uq_0030_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 3, vars.mbLayoutCode, 3 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl04_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl04_item0000|cl04pl0_uq_0040_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 4, vars.mbLayoutCode, 4 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl05_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl05_item0000|cl05pl0_uq_0050_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 5, vars.mbLayoutCode, 5 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
	
	{
		powerPlant_mchn_cl06_00 = {
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			locatorName = "ly003_cl06_item0000|cl06pl0_uq_0060_gimmick2|afgh_gnrt002_vrtn002_gim_n0000|srt_afgh_gnrt002_vrtn002",
			dataSetName = string.format( "/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2", vars.mbLayoutCode, 6, vars.mbLayoutCode, 6 ),	
			gimmickType = TppGimmick.GIMMICK_TYPE.GNRT,
			blockLarge	= "",
		},
	},
}

this.gimmickPowerCutConnectTable = {
	
	{
		powerPlant_mchn_cl00_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 0, 0, 0, 0 * 10, "mtbs_command_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl01_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 1, 1, 0, 1 * 10, "mtbs_combat_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl02_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 2, 2, 0, 2 * 10, "mtbs_develop_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl03_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 3, 3, 0, 3 * 10, "mtbs_support_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl04_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 4, 4, 0, 4 * 10, "mtbs_medic_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl05_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 5, 5, 0, 5 * 10, "mtbs_intel_cp"),	
		},
	},
	
	{
		powerPlant_mchn_cl06_00 = {
			powerCutAreaName = "TppGimmickPowerCutAreaData0000",
			cpName = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", 3, 6, 6, 0, 6 * 10, "mtbs_basedev_cp"),	
		},
	},
}

this.GetEnemyAssetTable = function( culasterId )
	return this.enemyAssetTable[culasterId]
end

this.GetItemAssetTable = function( culasterId )
	return this.itemTable[culasterId]
end
this.GetGimmickIdentifierTable = function( culasterId )
	return this.gimmickIdentifierParamTable[culasterId]
end

this.GetGimmickPowerCutConnectTable = function( culasterId )
	return this.gimmickPowerCutConnectTable[culasterId]
end

if TppEnemy then
	TppEnemy.GetMBEnemyAssetTable = this.GetEnemyAssetTable
else
	Fox.Error("TppEnemy.lua is nil!")
end

if TppGimmick then
	TppGimmick.GetMBItemAssetTable = this.GetItemAssetTable
	TppGimmick.GetMBGimmickIdentifierTable = this.GetGimmickIdentifierTable
	TppGimmick.GetMBGimmickPowerCutConnectTable = this.GetGimmickPowerCutConnectTable
else
	Fox.Error("TppGimmick.lua is nil!")
end



return this