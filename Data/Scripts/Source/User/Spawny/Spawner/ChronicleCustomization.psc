Scriptname Spawny:Spawner:ChronicleCustomization extends Chronicle:Package:CustomBehavior
{Used to allow a Chronicle package to start spawners upon the package being installed.
Also starts any and all spawners upon a game load event to allow for additional spawners to be installed during a mod upgrade.
Shuts down spawners when the package is uninstalled.
Ditto for a list of listeners.}

FormList Property Spawners Auto Const Mandatory
{A list of Spawny:Spawner records for this package's behavior to handle.}
FormList Property Listeners = None Auto Const
{A list of Spawny:ReferenceHandler:Listener records for this package's behavior to handle.}

Function handleQuests(FormList aflQuests, Bool bStart = true)
	if (!aflQuests || !aflQuests.GetSize())
		return
	endif
	
	Int iCounter = 0
	Int iSize = aflQuests.GetSize()
	while (iCounter < iSize)
		Quest targetQuest = aflQuests.GetAt(iCounter) as Quest
		if (targetQuest)
			if (bStart)
				targetQuest.Start()
			else
				targetQuest.Stop()
			endif
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function handle(Bool bStart = true)
	handleQuests(Spawners, bStart)
	handleQuests(Listeners, bStart)
EndFunction

Bool Function installBehavior()
	handle()
	return true
EndFunction

Bool Function uninstallBehavior()
	handle(false)
	return true
EndFunction
