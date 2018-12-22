Scriptname Spawny:ReferenceHandler:Observer:WorldSpace extends Spawny:ReferenceHandler:Observer Hidden

Worldspace Function getWorldspace()
	Spawny:Logger.logBehaviorUndefined(self, "getWorldspace")
	return None
EndFunction

Bool Function hasWorldspace()
	return None != getWorldspace()
EndFunction

ObjectReference Function getReference()
	return Game.GetPlayer()
EndFunction

Bool Function isPlayerInWorldspace()
	return getWorldspace() == Game.GetPlayer().GetWorldSpace()
EndFunction

Function stateCheck()
	if (isPlayerInWorldspace())
		Debug.MessageBox("Player is in Worldspace")
	endif
EndFunction
