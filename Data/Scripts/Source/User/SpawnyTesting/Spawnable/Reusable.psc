Scriptname SpawnyTesting:Spawnable:Reusable extends SpawnyTesting:Spawnable

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Spawny:Reusable:Form Property MyForm Auto Const Mandatory
Spawny:Reusable:Reference Property MyReference Auto Const Mandatory

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
	objectreference targetref = MyReference.getSetting()
	if (!targetref)
		Debug.MessageBox("no reference found")
	endif
	
	spawnedReference = place(MyForm.getSetting(), targetref)
	
	if (!spawnedReference)
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
