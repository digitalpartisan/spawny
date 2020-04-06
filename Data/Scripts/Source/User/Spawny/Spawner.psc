Scriptname Spawny:Spawner extends Quest Hidden
{This script defines the basic functionality of a Spawner object.
Reference child scripts in the Spawny:Spawner namespace for implementation details and possible use cases.}

CustomEvent Spawned

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
{Returns the ObjectReference spawned by this spawner.  Returns None when no such ObjectReference exists.}
	return spawnedObject
EndFunction

Bool Function hasSpawnedReference()
{True if this spawner has a handle to a reference (which is presumed to be the reference spawned by this spawner) and false otherwise (which would indicate that no reference has been spawned.)}
	return None != getSpawnedReference()
EndFunction

Function setSpawnedReference(ObjectReference akNewValue)
{Used in order to allow child scripts access to the variable they would otherwise be unable to alter.}
	spawnedObject = akNewValue
EndFunction

Function clearSpawnedReference()
{Resets the variable used to point to the spawned reference.
Called by internal logic as a helper method.
Avoid using this unless you're sure of what you're doing.}
	setSpawnedReference(None)
EndFunction

Form Function getForm()
{Returns the form the spawner is expected to spawn.
See child scripts for possible implementation details.}
	Spawny:Logger.logBehaviorUndefined(self, "getForm")
	return None
EndFunction

ObjectReference Function getReference()
{Returns the target reference which is used as the location at which to spawn the given form.
See child scripts for possible implementation details.}
	Spawny:Logger.logBehaviorUndefined(self, "getReference")
	return None
EndFunction

ObjectReference Function spawnBehavior()
{Performs the actual spawning and returns the newly spawned ObjectReference.}
	if ("" == NodeName)
		return PlaceOptions(getForm(), getReference(), PlacementOptions)
	else
		return placeAtNodeOptions(getForm(), getReference(), NodeName, PlacementOptions, Attach)
	endif
EndFunction

Function spawn()
{Causes the spawner to spawn the specified form at the specified target reference.
Do not call this directly unless you're sure of what you're doing.
Use of Start() on the quest record is a much better way to invoke this behavior.}
	Spawny:Logger:Spawner.logSpawning(self)
	setSpawnedReference(spawnBehavior())
	
	if (hasSpawnedReference() && Modifier)
		Modifier.apply(getSpawnedReference())
	endif
	
	SendCustomEvent("Spawned")
EndFunction

Function despawn()
{Causes the spawner to disable and delete the spawned reference.
Do not call this directory unless you're sure of what you're doing.
Use of Stop() on the quest record is a much better way to invoke this behavior.}
	ObjectReference myReference = getSpawnedReference()
	if (myReference)
		clearSpawnedReference()
		myReference.Disable()
		myReference.Delete()
	endif
EndFunction

Function startupBehavior()
{See cautionary note on spawn().  Prefer the use of Start() on the quest record to calling this method.}
	spawn()
EndFunction

Function shutdownBehavior()
{See cautionary note on despawn().  Prefer the use of Stop() on the quest record to calling this method.}
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
