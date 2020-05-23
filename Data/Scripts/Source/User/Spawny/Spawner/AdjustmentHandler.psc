Scriptname spawny:spawner:AdjustmentHandler extends Quest

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

String sStateUnstarted = "Unstarted" Const
String sStateOperating = "Operating" Const
String sStateShutdown = "Shutdown" Const

Spawny:Spawner[] spawners = None

Bool Function isState(String sValue)
	return GetState() == sValue
EndFunction

Bool Function isUnstarted()
	return isState(sStateUnstarted)
EndFunction

Function goToUnstarted()
	GoToState(sStateUnstarted)
EndFunction

Bool Function isOperating()
	return isState(sStateOperating)
EndFunction

Function goToOperating()
	GoToState(sStateOperating)
EndFunction

Bool Function isShutdown()
	return isState(sStateShutdown)
EndFunction

Function goToShutdown()
	GoToState(sStateShutdown)
EndFunction

Function postAdjustment(Spawny:Spawner spawner)
	if (!spawner)
		return
	endif
	
	Spawny:ObjectReference spawnyObject = spawner.getSpawnedReference() as Spawny:ObjectReference
	spawnyObject && spawnyObject.spawn()
EndFunction

Event Spawny:Spawner.ReferenceLoaded(Spawny:Spawner spawner, Var[] args)
	
EndEvent

Function observeSpawner(Spawny:Spawner spawner)
	RegisterForCustomEvent(spawner, "ReferenceLoaded")
EndFunction

Function stopObservingSpawner(Spawny:Spawner spawner)
	UnregisterForCustomEvent(spawner, "ReferenceLoaded")
EndFunction

Function registerSpawner(Spawny:Spawner spawner)
	if (!spawner)
		return
	endif
	
	Spawny:Logger.log(spawner + " will be adjusted")
	spawners.Add(spawner)
	observeSpawner(spawner)
EndFunction

Function register(Spawny:Spawner spawner)
	
EndFunction

Event OnQuestShutdown()
	goToShutdown()
EndEvent

Auto State Unstarted
	Event OnQuestInit()
		spawners = new Spawny:Spawner[0]
		goToOperating()
	EndEvent
	
	Function register(Spawny:Spawner spawner)
		Spawny:Logger.log(self + " is being started by " + spawner)
		Start()
		registerSpawner(spawner)
	EndFunction
EndState

State Operating
	Function register(Spawny:Spawner spawner)
		registerSpawner(spawner)
	EndFunction
	
	Event Spawny:Spawner.ReferenceLoaded(Spawny:Spawner spawner, Var[] args)
		Int iIndex = -1
		if (spawner)
			iIndex = spawners.Find(spawner)
		endif
		if (iIndex < 0)
			return
		endif
		
		Spawny:Logger.log(spawner + " is being adjusted")
		if (spawner.adjust())
			spawners.Remove(iIndex)
			stopObservingSpawner(spawner)
			postAdjustment(spawner)
		endif
	EndEvent
EndState

State Shutdown
	Event OnBeginState(String asOldState)
		Int iCounter = 0
		while (iCounter < spawners.Length)
			stopObservingSpawner(spawners[iCounter])
			iCounter += 1
		endWhile
		
		spawners = None
	EndEvent
EndState
