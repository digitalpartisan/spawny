Scriptname Spawny:ReferenceHandler:DataPoint extends Quest Hidden

Import InjectTec:HexidecimalLogic

Int Property ID = 0 Auto Const
DigitSet Property Digits = None Auto Const

Form myValue = None

Form Function getValue()
	return myValue
EndFunction

Bool Function hasValue()
	return None != getValue()
EndFunction

Function setValue(Form afNewValue)
	myValue = afNewValue
EndFunction

Function clearValue()
	setValue(None)
EndFunction

Bool Function isSet()
	return 0 < ID || Digits
EndFunction

Int Function getRecordID()
	if (!isSet())
		return 0
	endif

	if (Digits)
		return getDigitSetValue(Digits)
	endif
	
	return ID
EndFunction

Bool Function attemptLoad(Spawny:ReferenceHandler:Listener listener)
	clearValue()
	
	InjectTec:Plugin plugin = listener.getPlugin()
	if (!plugin.isInstalled())
		return false
	endif
	
	setValue(plugin.lookupForm(getRecordID()))
	
	return hasValue()
EndFunction
