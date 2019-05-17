Scriptname Spawny:ObjectReference extends ObjectReference

Bool Function stateCheck()
	return false
EndFunction

Function spawn()

EndFunction

Function despawn()

EndFunction

Event OnWorkshopObjectPlaced(ObjectReference akReference)
	spawn()
EndEvent

Event OnWorkshopObjectGrabbed(ObjectReference akReference)
	despawn()
EndEvent

Event OnWorkshopObjectMoved(ObjectReference akReference)
	spawn()
EndEvent

Event OnWorkshopObjectRepaired(ObjectReference akReference)
	spawn()
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akReference)
	despawn()
EndEvent
