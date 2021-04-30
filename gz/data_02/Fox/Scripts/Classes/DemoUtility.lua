




DemoUtility = {










GetDataBodyFromEditor = function( className )

	return DemoUtility.SearchDataBodies( className, false )

end, 






GetDataBodiesFromEditor = function( className )

	return DemoUtility.SearchDataBodies( className, true )

end, 










SearchDataBodies = function( className, all )

	local app = Application.GetInstance()
	local game = app:GetMainGame()

	if not game:IsKindOf( Editor ) then
		return nil
	end
	local editor = game

	local bodies = {}

	local buckets = editor:GetEditableBucketList()
	for bucketName, bucket in pairs( buckets ) do

		local bodySet = bucket:GetEditableDataBodySet()
		local bodyList = bodySet:GetDataBodyList()
		for dataName, body in pairs( bodyList ) do

			if className == body:GetClassName() then
				if not all then
					return body
				end
				table.insert( bodies, body )
			end
		end
	end

	return all and bodies or nil

end, 


} 
