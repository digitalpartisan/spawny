Scriptname Spawny:ChroniclePackageBehavior extends Chronicle:Package:CustomBehavior
{Used to allow a Chronicle package to start spawners upon the package being installed.
Also starts any and all spawners upon a game load event to allow for additional spawners to be installed during a mod upgrade.
Shuts down spawners when the package is uninstalled.
Ditto for a list of listeners.}

FormList Property Spawners Auto Const Mandatory
{A list of Spawny:Spawner records for this package's behavior to handle.}
FormList Property Listeners = None Auto Const
{A list of Spawny:ReferenceHandler:Listener records for this package's behavior to handle.}

Function handleQuestList(Bool bStart = true)
	
EndFunction

Function handleSpawners(Bool bStart = true)
	if (!Spawners)
		return
	endif
	
	Int iCounter = 0
	Int iSpawners = Spawners.GetSize()
	Spawny:Spawner spawner = None
	while (iCounter < iSpawners)
		spawner = Spawners.GetAt(iCounter) as Spawny:Spawner
		if (spawner)
			if (bStart)
				spawner.Start()
			else
				spawner.Stop()
			endif
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function handle(Bool bStart = true)
	handleSpawners
EndFunction

Bool Function installBehavior()
	handleSpawners()
	return true
EndFunction

Bool Function postloadBehavior()
	handleSpawners()
	return true
EndFunction

Bool Function uninstallBehavior()
	handleSpawners(false)
	return true
EndFunction
