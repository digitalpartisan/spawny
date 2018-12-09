Scriptname SpawnyTesting:Spawnable extends Quest Hidden

ObjectReference spawnedReference = None

ObjectReference Function spawnLogic()
	return None
EndFunction

Function spawn()
	despawn()
	spawnedReference = spawnLogic()
EndFunction

Function despawn()
	if (spawnedReference)
		spawnedReference.Disable()
		spawnedReference.Delete()
		spawnedReference = None
	endif
EndFunction

Event OnQuestInit()
	spawn()
EndEvent

Event OnQuestShutdown()
	despawn()
EndEvent
