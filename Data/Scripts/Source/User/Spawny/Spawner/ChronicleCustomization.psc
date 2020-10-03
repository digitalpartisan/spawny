Scriptname Spawny:Spawner:ChronicleCustomization extends Chronicle:Package:CustomBehavior
{Used to allow a Chronicle package to start spawners upon the package being installed.
Also starts any and all spawners upon a game load event to allow for additional spawners to be installed during a mod upgrade.
Shuts down spawners when the package is uninstalled.
Ditto for a list of listeners.}

InjectTec:Plugin Property MyPlugin Auto Const Mandatory
{The plugin required to load the object references observed by the Listener}
FormList Property Spawners Auto Const Mandatory
{A list of Spawny:Spawner records for this package's behavior to handle.}
Spawny:ReferenceHandler:Listener Property Listener Auto Const
{A list of Spawny:ReferenceHandler:Listener records for this package's behavior to handle.}

InjectTec:Plugin Function getPlugin()
	return MyPlugin
EndFunction

Bool Function meetsPluginRequirement()
	return getPlugin().isInstalled()
EndFunction

FormList Function getSpawners()
	return Spawners
EndFunction

Spawny:ReferenceHandler:Listener Function getListener()
	return Listener
EndFunction

Function handle(Bool bStart = true)
	if (!meetsPluginRequirement())
		return
	endif
	
	FormList mySpawners = getSpawners()
	Spawny:ReferenceHandler:Listener myListener = getListener()

	if (bStart)
		Spawny:Spawner.startList(mySpawners)
		myListener && myListener.Start()
	else
		Spawny:Spawner.stopList(mySpawners)
		myListener && myListener.Stop()
	endif
EndFunction

Bool Function installBehavior()
	handle()
	return true
EndFunction

Bool Function postloadBehavior()
	handle()
	return true
EndFunction

Bool Function uninstallBehavior()
	handle(false)
	return true
EndFunction
