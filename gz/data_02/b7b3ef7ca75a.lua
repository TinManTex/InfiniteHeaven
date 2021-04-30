local editor = Editor.GetInstance()
local bucket = editor:GetCurrentEditableBucket()
local dataSet = bucket:GetEditableDataSet()

Command.StartGroup()

local blendFunction = Command.CreateData( editor,'CustomBlendFunctionData' )
Command.SetProperty{ entity=blendFunction, property="name", value="XBlend_3x1_" }


local customData = dataSet:GetData( "TppPlayerWeaponHoldTurnCustomBlendFunctionPluginParam0000" )
if customData ~= nil then
	Command.SetProperty{ entity=selectorCustom, property="pluginParam", value=customData }
end


Command.AddPropertyElement{ entity=blendFunction, property="controls" }
local control = blendFunction.controls[1]
Command.SetProperty{ entity=control, property="portName", value="y" }



Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[1]
Command.SetProperty{ entity=item, property="portName", value="-90tn" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[2]
Command.SetProperty{ entity=item, property="portName", value="0tn" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[3]
Command.SetProperty{ entity=item, property="portName", value="90tn" }



Command.EndGroup()
