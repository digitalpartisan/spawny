Scriptname Spawny:ReferenceHandler:Observer:Remote extends Spawny:ReferenceHandler:Observer

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

Bool Function attemptReferenceLoad()
	if (isPluginValid())
		setReference(MyPlugin.lookupForm(ReferenceID) as ObjectReference)
	endif
	
	if (hasReference())
		Spawny:Logger.log(self + " got a reference!")
		goToReady()
	endif
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
		goToDormant()
	endif
	
	if (isPlayerInLocation())
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

Function timerHandler()
	stateCheck()
EndFunction

Event OnTimer(Int aiTimerID)
	if (TimerID == aiTimerID)
		Spawny:Logger.log(self + " detected a timer event")
		timerHandler()
	endif
EndEvent

Function startCheckTimer()
	StartTimer(getTimerDuration(), TimerID)
EndFunction

Function cancelCheckTimer()
	CancelTimer(TimerID)
EndFunction

Function stopObservingEvents()
	parent.stopObservingEvents()
	cancelCheckTimer()
EndFunction

Function clearLoadedForms()
	clearReference()
	clearCell()
	clearLocation()
EndFunction

Function beginDormant(String asOldState)
	clearLoadedForms()
EndFunction

Function beginObserving(String asOldState)
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
	
	parent.beginObserving(asOldState)
EndFunction
