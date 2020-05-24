Scriptname Spawny:Modifier extends Quest
{A pre-set package of specific modifications which can be used to define common modifications to newly spawned references.
This script can also be attached to an existing spawner object in order to cut down on the number of editor objects to manage.}

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

Group MovementSettings
	Bool Property ZeroPosition = false Auto Const
	{Sets the reference's position to zero coordinates.  Setting this option to true will prevent other position settings from being applied.}
	Coordinate Property Position = None Auto Const
	{The position to be applied according to the PositionIsAbsolute and PositionIsAugment settings.  By default, this coordinate is vectored.  See documentation on Spawny:Utility:Modification.vectorPosition().  When None, no action is taken.}
	Bool Property PositionIsAbsolute = false Auto Const
	{If Position has a value and this is set to true, the reference in question is moved to the coordinates specified by Position.  If true, this effect overrides vectoring and augmentation.}
	Bool Property PositionIsAugment = false Auto Const
	{If Position has a value and this is set to true, the reference in question has its current position augmented by the coordinates in Position.  This effect only processes if PositionIsAbsolute is false.}
EndGroup

Group RotationSettings
	Bool Property ZeroRotation = false Auto Const
	{Sets the reference's rotation to zero on every axis.  Setting this option to true will prevent other rotation settings from being applied.}
	Twist Property Angles = None Auto Const
	{The axis-based rotational information to be applied to the reference in question.  By default, these values will augment the existing rotation.}
	Bool Property AngleIsAbsolute = false Auto Const
	{If Angles has a value and this is set to true, the reference in question will have its axis rotations set to the values specified by Angles.}
EndGroup

Group BehaviorSettings
	Bool Property ForceStatic = false Auto Const
	{When set to true, the reference in question will have some logic applied to it which makes it behave as if it is a non-moveable static reference.}
	Bool Property Enable = false Auto Const
	{When set to true, the reference in question will be enabled when this modifier is applied.}
EndGroup

Spawny:Modifier:Ownership Property OwnershipModifier = None Auto Const

Coordinate Function calculatePosition(ObjectReference akTargetRef)
	if (!akTargetRef)
		return None
	endif
	
	if (ZeroPosition)
		return buildZeroCoordinate()
	elseif (Position)
		if (PositionIsAbsolute)
			return Position
		elseif (PositionIsAugment)
			return augmentPosition(akTargetRef, Position)
		else
			return vectorPosition(akTargetRef, Position)
		endif
	else
		return None
	endif
EndFunction

Bool Function applyPosition(ObjectReference akTargetRef)
{Returns true unless the position could not be applied to the reference in which case, returns false}
	if (!akTargetRef)
		return true ; techincally, a failure didn't happen
	endif
	
	return setPosition(akTargetRef, calculatePosition(akTargetRef))
EndFunction

Twist Function calculateRotation(ObjectReference akTargetRef)
	if (!akTargetRef)
		return None
	endif
	
	if (ZeroRotation)
		return buildZeroTwist()
	elseif (Angles)
		if (AngleIsAbsolute)
			return Angles
		else
			return augmentRotation(akTargetRef, Angles)
		endif
	else
		return None
	endif
EndFunction

Bool Function applyRotation(ObjectReference akTargetRef)
{Returns true unless the rotation could not be applied to the reference in which case, returns false}
	if (!akTargetRef)
		return true ; techincally, a failure didn't happen
	endif
	
	return setRotation(akTargetRef, calculateRotation(akTargetRef))
EndFunction

Bool Function apply3DSettings(ObjectReference akTargetRef)
	Bool bPosition = applyPosition(akTargetRef)
	Bool bRotation = applyRotation(akTargetRef)
	return bPosition && bRotation ; so that both are attempted to get as close as possible even if one of them fails, no & operator exists in Papyrus
EndFunction

Bool Function apply(ObjectReference akTargetRef)
{Return true unless the position or rotation could not be correctly set in which case, returns false}
	if (!akTargetRef)
		Spawny:Utility:Modification:Logger.logModifierCannotApply(self, akTargetRef)
		return true ; techincally, no failure occurred
	endif
	
	Spawny:Utility:Modification:Logger.logModifierApply(self, akTargetRef)
	
	ForceStatic && makeStatic(akTargetRef)
	OwnershipModifier && OwnershipModifier.apply(akTargetRef)
	Bool b3DSuccess = apply3DSettings(akTargetRef)
	Enable && akTargetRef.Enable()
	
	return b3DSuccess
EndFunction
