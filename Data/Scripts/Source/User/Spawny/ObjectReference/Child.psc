Scriptname Spawny:ObjectReference:Child extends Quest

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Form Property SpawnMe Auto Const Mandatory
Options Property PlacementOptions = None Auto Const
Coordinate Property OffsetValue = None Auto Const
Twist Property RotationValue = None Auto Const
Bool Property MakeStatic = false Auto Const

ObjectReference Function spawnReference(Spawny:ObjectReference akTargetRef)
	if (!akTargetRef || !SpawnMe)
		return None
	endif
	
	ObjectReference newReference = place(SpawnMe, akTargetRef, PlacementOptions)
	if (!newReference)
		return None
	endif
	
	MakeStatic && makeStatic(newReference)
	
	OffsetValue && setPosition(newReference, augmentPosition(newReference, rotateCoordinate(OffsetValue, getTwist(akTargetRef))))
	RotationValue && setRotation(newReference, augmentRotation(newReference, RotationValue))
	
	return newReference
EndFunction
