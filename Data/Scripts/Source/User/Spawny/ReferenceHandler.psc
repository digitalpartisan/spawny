Scriptname Spawny:ReferenceHandler extends Quest Hidden

CustomEvent ReferenceReady

String sStateDormant = "Dormant" Const
String sStateObserving = "Observing" Const
String sStateReady = "Ready" Const

ObjectReference myReference = None

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

Function goToDormant()
	GoToState(sStateDormant)
EndFunction

Function goToObserving()
	GoToState(sStateObserving)
EndFunction

Function goToReady()
	GoToState(sStateReady)
EndFunction

Function sendReferenceReady()
	
EndFunction

Function observe()
	
EndFunction

Function beginDormant(String asOldState)
	
EndFunction

Function endDormant(String asNewState)

EndFunction

Function beginObserving(String asOldState)

EndFunction

Function endObserving(String asNewState)

EndFunction

Function beginReady(String asOldState)
	if (hasReference())
		sendReferenceReady()
	else
		goToObserving()
	endif
EndFunction

Function endReady(String asNewState)

EndFunction

Auto State Dormant
	Event OnBeginState(String asOldState)
		beginDormant(asOldState)
	EndEvent
	
	Event OnEndState(String asNewState)
		endDormant(asNewState)
	EndEvent

	Function observe()
		goToObserving()
	EndFunction
EndState

State Observing
	Event OnBeginState(String asOldState)
		beginObserving(asOldState)
	EndEvent
	
	Event OnEndState(String asNewState)
		endObserving(asNewState)
	EndEvent
EndState

State Ready
	Event OnBeginState(String asOldState)
		beginReady(asOldState)
	EndEvent
	
	Event OnEndState(String asNewState)
		endReady(asNewState)
	EndEvent
	
	Function sendReferenceReady()
		Spawny:Logger.log(self + " sent reference ready")
		SendCustomEvent("ReferenceReady")
	EndFunction
EndState
