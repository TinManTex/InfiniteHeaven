ActionTppClimbPath = {



WakeUpStates = {
	
	"stateClimbIdle",
},




__OnWakeUp = function( plugin )

	





	
	if not plugin:UpdateCurrentPath() then



	end

	plugin:AdjustPath()
end,




__OnSleep = function( plugin )

	
	
	
	
	
	

	
	
	

end,





__OnPreControl = function( plugin )
	

	

	local chara = plugin:GetCharacter()
	local plgBody = chara:FindPlugin( "ChBodyPlugin" )

	

	local path
	
	
	
	
	
	
	
	
	local pos = chara:GetPosition() + Vector3(0,-0.2,0)
	if not plugin:UpdateCurrentPath{ center = pos } then



	end









	path = plugin:GetCurrentPathResult()

	if Entity.IsNull( path ) then
		



		local rootPlugin = chara:FindPlugin( "ChActionRootPlugin" )
		rootPlugin:SendActionRequestToAll( ChDirectChangeStateActionRequest{ groupName="stateStandIdle" } )
		plugin:SleepRequest()
		return
	end

	






	
	plugin:AdjustPath()
	
	

end,




__OnPreAnim = function( plugin )
	

	
	local chara = plugin:GetCharacter()
	local plgBody = plugin:GetBodyPlugin()









	
	local path = plugin:GetCurrentPathResult()

	local endL, endR = path:GetEndPoints()
	local edgeIndexL, edgeIndexR = path:GetCurrentLineIndex()
	local pos = path:GetPoint(edgeIndexR)
	
	
	if path:HasNodeTag( edgeIndexR, "Edge" ) then
		
		if (pos - path:GetCrossPoint()):GetLength() < 2.0 then
			plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSnaknon_clk_vtclclbup_ed" } )
			plugin:SleepRequest()
		end
	elseif path:HasNodeTag( edgeIndexR, "CHANGE_TO_60" ) then
		
		if (pos - path:GetCrossPoint()):GetLength() < 0.8 then
			plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateClimbUp60" } )
		end
	end



	
end,




__OnReceiveMessage  = function( plugin, messages )
	

	

	local plgBody	= plugin:GetBodyPlugin()

	
	local mesPrio = {}
		mesPrio["PrioMax"]	= 5
		mesPrio["EntryReq"]	= mesPrio["PrioMax"]

	
	local curPrio = 0	
	for i, message in ipairs( messages.array ) do

		

		
		if curPrio >= mesPrio["PrioMax"] then
			local chara = plugin:GetCharacter()
			Ch.Log( chara, "curPrio is bigger than PrioMax")
			break
		end

		local message = messages.array[i]

		
		if message:IsKindOf( TppClimbStartRequest ) then
			

			local chara = plugin:GetCharacter()
			local control = plgBody:GetControl()
			local charaPos = plgBody:GetControlPosition()
			

			
			
			local numCandidates = plugin:SearchCandidatePath{ center = charaPos + Vector3(0,0.5,0) + chara:GetRotation():Rotate( Vector3( 0, 0, 0.3 ) ) }
			






			local nearestPath = Entity.Null()
			local height = 0	

			

			
			if numCandidates <= 0 then
				 return false
			end

			
			local minDirNormal = 100
			local isStart = false

			
			for i = 1, numCandidates do

				
				while true do

					
					local path = plugin:GetCandidatePathResult( i )

					











					if Entity.IsNull( path ) or not path:HasTag( "Climb" ) then break end

					

						local pathHeightFromFoot = path:GetCrossPoint():GetY() - ( charaPos:GetY() - control:GetHeight() )
						
						if pathHeightFromFoot >= 0.75 and pathHeightFromFoot <= 2.25 then

							
							local lineNormY = path:GetLineDirY() - foxmath.DegreeToRadian( 90 )
							local CharaToCrossPoint = path:GetCrossPoint() - chara:GetPosition()
							CharaToCrossPoint = CharaToCrossPoint:Normalize()
							local dirCharaToCrossPoint = foxmath.Atan2( CharaToCrossPoint:GetX(), CharaToCrossPoint:GetZ() )



							local diffDirCrossPointLineNorm = plugin:GetDiffDirAbs( lineNormY, dirCharaToCrossPoint )
							local desc = chara:GetCharacterDesc()
							local dirY = desc.ch_direction
							local diffDir = plugin:GetDiffDirAbs( lineNormY, dirY )
							local dist = path:GetLength()
							





							




















							if dist < 3 then
								
								if diffDir < minDirNormal then
									
									

									nearestPath = path
									plugin:SetCurrentPath( path )
									height = pathHeightFromFoot
									minDirNormal = diffDir
									isStart = true
								end
							end
						end
					



					
					break
				end
			end

			
			

			if isStart then
				
				



				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateClimbIdle" } )
				


				curPrio = mesPrio["EntryReq"]
			end
		end
	end

	
end,






























































}
