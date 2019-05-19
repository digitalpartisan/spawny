Scriptname SpawnyTesting:FormRotator extends Spawny:Reusable:Form:Dynamic

Import SpawnyTesting:IndexLooper

Form[] Property MyForms Auto Const Mandatory

Int iIndex = 0

Function refreshForm()
	setForm(MyForms[iIndex])
EndFunction

Function rotate()
	iIndex = getNextIndex(iIndex, MyForms.Length)
	refreshForm()
EndFunction

Bool Function hasForm()
	return (None != parent.getForm())
EndFunction

Form Function getForm()
	if (!hasForm())
		refreshForm()
	endif
	
	Form fResult = parent.getForm()
	rotate()
	
	return fResult
EndFunction
