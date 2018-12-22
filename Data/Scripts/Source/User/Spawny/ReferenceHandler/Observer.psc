Scriptname Spawny:ReferenceHandler:Observer extends Spawny:ReferenceHandler Hidden

Function stateCheck()
	
EndFunction

Function loadHandler()
	stateCheck()
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
	if (Game.GetPlayer() == akSender)
		Spawny:Logger.log(self + " detected a game load")
		loadHandler()
	endif
EndEvent

Function locationHandler()
	stateCheck()
EndFunction

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
	if (Game.GetPlayer() == akSender)
		Spawny:Logger.log(self + " detected a location change")
		locationHandler()
	endif
EndEvent

Function observeGameLoad()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

Function stopObservingGameLoad()
	UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

Function observeLocationChange()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
EndFunction

Function stopObservingLocationChange()
	UnregisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
EndFunction

Function observeEvents()
	observeGameLoad()
	observeLocationChange()
EndFunction

Function stopObservingEvents()
	stopObservingLocationChange()
	stopObservingGameLoad()
EndFunction

Function beginObserving(String asOldState)
	observeEvents()
	stateCheck()
EndFunction

Function endObserving(String asNewState)
	stopObservingEvents()
EndFunction
