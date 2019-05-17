Scriptname Spawny:Reusable:Reference:Dynamic extends Spawny:Reusable:Reference

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
