Scriptname Spawny:Reusable:Reference:Remote extends Spawny:Reusable:Reference

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
