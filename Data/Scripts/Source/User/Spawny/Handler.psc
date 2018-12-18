Scriptname Spawny:Handler extends Quest

Import Spawny:Utility:Placement

Spawny:ReferenceHandler Property ReferenceHandler Auto Const Mandatory
Spawny:Reusable:Form Property ReusableForm Auto Const Mandatory
Spawny:Modifier Property Modifier = None Auto Const
Options Property PlacementOptions = None Auto Const

ObjectReference myReference = None

ObjectReference Function getReference()
	return myReference
EndFunction

Bool Function hasReference()
	return None != getReference()
EndFunction

Function setReference(ObjectReference akRef)
	myReference = akRef
EndFunction

Function clearReference()
	ObjectReference currentReference = getReference()
	if (currentReference)
		currentReference.Disable()
		currentReference.Delete()
	endif
EndFunction

Function spawn()
	ObjectReference newRef = placeOptions(ReusableForm.getSetting(), ReferenceHandler.getReference(), PlacementOptions)
	if (newRef && Modifier)
		Modifier.apply(newRef)
	endif
	setReference(newRef)
EndFunction

Event Spawny:ReferenceHandler.ReferenceReady(Spawny:ReferenceHandler handler, Var[] args)
	stopObservingReferenceReady()
	spawn()
	ReferenceHandler.Stop()
EndEvent

Function observeReferenceReady()
	RegisterForCustomEvent(ReferenceHandler, "ReferenceReady")
EndFunction

Function stopObservingReferenceReady()
	UnregisterForCustomEvent(ReferenceHandler, "ReferenceReady")
EndFunction

Event OnQuestInit()
	observeReferenceReady()
	ReferenceHandler.Start()
EndEvent

Event OnQuestShutdown()
	stopObservingReferenceReady()
	ReferenceHandler.Stop()
	clearReference()
EndEvent
