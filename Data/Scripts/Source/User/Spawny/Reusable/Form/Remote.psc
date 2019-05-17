Scriptname Spawny:Reusable:Form:Remote extends Spawny:Reusable:Form

Import InjectTec:HexidecimalLogic

InjectTec:Plugin Property Plugin = None Auto Const
Int Property ID = 0 Auto Const
InjectTec:HexidecimalLogic:DigitSet Property Digits = None Auto Const

Form myForm = None

Form Function getForm()
	if (!myForm)
		myForm = loadForm()
	endif

	return myForm
EndFunction

Form Function loadForm()
	if (!Plugin)
		return None
	endif
	
	if (Digits)
		return Plugin.lookupForm(getDigitSetValue(Digits))
	endif
	
	return Plugin.lookupForm(ID)
EndFunction

Function clearForm()
	myForm = None
EndFunction

Function refreshForm()
	myForm = loadForm()
EndFunction
