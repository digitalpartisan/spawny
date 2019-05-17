Scriptname Spawny:ReferenceHandler:DataPoint:Location extends Spawny:ReferenceHandler:DataPoint

Location Function getLocation()
	return getValue() as Location
EndFunction

Bool Function containsPlayer()
	return Game.GetPlayer().IsInLocation(getLocation())
EndFunction
