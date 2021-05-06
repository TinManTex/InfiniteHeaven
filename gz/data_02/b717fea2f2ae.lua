local editor = Editor.GetInstance()
local bucket = editor:GetCurrentEditableBucket()
local dataSet = bucket:GetEditableDataSet()

Command.StartGroup()

local blendFunction = Command.CreateData( editor,'CustomBlendFunctionData' )
Command.SetProperty{ entity=blendFunction, property="name", value="YBlend_5x1" }


local customData = dataSet:GetData( "TppPlayerWeaponHoldCrawlCustomBlendFunctionPluginParam0000" )
if customData ~= nil then
	Command.SetProperty{ entity=selectorCustom, property="pluginParam", value=customData }
end


Command.AddPropertyElement{ entity=blendFunction, property="controls" }
local control = blendFunction.controls[1]
Command.SetProperty{ entity=control, property="portName", value="x" }



Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[1]
Command.SetProperty{ entity=item, property="portName", value="0deg" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[2]
Command.SetProperty{ entity=item, property="portName", value="90deg" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[3]
Command.SetProperty{ entity=item, property="portName", value="+-180deg" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[4]
Command.SetProperty{ entity=item, property="portName", value="-90deg" }

Command.AddPropertyElement{ entity=blendFunction, property="items" }
local item = blendFunction.items[5]
Command.SetProperty{ entity=item, property="portName", value="-0deg" }

local blendFunction = Command.CreateData( editor,'TppPlayerWeaponHoldCrawlCustomBlendFunctionPluginParam' )

Command.EndGroup()
