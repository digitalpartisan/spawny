Scriptname SpawnyTesting:SpawnButton extends ObjectReference

Spawny:Spawner[] Property Spawners Auto Const Mandatory
Message Property SpawnyTesting_ActivatorText_Spawn Auto Const Mandatory
Message Property SpawnyTesting_ActivatorText_Despawn Auto Const Mandatory

Function handleSpawners(Bool bSpawn = true)
	if (!Spawners || 0 == Spawners.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < Spawners.Length)
		if (bSpawn)
			Spawners[iCounter].Start()
		else
			Spawners[iCounter].Stop()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Auto State Despawned
	Event OnBeginState(String asOldState)
		handleSpawners(false)
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Spawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Spawned")
	EndEvent
EndState

State Spawned
	Event OnBeginState(String asOldState)
		handleSpawners()
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Despawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Despawned")
	EndEvent
EndState
