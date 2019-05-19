Scriptname Spawny:Modifier extends Quest

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Group MovementSettings
	Bool Property ZeroPosition = false Auto Const
	Coordinate Property Position = None Auto Const
	Bool Property PositionIsAbsolute = false Auto Const
	Bool Property PositionIsAugment = false Auto Const
EndGroup

Group RotationSettings
	Bool Property ZeroRotation = false Auto Const
	Twist Property Angles = None Auto Const
	Bool Property AngleIsAbsolute = false Auto Const
EndGroup

Group BehaviorSettings
	Bool Property ForceStatic = false Auto Const
	Bool Property Enable = false Auto Const
EndGroup

Function applyPosition(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	if (ZeroPosition)
		zeroPosition(akTargetRef)
	elseif (Position)
		if (PositionIsAbsolute)
			setPosition(akTargetRef, Position)
		elseif (PositionIsAugment)
			augmentPosition(akTargetRef, Position)
		else
			vectorPosition(akTargetRef, Position)
		endif
	endif
EndFunction

Function applyRotation(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	if (ZeroRotation)
		zeroRotation(akTargetRef)
	elseif (Angles)
		if (AngleIsAbsolute)
			setRotation(akTargetRef, Angles)
		else
			augmentRotation(akTargetRef, Angles)
		endif
	endif
EndFunction

Function apply(ObjectReference akTargetRef)
	if (!akTargetRef)
		Spawny:Logger:Modification.logModifierCannotApply(self, akTargetRef)
		return
	endif
	
	Spawny:Logger:Modification.logModifierApply(self, akTargetRef)
	
	applyPosition(akTargetRef)
	applyRotation(akTargetRef)
	
	if (ForceStatic)
		makeStatic(akTargetRef)
	endif
	
	if (Enable)
		akTargetRef.Enable()
	endif
EndFunction
