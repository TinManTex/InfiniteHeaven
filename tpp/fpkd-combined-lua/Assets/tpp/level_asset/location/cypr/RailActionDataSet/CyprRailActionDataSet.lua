CyprRailActionDataSet = {

Init = function( data )
	Fox.Log("RailActionData Init")

	data:ClearNodeData()
	data:ClearDirectNodeData()

	
	data:AddDirectNodeDataStart("Path01")
	data:AddDirectNodeData(-38.26592,105.71256,-1716.35727,-50) 

	data:AddDirectNodeData(-38.53404,105.375,-1716.13229,-50)
	data:AddDirectNodeData(-39.07027,105.375,-1715.68233,-50)
	data:AddDirectNodeData(-39.56257,105.375,-1715.49117,-95)
	data:AddDirectNodeData(-39.91124,105.375,-1715.52167,-95)
	data:AddDirectNodeData(-40.25991,105.375,-1715.55217,-95) 
	data:AddDirectNodeData(-40.93606,105.375,-1715.37099,-75)
	data:AddDirectNodeData(-41.335,105.375,-1715.00527,-80)
	data:AddDirectNodeData(-41.94122,105.375,-1714.65527,-60)
	data:AddDirectNodeData(-42.39117,105.375,-1714.11903,-40)

	data:AddDirectNodeData(-42.84113,105.375,-1713.5828,-40) 
	data:AddDirectNodeData(-43.18928,105.375,-1712.95098,-20)
	data:AddDirectNodeData(-43.25006,105.375,-1712.6063,-10)

	data:AddDirectNodeData(-43.4131,105.375,-1711.86921,-30)
	data:AddDirectNodeData(-43.87961,105.375,-1711.56119,-75)
	data:AddDirectNodeData(-44.57362,105.375,-1711.46982,-82.5) 
	data:AddDirectNodeData(-45.27362,105.375,-1711.46982,-90)
	data:AddDirectNodeData(-45.97362,105.375,-1711.46982,-90)
	data:AddDirectNodeData(-46.37695,105.375,-1711.50018,-90)
	data:AddDirectNodeData(-47.42695,105.375,-1711.50018,-90)
	data:AddDirectNodeData(-48.47695,105.375,-1711.50018,-90) 
	data:AddDirectNodeData(-49.52695,105.375,-1711.50018,-90)
	data:AddDirectNodeData(-50.57695,105.375,-1711.50018,-90)
	data:AddDirectNodeData(-51.62695,105.375,-1711.50018,-90)
	data:AddDirectNodeData(-52.42695,105.375,-1711.80018,-135)

	data:AddDirectNodeData(-53.47695,105.375,-1712.30018,-90) 
	data:AddDirectNodeData(-54.14695,105.375,-1712.40518,-90)
	data:AddDirectNodeData(-55.06445,105.375,-1712.40518,-90)

	data:AddDirectNodeData(-55.98195,105.375,-1712.40518,-90)
	data:AddDirectNodeData(-57.98195,105.375,-1712.70518,-120)
	data:AddDirectNodeData(-58.43816,105.375,-1713.31499,-165) 
	data:AddDirectNodeData(-58.70992,105.375,-1714.32921,-165)
	data:AddDirectNodeData(-58.98168,105.375,-1715.34343,-165)
	data:AddDirectNodeData(-59.25344,105.375,-1716.35765,-165)
	data:AddDirectNodeData(-59.39049,105.375,-1717.39867,-172.5)
	data:AddDirectNodeData(-59.39049,105.375,-1718.44867,-180) 
	data:AddDirectNodeData(-59.39049,105.375,-1719.49867,-180)
	data:AddDirectNodeData(-59.39049,105.375,-1720.54867,-180)
	data:AddDirectNodeData(-59.39049,105.375,-1721.59867,-180)
	data:AddDirectNodeData(-59.39049,105.375,-1722.64867,-180)

	
	data:AddDirectNodeDataStart("Path02")
	
	data:AddDirectNodeData(-58.75103,105.66856,-1713.06441,31.5696)
	
	data:AddDirectNodeData(-58.12005,105.66856,-1712.73461,68)
	data:AddDirectNodeData(-56.13181,105.66856,-1711.87854,90)
	data:AddDirectNodeData(-55.39321,105.66856,-1711.74831,80)
	data:AddDirectNodeData(-54.68844,105.66856,-1711.49179,70)
	data:AddDirectNodeData(-53.98367,105.66856,-1711.23527,70)
	data:AddDirectNodeData(-53.27891,105.66856,-1710.97876,70)
	data:AddDirectNodeData(-52.5403,105.66856,-1710.84852,80)
	data:AddDirectNodeData(-51.7903,105.66856,-1710.84852,90)
	data:AddDirectNodeData(-51.4403,105.66856,-1711.74852,90)
	data:AddDirectNodeData(-50.79031,105.66856,-1711.74847,90)
	data:AddDirectNodeData(-50.14031,105.66856,-1711.74842,90)
	data:AddDirectNodeData(-49.49031,105.66856,-1711.74837,90)
	data:AddDirectNodeData(-48.42622,105.66856,-1711.09206,90)
	
	
	data:AddNodeData("Path01", 0, "STANCE", 0, "Weak" )
	
	data:AddNodeData("Path01", 0, "MOVE_INDEX_FOR_FORWARD", 6, "" )
	data:AddNodeData("Path01", 1, "MOVE_INDEX_FOR_FORWARD", 0, "" )
	data:AddNodeData("Path01", 2, "CONTINUITY_MOVE", 2, "WeakCartSet" ) 
	
	data:AddNodeData("Path01", 3, "MOVE_INDEX_FOR_FORWARD", 6, "" )
	data:AddNodeData("Path01", 4, "MOVE_INDEX_FOR_FORWARD", 7, "" )
	data:AddNodeData("Path01", 5, "MOVE_INDEX_FOR_FORWARD", 3, "" )
	data:AddNodeData("Path01", 6, "ACTION_ONCE", 0, "stateRailCircleChair" ) 
	data:AddNodeData("Path01", 7, "MOVE_INDEX_FOR_FORWARD", 3, "" )
	data:AddNodeData("Path01", 8, "MOVE_INDEX_FOR_FORWARD", 3, "" )

	data:AddNodeData("Path01", 9, "MOVE_INDEX_FOR_FORWARD", 0, "" )
	data:AddNodeData("Path01", 10, "MOVE_INDEX_FOR_FORWARD", 9, "" )
	data:AddNodeData("Path01", 11, "MOVE_INDEX_FOR_FORWARD", 10, "" )
	data:AddNodeData("Path01", 12, "MOVE_INDEX_FOR_FORWARD", 8, "" )
	data:AddNodeData("Path01", 13, "MOVE_INDEX_FOR_FORWARD", 4, "" )	
	data:AddNodeData("Path01", 14, "MOVE_INDEX_FOR_FORWARD", 5, "" )
	data:AddNodeData("Path01", 15, "MOVE_INDEX_FOR_FORWARD", 5, "" )
	data:AddNodeData("Path01", 17, "ACTION_ONCE", 0, "stateRailToAllFours" ) 
	data:AddNodeData("Path01", 17, "STANCE", 0, "AllFours" )
	data:AddNodeData("Path01", 18, "MOVE_INDEX_FOR_FORWARD", 0, "" )
	data:AddNodeData("Path01", 20, "MOVE_INDEX_FOR_FORWARD", 4, "" )
	data:AddNodeData("Path01", 22, "MOVE_INDEX_FOR_FORWARD", 3, "" )
	data:AddNodeData("Path01", 23, "MOVE_INDEX_FOR_FORWARD", 1, "" )
	data:AddNodeData("Path01", 24, "MOVE_INDEX_FOR_FORWARD", 7, "" )
	
	data:AddNodeData("Path01", 25, "CONTINUITY_MOVE", 2, "BenchSet" ) 
	data:AddNodeData("Path01", 25, "STANCE", 0, "Bench" )
	data:AddNodeData("Path01", 28, "ACTION_ONCE", 0, "stateRailEnd" ) 
	data:AddNodeData("Path01", 28, "STANCE", 0, "AllFours" )
	
	data:AddNodeData("Path01", 29, "MOVE_INDEX_FOR_FORWARD", 6, "" )
	data:AddNodeData("Path01", 30, "MOVE_INDEX_FOR_FORWARD", 5, "" )
	data:AddNodeData("Path01", 33, "MOVE_INDEX_FOR_FORWARD", 2, "" )
	data:AddNodeData("Path01", 34, "MOVE_INDEX_FOR_FORWARD", 2, "" )		
	data:AddNodeData("Path01", 35, "MOVE_INDEX_FOR_FORWARD", 5, "" )		
	
	data:AddNodeData("Path01", 36, "CONTINUITY_MOVE", 3, "BeforeVolginSet" )		
	

	
	data:AddNodeData("Path02", 0, "STANCE", 0, "Dislocation" )
	data:AddNodeData("Path02", 0, "MOVE_INDEX_FOR_FORWARD", 4, "" )
	data:AddNodeData("Path02", 1, "CONTINUITY_MOVE", 3, "DlBenchSet" )

	data:AddNodeData("Path02", 2, "MOVE_INDEX_FOR_FORWARD", 5, "" )
	data:AddNodeData("Path02", 3, "MOVE_INDEX_FOR_FORWARD", 2, "" )	
	data:AddNodeData("Path02", 6, "MOVE_INDEX_FOR_FORWARD", 3, "" )
	data:AddNodeData("Path02", 7, "MOVE_INDEX_FOR_FORWARD", 7, "" )	
	data:AddNodeData("Path02", 8, "STANCE", 0, "Handrail" )
	data:AddNodeData("Path02", 8, "ACTION_ONCE", 1, "stateRailToHnr" )
	data:AddNodeData("Path02", 12, "ACTION_ONCE", 1, "stateRailToDlSq" )
	data:AddNodeData("Path02", 12, "STANCE", 0, "DislocationSquat" )
	data:AddNodeData("Path02", 13, "CONTINUITY_MOVE", 4, "DislocationSquatSet" )
	
	
	data:ClearAttachData()
	data:AddAttachData("stateRailEnd", "Ashtray", "MTP_GLOBAL_B" )
	data:AddAttachData("stateRailWagon", "Wagon", "MTP_GLOBAL_B")
	data:AddAttachData("stateRailWagonEnd", "Wagon", "MTP_GLOBAL_B")
	data:AddAttachData("stateRailWheelChair", "WheelChair", "MTP_GLOBAL_B")
	

	data:ClearMotionObjectData();
	data:AddMotionObjectData("stateRailCircleChair", "CircleChairWillBeOverturned", "/Assets/tpp/motion/SI_game/fani/props/char/charp21/charp21_4_wk_cir.gani" )
	data:AddMotionObjectData("stateRailWagon", "EquipmentOnTheCart", "/Assets/tpp/motion/SI_demo/fani/p21_mdeq004/skl/bodies/vrtn09/p21_mdeq004_vrtn009_an_a_B.gani" )
	data:AddMotionObjectData("stateRailWagonIdle", "EquipmentOnTheCart", "/Assets/tpp/motion/SI_demo/fani/p21_mdeq004/skl/bodies/vrtn09/p21_mdeq004_vrtn009_an_b_B.gani" )
	data:AddMotionObjectData("stateRailWagonEnd", "EquipmentOnTheCart", "/Assets/tpp/motion/SI_demo/fani/p21_mdeq004/skl/bodies/vrtn09/p21_mdeq004_vrtn009_an_c_B.gani" )

	
	data:ClearContinuityMoveData()
	
	data:AddContinuityMoveData("WeakCartSet", 0, "stateRailWagon", "stateRailWagonIdle", 11, "stateRailWagonEnd")
	data:AddContinuityMoveData("WeakCartSet", 1, "stateRailWagonEnd", "stateRailIdle", 0, "Empty")

	data:AddContinuityMoveData("BenchSet", 0, "stateRailToBench", "stateRailIdle", 1, "stateRailBenchSmallWalk")
	data:AddContinuityMoveData("BenchSet", 1, "stateRailBenchSmallWalk", "stateRailIdle", 0, "Empty")

	data:AddContinuityMoveData("BeforeVolginSet", 0, "stateRailToVol2", "stateRailIdle", 0, "stateRailToVol1")
	data:AddContinuityMoveData("BeforeVolginSet", 1, "stateRailToVol1", "stateRailIdle", 0, "stateRailToVol")
	data:AddContinuityMoveData("BeforeVolginSet", 2, "stateRailToVol", "Empty", 0, "Empty")

	data:AddContinuityMoveData("DlBenchSet", 0, "stateRailDlBench", "stateRailIdle", 8, "stateRailDlBenchEnd")
	data:AddContinuityMoveData("DlBenchSet", 1, "stateRailDlBenchEnd", "stateRailIdle", 9, "stateRailDlBenchEndSmallWalk")	
	data:AddContinuityMoveData("DlBenchSet", 2, "stateRailDlBenchEndSmallWalk", "stateRailIdle", 0, "Empty")	

	data:AddContinuityMoveData("DislocationSquatSet", 0, "stateRailMoveForward1", "stateRailIdle", 0, "stateRailMoveForward2")
	data:AddContinuityMoveData("DislocationSquatSet", 1, "stateRailMoveForward2", "stateRailIdle", 2, "stateRailMoveForward3")
	data:AddContinuityMoveData("DislocationSquatSet", 2, "stateRailMoveForward3", "stateRailIdle", 0, "stateRailMoveForward4")
	data:AddContinuityMoveData("DislocationSquatSet", 3, "stateRailMoveForward4", "Empty", 0, "Empty")

end,

}