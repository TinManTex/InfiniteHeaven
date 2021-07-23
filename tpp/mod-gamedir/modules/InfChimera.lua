--InfChimera.lua
local this={}
--chimera
--3x slots x 8 categories
--= 24
--12 parts slots per weapon, including color
--3x equipped (primary, secondary, tertiary)
this.SLOTS_PER_CATEROGRY=3
this.PARTS_COUNT=12--tex chimera parts slots per weapon, includes color

this.saveName="chimera"

--all arrays
--REF
--  chimeraColorIndex = { [0] = 0, 0, 0,},
--  chimeraPaintType = { [0] = 0, 0, 0,},
--  chimeraParts = { [0] = 199, 46, 64, 17, 9, 38, 4, 3, 4, 0, 4, 0, 155, 83, 109, 35, 17, 33, 16, 0, 0, 0, 0, 0, 10, 5, 6, 0, 0, 1, 0, 0, 2, 0, 0, 0,
--  },--#36

--  customizedWeapon = { [0] = 856, 790, 573,},
--  customizedWeaponSlotIndex = { [0] = 0, 0, 0,},

--  initChimeraColorIndex = { [0] = 59, 0, 62,},
--  initChimeraPaintType = { [0] = 2, 0, 2, },
--  initChimeraParts = { [0] = 199, 46, 64, 17, 9, 38, 4, 3, 4, 0, 4, 0, 155, 83, 109, 35, 17, 33, 16, 0, 0, 0, 0, 0, 10, 5, 6, 0, 0, 1, 0, 0, 2, 0, 0, 0, 
--  },--#36

--  initCustomizedWeapon = { [0] = 856, 790, 573,},
--  
--  userPresetChimeraColorIndex = { [0] = 64, 0, 0, 62, 0, 0, 59, 53, 0, 0, 0, 0, 0, 0, 0, 64, 64, 45, 58, 64, 0, 0, 0, 0, 
--  },--#24
--  userPresetChimeraPaintType = { 0, 0, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0,
--    [0] = 2
--  },--#24
--  userPresetChimeraParts = { [0] = 15, 5, 7, 0, 0, 1, 0, 0, 2, 0, 0, 0, 29, 11, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 16, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59, 23, 47, 4, 0, 17, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74, 46, 64, 20, 9, 28, 5, 3, 4, 9, 14, 89, 68, 40, 56, 15, 1, 32, 3, 0, 4, 8, 11, 86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 196, 63, 148, 23, 11, 0, 1, 0, 5, 0, 0, 0, 88, 57, 73, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 71, 0, 28, 0, 0, 9, 0, 0, 9, 11, 86, 142, 77, 101, 10, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 88, 113, 39, 19, 33, 19, 0, 0, 9, 3, 0, 150, 81, 106, 36, 25, 33, 5, 1, 0, 9, 0, 0, 145, 83, 104, 28, 17, 33, 16, 0, 0, 0, 0, 0, 170, 96, 120, 0, 0, 20, 3, 0, 4, 8, 0, 0, 208, 99, 152, 18, 25, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 210, 0, 157, 0, 0, 0, 22, 0, 3, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
--  },--#288  ==3*8*12


--  --#24
--  userPresetCustomizedWeapon = { [0] = 7, 36, 42, 666, 0, 0, 122, 105, 0, 708, 144, 0, 182, 208, 0, 243, 220, 214, 256, 831, 0, 817, 0, 0, },
--  isUseCustomizedWeapon = { [0] = 0, 0, 0,},

