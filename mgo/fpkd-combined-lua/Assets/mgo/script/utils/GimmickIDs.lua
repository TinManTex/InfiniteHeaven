local this = {}

this.friendlyBase = nil
this.enemyBase = nil




local FlagAFCRnd1Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base8_present.fox2",
	},
	[9] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base9_present.fox2",
	},
}

local FlagAFCRnd2Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base8_present.fox2",
	},
	[9] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc0/block_ruleset/base9_present.fox2",
	},
}

local FlagAFC1Rnd1Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base4_present.fox2",
	},
}

local FlagAFC1Rnd2Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afc1/block_ruleset/base4_present.fox2",
	},
}


local FlagAFNRnd1Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base6_present.fox2",
	},
}

local FlagAFNRnd2Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afn0/block_ruleset/base6_present.fox2",
	},
}

local FlagAFDARnd1Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base8_present.fox2",
	},
	[9] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base9_present.fox2",
	},
}

local FlagAFDARnd2Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base8_present.fox2",
	},
	[9] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/afda/block_ruleset/base9_present.fox2",
	},
}

local FlagCUBARnd1Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base8_present.fox2",
	},
}

local FlagCUBARnd2Gimmick = {
	[1] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base1_present.fox2",
	},
	[2] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base2_present.fox2",
	},
	[3] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base3_present.fox2",
	},
	[4] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base4_present.fox2",
	},
	[5] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base5_present.fox2",
	},
	[6] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base6_present.fox2",
	},
	[7] = {
					type = -1,
					name = "mgor_flag002_vrtn002_gim_n0000|srt_mgor_flag002_vrtn002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base7_present.fox2",
	},
	[8] = {
					type = -1,
					name = "mgor_flag002_gim_n0000|srt_mgor_flag002",
					dataset = "/Assets/mgo/level/location/cuba/block_ruleset/base8_present.fox2",
	},
}






function this.DEBUG_NotExistLog( type, name, dataset )
	Fox.Log( "not Exist type:" .. tostring( type ) .. "name:" .. tostring( name ) .. "dataset:" .. tostring( dataset ) )
end

this.SwapFlags = function(mapId, round)
	if mapId == "afc0" then
		if round == 1 then
			for i = 1, #FlagAFCRnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset )
				end
			end
		else
			for i = 1, #FlagAFCRnd1Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFCRnd1Gimmick[i].type, FlagAFCRnd1Gimmick[i].name, FlagAFCRnd1Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFCRnd1Gimmick[i].type, FlagAFCRnd1Gimmick[i].name, FlagAFCRnd1Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFCRnd1Gimmick[i].type, FlagAFCRnd1Gimmick[i].name, FlagAFCRnd1Gimmick[i].dataset )
				end
			end
			for i = 1, #FlagAFCRnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset, false)
				else
					this.DEBUG_NotExistLog( FlagAFCRnd2Gimmick[i].type, FlagAFCRnd2Gimmick[i].name, FlagAFCRnd2Gimmick[i].dataset )
				end
			end
		end
	elseif mapId == "afc1" then
		if round == 1 then
			for i = 1, #FlagAFC1Rnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset )
				end
			end
		else
			for i = 1, #FlagAFC1Rnd1Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFC1Rnd1Gimmick[i].type, FlagAFC1Rnd1Gimmick[i].name, FlagAFC1Rnd1Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFC1Rnd1Gimmick[i].type, FlagAFC1Rnd1Gimmick[i].name, FlagAFC1Rnd1Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFC1Rnd1Gimmick[i].type, FlagAFC1Rnd1Gimmick[i].name, FlagAFC1Rnd1Gimmick[i].dataset )
				end
			end
			for i = 1, #FlagAFC1Rnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset, false)
				else
					this.DEBUG_NotExistLog( FlagAFC1Rnd2Gimmick[i].type, FlagAFC1Rnd2Gimmick[i].name, FlagAFC1Rnd2Gimmick[i].dataset )
				end
			end
		end
	elseif mapId == "afn0" then
		if round == 1 then
			for i = 1, #FlagAFNRnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset )
				end
			end
		else
			for i = 1, #FlagAFNRnd1Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFNRnd1Gimmick[i].type, FlagAFNRnd1Gimmick[i].name, FlagAFNRnd1Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFNRnd1Gimmick[i].type, FlagAFNRnd1Gimmick[i].name, FlagAFNRnd1Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFNRnd1Gimmick[i].type, FlagAFNRnd1Gimmick[i].name, FlagAFNRnd1Gimmick[i].dataset )
				end
			end
			for i = 1, #FlagAFNRnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset, false)
				else
					this.DEBUG_NotExistLog( FlagAFNRnd2Gimmick[i].type, FlagAFNRnd2Gimmick[i].name, FlagAFNRnd2Gimmick[i].dataset )
				end
			end
		end
	elseif mapId == "afda" then
		if round == 1 then
			for i = 1, #FlagAFDARnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset )
				end
			end
		else
			for i = 1, #FlagAFDARnd1Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFDARnd1Gimmick[i].type, FlagAFDARnd1Gimmick[i].name, FlagAFDARnd1Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFDARnd1Gimmick[i].type, FlagAFDARnd1Gimmick[i].name, FlagAFDARnd1Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagAFDARnd1Gimmick[i].type, FlagAFDARnd1Gimmick[i].name, FlagAFDARnd1Gimmick[i].dataset )
				end
			end
			for i = 1, #FlagAFDARnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset, false)
				else
					this.DEBUG_NotExistLog( FlagAFDARnd2Gimmick[i].type, FlagAFDARnd2Gimmick[i].name, FlagAFDARnd2Gimmick[i].dataset )
				end
			end
		end
	elseif mapId == "cuba" then
		if round == 1 then
			for i = 1, #FlagCUBARnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset )
				end
			end
		else
			for i = 1, #FlagCUBARnd1Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagCUBARnd1Gimmick[i].type, FlagCUBARnd1Gimmick[i].name, FlagCUBARnd1Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagCUBARnd1Gimmick[i].type, FlagCUBARnd1Gimmick[i].name, FlagCUBARnd1Gimmick[i].dataset, true)
				else
					this.DEBUG_NotExistLog( FlagCUBARnd1Gimmick[i].type, FlagCUBARnd1Gimmick[i].name, FlagCUBARnd1Gimmick[i].dataset )
				end
			end
			for i = 1, #FlagCUBARnd2Gimmick do
				local doesExist = Gimmick.DoesGimmickExist( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset )
				if doesExist then
					Gimmick.InvisibleGimmick( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset, false)
				else
					this.DEBUG_NotExistLog( FlagCUBARnd2Gimmick[i].type, FlagCUBARnd2Gimmick[i].name, FlagCUBARnd2Gimmick[i].dataset )
				end
			end
		end
	end
