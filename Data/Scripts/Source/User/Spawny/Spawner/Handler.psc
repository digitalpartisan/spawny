Scriptname Spawny:Spawner:Handler extends DynamicTerminal:Basic Conditional

Bool bValid = false Conditional

Spawny:Spawner mySpawner = None

Bool Function isValid()
	return bValid
EndFunction

Spawny:Spawner Function getSpawner()
	return mySpawner
EndFunction

Function setSpawner(Spawny:Spawner newValue)
	mySpawner = newValue
	refreshStatus()
EndFunction

Function refreshStatus()
	bValid = getSpawner() as Bool
EndFunction

Function goTo()
	isValid() && getSpawner().goTo()
EndFunction

Function tokenReplacementLogic()
	if (isValid())
		replace("SelectedSpawner", getSpawner())
	else
		replace("SelectedPackage", None)
	endif
EndFunction
