Scriptname SpawnyTesting:SpawnButton extends ObjectReference

SpawnyTesting:Spawnable[] Property Spawnables Auto Const Mandatory
Message Property SpawnyTesting_ActivatorText_Spawn Auto Const Mandatory
Message Property SpawnyTesting_ActivatorText_Despawn Auto Const Mandatory

Function handleSpawns(Bool bSpawn = true)
	if (!Spawnables || 0 == Spawnables.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < Spawnables.Length)
		if (bSpawn)
			Spawnables[iCounter].Start()
		else
			Spawnables[iCounter].Stop()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Auto State Despawned
	Event OnBeginState(String asOldState)
		handleSpawns(false)
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Spawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Spawned")
	EndEvent
EndState

State Spawned
	Event OnBeginState(String asOldState)
		handleSpawns()
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Despawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Despawned")
	EndEvent
EndState
