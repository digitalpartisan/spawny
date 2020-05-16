Scriptname Spawny:ReferenceHandler:DataPoint:Location extends Spawny:ReferenceHandler:DataPoint

Location Property MyLocation Auto Const

Bool Function hasValue()
	return (MyLocation || parent.hasValue())
EndFunction

Bool Function isSet()
	return (MyLocation || Digits)
EndFunction

Location Function getLocation()
	if (MyLocation)
		return MyLocation
	else
		return getValue() as Location
	endif
EndFunction

Bool Function containsPlayer()
	return Game.GetPlayer().IsInLocation(getLocation())
EndFunction

Bool Function attemptLoad(Spawny:ReferenceHandler:Listener listener)
	if (MyLocation)
		setValue(MyLocation)
		return true
	endif
	
	return parent.attemptLoad(listener)
EndFunction
