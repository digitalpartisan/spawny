Scriptname SpawnyTesting:ReferenceRotator extends Spawny:Reusable:Reference:Dynamic

Import SpawnyTesting:IndexLooper

ObjectReference[] Property MyReferences Auto Const Mandatory

Int iIndex = 0

Function refreshSetting()
	set(MyReferences[iIndex])
EndFunction

Function rotate()
	iIndex = getNextIndex(iIndex, MyReferences.Length)
	refreshSetting()
EndFunction

Bool Function hasReference()
	return (None != parent.getSetting())
EndFunction

ObjectReference Function getSetting()
	if (!hasReference())
		refreshSetting()
	endif
	
	ObjectReference kResult = parent.getSetting()
	rotate()
	
	return kResult
EndFunction
