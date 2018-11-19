Scriptname Spawny:Simple:Bulk extends Spawny:Simple

FormList Property Objects Auto Const Mandatory

Int Function getObjectCount()
	if (Objects)
		Objects.GetSize()
	endif
	
	return 0
EndFunction

Function handle(Bool abSpawn = true)
	Int iCount = getObjectCount()
	if (!iCount)
		return
	endif
	
	Int iCounter = 0
	Spawny:Simple currentObject = None
	while (iCounter < iCounter)
		currentObject = Objects.GetAt(iCounter) as Spawny:Simple
		if (currentObject)
			if (abSpawn)
				currentObject.Start()
			else
				currentObject.Stop()
			endif
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function spawn()
	handle()
EndFunction

Function despawn()
	handle(false)
EndFunction