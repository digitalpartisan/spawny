Scriptname Spawny:ObjectReference extends ObjectReference

Struct ChildPlacement
	String name = ""
	Spawny:ObjectReference:Child spawnMe = None
	ObjectReference reference = None
EndStruct

ChildPlacement[] Property Children Auto Mandatory
{If this array were labeled Const, the spawned references would not be persisted in the individual structs after a game load.}
Bool Property PersistThroughUnload = false Auto Const

String sStateDespawned = "Despawned" Const
String sStateSpawned = "Spawned" Const

Function goToDespawned()
	GoToState(sStateDespawned)
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
	
EndFunction

Function stopObservingContainerChange(ChildPlacement childToStopObserving)
	UnregisterForRemoteEvent(childToStopObserving.reference, "OnContainerChanged")
EndFunction

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

Function spawnChild(ChildPlacement childToSpawn)

EndFunction

Event ObjectReference.OnContainerChanged(ObjectReference akSender, ObjectReference akNewContainer, ObjectReference akOldContainer)
	
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
	
	Event OnWorkshopObjectPlaced(ObjectReference akReference)
		goToSpawned()
	EndEvent
	
	Function Enable(Bool abFadeIn = false)
		Spawny:Logger:ObjectReference.logEnabled(self)
		parent.Enable(abFadeIn)
		Is3DLoaded() && goToSpawned()
	EndFunction
	
	Event OnInit()
		Spawny:Logger:ObjectReference.logInitialized(self)
		PersistThroughUnload && IsEnabled() && goToSpawned()
	EndEvent
	
	Event OnLoad()
		Spawny:Logger:ObjectReference.logLoaded(self)
		!PersistThroughUnload && IsEnabled() && goToSpawned()
	EndEvent
EndState

State Spawned
	Event OnBeginState(String asOldState)
		if (!Children || 0 == Children.Length)
			return
		endif
		
		Spawny:Logger:ObjectReference.logSpawning(self)
		
		Int iCounter = 0
		while (iCounter < Children.Length)
			spawnChild(Children[iCounter])
			iCounter += 1
		endWhile
	EndEvent
	
	Function spawnChild(ChildPlacement childToSpawn)
		if (!childToSpawn || !childToSpawn.spawnMe || !childToSpawn.name)
			return
		endif
		
		clearChild(childToSpawn)
		childToSpawn.reference = childToSpawn.spawnMe.spawnReference(self, childToSpawn.name)
		observeContainerChange(childToSpawn)
	EndFunction
	
	Function observeContainerChange(ChildPlacement childToObserve)
		RegisterForRemoteEvent(childToObserve.reference, "OnContainerChanged")
	EndFunction
	
	Event ObjectReference.OnContainerChanged(ObjectReference akSender, ObjectReference akNewContainer, ObjectReference akOldContainer)
		ChildPlacement childToHandle = findChildByReference(akSender)
		if (childToHandle)
			Spawny:Logger:ObjectReference.logContainerChanged(self, childToHandle)
			clearChild(childToHandle, false)
		endif
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
		!PersistThroughUnload && goToDespawned()
	EndEvent
EndState
