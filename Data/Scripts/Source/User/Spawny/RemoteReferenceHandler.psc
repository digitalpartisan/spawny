Scriptname Spawny:RemoteReferenceHandler extends Quest Hidden

Group ReferenceSettings
	InjectTec:Plugin Property MyPlugin Auto Const Mandatory
	Int Property LocationID Auto Const Mandatory
	Int Property ReferenceID Auto Const Mandatory
EndGroup

String sStateDormant = "Dormant" Const
String sStateWaiting = "Waiting" Const
String sStateLoaded = "Loaded" Const

Location targetLocation = None
ObjectReference targetReference = None

Bool Function isPluginValid()
	return (MyPlugin && MyPlugin.isInstalled())
EndFunction

Location Function getLocation()
	return targetLocation
EndFunction

ObjectReference Function getReference()
	return targetReference
EndFunction

Event OnQuestShutdown()
	GoToState(sStateDormant)
EndEvent

Bool Function attemptLocationLoad()
	if (isPluginValid())
		targetLocation = MyPlugin.lookupForm(LocationID) as Location
	endif
	
	return targetLocation as Bool
EndFunction

Bool Function attemptReferenceLoad()
	if (isPluginValid())
		targetReference = MyPlugin.lookupForm(ReferenceID) as ObjectReference
	endif
	
	return targetReference as Bool
EndFunction

Function checkLocation(Location akLocation)
	
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
	if (Game.GetPlayer() == akSender)
		checkLocation(akSender.GetCurrentLocation())
	endif
EndEvent

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
	if (Game.GetPlayer() == akSender)
		checkLocation(akSender.GetCurrentLocation())
	endif
EndEvent

Function observeGameLoad()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

Function stopObservingGameLoad()
	UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

Function observeLocationChange()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
EndFunction

Function stopObservingLocationChange()
	UnregisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
EndFunction

ObjectReference Function spawnLogic()
	return None
EndFunction

Function spawn()
	
EndFunction

Auto State Dormant
	Event OnBeginState(String asOldState)
		stopObservingGameLoad()
		stopObservingLocationChange()
		targetLocation = None
		targetReference = None
	EndEvent
	
	Event OnQuestInit()
		GoToState(sStateWaiting)
	EndEvent
EndState

State Waiting
	Event OnBeginState(String asOldState)
		if (isPluginValid() && attemptLocationLoad())
			observeGameLoad()
			observeLocationChange()
			if (sStateLoaded != asOldState)
				checkLocation(Game.GetPlayer().GetCurrentLocation())
			endif
		else
			Stop()
		endif
	EndEvent
	
	Function checkLocation(Location akLocation)
		Spawny:Logger.log(self + " is checking location " + akLocation)
		Location spawnLocation = getLocation()
		if (!isPluginValid() || !spawnLocation)
			Spawny:Logger.log(self + " has failed horribly")
			Stop()
			return
		endif
			
		if (spawnLocation == akLocation)
			Spawny:Logger.log(self + " has matched")
			GoToState(sStateLoaded)
		endif
	EndFunction
EndState

State Loaded
	Event OnBeginState(String asOldState)
		stopObservingGameLoad()
		stopObservingLocationChange()
		
		if (attemptReferenceLoad())
			Spawny:Logger.log(self + " has loaded reference, spawning")
			spawn()
		else
			Spawny:Logger.log(self + " did not load reference")
			GoToState(sStateWaiting)
		endif
	EndEvent
EndState
