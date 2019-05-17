Scriptname Spawny:ReferenceHandler extends Quest

CustomEvent ReferenceReady

Group ObservationSettings
	Spawny:ReferenceHandler:DataPoint:Reference Property MyReference Auto Const Mandatory
	Spawny:ReferenceHandler:DataPoint:Location Property MyLocation Auto Const Mandatory
	Spawny:ReferenceHandler:DataPoint:Cell Property MyCell = None Auto Const
	
	Spawny:ReferenceHandler:Listener Property MyListener Auto Const Mandatory
EndGroup

Group StateCheckTimerSettings
	Int Property TimerID = 1 Auto Const
	GlobalVariable Property TimerDuration = None Auto Const
	Float Property DefaultTimerDuration = 30.0 Auto Const
EndGroup

String sStateDormant = "Dormant" Const
String sStateObserving = "Observing" Const
String sStateReady = "Ready" Const
String sStateComplete = "Complete" Const

Bool Function isDormant()
	return false
EndFunction

Function goToDormant()
	
EndFunction

Function goToObserving()
	
EndFunction

Function goToReady()
	
EndFunction

Function goToComplete()
	
EndFunction

Bool Function hasCellSetting()
	return (MyCell && MyCell.isSet())
EndFunction

Float Function getTimerDuration()
	if (TimerDuration)
		return TimerDuration.GetValue()
	endif
	
	return DefaultTimerDuration
EndFunction

Function observe()
	
EndFunction

Function stateCheck()
	
EndFunction

Event OnTimer(Int aiTimerID)
	if (TimerID == aiTimerID)
		Spawny:Logger.log(self + " detected a timer event")
		stateCheck()
	endif
EndEvent

Function startCheckTimer()
	StartTimer(getTimerDuration(), TimerID)
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
	
	Function observe()
		goToObserving()
	EndFunction
	
	Function stateCheck()
		observe()
	EndFunction
	
	Function goToObserving()
		GoToState(sStateObserving)
	EndFunction
EndState

State Observing
	Event OnBeginState(String asOldState)
		if (!MyListener || !MyReference || !MyLocation)
			Spawny:Logger.log(self + " has invalid configuration")
			goToDormant()
			return
		endif
		
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
		
		Spawny:Logger.log(self + "loaded everything")
		
		stateCheck()
	EndEvent
	
	Function stateCheck()
		Spawny:Logger.log(self + " is checking state")
		
		if (!MyListener.isReady()); paranoia, but if the plugin is suddenly out of the load order, drop everything for the sake of safety
			goToDormant()
		endif
		
		if (MyLocation.containsPlayer())
			if (hasCellSetting())
				if (MyCell.attemptLoad(MyListener))
					Spawny:Logger.log(self + " detected its cell is loaded")
					MyReference.attemptLoad(MyListener)
				endif
				
				if (!MyReference.hasValue())
					startCheckTimer()
				endif
			else
				MyReference.attemptLoad(MyListener)
			endif
			
			if (MyReference.hasValue())
				goToReady()
			endif
		else
			goToDormant()
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
