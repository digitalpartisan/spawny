Scriptname Spawny:Reusable:Reference:Random extends Spawny:Reusable:Reference
{This reusable reference script randomly chooses the contents of an ObjectReference array Property.}

ObjectReference[] Property References = None Auto Const Mandatory

ObjectReference Function getReference()
	return Jiffy:Utility.randomReference(References)
EndFunction
