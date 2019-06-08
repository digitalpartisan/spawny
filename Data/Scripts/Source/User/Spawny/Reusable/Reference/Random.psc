Scriptname Spawny:Reusable:Reference:Random extends Spawny:Reusable:Reference
{This reusable reference script randomly chooses the contents of an ObjectReference array Property.}

ObjectReference[] Property References = None Auto Const Mandatory

ObjectReference Function getReference()
	if (!References || 0 == References.Length)
		return None
	endif
	
	return References[(Utility.RandomInt(0, References.Length - 1))]
EndFunction
