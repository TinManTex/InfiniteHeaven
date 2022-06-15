--IHDev_AddMotions.lua
--tex: just a method to add motions to InfMotions.lua your changes to that would get trampled on installing an new IH
--just a stop-gap till/if InfMotions gets an actual addon system
--put file in mgs_tpp\mod\modules
--see InfMotions.lua for examples of .motions and .packages entries
local this={}	

--tex completely replace InfMotions instead of adding them
local replaceMotions=true

this.motions={
--Example entries (commented out)
--  Salute={
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_start_l.gani",
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_idl_l.gani",
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_slt_ed_l.gani"
--  },
--
--  VenomSnake={
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_st.gani",
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_idl_lp.gani",
--    "/Assets/mgo/motion/SI_game/fani/bodies/snam/snambud/snambud_s_fst_ed.gani"
--  },
}

--tex: lua tables with string keys (like the motions table) don't actually use the order they are defined in
--so specify the order you want (or leave empty to just have them alpha sort).
this.motionGroups={
--Example entries (commented out)
--  "VenomSnake",
--  "Salute",
}

this.packages={
--Example entries (commented out)
-- "/Assets/tpp/pack/player/motion/ih/ih_additional_motion.fpk",
}

function this.PostAllModulesLoad()
  if #this.motionGroups==0 then
    this.motionGroups={}
    for name,ganis in pairs(this.motions)do
      this.motionGroups[#this.motionGroups+1]=name
    end
    table.sort(this.motionGroups)
  end

	if replaceMotions then
		InfMotion.motions=this.motions
		InfMotion.motionGroups=this.motionGroups
		InfMotion.packages=this.packages
	else--add
		for motionGroup,motions in pairs(this.motions)do
			InfMotion.motions[motionGroup]=motions
		end
    for i,motionGroupName in ipairs(this.motionGroups)do
      table.insert(InfMotion.motionGroups,motionGroupName)
    end		
		for i,packagePath in ipairs(this.packages)do
			table.insert(InfMotion.packages,packagePath)
		end
	end
	
	--WORKAROUND: for using QuickMenu without using motions menu, the ivars need to be settomax of motiongroups -^-
  Ivars.motionGroupIndex:OnSelect()
  Ivars.motionGaniIndex:OnSelect()
end--PostAllModulesLoad

return this