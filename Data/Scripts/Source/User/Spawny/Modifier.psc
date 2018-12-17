Scriptname Spawny:Modifier extends Quest

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Group MovementSettings
	Bool Property ResetPosition = false Auto Const
	Coordinate Property Position = None Auto Const
	Bool Property RelativePosition = true Auto Const
EndGroup

Group RotationSettings
	Bool Property ResetRotation = false Auto Const
	Twist Property Rotation = None Auto Const
	Bool Property RelativeRotation = true Auto Const
EndGroup

Function applyPosition(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	if (ResetPosition)
		resetPosition(akTargetRef)
	endif
	
	if (Position)
		offset(akTargetRef, Position, RelativePosition)
	endif
EndFunction

Function applyRotation(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	if (ResetRotation)
		resetRotation(akTargetRef)
	endif
	
	if (Rotation)
		rotate(akTargetRef, Rotation, RelativeRotation)
	endif
EndFunction

Function apply(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	applyPosition(akTargetRef)
	applyRotation(akTargetRef)
EndFunction
