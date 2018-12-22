Scriptname Spawny:Spawner:Reusable extends Spawny:Spawner

Spawny:Reusable:Form Property ReusableForm Auto Const Mandatory
Spawny:Reusable:Reference Property ReusableReference Auto Const Mandatory

Form Function getForm()
	return ReusableForm.getSetting()
EndFunction

ObjectReference Function getReference()
	return ReusableReference.getSetting()
EndFunction
