Scriptname Spawny:Reusable:Reference:Random extends Spawny:Reusable:Reference

ObjectReference[] Property References = None Auto Mandatory

Function init()
	if (None == References)
		References = new ObjectReference[0]
	endif
EndFunction

Bool Function hasData()
	return (0 != getSize())
EndFunction

Int Function getSize()
	if (None == References)
		return 0
	else
		return References.Length
	endif
EndFunction

Function addReference(ObjectReference akNewReference)
	init()
	References.Add(akNewReference)
EndFunction

Function removeReference(ObjectReference akRemoveReference)
	if (!hasData())
		return
	endif
	
	Int iLocation = References.Find(akRemoveReference)
	if (iLocation >= 0)
		References.Remove(iLocation)
	endif
EndFunction

ObjectReference Function getSetting()
	if (!hasData())
		return None
	endif
	
	return References[Utility.RandomInt(0, getSize() - 1)]
EndFunction
