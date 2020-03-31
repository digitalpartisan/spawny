Scriptname Spawny:Spawner:Reusable extends Spawny:Spawner
{Uses both a Spawny:Reusable:Form and a Spawny:Reusable:Reference to get its form and target data.}

Spawny:Reusable:Form Property ReusableForm Auto Const Mandatory
Spawny:Reusable:Reference Property ReusableReference Auto Const Mandatory

Form Function getForm()
	return ReusableForm.getForm()
EndFunction

ObjectReference Function getReference()
	return ReusableReference.getReference()
EndFunction
