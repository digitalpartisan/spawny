Scriptname Spawny:Reusable:Reference:Random extends Spawny:Reusable:Reference

ObjectReference[] Property References = None Auto Const Mandatory

ObjectReference[] myReferences = None

Function init()
	if (None == myReferences)
		myReferences = new ObjectReference[0]
	endif
EndFunction

Function reset()
	myReferences = new ObjectReference[0]
	addReferences(References)
EndFunction

Bool Function hasData()
	return (0 != getSize())
EndFunction

Int Function getSize()
	if (None == myReferences)
		return 0
	else
		return myReferences.Length
	endif
EndFunction

Function addReference(ObjectReference akNewReference)
	init()
	myReferences.Add(akNewReference)
EndFunction

Function addReferences(ObjectReference[] akNewReferences)
	if (!akNewReferences || 0 == akNewReferences.Length)
		return
	endif
	
	init()
	
	Int iCounter = 0
	while (iCounter < akNewReferences.Length)
		myReferences.Add(akNewReferences[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function removeReference(ObjectReference akRemoveReference)
	Int iLocation = myReferences.Find(akRemoveReference)
	if (iLocation >= 0)
		myReferences.Remove(iLocation)
	endif
EndFunction

ObjectReference Function getReference()
	if (!hasData())
		return None
	endif
	
	return myReferences[Utility.RandomInt(0, getSize() - 1)]
EndFunction
