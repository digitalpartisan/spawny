Scriptname Spawny:Spawner:Placed extends Spawny:Spawner
{This spawner is appropriate for treating placed objects as the result of a Spawny Spawner. This is especially helpful when using a debug terminal (see the Spawny:Debug scripts) to visit spawned objects while testing a plugin.}

ObjectReference Property PlacedObject Auto Const Mandatory

ObjectReference Function spawnBehavior()
	return PlacedObject
EndFunction

Function despawn()
	ObjectReference myReference = getSpawnedReference()
	if (myReference)
		clearSpawnedReference()
		myReference.Disable()
	endif
EndFunction
