--plparts_dd_male_modelInfo.lua.lua
--ModelInfo file for Infinite Heaven
local this={
  modelDescription="Private Forces",
  noBlackDiamond=true,--tex don't show diamond shine where ddogs emblem is
  hideBodyFova="/Assets/tpp/fova/chara/pfs/pfa0_v00_a.fv2",
  fovaTable={
    --[[mostly untextured, seems to be changing the texure of a submodel by right armpit?
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip0_v00.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip0_v01.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip0_v02.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip0_v03.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip0_v04.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip1_v00.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip1_v01.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip1_v02.fv2",
    },
    {
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_quip1_v03.fv2",
    },
    --]]
    --[[all gear is combined (helmet cap gasmask nvg, softarmor), and foxkit is not at a stage where it can output modified verisions of these files correctly
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_a.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_b.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_c.fv2",},
    
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_a.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_b.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_c.fv2",},
    
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_a.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_a.fv2",},
    
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_b.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_b.fv2",},
    
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_c.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_c.fv2",},
    
    
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_a.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_b.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_c.fv2",},
    --]]
    --tex uses seperate model, which ApplyFormVariationWithFile doesnt seem to support
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfa0_v00_a.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfa0_v00_b.fv2",},
    {fovaFile="/Assets/tpp/fova/chara/pfs/pfa0_v00_c.fv2",},
    
    {
      fovaDescription="cap, glases, medal, brown leather top, light tan muddy pants, fingerless gloves, white hands",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v140.fv2",
    },
    {
      fovaDescription="green beret, brown leather top, light tan muddy pants, white hands",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v150.fv2",
    },
    {
      fovaDescription="red beret cfa light tank shortpants fingerless gloves white hands",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v155.fv2",
    },
    {
      fovaDescription="black beret, glases, black vest, red shirt, tan pants, fingerless gloves, white hands",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v210.fv2",
    },
    {
      fovaDescription="tan shorts",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v220.fv2",
    },
    {
      fovaDescription="brown leather top, light tan muddy pants",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v241.fv2",
    },
    {
      fovaDescription="brown leather top, light tan muddy pants, sidearm holster on leg",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v242.fv2",
    },
    {
      fovaDescription="black beret, white coyote tshirt, black pants",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v250.fv2",
    },
    -- {
    --OFF fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v280.fv2",--tex uses seperate model
    -- },
    {
      fovaDescription="red long sleeve shirt, body vest, black pants",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v360.fv2",
    },
    {
      fovaDescription="red beret, black leather top, black pants",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v440.fv2",
    },
    {
      fovaDescription="red beret, brown leather top, light tan muddy pants",
      fovaFile="/Assets/tpp/fova/chara/pfs/pfs0_unq_v450.fv2",
    },
  }
}

return this
