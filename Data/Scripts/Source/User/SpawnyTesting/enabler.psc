Scriptname SpawnyTesting:enabler extends ObjectReference

Message Property SpawnyTesting_ActivatorText_Spawn Auto Const Mandatory
Message Property SpawnyTesting_ActivatorText_Despawn Auto Const Mandatory
ObjectReference Property Target Auto Const Mandatory

Auto State Despawned
	Event OnBeginState(String asOldState)
		Target.Disable()
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Spawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Spawned")
	EndEvent
EndState

State Spawned
	Event OnBeginState(String asOldState)
		Target.Enable()
		SetActivateTextOverride(SpawnyTesting_ActivatorText_Despawn)
	EndEvent
	
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Despawned")
	EndEvent
EndState
