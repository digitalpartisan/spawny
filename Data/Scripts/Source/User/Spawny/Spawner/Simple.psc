Scriptname Spawny:Spawner:Simple extends Spawny:Spawner
{Uses properties to retrieve form and target data.  Useful for one-off spawning needs where the records required are immediately in the plugin being developed or one of its required master files.}

Form Property MyForm Auto Const Mandatory
ObjectReference Property MyReference Auto Const Mandatory

Form Function getForm()
	return MyForm
EndFunction

ObjectReference Function getReference()
	return MyReference
EndFunction
