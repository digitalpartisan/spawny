Scriptname Spawny:ReferenceHandler extends Quest
{This is the preferred way of detecting when a reference contained in a third-party plugin is loaded.  This script will fire an event which a Spawny:Spawner:ReferenceHandler will detect to cause hat spawner to spawn.  See Spawny:Spawner:ReferenceHandler for details.}

CustomEvent ReferenceReady

Group ObservationSettings
	Spawny:ReferenceHandler:DataPoint:Location Property MyLocation Auto Const Mandatory
	{This value could easily come from a script attached to the same object as this script unless the location in question is used by more than one reference handler.
	This location is required to help determine that the reference in question might be about to load.}
	Spawny:ReferenceHandler:DataPoint:Reference Property MyReference Auto Const Mandatory
	{This value could easily come from a script attached to the same object as this script unless said reference is used by more than one reference handler.
	The refernce information itself is required because references in third-party plugins (i.e. non-assured master files) cannot be easily referenced by ObjectReference properties.
	Such references cannot be looked up from their plugin until they are loaded, which is the reason this script exists.}
	Spawny:ReferenceHandler:DataPoint:Cell Property MyCell Auto Const
	{While only helpful in very rare situations where the Cell containing your targeted Reference (as specified by the values in MyReference) are loaded before you enter them, making use of
	this value may very well result in a sooner-than-otherwise loading of the taget reference.  See the StateCheckTimerSettings for details.}
	Spawny:ReferenceHandler:Listener Property MyListener Auto Const Mandatory
	{A listener must be set because it listens for the relevant player-triggered events that could cause a reference to become load-able.  This is the ideal pattern rather than having each
	reference handler listen for these events since generally, only one or two reference handlers will ever be relevant out of the many that might be inclueded in a mod.
	Also, a listener is per-plugin and conveniently groups all appropriate reference handlers that load from that plugin to prevent more objects than necessary listening for said player-driven events.}
EndGroup

Group StateCheckTimerSettings
	Int Property TimerID = 1 Auto Const
	{Adjust this if, for any reason, you have need of more than one timer on the object this script is attached to.  This assures that the right timer event is responded to.}
	GlobalVariable Property TimerDuration = None Auto Const
	{Setting this value uses the value of the GlobalVariable to override DefaultTimerDuration.}
	Float Property DefaultTimerDuration = 30.0 Auto Const
	{The default number of seconds after which this script will attempt loading the targeted reference again.}
	GlobalVariable Property CellLoadedTimerDuration = None Auto Const
	{Setting this value uses the value of the GlobalVariable to override CellLoadedDefaultTimerDuration.}
	Float Property CellLoadedDefaultTimerDuration = 10.0 Auto Const
	{This value is used in a special case where MyCell is set and the cell in question loads but for some reason, the reference in question cannot be pulled from the third-party plugin.
	A much lower interval between loading attempts is used in this case because it is very likely that the reference will soon be available.}
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
{Useful for determining which time length should be used to register the next timer event.}
	if (agvTimerLength)
		return agvTimerLength.GetValue()
	endif
	
	return afDefaultValue
EndFunction

Float Function getTimerDuration()
{Uses the state of the MyCell data point (if any) to determine how far in the future the next timer event should occur.}
	if (hasCellSetting() && MyCell.isLoaded())
		return determineTimerValue(CellLoadedTimerDuration, CellLoadedDefaultTimerDuration)
	else
		return determineTimerValue(TimerDuration, DefaultTimerDuration)
	endif
EndFunction

Function stateRefresh()
{Refreshes the state of the Spawny:ReferenceHandler:DataPoint properties.}
EndFunction

Function stateCheck()
{Used to determine if the reference record can be loaded, and if so, takes appropriate action.}
EndFunction

Function examine()
	
EndFunction

Event OnTimer(Int aiTimerID)
	if (TimerID == aiTimerID)
		examine()
	endif
EndEvent

Function startCheckTimer()
	Float duration = getTimerDuration()
	StartTimer(duration, TimerID)
EndFunction

Function cancelCheckTimer()
	CancelTimer(TimerID)
EndFunction

Function stopObservingEvents()
	cancelCheckTimer()
EndFunction

Function clearDataPoints()
{Forces the values in the Spawny:ReferenceHandler:DataPoint properties to be cleared so that they can be reloaded.  Useful in situations where the wrong record IDs / Digits made it in to a public release of a mod.}
	MyReference.clearValue()
	MyLocation.clearValue()
	
	if (hasCellSetting())
		MyCell.clearValue()
	endif
EndFunction

Function restart()
{Forces the reference handler to unload its data points and start examining from scratch.  See remarks on clearDataPoints().}
	GoToState(sStateDormant)
	examine()
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
			goToDormant()
			return
		endif
		
		if (!MyLocation.attemptLoad(MyListener))
			goToDormant()
			return
		endif
		
		examine()
	EndEvent
	
	Function stateRefresh()
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
	
	Function examine()
	{When called, forces a state update of the various Spawny:ReferenceHandler:DataPoint properties on this script and then determines if the targetted reference can be loaded.}
		stateRefresh()
		stateCheck()
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
