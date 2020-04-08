Scriptname Spawny:ObjectReference:Child extends Quest

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Form Property SpawnMe Auto Const Mandatory
Bool Property OnNode = false Auto Const
Bool Property Attach = false Auto Const
Options Property PlacementOptions = None Auto Const
Coordinate Property OffsetValue = None Auto Const
Twist Property RotationValue = None Auto Const
Bool Property MakeStatic = false Auto Const

ObjectReference Function spawnReference(Spawny:ObjectReference akTargetRef, String asNodeName = "")
	if (!akTargetRef || !SpawnMe)
		return None
	endif

	ObjectReference newReference = None
	if (OnNode)
		newReference = placeAtNodeOptions(SpawnMe, akTargetRef, asNodeName, PlacementOptions, Attach)
	else
		newReference = placeOptions(SpawnMe, akTargetRef, PlacementOptions)
	endif
	
	if (!newReference)
		return None
	endif
	
	if (OffsetValue)
		setPosition(newReference, augmentPosition(newReference, rotateCoordinate(OffsetValue, getTwist(akTargetRef))))
	endif
	
	if (RotationValue)
		setRotation(newReference, augmentRotation(newReference, RotationValue))
	endif
	
	if (MakeStatic)
		makeStatic(newReference)
	endif
	
	return newReference
EndFunction
