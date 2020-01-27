--DEBUGNOW
local this={}

this.ivarTest={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1,increment=1},
}

this.ivars={
  ivarTest=this.ivarTest,
}

this.playAnimMenu={
  nonConfig=true,--DEBUGNOW
  context="HELISPACE",
  options={
    "Ivars.ivarTest",
  }
}

this.menuDefs={
  playAnimMenu=this.playAnimMenu,
}

this.langStrings={
  ivarTest="Ivars test",
}

return this