Scriptname Spawny:Reusable:Reference:Random extends Spawny:Reusable:Reference

ObjectReference[] Property References = None Auto Const Mandatory

ObjectReference Function getReference()
	if (!References || 0 == References.Length)
		return None
	endif
	
	return References[(Utility.RandomInt(0, References.Length - 1))]
EndFunction
