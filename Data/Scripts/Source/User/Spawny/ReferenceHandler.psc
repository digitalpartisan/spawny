Scriptname Spawny:ReferenceHandler extends Quest

CustomEvent ReferenceReady

Group ObservationSettings
	Spawny:ReferenceHandler:DataPoint:Location Property MyLocation Auto Const Mandatory
	Spawny:ReferenceHandler:DataPoint:Reference Property MyReference Auto Const Mandatory
	Spawny:ReferenceHandler:DataPoint:Cell Property MyCell Auto Const
	
	Spawny:ReferenceHandler:Listener Property MyListener Auto Const Mandatory
EndGroup

Group StateCheckTimerSettings
	Int Property TimerID = 1 Auto Const
	
	GlobalVariable Property TimerDuration = None Auto Const
	Float Property DefaultTimerDuration = 30.0 Auto Const

	GlobalVariable Property CellLoadedTimerDuration = None Auto Const
	Float Property CellLoadedDefaultTimerDuration = 10.0 Auto Const
EndGroup

String sStateDormant = "Dormant" Const
String sStateObserving = "Observing" Const
String sStateReady = "Ready" Const
String sStateComplete = "Complete" Const

Bool Function isDataPointValid(Spawny:ReferenceHandler:DataPoint dataPoint)
	return dataPoint && dataPoint.isSet()
EndFunction

Bool Function hasLocationSetting()
	return isDataPointValid(MyLocation)
EndFunction

Bool Function hasReferenceSetting()
	return isDataPointValid(MyReference)
EndFunction

Bool Function hasCellSetting()
	return isDataPointValid(MyCell)
EndFunction

Function goToDormant()
	
EndFunction

Function goToObserving()
	
EndFunction

Function goToReady()
	
EndFunction

Function goToComplete()
	
EndFunction

Float Function determineTimerValue(GlobalVariable agvTimerLength, Float afDefaultValue)
	if (agvTimerLength)
		return agvTimerLength.GetValue()
	endif
	
	return afDefaultValue
EndFunction

Float Function getTimerDuration()
	if (hasCellSetting() && MyCell.isLoaded())
		return determineTimerValue(CellLoadedTimerDuration, CellLoadedDefaultTimerDuration)
	else
		return determineTimerValue(TimerDuration, DefaultTimerDuration)
	endif
EndFunction

Function observe()
	
EndFunction

Function stateRefresh()

EndFunction

Function stateCheck()
	
EndFunction

Function examine()
	stateRefresh()
	stateCheck()
EndFunction

Event OnTimer(Int aiTimerID)
	if (TimerID == aiTimerID)
		Spawny:Logger.log(self + " detected a timer event")
		examine()
	endif
EndEvent

Function startCheckTimer()
	Float duration = getTimerDuration()
	Spawny:Logger.log(self + " started a timer with length " + duration)
	StartTimer(duration, TimerID)
EndFunction

Function cancelCheckTimer()
	CancelTimer(TimerID)
EndFunction

Function stopObservingEvents()
	cancelCheckTimer()
EndFunction

Function clearDataPoints()
	MyReference.clearValue()
	MyLocation.clearValue()
	
	if (hasCellSetting())
		MyCell.clearValue()
	endif
EndFunction

Function restart()
	GoToState(sStateDormant)
	observe()
EndFunction

Auto State Dormant
	Event OnBeginState(String asOldState)
		stopObservingEvents()
		clearDataPoints()
	EndEvent
	
	Function examine()
		goToObserving()
	EndFunction
	
	Function goToObserving()
		GoToState(sStateObserving)
	EndFunction
EndState

State Observing
	Event OnBeginState(String asOldState)
		if (!MyListener.isReady())
			Spawny:Logger.log(self + " does not have installed plugin")
			goToDormant()
			return
		endif
		
		if (!MyLocation.attemptLoad(MyListener))
			Spawny:Logger.log(self + " has invalid location ID")
			goToDormant()
			return
		endif
		
		Spawny:Logger.log(self + " is observing")
		
		examine()
	EndEvent
	
	Function stateRefresh()
		Spawny:Logger.log(self + " refreshing state")
		
		if (!MyListener.isReady()); paranoia, but if the plugin is suddenly out of the load order, drop everything for the sake of safety
			goToDormant()
		endif
		
		if (MyLocation.containsPlayer())
			MyReference.attemptLoad(MyListener)
		else
			goToDormant()
		endif
	EndFunction
	
	Function stateCheck()
		if (MyReference.hasValue())
			goToReady()
		else
			startCheckTimer()
		endif
	EndFunction
	
	Function goToDormant()
		GoToState(sStateDormant)
	EndFunction
	
	Function goToObserving()
		GoToState(sStateObserving)
	EndFunction
	
	Function goToReady()
		GoToState(sStateReady)
	EndFunction
EndState

State Ready
	Event OnBeginState(String asOldState)
		if (!MyReference.hasValue())
			goToObserving()
		endif
		
		Spawny:Logger.log(self + " sent reference ready")
		SendCustomEvent("ReferenceReady")
		stopObservingEvents()
	EndEvent
	
	Function goToComplete()
		GoToState(sStateComplete)
	EndFunction
EndState

State Complete
	Event OnBeginState(String asOldState)
		clearDataPoints()
	EndEvent
EndState
