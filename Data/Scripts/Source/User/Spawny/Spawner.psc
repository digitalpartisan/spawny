Scriptname Spawny:Spawner extends Quest Hidden
{This script defines the basic functionality of a Spawner object.
Reference child scripts in the Spawny:Spawner namespace for implementation details and possible use cases.}

Import Spawny:Utility:Placement

Options Property PlacementOptions = None Auto Const
{Useful for tweaking the state of the placed object.  No effect is had for a None value.}
Spawny:Modifier Property Modifier = None Auto Const
{Useful for modifying the placed object after placement.  No effect is had for a None value.}
String Property NodeName = "" Auto Const
{The NIF node at which to place the object.  Only effective when a value is specified and the named node exists on the target reference's nif.}
Bool Property Attach = false Auto Const
{Whether or not to attach the spawned reference to the node.  Has no effect unless the conditions on NodeName are met.}

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
