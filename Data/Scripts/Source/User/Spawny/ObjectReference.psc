Scriptname Spawny:ObjectReference extends ObjectReference

Struct ChildPlacement
	String name = ""
	Spawny:ObjectReference:Child spawnMe = None
	ObjectReference reference = None
EndStruct

ChildPlacement[] Property Children Auto Mandatory
{If this array were labeled Const, the spawned references would not be persisted in the individual structs after a game load.}
Bool Property ChildrenMustAlwaysExist = false Auto Const

String sStateDespawned = "Despawned" Const
String sStateSpawning = "Spawning" Const
String sStateSpawned = "Spawned" Const

Bool bRespawn = false

Function goToDespawned()
	GoToState(sStateDespawned)
EndFunction

Function goToSpawning()
	GoToState(sStateSpawning)
EndFunction

Function goToSpawned()
	GoToState(sStateSpawned)
EndFunction

ChildPlacement Function findChildByReference(ObjectReference akTarget)
	ChildPlacement result = None
	Int iIndex = Children.FindStruct("reference", akTarget)
	if (iIndex >= 0)
		result = Children[iIndex]
	endif
	
	return result
EndFunction

ObjectReference Function getChildReference(String asChildName)
	ChildPlacement result = None
	Int iIndex = Children.FindStruct("name", asChildName)
	if (iIndex >= 0)
		result = Children[iIndex]
	endif
	
	if (result)
		return result.reference
	else
		return None
	endif
EndFunction

Function observeContainerChange(ChildPlacement childToObserve)
	RegisterForRemoteEvent(childToObserve.reference, "OnContainerChanged")
EndFunction

Function stopObservingContainerChange(ChildPlacement childToStopObserving)
	UnregisterForRemoteEvent(childToStopObserving.reference, "OnContainerChanged")
EndFunction

Event ObjectReference.OnContainerChanged(ObjectReference akSender, ObjectReference akNewContainer, ObjectReference akOldContainer)
	ChildPlacement childToHandle = findChildByReference(akSender)
	if (childToHandle)
		Spawny:Logger:ObjectReference.logContainerChanged(self, childToHandle)
		clearChild(childToHandle, false)
	endif
EndEvent

Function clearChild(ChildPlacement childToClear, Bool bDestroy = true)
	if (!childToClear || !childToClear.reference)
		return
	endif
	
	stopObservingContainerChange(childToClear)
	if (bDestroy)
		childToClear.reference.Disable()
		childToClear.reference.Delete()
	endif
	
	childToClear.reference = None
EndFunction

Function clearChildren()
	
EndFunction

Function spawnChild(ChildPlacement childToSpawn)

EndFunction

Function spawn()
	
EndFunction

Event OnWorkshopObjectPlaced(ObjectReference akReference)
	goToSpawning()
EndEvent

Event OnWorkshopObjectGrabbed(ObjectReference akReference)
	goToDespawned()
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akReference)
	goToDespawned()
EndEvent

Function Disable(Bool abFadeOut = false)
	Spawny:Logger:ObjectReference.logDisabled(self)
	goToDespawned()
	parent.Disable(abFadeOut)
EndFunction

Function Delete()
	Spawny:Logger:ObjectReference.logDeleted(self)
	goToDespawned()
	parent.Delete()
EndFunction

Event OnUnload()
	Spawny:Logger:ObjectReference.logUnloaded(self)
	!ChildrenMustAlwaysExist && goToDespawned()
EndEvent

Auto State Despawned
	Event OnBeginState(String asOldState)
		if (!Children || 0 == Children.Length)
			return
		endIf
		
		Spawny:Logger:ObjectReference.logDespawning(self)
		
		Int iCounter = 0
		while (iCounter < Children.Length)
			clearChild(Children[iCounter])
			iCounter += 1
		endWhile
	EndEvent
	
	Event OnInit()
		Spawny:Logger:ObjectReference.log(self + " init while despawned")
		ChildrenMustAlwaysExist && IsEnabled() && goToSpawning()
	EndEvent
	
	Function Enable(Bool abFadeIn = false)
		Spawny:Logger:ObjectReference.log(self + " enabled while despawned")
		parent.Enable(abFadeIn)
		ChildrenMustAlwaysExist && goToSpawning()
	EndFunction
	
	Event OnLoad()
		Spawny:Logger:ObjectReference.log(self + " loaded while despawned")
		IsEnabled() && goToSpawning()
	EndEvent
	
	Function spawn()
		bRespawn = true ; edge case for non-persistent objects (i.e. ChildrenMustAlwaysExist = false) that are spawning and adjusting at the same time
	EndFunction
EndState

State Spawning
	Event OnBeginState(String asOldState)
		bRespawn = false
		
		if (Children && Children.Length)
			Spawny:Logger:ObjectReference.logSpawning(self)
		
		Int iCounter = 0
		while (iCounter < Children.Length)
			spawnChild(Children[iCounter])
			iCounter += 1
		endWhile
		endif
		
		goToSpawned()
	EndEvent
	
	Function spawnChild(ChildPlacement childToSpawn)
		if (!childToSpawn || !childToSpawn.spawnMe || !childToSpawn.name)
			return
		endif
		
		clearChild(childToSpawn)
		childToSpawn.reference = childToSpawn.spawnMe.spawnReference(self)
		if (childToSpawn.reference)
			observeContainerChange(childToSpawn)
		else
			Spawny:Logger:ObjectReference.logFailureToSpawn(self, childToSpawn)
		endif
	EndFunction
	
	Function spawn()
		bRespawn = true ; edge case for non-persistent objects (i.e. ChildrenMustAlwaysExist = false) that are spawning and adjusting at the same time
	EndFunction
EndState

State Spawned
	Event OnBeginState(String asOldState)
		bRespawn && goToSpawning()
	EndEvent

	Function spawn()
		goToSpawning()
	EndFunction
EndState
