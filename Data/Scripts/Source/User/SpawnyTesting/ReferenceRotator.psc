Scriptname SpawnyTesting:ReferenceRotator extends Spawny:Reusable:Reference:Dynamic

Import SpawnyTesting:IndexLooper

ObjectReference[] Property MyReferences Auto Const Mandatory

Int iIndex = 0

Function refreshReference()
	setReference(MyReferences[iIndex])
EndFunction

Function rotate()
	iIndex = getNextIndex(iIndex, MyReferences.Length)
	refreshReference()
EndFunction

Bool Function hasReference()
	return (None != parent.getReference())
EndFunction

ObjectReference Function getReference()
	if (!hasReference())
		refreshReference()
	endif
	
	ObjectReference kResult = parent.getReference()
	rotate()
	
	return kResult
EndFunction
