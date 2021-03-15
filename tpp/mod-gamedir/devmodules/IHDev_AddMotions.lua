--IHDev_AddMotions.lua
--tex: just a method to add motions to InfMotions.lua your changes to that would get trampled on installing an new IH
--just a stop-gap till/if InfMotions gets an actual addon system
--put file in mgs_tpp\mod\modules
--see InfMotions.lua for examples of .motions and .packages entries
local this={}

this.motions={

}

this.packages={
}


function this.PostAllModulesLoad()
	for motionGroup,motions in pairs(this.motions)do
		InfMotion.motions[motionGroup]=motions
	end
	for i,packagePath in ipairs(this.packages)do
		table.insert(InfMotion.packages,packagePath)
	end
end

return this