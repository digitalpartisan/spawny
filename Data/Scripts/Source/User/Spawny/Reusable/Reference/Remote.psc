Scriptname Spawny:Reusable:Reference:Remote extends Spawny:Reusable:Reference
{This script has been included for reference value since it is not likely to be very useful except in the most coincidental of cases.
Generally, the functionality this script might accomplish is better handled by using a Spawny:ReferenceHandler object.}

Import InjectTec:HexidecimalLogic

InjectTec:Plugin Property Plugin = None Auto Const
Int Property ID = 0 Auto Const
InjectTec:HexidecimalLogic:DigitSet Property Digits = None Auto Const

ObjectReference myReference = None

ObjectReference Function getReference()
	if (!myReference)
		myReference = loadReference()
	endif
	
	return myReference
EndFunction

ObjectReference Function loadReference()
	if (!Plugin)
		return None
	endif
	
	if (Digits)
		return Plugin.lookupForm(getDigitSetValue(Digits)) as ObjectReference
	endif
	
	return Plugin.lookupForm(ID) as ObjectReference
EndFunction

Function clearReference()
	myReference = None
EndFunction

Function refreshReference()
	myReference = loadReference()
EndFunction
