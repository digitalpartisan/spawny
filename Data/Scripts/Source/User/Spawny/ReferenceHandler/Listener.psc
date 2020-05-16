Scriptname Spawny:ReferenceHandler:Listener extends Quest
{Use this script to implement a listener on a Quest record which will start and stop with the quest object itself.
Each of these records assumes the presence of a particular plugin to load the records from using the Spawny:ReferenceHandler records stored in the Handlers FormList.}

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
	
	Spawny:Logger.log(self + " is processing handlers")
	
	Int iCounter = 0
	Int iSize = Handlers.GetSize()
	Spawny:ReferenceHandler handler = None
	while (iCounter < iSize)
		handler = Handlers.GetAt(iCounter) as Spawny:ReferenceHandler
		if (handler)
			if (bShutdown)
				handler.goToDormant()
			else
				handler.examine()
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
		Spawny:Logger.log(self + " observed a location change")
		processHandlers()
	endif
EndEvent

Event OnQuestInit()
	if (isReady())
		observeEvents()
		processHandlers()
	else
		Stop()
	endif
EndEvent

Event OnQuestShutdown()
	processHandlers(true)
EndEvent

Function startBulk(Spawny:ReferenceHandler:Listener[] listeners) Global
	if (!listeners || !listeners.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < listeners.Length)
		listeners[iCounter] && listeners[iCounter].Start()
		iCounter += 1
	endWhile
EndFunction

Function startList(FormList listeners) Global
	startBulk(Jiffy:Utility:FormList.toArray(listeners) as Spawny:ReferenceHandler:Listener[])
EndFunction

Function stopBulk(Spawny:ReferenceHandler:Listener[] listeners) Global
	if (!listeners || !listeners.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < listeners.Length)
		listeners[iCounter] && listeners[iCounter].Stop()
		iCounter += 1
	endWhile
EndFunction

Function stopList(FormList listeners) Global
	stopBulk(Jiffy:Utility:FormList.toArray(listeners) as Spawny:ReferenceHandler:Listener[])
EndFunction
