Scriptname Spawny:Spawner extends Quest Hidden
{This script defines the basic functionality of a Spawner object.
Reference child scripts in the Spawny:Spawner namespace for implementation details and possible use cases.}

CustomEvent Spawned
CustomEvent ReferenceLoaded

Import Spawny:Utility:Placement

Options Property PlacementOptions = None Auto Const
{Useful for tweaking the state of the placed object.  No effect is had for a None value.}
Spawny:Modifier Property Modifier = None Auto Const
{Useful for modifying the placed object after placement.  No effect is had for a None value.}

ObjectReference spawnedObject = None

Function sendSpawned()
	SendCustomEvent("Spawned")
EndFunction

Function sendLoaded()
	SendCustomEvent("ReferenceLoaded")
EndFunction

ObjectReference Function getSpawnedReference()
{Returns the ObjectReference spawned by this spawner.  Returns None when no such ObjectReference exists.}
	return spawnedObject
EndFunction

Bool Function hasSpawnedReference()
{True if this spawner has a handle to a reference (which is presumed to be the reference spawned by this spawner) and false otherwise (which would indicate that no reference has been spawned.)}
	return getSpawnedReference() as Bool
EndFunction

Event ObjectReference.OnLoad(ObjectReference akSender)
	getSpawnedReference() == akSender && sendLoaded()
EndEvent

Function setSpawnedReference(ObjectReference akNewValue)
{Used in order to allow child scripts access to the variable they would otherwise be unable to alter.}
	spawnedObject && UnregisterForRemoteEvent(spawnedObject, "OnLoad")
	spawnedObject = akNewValue
	spawnedObject && RegisterForRemoteEvent(spawnedObject, "OnLoad")
EndFunction

Function clearSpawnedReference()
{Resets the variable used to point to the spawned reference.
Called by internal logic as a helper method.
Avoid using this unless you're sure of what you're doing.}
	setSpawnedReference(None)
EndFunction

Spawny:Modifier Function getModifier()
	return Modifier
EndFunction

Bool Function hasModifier()
	return getModifier() as Bool
EndFunction

Spawny:Spawner:AdjustmentHandler Function getAdjuster()
{Override this method to specify the adjuster to use in case of a 3D settings failure upon spawning.  Leave as-is if you know for a fact post-spawning adjustments will not be required.}
	return None
EndFunction

Bool Function hasAdjuster()
	return getAdjuster() as Bool
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
	return place(getForm(), getReference(), PlacementOptions)
EndFunction

Function spawn()
{Causes the spawner to spawn the specified form at the specified target reference.
Do not call this directly unless you're sure of what you're doing.
Use of Start() on the quest record is a much better way to invoke this behavior.}
	Spawny:Spawner:Logger.logSpawning(self)
	
	setSpawnedReference(spawnBehavior())
	sendSpawned()
	hasModifier() && !getModifier().apply(getSpawnedReference()) && hasAdjuster() && getAdjuster().register(self)
EndFunction

Bool Function adjust()
	ObjectReference myReference = getSpawnedReference()
	Spawny:Modifier myModifier = getModifier()
	
	if (!myReference || !myModifier)
		return true ; no failure occurred
	endif
	
	return myModifier.apply3DSettings(myReference)
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

Bool Function goTo()
{Places the player at the spawned reference or as close to it as is possible.}
	if (hasSpawnedReference())
		Game.GetPlayer().MoveTo(getSpawnedReference())
		return true
	endif

	return false
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
	Spawny:Spawner:Logger.logStartup(self)
	startupBehavior()
EndEvent

Event OnQuestShutdown()
	Spawny:Spawner:Logger.logShutdown(self)
	shutdownBehavior()
EndEvent

Function handleBulk(Spawny:Spawner[] spawners, Bool bStart = true) Global
	if (!spawners || !spawners.Length)
		return
	endif
	
	Int iCounter = 0
	Spawny:Spawner target = None
	while (iCounter < spawners.Length)
		target = spawners[iCounter] as Spawny:Spawner
		if (target)
			if (bStart)
				target.Start()
			else
				target.Stop()
			endif
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function startBulk(Spawny:Spawner[] spawners) Global
	handleBulk(spawners)
EndFunction

Function stopBulk(Spawny:Spawner[] spawners) Global
	handleBulk(spawners, false)
EndFunction

Function startList(FormList spawners) Global
	handleBulk(Jiffy:Utility:FormList.toArray(spawners) as Spawny:Spawner[])
EndFunction

Function stopList(FormList spawners) Global
	handleBulk(Jiffy:Utility:FormList.toArray(spawners) as Spawny:Spawner[], false)
EndFunction
