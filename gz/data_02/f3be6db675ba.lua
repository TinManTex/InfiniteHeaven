local editor = Editor.GetInstance()
local bucket = editor:GetCurrentEditableBucket()
local dataSet = bucket:GetEditableDataSet()

Command.StartGroup()

local blendFunction = Command.CreateData( editor,'CustomBlendFunctionData' )
Command.SetProperty{ entity=blendFunction, property="name", value="YBlend_9x1" }


local customData = dataSet:GetData( "TppCustomBlendFunctionPlugin_9x1Param0000" )
if customData ~= nil then
	Command.SetProperty{ entity=selectorCustom, property="pluginParam", value=customData }
end


Command.AddPropertyElement{ entity=blendFunction, property="controls" }
local control = blendFunction.controls[1]
Command.SetProperty{ entity=control, property="portName", value="x" }



Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[1]
Command.SetProperty{ entity=item, property="portName", value="Forward" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[2]
Command.SetProperty{ entity=item, property="portName", value="ForwardLeft" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[3]
Command.SetProperty{ entity=item, property="portName", value="Left" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[4]
Command.SetProperty{ entity=item, property="portName", value="BackwardLeft" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[5]
Command.SetProperty{ entity=item, property="portName", value="Backward" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[6]
Command.SetProperty{ entity=item, property="portName", value="BackwardRight" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[7]
Command.SetProperty{ entity=item, property="portName", value="Right" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[8]
Command.SetProperty{ entity=item, property="portName", value="ForwardRight" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[9]
Command.SetProperty{ entity=item, property="portName", value="Forward" }

local blendFunction = Command.CreateData( editor,'TppCustomBlendFunctionPlugin_9x1Param' )

Command.EndGroup()
