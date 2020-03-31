Scriptname Spawny:Utility:Modification Hidden Const
{Implements the logic required to perform complicated modifications on a given ObjectReference.
Movement and Rotation can be accomplished in a number of ways.  Reference the documentation on each method individually for details.}

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Math

Function setPosition(ObjectReference akTargetRef, Coordinate position) Global
{Sets the absolute position of the given ObjectReference to the given coordinates.}
	akTargetRef.SetPosition(position.x, position.y, position.z)
EndFunction

Function zeroPosition(ObjectReference akTargetRef) Global
{Moves the given ObjectReference to the center of the cell or worldspace.}
	setPosition(akTargetRef, buildZeroCoordinate())
EndFunction

Function augmentPosition(ObjectReference akTargetRef, Coordinate augmentation) Global
{Moves the position of the given ObjectReference to its current position plus the values contained in coordinate.  That is, this method performs a relative position adjustment.}
	setPosition(akTargetRef, addCoordinates(getPosition(akTargetRef), augmentation))
EndFunction

Function vectorPosition(ObjectReference akTargetRef, Coordinate vector) Global
{Vectors the ObjectReference by the values contained in vector.
That is, the position of akTargetRef is adjusted by the amount indicated in vector as if the current position and rotation of akTargetRef are both zero.
To phrase that in a more helpful way, the values in vector are applied to akTargetRef, but in the coordinate system located at akTargetRef's origin with its axis rotated to match akTargetRef's rotation.
See rotateCoordinate() for details on this process.}
	augmentPosition(akTargetRef, rotateCoordinate(vector, getTwist(akTargetRef)))
EndFunction

Function setRotation(ObjectReference akTargetRef, Twist angles) Global
{Sets the absolute rotation of akTargetRef to the values specified by angles.}
	akTargetRef.SetAngle(angles.x, angles.y, angles.z)
EndFunction

Function zeroRotation(ObjectReference akTargetRef) Global
{Sets the absolute rotation of akTargetRef around every axis to zero.}
	setRotation(akTargetRef, buildZeroTwist())
EndFunction

Function augmentRotation(ObjectReference akTargetRef, Twist augmentation) Global
{Augments akTargetRef's current rotation by the values in augmentation.}
	setRotation(akTargetRef, addTwists(getTwist(akTargetRef), augmentation))
EndFunction

Coordinate Function rotateCoordinate(Coordinate coordinates, Twist angles) Global
{Logic used in the vectorPosition() method to determine the absolute value of coordinates when angles is treated as if it is a zero rotation.
In other words, the given coordinates are adjusted as if they represent a point from the origin and the whole system is rotated by the values specified in angles.}
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
{Useful utility method to make any given ObjectReference "static" is that it cannot be activated and will not move.}
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
{Uses toggleStatic() to force the given ObjectReference to be un-activatable as well as unmovable.}
	Spawny:Logger:Modification.logMakeStatic(akTargetRef)
	toggleStatic(akTargetRef)
EndFunction

Function unmakeStatic(ObjectReference akTargetRef) Global
{Uses toggleStatic() on the given ObjectReference to remove the activation block and motion hinderance.}
	Spawny:Logger:Modification.logUnmakeStatic(akTargetRef)
	toggleStatic(akTargetRef, false)
EndFunction