this.weaponCategories={
  "HANDGGUN",
  "SMG",
  "ASSAULT",
  "SHOTGUN",
  "GRENADELAUNCHER",
  "SNIPER",
  "MG",
  "MISSILE",
}--weaponCategories
this.weaponCategoriesEnum=Tpp.Enum(this.weaponCategories)
this.slots={
  "SLOT1",
  "SLOT2",
  "SLOT3",
}--slots
this.slotsEnum=Tpp.Enum(this.slots)
--VERIFY, just cribbing from TppDebug DEBUG_ChangeChimeraWeapon chimeraInfo
--comments are edit mode
this.parts={
  "equipId",--recieverId?--'Base'
  "barrel",
  "ammo",--'Magazine'
  "stock",
  "muzzle",
  "muzzleOption",--'muzzle accessory'
  "rearSight",--'Optics 1'
  "frontSight",--'Optics 2'
  "option1",--'Flashlight'
  "option2",--'Laser Sight'
  "underBarrel",
  "underBarrelAmmo",
}--parts
this.partsEnum=Tpp.Enum(this.parts)


function this.TypesToVarsIndex(category,slot,part)
  local categoryIdx=this.weaponCategoriesEnum[category]-1
  local slotIdx=this.slotsEnum[slot]-1
  local partIdx=this.partsEnum[part]-1
  return InfUtil.From3Dto1D(partIdx,slotIdx,categoryIdx,#this.parts,#this.slots)
end--ToVarsIndex
function this.VarsIndexToTypeIndexes(index)
  local partIdx,slotIdx,catIdx=InfUtil.From1Dto3D(index,#this.parts,#this.slots)
  return catIdx+1,slotIdx+1,partIdx+1
end--VarsIndexToTypeIndexes

function this.BuildSaveText(saveName,category,slot)
  local saveTextList={
    "-- "..saveName,
    "-- ",
    "local this={",
  }
  
  saveTextList[#saveTextList+1]="\t"..'category="'..this.weaponCategories[category+1]..'",'
  
  local part=0
  local startIdx=InfUtil.From3Dto1D(part,slot,category,#this.parts,#this.slots)
  local partsLine="\t".."chimeraParts={"
  for i=startIdx,startIdx+#this.parts-1 do
    partsLine=partsLine..vars.userPresetChimeraParts[i]..","
  end
  partsLine=partsLine.."},"
  saveTextList[#saveTextList+1]=partsLine
  --TODO
  --chimeraColorIndex= vars.userPresetChimeraColorIndex[]
  --chimeraColorIndex= vars.userPresetChimeraPaintType[]


  saveTextList[#saveTextList+1]="}--this"
  saveTextList[#saveTextList+1]="return this"

  InfCore.PrintInspect(saveTextList,"InfChimera.BuildSaveText saveTextList")--DEBUGNOW
  return saveTextList
end--BuildSaveText

function this.SaveVars(saveName,category,slot)
  InfCore.LogFlow"InfChimera.SaveVars"
  local saveTextList=this.BuildSaveText(saveName,category,slot)
  local fileName=InfCore.paths.chimeras..saveName
  InfCore.WriteStringTable(fileName,saveTextList)
  InfCore.RefreshFileList()
  InfCore.Log("Saved "..saveName,true,true)
end--SaveVars
function this.LoadVars(saveName,category,slot)
  local module=InfCore.LoadSimpleModule(InfCore.paths.chimeras,saveName)
  if module==nil then
    InfCore.Log("ERROR: InfChimera.LoadVars: could not load saves\\"..saveName,true,true)
    return
  end
  
  --tex TODO dont like this, should be filtered before even getting to this point
  local weaponCategory=ivars.chimera_weaponCategory
  if module.category~=this.weaponCategoriesEnum[category+1] then
    InfMenu.PrintLangId"chimera_wrong_weapon_category"
    return
  end
  
  local part=0
  local startIdx=InfUtil.From3Dto1D(part,slot,category,#this.parts,#this.slots)
  for i=startIdx,startIdx+#this.parts do
    vars.userPresetChimeraParts[i]=module.chimeraParts[i]
  end
  
    --TODO
  --vars.userPresetChimeraColorIndex[]=module.chimeraColorIndex 
  --vars.userPresetChimeraPaintType[]=module.chimeraColorIndex 
end--LoadVars

--Ivars
this.registerIvars={
  'chimera_weaponCategory',
  'chimera_clearSlot',
}

this.registerMenus={
  'chimeraMenu',
}

this.chimeraMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},--DEBUGNOW
  options={
    'Ivars.chimera_weaponCategory',
  },
}

this.chimera_weaponCategory={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.weaponCategories,
}--chimera_weaponCategory

for i=0,#this.slots-1 do
  local ivarName="chimera_loadSlot"..i
  table.insert(this.registerIvars,ivarName)
  table.insert(this.chimeraMenu.options,"Ivars."..ivarName)
  this[ivarName]={
    --save=IvarProc.CATEGORY_EXTERNAL,
    slot=i,
    settings={"None found"},--DYNAMIC
    default=0,
    OnSelect=function(self)
      local files=InfCore.GetFileList(InfCore.files.chimeras,".lua")
      --DEBUGNOW load all into this.chimeras instead so can filter by category ivar here
      if #files==0 then
        table.insert(files,1,"None Found")
      end
      IvarProc.SetSettings(self,files)
    end,
    OnActivate=function(self,setting)
      local saveName=self.settings[setting+1]
      local weaponCategory=ivars.chimera_weaponCategory
      this.LoadVars(saveName,weaponCategory,self.slot)
      InfCore.DebugPrint(InfLangProc.LangString"chimera_loaded_to_slot".." "..self.slot)
    end,
  }--chimera_loadSlot
end--for slots

for i=0,#this.slots-1 do
  local ivarName="chimera_saveSlot"..i
  table.insert(this.registerIvars,ivarName)
  table.insert(this.chimeraMenu.options,"Ivars."..ivarName)
  this[ivarName]={
    --save=IvarProc.CATEGORY_EXTERNAL,
    slot=i,
    settings={"New",},--DYNAMIC
    OnSelect=function(self)
      local files=InfCore.GetFileList(InfCore.files.chimeras,".lua")
      --DEBUGNOW load all into this.chimeras instead so can filter by category ivar here
      table.insert(files,1,"New")
      IvarProc.SetSettings(self,files)
    end,
    OnActivate=function(self,setting)
      local saveName=self.settings[setting+1]
      --TODO: IHHook text entry?
      if saveName=="New" then
        saveName=this.saveName..os.time()..".lua"
      end
      local weaponCategory=ivars.chimera_weaponCategory
      this.SaveVars(saveName,weaponCategory,self.slot)
      self:OnSelect()
      InfCore.DebugPrint(InfLangProc.LangString"chimera_saved_slot".." "..self.slot)
    end,
  }--saveChimera
end--for slots

this.chimera_clearSlot={
  settingNames=this.slots,
  OnActivate=function(self,setting)
    local category=ivars.chimera_weaponCategory
    local part=0
    local startIdx=InfUtil.From3Dto1D(part,self.slot,category,#this.parts,#this.slots)
    for i=startIdx,startIdx+#this.parts do
      vars.userPresetChimeraParts[i]=0
    end
    --DEBUGNOW TODO:
    --vars.userPresetChimeraColorIndex[]
    --vars.userPresetChimeraPaintType[]
    InfCore.DebugPrint(InfLangProc.LangString"chimera_cleared_slot".." "..setting)
  end,
}--chimera_clearSlot
table.insert(this.chimeraMenu.options,this.chimera_clearSlot)

this.langStrings={
  eng={
    loadChimera="Load chimera",
    saveChimera="Save chimera",
    chimeraMenu="Chimera menu",
  },
  help={
    eng={
      loadChimera="Load chimera from MGS_TPP\\mod\\chimeras to spcified slot",--DEBUGNOW
      saveChimera="Save chimera of specified slot for to MGS_TPP\\mod\\chimeras ",
    },
  }
}--langStrings

return this