Scriptname Spawny:Reusable:Reference:Dynamic extends Spawny:Reusable:Reference

ObjectReference kMyReference = None

Bool Function hasReference()
	return None != getSetting()
EndFunction

Function set(ObjectReference akNewValue)
	kMyReference = akNewValue
EndFunction

Function clear()
	set(None)
EndFunction

ObjectReference Function getSetting()
	return kMyReference
EndFunction
