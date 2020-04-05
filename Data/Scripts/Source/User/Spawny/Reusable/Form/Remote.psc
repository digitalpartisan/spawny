Scriptname Spawny:Reusable:Form:Remote extends Spawny:Reusable:Form
{This reusable form loads a Form record from a third-party plugin.}

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property Plugin = None Auto Const Mandatory
DigitSet Property Digits = None Auto Const Mandatory

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
	
	return Plugin.lookupWithDigits(Digits)
EndFunction

Function clearForm()
	myForm = None
EndFunction

Function refreshForm()
	myForm = loadForm()
EndFunction
