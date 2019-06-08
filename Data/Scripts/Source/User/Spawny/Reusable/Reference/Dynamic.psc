Scriptname Spawny:Reusable:Reference:Dynamic extends Spawny:Reusable:Reference
{This reusable reference script allows its value to be set by a calling entity.
This is useful for when multiple Spawny:Spawner objects need to use the same target reference that changes from time to time.}

ObjectReference kMyReference = None

ObjectReference Function getReference()
	return kMyReference
EndFunction

Bool Function hasReference()
	return None != getReference()
EndFunction

Function setReference(ObjectReference akNewValue)
	kMyReference = akNewValue
EndFunction

Function clearReference()
	setReference(None)
EndFunction
