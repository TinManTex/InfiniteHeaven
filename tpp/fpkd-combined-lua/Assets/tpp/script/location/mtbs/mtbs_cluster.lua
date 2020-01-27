-- DOBUILD: 1
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\location\mtbs\pack_common\mtbs_script.fpkd
local mtbs_cluster = {}

local CLUSTER_INDEX = {}
for i,clusterName in ipairs(TppDefine.CLUSTER_NAME) do
	CLUSTER_INDEX[clusterName] = i
end
local PLNT_INDEX = {
	plnt0 = 0,
	plnt1 = 1,
	plnt2 = 2,
	plnt3 = 3,
}







mtbs_cluster.requires = {
}




function mtbs_cluster.GetClusterConstruct( clusterId )
	return mvars.mtbsClst_constructTable[ clusterId ]
end




function mtbs_cluster.GetCurrentClusterId()
	return MotherBaseStage.GetCurrentCluster() + 1
end




function mtbs_cluster.GetCurrentClusterName()
	return TppDefine.CLUSTER_NAME[ mtbs_cluster.GetCurrentClusterId() ]
end




function mtbs_cluster.GetClusterName( clusterId )
	return TppDefine.CLUSTER_NAME[clusterId]
end




function mtbs_cluster.GetClusterId( clusterName )
	return CLUSTER_INDEX[clusterName]
end








function mtbs_cluster.GetDemoCenter( clusterName, plntName )
	if clusterName then
		local clusterId = CLUSTER_INDEX[clusterName] - 1
		local plntId = 0
		if plntName then
			if Tpp.IsTypeString(plntName) then
				plntId = PLNT_INDEX[plntName]
			elseif Tpp.IsTypeNumber( plntName ) then
				plntId = plntName
			end
		end
		return MotherBaseStage.GetDemoCenter( clusterId, plntId )
	else
		return MotherBaseStage.GetDemoCenter()
	end
end





function mtbs_cluster.LockCluster( clusterName )
	if clusterName then
		MotherBaseStage.LockCluster( CLUSTER_INDEX[clusterName] - 1 )
	else
		MotherBaseStage.LockCluster()
	end
end




function mtbs_cluster.UnlockCluster( )
	MotherBaseStage.UnlockCluster()
end




function mtbs_cluster.HasPlant( clusterName, plntName )
	local grade = TppLocation.GetMbStageClusterGrade( mtbs_cluster.GetClusterId(clusterName) )
	return grade > PLNT_INDEX[plntName]
end




function mtbs_cluster.GetCurrentPlnt()
	local plntNameList = {"plnt0","plnt1","plnt2","plnt3"}
	local playerPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
	local clusterName = mtbs_cluster.GetCurrentClusterName()
	local nearestDistance = 1000000
	local nearestPlntName = "plnt0"
	for _, plntName in ipairs( plntNameList ) do
		if not mtbs_cluster.HasPlant(clusterName, plntName) then
			break
		end
		local plntCenterPos = mtbs_cluster.GetDemoCenter( clusterName, plntName )
		local distSqr = (plntCenterPos - playerPos ):GetLengthSqr()
		if distSqr < nearestDistance then
			nearestDistance = distSqr
			nearestPlntName = plntName
		end
	end
	return nearestPlntName
end





function mtbs_cluster.SetUpLandingZone( landingZoneTable, clusterId )
  local enabledLzs={}--tex>
  if InfNPCHeli then InfNPCHeli.enabledLzs[clusterId]=enabledLzs end--<
	local disableLandingZoneTable = {
		{ disableClusterIndex = 0 },
		{ disableClusterIndex = ( TppDefine.CLUSTER_DEFINE.Develop + 1 ), layoutCode = 1, disableIndex = 1, },
		{ disableClusterIndex = ( TppDefine.CLUSTER_DEFINE.Combat + 1  ), layoutCode = 2, },
		{ disableClusterIndex = ( TppDefine.CLUSTER_DEFINE.Develop + 1 ), layoutCode = 3, },
	}
	if landingZoneTable == nil then
		Fox.Warning( "SetLandingZones is nil" )
		return
	end
	local gameObjectId = GameObject.GetGameObjectId( "SupportHeli" )
	
	for plntId, plntLzNameTable in pairs( landingZoneTable ) do
		
		if clusterId == ( TppDefine.CLUSTER_DEFINE.Command + 1 ) then
			for i, landingZoneName in pairs( plntLzNameTable ) do
				local isDisable = false
				if plntId > mvars.mtbsClst_constructTable[clusterId] then
					isDisable = true
				else
					local clusterData = disableLandingZoneTable[plntId]
					if clusterData.disableClusterIndex ~= 0  then
						if mvars.mtbsClst_constructTable[clusterData.disableClusterIndex] > 0 and vars.mbLayoutCode == clusterData.layoutCode then
							if clusterData.disableIndex then
								
								if clusterData.disableIndex == i then
									isDisable = true
								end
							else
								isDisable = true
							end
						end
					end
				end
				if isDisable == true then
					GameObject.SendCommand( gameObjectId, { id = "DisableLandingZone", name = landingZoneName })
			  else
			   enabledLzs[#enabledLzs+1]=landingZoneName--tex
				end
			end
		
		else
			for i, landingZoneName in pairs( plntLzNameTable ) do
				if plntId > mvars.mtbsClst_constructTable[clusterId] then
					GameObject.SendCommand( gameObjectId, { id = "DisableLandingZone", name = landingZoneName })
				else
				  enabledLzs[#enabledLzs+1]=landingZoneName--tex
				end
			end
		end
	end
end















function mtbs_cluster.GetPosAndRotY( clusterName, plntName, pos, rotY )
	local plntCenterPos, rotQuat = mtbs_cluster.GetDemoCenter( clusterName, plntName )
	local posVec = plntCenterPos + rotQuat:Rotate( Vector3(pos[1],pos[2],pos[3]) )
	local retPos = { posVec:GetX(), posVec:GetY(), posVec:GetZ() }
	local retRotY = rotY + Tpp.GetRotationY( rotQuat )
	return retPos, retRotY
end

function mtbs_cluster.GetPosAndRotY_FOB( clusterName, plntName, pos, rotY )
	local plntCenterPos, rotQuat = mtbs_cluster.GetDemoCenter( clusterName, plntName )
	local posVec = plntCenterPos + rotQuat:Rotate( Vector3(pos[1],pos[2],pos[3]) )
	local retPos = { posVec:GetX(), posVec:GetY(), posVec:GetZ() }
	local retRotY = rotY - Tpp.GetRotationY( rotQuat )
	return retPos, retRotY
end





function mtbs_cluster.OnAllocate()
	Fox.Log("############### mtbs_cluster.OnAllocate ###############")
	mtbs_cluster._SetupClusterConstructState()
end









mtbs_cluster._SetupClusterConstructState = function ()
	Fox.Log("######## SetClusterConstructState ########")
	
	mvars.mtbsClst_constructTable = {}

	
	for clusterId, clusterName in ipairs( TppDefine.CLUSTER_NAME ) do
		mvars.mtbsClst_constructTable[clusterId] = TppLocation.GetMbStageClusterGrade( clusterId )
		Fox.Log("######## SetClusterConstructState @ " .. tostring(clusterName).." : Lv:" .. tostring(mvars.mtbsClst_constructTable[clusterId]) .. "########")
	end
end

return mtbs_cluster
