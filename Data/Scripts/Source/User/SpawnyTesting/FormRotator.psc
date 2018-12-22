Scriptname SpawnyTesting:FormRotator extends Spawny:Reusable:Form:Dynamic

Import SpawnyTesting:IndexLooper

Form[] Property MyForms Auto Const Mandatory

Int iIndex = 0

Function refreshSetting()
	set(MyForms[iIndex])
EndFunction

Function rotate()
	iIndex = getNextIndex(iIndex, MyForms.Length)
	refreshSetting()
EndFunction

Bool Function hasForm()
	return (None != parent.getSetting())
EndFunction

Form Function getSetting()
	if (!hasForm())
		refreshSetting()
	endif
	
	Form fResult = parent.getSetting()
	rotate()
	
	return fResult
EndFunction
