Scriptname Spawny:Utility:Rotation Hidden Const

Import Spawny:Utility:Placement
Import Math

Struct Twist
	Float x = 0.0
	Float y = 0.0
	float z = 0.0
EndStruct

Twist Function addTwists(Twist twistA, Twist twistB) Global
	if (!twistA || !twistB)
		return None
	endif
	
	Twist result = new Twist
	
	result.x = twistA.x + twistB.x
	result.y = twistA.y + twistB.y
	result.z = twistA.z + twistB.z
	
	return result
EndFunction

Twist Function subtractTwists(Twist lefthand, Twist righthand) Global
	if (!lefthand || !righthand)
		return None
	endif
	
	Twist result = new Twist
	
	result.x = lefthand.x - righthand.x
	result.y = lefthand.y - righthand.y
	result.z = lefthand.z - righthand.z
	
	return result
EndFunction

Twist Function getTwist(ObjectReference targetRef) Global
	Twist data = new Twist
	
	if (targetRef)
		data.x = targetRef.GetAngleX()
		data.y = targetRef.GetAngleY()
		data.z = targetRef.GetAngleZ()
	endif
	
	return data
EndFunction

Function applyRotation(ObjectReference targetRef, Float xAngle, Float yAngle, Float zAngle) Global
	if (!targetRef)
		return
	endif
	
	targetRef.SetAngle(xAngle, yAngle, zAngle)
EndFunction

Function applyTwist(ObjectReference targetRef, Twist data) Global
	if (!targetRef || !data)
		return
	endif
	
	applyRotation(targetRef, data.x, data.y, data.z)
EndFunction

Coordinate Function twistCoordinate(Coordinate coordinateData, Twist rotationData) Global
	if (!coordinateData)
		return None
	endif
	
	if (!rotationData)
		return coordinateData
	endif
	
	Coordinate result = new Coordinate
	result.x = coordinateData.x
	result.y = coordinateData.y
	result.z = coordinateData.z
	
	; rotation logic taken from https://stackoverflow.com/questions/14607640/rotating-a-vector-in-3d-space
	
	; x rotation
	Float sinX = sin(rotationData.x)
	Float cosX = cos(rotationData.x)
	result.y = result.y * cosX - result.z * sinX
	result.z = result.y * sinX + result.z * cosX
	
	; y rotation
	Float sinY = sin(rotationData.y)
	Float cosY = cos(rotationData.y)
	result.x = result.x * cosY + result.z * sinY
	result.z = result.z * cosY - result.x * sinY
	
	;z rotation
	Float sinZ = sin(rotationData.z)
	Float cosZ = cos(rotationData.z)
	result.x = result.x * cosZ - result.y * sinZ
	result.y = result.x * sinZ + result.y * cosZ
	
	return result
EndFunction
