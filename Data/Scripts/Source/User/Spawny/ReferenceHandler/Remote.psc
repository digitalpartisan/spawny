Scriptname Spawny:ReferenceHandler:Remote extends Spawny:ReferenceHandler

Group ReferenceSettings
	InjectTec:Plugin Property MyPlugin Auto Const Mandatory
	Int Property LocationID Auto Const Mandatory
	Int Property ReferenceID Auto Const Mandatory
	Int Property CellID = 0 Auto Const
	Int Property TimerID = 1 Auto Const
	GlobalVariable Property TimerDuration = None Auto Const
	Float Property DefaultTimerDuration = 60.0 Auto Const
EndGroup

Location targetLocation = None
Cell targetCell = None
ObjectReference targetReference = None

Function sendReferenceReady()
	stopEventObservation()
	parent.sendReferenceReady()
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

ObjectReference Function getReference()
	return targetReference
EndFunction

Function setReference(ObjectReference akNewValue)
	targetReference = akNewValue
EndFunction

Function clearReference()
	setReference(None)
EndFunction

Bool Function attemptReferenceLoad()
	if (isPluginValid())
		setReference(MyPlugin.lookupForm(ReferenceID) as ObjectReference)
	endif
	
	return hasReference()
EndFunction

Bool Function isPlayerInLocation()
	if (!hasLocation())
		return false
	endif
	
	return Game.GetPlayer().isInLocation(getLocation())
EndFunction

Bool Function isCellLoaded()
	if (!hasCell())
		return false
	endif
	
	return getCell().IsLoaded()
EndFunction

Function stateCheck()
	Spawny:Logger.log(self + " is checking state")

	if (!isPluginValid()); paranoia, but if the plugin is suddenly out of the load order, drop everything for the sake of safety
		Stop()
		return
	endif
	
	if (getLocation() == Game.GetPlayer().GetCurrentLocation())
		if (hasCellSetting())
			if (attemptCellLoad())
				Spawny:Logger.log(self + " detected its cell is loaded")
				attemptReferenceLoad()
			else
				Spawny:Logger.log(self + " has not detected a loaded cell")
				startCheckTimer()
			endif
		else
			attemptReferenceLoad()
		endif
	endif
	
	if (hasReference())
		Spawny:Logger.log(self + " got a reference!")
		sendReferenceReady()
	endif
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

Function stopEventObservation()
	cancelCheckTimer()
	stopObservingLocationChange()
	stopObservingGameLoad()
EndFunction

Function clearLoadedForms()
	clearReference()
	clearCell()
	clearLocation()
EndFunction

Function startupBehavior()
	if (!isPluginValid())
		Spawny:Logger.log(self + " has invalid plugin")
		Stop()
		return
	endif
	
	if (!attemptLocationLoad())
		Spawny:Logger.log(self + " has invalid location ID")
		Stop()
		return
	endif
	
	Spawny:Logger.log(self + "loaded everything")
	
	observeLocationChange()
	observeGameLoad()
	stateCheck()
EndFunction

Event OnQuestInit()
	Spawny:Logger.log(self + " is starting")
	startupBehavior()
EndEvent

Function shutdownBehavior()
	stopEventObservation()
	clearLoadedForms()
EndFunction

Event OnQuestShutdown()
	Spawny:Logger.log(self + " is stopping")
	shutdownBehavior()
EndEvent
