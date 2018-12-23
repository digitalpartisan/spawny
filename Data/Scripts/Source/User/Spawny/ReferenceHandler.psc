Scriptname Spawny:ReferenceHandler extends Quest

CustomEvent ReferenceReady

Group ObservationSettings
	InjectTec:Plugin Property MyPlugin Auto Const Mandatory
	Int Property LocationID Auto Const Mandatory
	Int Property ReferenceID Auto Const Mandatory
	Int Property CellID = 0 Auto Const
EndGroup

Group StateCheckTimerSettings
	Int Property TimerID = 1 Auto Const
	GlobalVariable Property TimerDuration = None Auto Const
	Float Property DefaultTimerDuration = 30.0 Auto Const
EndGroup

String sStateDormant = "Dormant" Const
String sStateObserving = "Observing" Const
String sStateReady = "Ready" Const

Location targetLocation = None
Cell targetCell = None
ObjectReference myReference = None

Function goToDormant()
	GoToState(sStateDormant)
EndFunction

Function goToObserving()
	GoToState(sStateObserving)
EndFunction

Function goToReady()
	GoToState(sStateReady)
EndFunction

Bool Function hasCellSetting()
	return CellID > 0
EndFunction

Float Function getTimerDuration()
	if (TimerDuration)
		return TimerDuration.GetValue()
	endif
	
	return DefaultTimerDuration
EndFunction

Bool Function isPluginValid()
	return (MyPlugin && MyPlugin.isInstalled())
EndFunction

Location Function getLocation()
	return targetLocation
EndFunction

Bool Function hasLocation()
	return None != getLocation()
EndFunction

Function setLocation(Location akNewValue)
	targetLocation = akNewValue
EndFunction

Function clearLocation()
	setLocation(None)
EndFunction

Bool Function attemptLocationLoad()
	if (isPluginValid())
		setLocation(MyPlugin.lookupForm(LocationID) as Location)
	endif
	
	return hasLocation()
EndFunction

Bool Function isPlayerInLocation()
	if (!hasLocation())
		return false
	endif
	
	return Game.GetPlayer().isInLocation(getLocation())
EndFunction

Cell Function getCell()
	return targetCell
EndFunction

Bool Function hasCell()
	return None != getCell()
EndFunction

Function setCell(Cell akNewValue)
	targetCell = akNewValue
EndFunction

Function clearCell()
	setCell(None)
EndFunction

Bool Function attemptCellLoad()
	if (isPluginValid())
		setCell(MyPlugin.lookupForm(CellID) as Cell)
	endif
	
	return hasCell()
EndFunction

Bool Function isCellLoaded()
	if (!hasCell())
		return false
	endif
	
	return getCell().IsLoaded()
EndFunction

ObjectReference Function getReference()
	return myReference
EndFunction

Bool Function hasReference()
	return None != getReference()
EndFunction

Function setReference(ObjectReference akNewValue)
	myReference = akNewValue
EndFunction

Function clearReference()
	setReference(None)
EndFunction

Bool Function attemptReferenceLoad()
	if (isPluginValid())
		setReference(MyPlugin.lookupForm(ReferenceID) as ObjectReference)
	endif
	
	if (hasReference())
		Spawny:Logger.log(self + " got a reference!")
		goToReady()
	endif
EndFunction

Function sendReferenceReady()
	
EndFunction

Function observe()
	
EndFunction

Function stateCheck()
	
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
	if (Game.GetPlayer() == akSender)
		Spawny:Logger.log(self + " detected a game load")
		stateCheck()
	endif
EndEvent

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
	if (Game.GetPlayer() == akSender)
		Spawny:Logger.log(self + " detected a location change")
		cancelCheckTimer()
		stateCheck()
	endif
EndEvent

Event OnTimer(Int aiTimerID)
	if (TimerID == aiTimerID)
		Spawny:Logger.log(self + " detected a timer event")
		stateCheck()
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

Function startCheckTimer()
	StartTimer(getTimerDuration(), TimerID)
EndFunction

Function cancelCheckTimer()
	CancelTimer(TimerID)
EndFunction

Function observeEvents()
	observeGameLoad()
	observeLocationChange()
EndFunction

Function stopObservingEvents()
	stopObservingLocationChange()
	stopObservingGameLoad()
	cancelCheckTimer()
EndFunction

Auto State Dormant
	Event OnBeginState(String asOldState)
		stopObservingEvents()
	EndEvent

	Function observe()
		goToObserving()
	EndFunction
EndState

State Observing
	Event OnBeginState(String asOldState)
		if (!isPluginValid())
			Spawny:Logger.log(self + " has invalid plugin")
			goToDormant()
			return
		endif
		
		if (!attemptLocationLoad())
			Spawny:Logger.log(self + " has invalid location ID")
			goToDormant()
			return
		endif
		
		Spawny:Logger.log(self + "loaded everything")
		
		observeEvents()
		stateCheck()
	EndEvent
	
	Function stateCheck()
		Spawny:Logger.log(self + " is checking state")
		
		if (!isPluginValid()); paranoia, but if the plugin is suddenly out of the load order, drop everything for the sake of safety
			goToDormant()
		endif
		
		if (isPlayerInLocation())
			if (hasCellSetting())
				if (attemptCellLoad())
					Spawny:Logger.log(self + " detected its cell is loaded")
					attemptReferenceLoad()
				endif
				
				if (!hasReference())
					startCheckTimer()
				endif
			else
				attemptReferenceLoad()
			endif
		endif
	EndFunction
EndState

State Ready
	Event OnBeginState(String asOldState)
		if (hasReference())
			sendReferenceReady()
		else
			goToObserving()
		endif
	EndEvent
	
	Function sendReferenceReady()
		Spawny:Logger.log(self + " sent reference ready")
		SendCustomEvent("ReferenceReady")
	EndFunction
EndState
