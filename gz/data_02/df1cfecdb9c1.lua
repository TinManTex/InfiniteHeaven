local editor = Editor.GetInstance()
Command.StartGroup()

local blendFunction = Command.CreateData( editor,'CustomBlendFunctionData' )
Command.SetProperty{ entity=blendFunction, property="name", value="XYBlend_5x5" }


Command.AddPropertyElement{ entity=blendFunction, property="controls" }
local control = blendFunction.controls[1]
Command.SetProperty{ entity=control, property="portName", value="x" }

Command.AddPropertyElement{ entity=blendFunction, property="controls" }
control = blendFunction.controls[2]
Command.SetProperty{ entity=control, property="portName", value="y" }


Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[1]
Command.SetProperty{ entity=item, property="portName", value="-90_90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[2]
Command.SetProperty{ entity=item, property="portName", value="-90_45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[3]
Command.SetProperty{ entity=item, property="portName", value="-90_0" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[4]
Command.SetProperty{ entity=item, property="portName", value="-90_-45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[5]
Command.SetProperty{ entity=item, property="portName", value="-90_-90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[6]
Command.SetProperty{ entity=item, property="portName", value="-45_90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[7]
Command.SetProperty{ entity=item, property="portName", value="-45_45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[8]
Command.SetProperty{ entity=item, property="portName", value="-45_0" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[9]
Command.SetProperty{ entity=item, property="portName", value="-45_-45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[10]
Command.SetProperty{ entity=item, property="portName", value="-45_-90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[11]
Command.SetProperty{ entity=item, property="portName", value="0_90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[12]
Command.SetProperty{ entity=item, property="portName", value="0_45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[13]
Command.SetProperty{ entity=item, property="portName", value="0_0" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[14]
Command.SetProperty{ entity=item, property="portName", value="0_-45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[15]
Command.SetProperty{ entity=item, property="portName", value="0_-90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[16]
Command.SetProperty{ entity=item, property="portName", value="45_90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[17]
Command.SetProperty{ entity=item, property="portName", value="45_45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[18]
Command.SetProperty{ entity=item, property="portName", value="45_0" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[19]
Command.SetProperty{ entity=item, property="portName", value="45_-45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[20]
Command.SetProperty{ entity=item, property="portName", value="45_-90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[21]
Command.SetProperty{ entity=item, property="portName", value="90_90" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[22]
Command.SetProperty{ entity=item, property="portName", value="90_45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[23]
Command.SetProperty{ entity=item, property="portName", value="90_0" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[24]
Command.SetProperty{ entity=item, property="portName", value="90_-45" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[25]
Command.SetProperty{ entity=item, property="portName", value="90_-90" }




Command.EndGroup()
