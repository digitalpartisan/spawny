Scriptname SpawnyTesting:Spawnable:Basic extends SpawnyTesting:Spawnable

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation

Group SpawnSettings
	Form Property PlaceMe Auto Const Mandatory
	ObjectReference Property TargetReference Auto Const Mandatory
EndGroup

Group MovementSettings
	Coordinate Property OffsetValue Auto Const
EndGroup

Group RotationSettings
	Twist Property RotationValue Auto Const
	Bool Property AbsoluteRotation = true Auto Const
	Bool Property ResetRotation = false Auto Const
EndGroup

ObjectReference spawnedReference = None

ObjectReference Function spawnLogic()
	ObjectReference newRef = place(PlaceMe, TargetReference)
	
	if (OffsetValue)
		offset(newRef, OffsetValue)
	endif
	
	if (ResetRotation)
		resetRotation(newRef)
	endif
	
	if (RotationValue)
		rotate(newRef, RotationValue, AbsoluteRotation)
	endif
	
	return newRef
EndFunction
