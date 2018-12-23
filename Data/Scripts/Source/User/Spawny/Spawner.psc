Scriptname Spawny:Spawner extends Quest Hidden

Import Spawny:Utility:Placement

Options Property PlacementOptions = None Auto Const
Spawny:Modifier Property Modifier = None Auto Const
String Property NodeName = "" Auto Const
Bool Property Attach = false Auto Const

ObjectReference spawnedObject = None

ObjectReference Function getSpawnedReference()
	return spawnedObject
EndFunction

Bool Function hasSpawnedReference()
	return None != getSpawnedReference()
EndFunction

Function setSpawnedReference(ObjectReference akNewValue)
	spawnedObject = akNewValue
EndFunction

Function clearSpawnedReference()
	setSpawnedReference(None)
EndFunction

Form Function getForm()
	Spawny:Logger.logBehaviorUndefined(self, "getForm")
	return None
EndFunction

ObjectReference Function getReference()
	Spawny:Logger.logBehaviorUndefined(self, "getReference")
	return None
EndFunction

ObjectReference Function spawnBehavior()
	if ("" == NodeName)
		return PlaceOptions(getForm(), getReference(), PlacementOptions)
	else
		return placeAtNodeOptions(getForm(), getReference(), NodeName, PlacementOptions, Attach)
	endif
EndFunction

Function spawn()
	Spawny:Logger:Spawner.logSpawning(self)
	setSpawnedReference(spawnBehavior())
	
	if (hasSpawnedReference() && Modifier)
		Modifier.apply(getSpawnedReference())
	endif
EndFunction

Function despawn()
	ObjectReference myReference = getSpawnedReference()
	if (myReference)
		clearSpawnedReference()
		myReference.Disable()
		myReference.Delete()
	endif
EndFunction

Function startupBehavior()
	spawn()
EndFunction

Function shutdownBehavior()
	despawn()
EndFunction

Event OnQuestInit()
	Spawny:Logger:Spawner.logStartup(self)
	startupBehavior()
EndEvent

Event OnQuestShutdown()
	Spawny:Logger:Spawner.logShutdown(self)
	shutdownBehavior()
EndEvent