end

this.AddObjectiveBlip = function(POI_SYSTEM_ID)	
	POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )
	local objectives = GameObject.SendCommand( POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_TYPE_GENERIC,
				tags = { "BASE", "TEAM_01" },
			}
		}
	)

	if ( objectives.resultCount == 0) then		
	else		
		this.addTeamIcons( 0, objectives.results[1].posX, objectives.results[1].posY, objectives.results[1].posZ )
	end	
	objectives = GameObject.SendCommand( POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_TYPE_GENERIC,
				tags = { "BASE", "TEAM_02" },
			}
		}
	)

	if ( objectives.resultCount == 0) then		
	else				
		this.addTeamIcons( 1, objectives.results[1].posX, objectives.results[1].posY, objectives.results[1].posZ )
	end
	
	local objectives = GameObject.SendCommand( POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_TYPE_GENERIC,
				tags = { "BASE", "OBJECTIVE" },
			}
		}
	)
	if ( objectives.resultCount == 0) then		
	else				
		this.addTeamIcons( 2, objectives.results[1].posX, objectives.results[1].posY, objectives.results[1].posZ )
	end
end

this.addTeamIcons = function(base, x, y, z)
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	if localTeam == base then
		if this.friendlyBase ~= nil then
			MgoMap.RemoveIcon(this.friendlyBase)
		end
		if MgoMap.AddIcon2 ~= nil then
			this.friendlyBase = MgoMap.AddIcon2("FortFriendly", x, y, z, "Icons")
		else
			this.friendlyBase = MgoMap.AddIcon("FortFriendly", x, z, "Icons")
		end
	elseif base == 2 then
		if this.friendlyBase ~= nil then
			MgoMap.RemoveIcon(this.friendlyBase)
		end
		if MgoMap.AddIcon2 ~= nil then
			this.friendlyBase = MgoMap.AddIcon2("FortFriendly", x, y, z, "Icons")
		else
			this.friendlyBase = MgoMap.AddIcon("FortFriendly", x, z, "Icons")
		end
	else
		if this.enemyBase ~= nil then
			MgoMap.RemoveIcon(this.enemyBase)
		end
		if MgoMap.AddIcon2 ~= nil then
			this.enemyBase = MgoMap.AddIcon2("FortEnemy", x, y, z, "Icons")
		else
			this.enemyBase = MgoMap.AddIcon("FortEnemy", x, z, "Icons")
		end
	end
end

this.removeTeamIcons = function()
	if this.friendlyBase ~= nil then
		MgoMap.RemoveIcon(this.friendlyBase)
	end
	if this.enemyBase ~= nil then
		MgoMap.RemoveIcon(this.enemyBase)
	end
end

return this