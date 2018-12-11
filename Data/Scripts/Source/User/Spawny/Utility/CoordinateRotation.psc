Scriptname Spawny:Utility:CoordinateRotation Hidden Const

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Math

Coordinate Function rotateAxisX(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate newCoordinates = copyCoordinate(coordinates)
	
	Float sinX = sin(angles.x)
	Float cosX = cos(angles.x)
	newCoordinates.y = coordinates.y * cosX + coordinates.z * sinX
	newCoordinates.z = -1 * coordinates.y * sinX + coordinates.z * cosX
	
	return newCoordinates
EndFunction

Coordinate Function rotateAxisY(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate newCoordinates = copyCoordinate(coordinates)
	
	Float sinY = sin(angles.y)
	Float cosY = cos(angles.y)
	newCoordinates.x = coordinates.x * cosY + -1 * coordinates.z * sinY
	newCoordinates.z = coordinates.x * sinY + coordinates.z * cosY
	
	return newCoordinates
EndFunction

Coordinate Function rotateAxisZ(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	Coordinate newCoordinates = copyCoordinate(coordinates)
	
	Float sinZ = sin(angles.z)
	Float cosZ = cos(angles.z)
	newCoordinates.x = coordinates.x * cosZ + coordinates.y * sinZ
	newCoordinates.y = -1 * coordinates.x * sinZ + coordinates.y * cosZ
	
	return newCoordinates
EndFunction

Coordinate Function rotateCoordinate(Coordinate coordinates, Twist angles) Global
	if (!coordinates || !angles)
		return coordinates
	endif
	
	coordinates = rotateAxisZ(coordinates, angles)
	coordinates = rotateAxisY(coordinates, angles)
	coordinates = rotateAxisX(coordinates, angles)
	
	return coordinates
EndFunction
