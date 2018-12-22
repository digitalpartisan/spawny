Scriptname Spawny:Spawner:Simple extends Spawny:Spawner

Form Property MyForm Auto Const Mandatory
ObjectReference Property MyReference Auto Const Mandatory

Form Function getForm()
	return MyForm
EndFunction

ObjectReference Function getReference()
	return MyReference
EndFunction
