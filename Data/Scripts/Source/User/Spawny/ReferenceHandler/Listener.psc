Scriptname Spawny:ReferenceHandler:Listener extends Quest

InjectTec:Plugin Property MyPlugin Auto Const Mandatory
FormList Property Handlers Auto Const Mandatory

InjectTec:Plugin Function getPlugin()
	return MyPlugin
EndFunction

Bool Function isReady()
	InjectTec:Plugin plugin = getPlugin()
	return plugin && plugin.isInstalled()
EndFunction

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
	stopObservingGameLoad()
	stopObservingLocationChange()
EndFunction

Function processHandlers(Bool bShutdown = false)
	if (!Handlers)
		return
	endif
	
	Int iCounter = 0
	Int iSize = Handlers.GetSize()
	Spawny:ReferenceHandler handler = None
	while (iCounter < iSize)
		handler = Handlers.GetAt(iCounter) as Spawny:ReferenceHandler
		if (handler)
			if (bShutdown)
				handler.goToDormant()
			else
				handler.stateCheck()
			endif
		endif
		
		iCounter += 1
	endWhile
EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)
	if (Game.GetPlayer() == akSender)
		processHandlers()
	endif
EndEvent

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
	if (Game.GetPlayer() == akSender)
		processHandlers()
	endif
EndEvent

Event OnQuestInit()
	if (isReady())
		observeEvents()
	else
		Stop()
	endif
EndEvent

Event OnQuestShutdown()
	processHandlers(true)
EndEvent
