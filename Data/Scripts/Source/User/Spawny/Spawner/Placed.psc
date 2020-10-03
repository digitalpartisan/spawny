Scriptname Spawny:Spawner:Placed extends Spawny:Spawner
{This spawner is appropriate for treating placed objects as the result of a Spawny Spawner.  This is especially useful in making sure precombines are not broken, unlike the Spawny:Spawner:Simple script.}

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
