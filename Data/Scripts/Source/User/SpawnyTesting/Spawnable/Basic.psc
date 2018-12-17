Scriptname SpawnyTesting:Spawnable:Basic extends SpawnyTesting:Spawnable

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Group SpawnSettings
	Form Property PlaceMe Auto Const Mandatory
	ObjectReference Property TargetReference Auto Const Mandatory
EndGroup

Group MovementSettings
	Coordinate Property OffsetValue Auto Const
	Bool Property RelativeOffset = true Auto Const
EndGroup

Group RotationSettings
	Twist Property RotationValue Auto Const
	Bool Property RelativeRotation = true Auto Const
	Bool Property ResetRotation = false Auto Const
EndGroup

ObjectReference spawnedReference = None

Function spawnLogic()
	spawnedReference = place(PlaceMe, TargetReference)
	
	if (!spawnedReference)
		despawn()
		return
	endif
	
	if (OffsetValue)
		offset(spawnedReference, OffsetValue, RelativeOffset)
	endif
	
	if (ResetRotation)
		resetRotation(spawnedReference)
	endif
	
	if (RotationValue)
		rotate(spawnedReference, RotationValue, RelativeRotation)
	endif
EndFunction

Function despawnLogic()
	if (spawnedReference)
		spawnedReference.Disable()
		spawnedReference.Delete()
		spawnedReference = None
	endif
EndFunction
