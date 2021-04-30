Scene = {

GetActorsByClassName = function( scene, className ) 
	actors = scene:GetActorList();
	return DataActor.GetActorsByClassName(actors, className)
end
}
