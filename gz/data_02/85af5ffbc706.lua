local editor = Editor.GetInstance()
Command.StartGroup()

local blendFunction = Command.CreateData( editor,'CustomBlendFunctionData' )
Command.SetProperty{ entity=blendFunction, property="name", value="XYBlend_9x3" }


Command.AddPropertyElement{ entity=blendFunction, property="controls" }
local control = blendFunction.controls[1]
Command.SetProperty{ entity=control, property="portName", value="x" }

Command.AddPropertyElement{ entity=blendFunction, property="controls" }
control = blendFunction.controls[2]
Command.SetProperty{ entity=control, property="portName", value="y" }


Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[1]
Command.SetProperty{ entity=item, property="portName", value="0_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[2]
Command.SetProperty{ entity=item, property="portName", value="0_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[3]
Command.SetProperty{ entity=item, property="portName", value="0_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[4]
Command.SetProperty{ entity=item, property="portName", value="45_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[5]
Command.SetProperty{ entity=item, property="portName", value="45_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[6]
Command.SetProperty{ entity=item, property="portName", value="45_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[7]
Command.SetProperty{ entity=item, property="portName", value="90_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[8]
Command.SetProperty{ entity=item, property="portName", value="90_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[9]
Command.SetProperty{ entity=item, property="portName", value="90_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[10]
Command.SetProperty{ entity=item, property="portName", value="135_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[11]
Command.SetProperty{ entity=item, property="portName", value="135_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[12]
Command.SetProperty{ entity=item, property="portName", value="135_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[13]
Command.SetProperty{ entity=item, property="portName", value="180_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[14]
Command.SetProperty{ entity=item, property="portName", value="180_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[15]
Command.SetProperty{ entity=item, property="portName", value="180_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[16]
Command.SetProperty{ entity=item, property="portName", value="225_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[17]
Command.SetProperty{ entity=item, property="portName", value="225_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[18]
Command.SetProperty{ entity=item, property="portName", value="225_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[19]
Command.SetProperty{ entity=item, property="portName", value="270_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[20]
Command.SetProperty{ entity=item, property="portName", value="270_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[21]
Command.SetProperty{ entity=item, property="portName", value="270_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[22]
Command.SetProperty{ entity=item, property="portName", value="315_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[23]
Command.SetProperty{ entity=item, property="portName", value="315_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[24]
Command.SetProperty{ entity=item, property="portName", value="315_Lower" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[25]
Command.SetProperty{ entity=item, property="portName", value="360_Upper" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[26]
Command.SetProperty{ entity=item, property="portName", value="360_Center" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[27]
Command.SetProperty{ entity=item, property="portName", value="360_Lower" }



Command.EndGroup()
