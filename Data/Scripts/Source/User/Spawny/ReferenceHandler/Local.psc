Scriptname Spawny:ReferenceHandler:Local extends Spawny:ReferenceHandler

ObjectReference Property TargetReference Auto Const Mandatory

ObjectReference Function getReference()
	return TargetReference
EndFunction

Bool Function canLoadReference()
	return true
EndFunction

Event OnQuestInit()
	sendReferenceReady()
EndEvent
