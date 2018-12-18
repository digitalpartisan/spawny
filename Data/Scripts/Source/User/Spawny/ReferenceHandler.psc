Scriptname Spawny:ReferenceHandler extends Quest Hidden

CustomEvent ReferenceReady

Function sendReferenceReady()
	Spawny:Logger.log(self + " sent reference ready")
	SendCustomEvent("ReferenceReady")
EndFunction

ObjectReference Function getReference()
	return None
EndFunction

Bool Function hasReference()
	return None != getReference()
EndFunction
