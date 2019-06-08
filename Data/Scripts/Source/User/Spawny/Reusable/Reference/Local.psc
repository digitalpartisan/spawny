Scriptname Spawny:Reusable:Reference:Local extends Spawny:Reusable:Reference
{This reusable reference script uses a simple, local (i.e. available within a mod or its required master plugins) ObjectReference Property value.}

ObjectReference Property MyReference Auto Const Mandatory

ObjectReference Function getReference()
	return MyReference
EndFunction
