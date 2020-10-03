Scriptname Spawny:Spawner:ReferenceHandler extends Spawny:Spawner
{This spawner uses a Spawny:ReferenceHandler to get a handle to an ObjectReference record contained in a third-party plugin.
Uses a Spawny:Reusable:Form record to load the form to spawn.}

Spawny:Reusable:Form Property ReusableForm Auto Const Mandatory
{What form to spawn when the reference indicated by ReferenceHandler is available.}
Spawny:ReferenceHandler Property ReferenceHandler Auto Const Mandatory

Form Function getForm()
	return ReusableForm.getForm()
EndFunction

Spawny:ReferenceHandler Function getReferencehandler()
	return ReferenceHandler
EndFunction

ObjectReference Function getReference()
	return getReferenceHandler().MyReference.getReference()
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

Bool Function goTo()
	if (parent.goTo())
		return true
	endif

	getReferencehandler().goTo()
	return true
EndFunction

Function startupBehavior()
	observeReferenceReady()
	ReferenceHandler.examine()
EndFunction
