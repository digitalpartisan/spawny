Scriptname Spawny:ObjectReference extends ObjectReference

Bool Function stateCheck()
	return false
EndFunction

Function spawn()

EndFunction

Function despawn()

EndFunction

Event OnWorkshopObjectPlaced(ObjectReference akReference)

EndEvent

Event OnWorkshopObjectGrabbed(ObjectReference akReference)

EndEvent

Event OnWorkshopObjectMoved(ObjectReference akReference)

EndEvent

Event OnWorkshopObjectRepaired(ObjectReference akReference)

EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akReference)

EndEvent

Auto State Despawned
	
EndState

State Spawned
	
EndState
