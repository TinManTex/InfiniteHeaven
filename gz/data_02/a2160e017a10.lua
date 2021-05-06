
local   editor = Editor.GetInstance()
local	selector	= editor.entitySelector
local	selection	= selector:GetEntities()
local   bucket = editor:GetCurrentEditableBucket()
local   dataSet = bucket:GetEditableDataSet()
local   dataList = dataSet:GetDataList()

Command.StartGroup()

	local node = dataSet:GetData( "Test" )

	if node ~= nil then
		

		
		Command.AddPropertyElement{ entity=node, property="tags" }
		local last = #node.tags
		
		Command.SetProperty{ entity=node, property="tags", key=last-1, value="DiffMotion"}


		
		
		local selectorTwo = Command.CreateData( editor, 'BlendTwoFunctionData' )
		
		local selectorCustom = Command.CreateData( editor, 'CustomBlendFunctionData' )
		
		local selectorAdd = Command.CreateData( editor, 'AddBlendFunctionData' )
		
		local selectorSubtract = Command.CreateData( editor, 'SubtractBlendFunctionData' )

		
		Command.SetProperty{ entity=selectorCustom, property="name", value="XBlend_3x1" }

		local customData = dataSet:GetData( "TppPlayerWeaponHoldTurnCustomBlendFunctionPluginParam0000" )
		if customData ~= nil then

			Command.SetProperty{ entity=selectorCustom, property="pluginParam", value=customData }
		end

		
		Command.AddPropertyElement{ entity=selectorCustom, property="controls" }
		local control = selectorCustom.controls[1]
		Command.SetProperty{ entity=control, property="portName", value="y" }

		
		Command.AddPropertyElement{ entity=selectorCustom, property="items" }
		local item = selectorCustom.items[1]
		Command.SetProperty{ entity=item, property="portName", value="-90tn" }

		Command.AddPropertyElement{ entity=selectorCustom, property="items" }
		local item = selectorCustom.items[2]
		Command.SetProperty{ entity=item, property="portName", value="0tn" }

		Command.AddPropertyElement{ entity=selectorCustom, property="items" }
		local item = selectorCustom.items[3]
		Command.SetProperty{ entity=item, property="portName", value="90tn" }


		
		AnimGraphCommand:AddBlendNode( node, selectorTwo )
		AnimGraphCommand:AddBlendNode( node, selectorCustom )
		AnimGraphCommand:AddBlendNode( node, selectorAdd )
		AnimGraphCommand:AddBlendNode( node, selectorSubtract )


		
		AnimGraphCommand:ConnectRoot( node, selectorAdd )

		
		Command.SetProperty{ entity=selectorAdd, property="basePort", value=selectorTwo }

		
		Command.SetProperty{ entity=selectorAdd, property="subPort", value=selectorSubtract }

		
		Command.SetProperty{ entity=selectorSubtract, property="basePort", value=selectorCustom }

		
		local singleData1 = dataSet:GetData( "snapasr_q_fre-90_idl_0" )
		local singleData2 = dataSet:GetData( "snapasr_q_fre0_idl_0" )
		local singleData3 = dataSet:GetData( "snapasr_q_fre90_idl_0" )
		if singleData1 ~= nil then

			
			AnimGraphCommand:AddBlendNode( node, singleData1 )
			
			local port = selectorCustom.items[1]
			Command.SetProperty{ entity=port, property="node", value=singleData1 }
		end
		if singleData2 ~= nil then

			
			AnimGraphCommand:AddBlendNode( node, singleData2 )
			
			local port = selectorCustom.items[2]
			Command.SetProperty{ entity=port, property="node", value=singleData2 }
			
			Command.SetProperty{ entity=selectorSubtract, property="subPort", value=singleData2 }
		end
		if singleData3 ~= nil then

			
			AnimGraphCommand:AddBlendNode( node, singleData3 )
			
			local port = selectorCustom.items[3]
			Command.SetProperty{ entity=port, property="node", value=singleData3 }
		end

		
		AnimGraphCommand.ConnectBlendTwoFunctionDataControlPort( selectorTwo, "moveSpeed" )

		
		AnimGraphCommand.ConnectCustomBlendFunctionDataControlPort( selectorCustom, 1, "holdAngleY" )

		
		local treeViewData = node.data
		local treeView = treeViewData.view
		local goal = treeView.goal
		goal.left = 1200
		goal.top = 500

		for i,item in ipairs( treeView.items ) do
			if item.data then
				if item.data:GetClassName() == "BlendTwoFunctionData" then
					local left = item.left + 600
					local top = item.top + 400
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data:GetClassName() == "CustomBlendFunctionData" then
					local left = item.left + 450
					local top = item.top + 680
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data:GetClassName() == "AddBlendFunctionData" then
					local left = item.left + 900
					local top = item.top + 550
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data:GetClassName() == "SubtractBlendFunctionData" then
					local left = item.left + 600
					local top = item.top + 700
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data.name == "snapasr_q_fre-90_idl_0" then
					local left = item.left + 200
					local top = item.top + 600
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data.name == "snapasr_q_fre0_idl_0" then
					local left = item.left + 200
					local top = item.top + 740
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
				if item.data.name == "snapasr_q_fre90_idl_0" then
					local left = item.left + 200
					local top = item.top + 900
					Command.SetProperty{ entity=item, property="left", value=left }
					Command.SetProperty{ entity=item, property="top", value=top }
				end
			end
		end

	end
Command.EndGroup()
