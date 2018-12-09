Scriptname SpawnyTesting:Spawnable extends Quest Hidden

Function spawnLogic()
	return None
EndFunction

Function spawn()
	despawn()
	spawnLogic()
EndFunction

Function despawnLogic()

EndFunction

Function despawn()
	despawnLogic()
EndFunction

Event OnQuestInit()
	spawn()
EndEvent

Event OnQuestShutdown()
	despawn()
EndEvent
