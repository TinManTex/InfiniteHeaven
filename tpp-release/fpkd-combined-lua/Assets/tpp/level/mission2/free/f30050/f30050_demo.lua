local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = TppMbFreeDemo.demoList

this.demoBlockList = TppMbFreeDemo.demoBlockList

this.demoOptions = TppMbFreeDemo.demoOptions






this.PlayMtbsEventDemo = function( params )
	TppMbFreeDemo.PlayMtbsEventDemo( params )
end

function this.ChangeBlock( currentDemoName, nextDemoName )
	TppMbFreeDemo.ChangeBlock( currentDemoName, nextDemoName )
end

 
function this.GetNextDemo( demoName )
	return TppMbFreeDemo.GetNextDemo( demoName )
end

function this.GetDemoPlayCluster( demoName )
	return TppMbFreeDemo.GetDemoPlayCluster(demoName)
end

function this.HasPlant( demoName )
	return TppMbFreeDemo.HasPlant( demoName )
end

function this.GetDemoTime(demoName)
	return TppMbFreeDemo.GetDemoTime(demoName)
end

function this.DisableOcelot()
	TppMbFreeDemo.DisableOcelot()
end





function this.UpdatePackList(blockName)
	return TppMbFreeDemo.UpdatePackList(blockName)
end

function this.RegisterFovaPack( packList )
	TppMbFreeDemo.RegisterFovaPack( packList )
end

function this.SetupEnemy( demoName )
	TppMbFreeDemo.SetupEnemy( demoName )
end

function this.GetSoldierListInDemo(demoName)
	return TppMbFreeDemo.GetSoldierListInDemo(demoName)
end

function this.GetForceMaleSoldierList(demoName)
	return TppMbFreeDemo.GetForceMaleSoldierList(demoName)
end

function this.IsBalaclava( demoName, locatorName )
	return TppMbFreeDemo.IsBalaclava( demoName, locatorName )
end

function this.NeedLoadBuddyBlock( demoName )
	return TppMbFreeDemo.NeedLoadBuddyBlock( demoName )
end

function this.SetupBuddy( demoName )
	TppMbFreeDemo.SetupBuddy( demoName )
end

function this.IsShowReward( demoName ) 
	return TppMbFreeDemo.IsShowReward( demoName )
end




return this
