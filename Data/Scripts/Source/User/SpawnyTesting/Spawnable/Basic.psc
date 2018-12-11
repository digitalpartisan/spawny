Scriptname SpawnyTesting:Spawnable:Basic extends SpawnyTesting:Spawnable

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:CoordinateRotation

Group SpawnSettings
	Form Property PlaceMe Auto Const Mandatory
	ObjectReference Property TargetReference Auto Const Mandatory
EndGroup

Group MovementSettings
	Coordinate Property OffsetValue Auto Const
	Bool Property RotateOffset = false Auto Const
EndGroup

Group RotationSettings
	Twist Property RotationValue Auto Const
	Bool Property AbsoluteRotation = true Auto Const
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
		if (RotateOffset)
			offset(spawnedReference, rotateCoordinate(OffsetValue, getTwist(spawnedReference)))
		else
			offset(spawnedReference, OffsetValue)
		endif
	endif
	
	if (ResetRotation)
		resetRotation(spawnedReference)
	endif
	
	if (RotationValue)
		rotate(spawnedReference, RotationValue, AbsoluteRotation)
	endif
EndFunction

Function despawnLogic()
	if (spawnedReference)
		spawnedReference.Disable()
		spawnedReference.Delete()
		spawnedReference = None
	endif
EndFunction
