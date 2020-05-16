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

Group OwnershipSettings
	Bool Property PlayerOwns = false Auto Const
	Actor Property Owner Auto Const
	Faction Property FactionOwner Auto Const
EndGroup

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

Function apply(ObjectReference akTargetRef, Spawny:Adjuster adjuster)
	if (!akTargetRef)
		Spawny:Logger:Modification.logModifierCannotApply(self, akTargetRef)
		return
	endif
	
	Spawny:Logger:Modification.logModifierApply(self, akTargetRef)
	Coordinate newPosition = calculatePosition(akTargetRef)
	Twist newRotation = calculateRotation(akTargetRef)
	
	if ( (!setPosition(akTargetRef, newPosition) || !setRotation(akTargetRef, newRotation)) && adjuster )
		adjuster.register(akTargetRef, newPosition, newRotation)
	endif
	
	if (FactionOwner)
		akTargetRef.SetFactionOwner(FactionOwner)
	endif
	
	if (Owner)
		akTargetRef.SetActorOwner(Owner.GetActorBase())
	endif
	
	if (PlayerOwns)
		akTargetRef.SetActorOwner(Game.GetPlayer().GetActorBase())
	endif
	
	if (ForceStatic)
		makeStatic(akTargetRef)
	endif
	
	if (Enable)
		akTargetRef.Enable()
	endif
EndFunction
