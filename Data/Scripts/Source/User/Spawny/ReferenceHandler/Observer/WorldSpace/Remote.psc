Scriptname Spawny:ReferenceHandler:Observer:WorldSpace:Remote extends Spawny:ReferenceHandler:Observer:WorldSpace

InjectTec:Plugin Property WorldspacePlugin Auto Const Mandatory
Int Property WorldspaceID = 0 Auto Const Mandatory

Worldspace myWorldspace = None

Worldspace Function getWorldspace()
	return myWorldspace
EndFunction

Function setWorldspace(Worldspace aNewValue)
	myWorldspace = aNewValue
EndFunction

Function clearWorldspace()
	setWorldspace(None)
EndFunction

Bool Function isPluginValid()
	return (WorldspacePlugin && WorldspacePlugin.isInstalled())
EndFunction

Bool Function attemptWorldspaceLoad()
	if (isPluginValid())
		setWorldspace(WorldspacePlugin.lookupForm(WorldspaceID) as Worldspace)
	endif
	
	return hasWorldspace()
EndFunction

Function clearLoadedForms()
	clearWorldspace()
EndFunction

Function beginDormant(String asOldState)
	clearLoadedForms()
EndFunction

Function stateCheck()
	if (!isPluginValid())
		goToDormant()
	endif
	
	parent.stateCheck()
EndFunction

Function beginObserving(String asOldState)
	if (!isPluginValid())
		Spawny:Logger.log(self + " has invalid plugin")
		goToDormant()
		return
	endif
	
	if (!attemptWorldspaceLoad())
		Spawny:Logger.log(self + " has invalid worldspace ID")
		goToDormant()
		return
	endif
	
	Spawny:Logger.log(self + "loaded everything")
	
	parent.beginObserving(asOldState)
EndFunction
