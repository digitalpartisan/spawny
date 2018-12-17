Scriptname Spawny:Utility:Modification Hidden Const

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Math

Function offset(ObjectReference akTargetRef, Coordinate offset, Bool bRelative = true) Global
	if (!akTargetRef || !offset)
		return
	endif
	
	Coordinate realOffset = copyCoordinate(offset)
	if (bRelative)
		realOffset = rotateCoordinate(realOffset, getTwist(akTargetRef))
	endif
	
	akTargetRef.MoveTo(akTargetRef, realOffset.x, realOffset.y, realOffset.z)
EndFunction

Function resetPosition(ObjectReference akTargetRef) Global
	if (!akTargetRef)
		return
	endif
	
	offset(akTargetRef, buildZeroCoordinate(), false)
EndFunction

Function rotate(ObjectReference akTargetRef, Twist rotation, Bool bRelative = true) Global
	if (!akTargetRef || !rotation)
		return
	endif
	
	Twist twistToApply = copyTwist(rotation)
	if (bRelative)
		twistToApply = addTwists(getTwist(akTargetRef), rotation)
	endif
	
	akTargetRef.SetAngle(twistToApply.x, twistToApply.y, twistToApply.z)
EndFunction

Function resetRotation(ObjectReference akTargetRef) Global
	rotate(akTargetRef, buildZeroTwist(), false)
EndFunction

Coordinate Function rotateXAxis(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate result = copyCoordinate(coordinates)
	
	Float sinX = sin(angles.x)
	Float cosX = cos(angles.x)
	result.y = coordinates.y * cosX + coordinates.z * sinX
	result.z = -1 * coordinates.y * sinX + coordinates.z * cosX
	
	return result
EndFunction

Coordinate Function rotateYAxis(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate result = copyCoordinate(coordinates)
	
	Float sinY = sin(angles.y)
	Float cosY = cos(angles.y)
	result.x = coordinates.x * cosY + -1 * coordinates.z * sinY
	result.z = coordinates.x * sinY + coordinates.z * cosY
	
	return result
EndFunction

Coordinate Function rotateZAxis(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate result = copyCoordinate(coordinates)
	
	Float sinZ = sin(angles.z)
	Float cosZ = cos(angles.z)
	result.x = coordinates.x * cosZ + coordinates.y * sinZ
	result.y = -1 * coordinates.x * sinZ + coordinates.y * cosZ
	
	return result
EndFunction

Coordinate Function rotateCoordinate(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
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
	
	return result
EndFunction
