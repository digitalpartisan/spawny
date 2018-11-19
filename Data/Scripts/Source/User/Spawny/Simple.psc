Scriptname Spawny:Simple extends Quest Hidden

ObjectReference Property Reference Auto Const

Function spawn()

EndFunction

Function despawn()

EndFunction

Event OnInit()
	spawn()
EndEvent

Event OnQuestShutdown()
	despawn()
EndEvent
