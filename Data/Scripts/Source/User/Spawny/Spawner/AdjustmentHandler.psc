Scriptname Spawny:Spawner:AdjustmentHandler extends Quest
{This quest should be running prior to register() being called, though the failure case in this scenario has been somewhat hedged.}

Jiffy:List Property Spawners Auto Const Mandatory

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

String sStateUnstarted = "Unstarted" Const
String sStateOperating = "Operating" Const
String sStateShutdown = "Shutdown" Const

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
	if (!spawner || !spawner.hasSpawnedReference() || !Spawners.Add(spawner))
		Spawny:Logger.log(self + " will not adjust spawner " + spawner)
		return
	endif
	
	Spawny:Logger.log(spawner + " will be adjusted")
	observeSpawner(spawner)
EndFunction

Function register(Spawny:Spawner spawner)
	
EndFunction

Event OnQuestShutdown()
	goToShutdown()
EndEvent

Auto State Unstarted
	Event OnQuestInit()
		goToOperating()
	EndEvent
	
	Function register(Spawny:Spawner spawner)
		Start()
		registerSpawner(spawner)
	EndFunction
EndState

State Operating
	Function register(Spawny:Spawner spawner)
		registerSpawner(spawner)
	EndFunction
	
	Event Spawny:Spawner.ReferenceLoaded(Spawny:Spawner spawner, Var[] args)
		if (!Spawners.has(spawner))
			return
		endif
		
		Spawny:Logger.log(spawner + " is being adjusted")
		if (spawner.adjust())
			Spawners.Remove(spawner)
			stopObservingSpawner(spawner)
			postAdjustment(spawner)
		else
			Spawny:Logger.log(spawner + " failed to adjust")
		endif
	EndEvent
EndState

State Shutdown
	Event OnBeginState(String asOldState)
		Int iCounter = 0
		Spawny:Spawner[] spawnerSet = Spawners.getData() as Spawny:Spawner[]
		while (iCounter < spawnerSet.Length)
			stopObservingSpawner(spawnerSet[iCounter])
			iCounter += 1
		endWhile
		
		Spawners.clear()
	EndEvent
EndState
