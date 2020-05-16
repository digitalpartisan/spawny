Scriptname Spawny:ReferenceHandler:DataPoint extends Quest Hidden 

Import InjectTec:Utility:HexidecimalLogic

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
	return Digits as Bool
EndFunction

Bool Function attemptLoad(Spawny:ReferenceHandler:Listener listener)
	clearValue()
	
	InjectTec:Plugin plugin = listener.getPlugin()
	if (!plugin.isInstalled())
		return false
	endif
	
	setValue(plugin.lookupWithDigits(Digits))
	
	return hasValue()
EndFunction
