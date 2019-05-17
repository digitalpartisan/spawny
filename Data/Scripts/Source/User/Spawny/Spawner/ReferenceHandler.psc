Scriptname Spawny:Spawner:ReferenceHandler extends Spawny:Spawner

Spawny:Reusable:Form Property ReusableForm Auto Const Mandatory
Spawny:ReferenceHandler Property ReferenceHandler Auto Const Mandatory

Form Function getForm()
	return ReusableForm.getForm()
EndFunction

ObjectReference Function getReference()
	return ReferenceHandler.MyReference.getReference()
EndFunction

Function observeReferenceReady()
	RegisterForCustomEvent(ReferenceHandler, "ReferenceReady")
EndFunction

Function stopObservingReferenceReady()
	UnregisterForCustomEvent(ReferenceHandler, "ReferenceReady")
EndFunction

Event Spawny:ReferenceHandler.ReferenceReady(Spawny:ReferenceHandler handler, Var[] args)
	if (handler != ReferenceHandler)
		return
	endif
	
	stopObservingReferenceReady()
	spawn()
	ReferenceHandler.goToComplete()
EndEvent

Function startupBehavior()
	observeReferenceReady()
	ReferenceHandler.observe()
EndFunction
