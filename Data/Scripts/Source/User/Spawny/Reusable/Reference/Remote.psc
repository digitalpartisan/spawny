Scriptname Spawny:Reusable:Reference:Remote extends Spawny:Reusable:Reference
{This script has been included for reference value since it is not likely to be very useful except in the most coincidental of cases.
Generally, the functionality this script might accomplish is better handled by using a Spawny:ReferenceHandler object.}

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property Plugin = None Auto Const Mandatory
DigitSet Property Digits = None Auto Const Mandatory

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
	
	return Plugin.lookupWithDigits(Digits) as ObjectReference
EndFunction

Function clearReference()
	myReference = None
EndFunction

Function refreshReference()
	myReference = loadReference()
EndFunction
