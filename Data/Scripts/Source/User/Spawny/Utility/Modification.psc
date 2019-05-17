Scriptname Spawny:Utility:Modification Hidden Const

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Math

Function offset(ObjectReference akTargetRef, Coordinate offset, Bool abRelative = true) Global
	if (!akTargetRef || !offset)
		Spawny:Logger:Modification.logCannotOffset(akTargetRef, offset)
		return
	endif
	
	Coordinate realOffset = copyCoordinate(offset)
	if (abRelative)
		realOffset = rotateCoordinate(realOffset, getTwist(akTargetRef))
		akTargetRef.MoveTo(akTargetRef, realOffset.x, realOffset.y, realOffset.z)
	else
		akTargetRef.SetPosition(realOffset.x, realOffset.y, realOffset.z)
	endif
	
	Spawny:Logger:Modification.logOffset(akTargetRef, offset, abRelative, realOffset)
EndFunction

Function resetPosition(ObjectReference akTargetRef) Global
	if (!akTargetRef)
		Spawny:Logger:Modification.logCannotResetPosition(akTargetRef)
		return
	endif
	
	Spawny:Logger:Modification.logResetPosition(akTargetRef)
	offset(akTargetRef, buildZeroCoordinate(), false)
EndFunction

Function rotate(ObjectReference akTargetRef, Twist angles, Bool abRelative = true) Global
	if (!akTargetRef || !angles)
		Spawny:Logger:Modification.logCannotRotate(akTargetRef, angles)
		return
	endif
	
	Twist twistToApply = copyTwist(angles)
	if (abRelative)
		twistToApply = addTwists(getTwist(akTargetRef), angles)
	endif
	
	Spawny:Logger:Modification.logRotate(akTargetRef, angles, abRelative, twistToApply)
	akTargetRef.SetAngle(twistToApply.x, twistToApply.y, twistToApply.z)
EndFunction

Function resetRotation(ObjectReference akTargetRef) Global
	if (!akTargetRef)
		Spawny:Logger:Modification.logCannotResetRotation(akTargetRef)
		return
	endif
	
	Spawny:Logger:Modification.logResetRotation(akTargetRef)
	rotate(akTargetRef, buildZeroTwist(), false)
EndFunction

Coordinate Function rotateCoordinate(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		Spawny:Logger:Modification.logCannotRotateCoordinate(coordinates, angles)
		return coordinates
	endif
	
	Coordinate intermediate = copyCoordinate(coordinates)
	Coordinate result = copyCoordinate(intermediate)
	
	Float sinZ = sin(angles.z)
	Float cosZ = cos(angles.z)
	result.x = intermediate.x * cosZ + intermediate.y * sinZ
	result.y = -1 * intermediate.x * sinZ + intermediate.y * cosZ
	
	intermediate = copyCoordinate(result)
	
	Float sinY = sin(angles.y)
	Float cosY = cos(angles.y)
	result.x = intermediate.x * cosY + -1 * intermediate.z * sinY
	result.z = intermediate.x * sinY + intermediate.z * cosY
	
	intermediate = copyCoordinate(result)
	
	Float sinX = sin(angles.x)
	Float cosX = cos(angles.x)
	result.y = intermediate.y * cosX + intermediate.z * sinX
	result.z = -1 * intermediate.y * sinX + intermediate.z * cosX
	
	Spawny:Logger:Modification.logRotateCoordinate(coordinates, angles, result)
	return result
EndFunction

Function toggleStatic(ObjectReference akTargetRef, Bool abMakeStatic = true) Global
	if (!akTargetRef)
		Spawny:Logger:Modification.logCannotToggleStatic(akTargetRef)
		return
	endif
	
	Bool bBlockActivation = false
	Bool bHideActivateText = false
	Int iMotionType = akTargetRef.Motion_Dynamic
	if (abMakeStatic)
		bBlockActivation = true
		bHideActivateText = true
		iMotionType = akTargetRef.Motion_Keyframed
	endif
	
	akTargetRef.BlockActivation(bBlockActivation, bHideActivateText)
	akTargetRef.SetMotionType(iMotionType)
EndFunction

Function makeStatic(ObjectReference akTargetRef) Global
	Spawny:Logger:Modification.logMakeStatic(akTargetRef)
	toggleStatic(akTargetRef)
EndFunction

Function unmakeStatic(ObjectReference akTargetRef) Global
	Spawny:Logger:Modification.logUnmakeStatic(akTargetRef)
	toggleStatic(akTargetRef, false)
EndFunction
