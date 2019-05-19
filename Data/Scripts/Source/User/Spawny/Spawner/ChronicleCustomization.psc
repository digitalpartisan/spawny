Scriptname Spawny:Spawner:ChronicleCustomization extends Chronicle:Package:CustomBehavior

FormList Property Spawners Auto Const Mandatory

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
