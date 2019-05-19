Scriptname Spawny:Utility:Modification Hidden Const

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Math

Function setPosition(ObjectReference akTargetRef, Coordinate position) Global
	akTargetRef.SetPosition(position.x, position.y, position.z)
EndFunction

Function zeroPosition(ObjectReference akTargetRef) Global
	setPosition(akTargetRef, buildZeroCoordinate())
EndFunction

Function augmentPosition(ObjectReference akTargetRef, Coordinate augmentation) Global
	setPosition(akTargetRef, addCoordinates(getPosition(akTargetRef), augmentation))
EndFunction

Function vectorPosition(ObjectReference akTargetRef, Coordinate vector) Global
	augmentPosition(akTargetRef, rotateCoordinate(vector, getTwist(akTargetRef)))
EndFunction

Function setRotation(ObjectReference akTargetRef, Twist angles) Global
	akTargetRef.SetAngle(angles.x, angles.y, angles.z)
EndFunction

Function zeroRotation(ObjectReference akTargetRef) Global
	setRotation(akTargetRef, buildZeroTwist())
EndFunction

Function augmentRotation(ObjectReference akTargetRef, Twist augmentation) Global
	setRotation(akTargetRef, addTwists(getTwist(akTargetRef), augmentation))
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
