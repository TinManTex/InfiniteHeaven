local this={
	bodyFova={
	},

	bodyDefinitions={
	},
}

--TABLESETUP
local chara="sna"
local idFmt="dds5_main0_ply_v%02d"
local fv2Fmt="/Assets/tpp/fova/chara/%s/%s.fv2"
local fpkFmt="/Assets/tpp/pack/player/fova/plfova_%s.fpk"
local numFovas=60--from 0.  missing 9,15,21 (see inffova), but will add them for simplicty since they're otherwise complete/contiguous.

for i=0,numFovas do
	local bodyIdName=string.format(idFmt,i)

	local fovaEntry={
		string.format(fv2Fmt,chara,bodyIdName),
		string.format(fpkFmt,bodyIdName)
	}
	table.insert(this.bodyFova,fovaEntry)

	this.bodyDefinitions[bodyIdName]={
		bodyFova=bodyIdName..".fv2"
	}
end

return this