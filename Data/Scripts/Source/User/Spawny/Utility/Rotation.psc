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
		Spawny:Logger:Rotation.cannotAddTwists(twistA, twistB)
		return None
	endif
	
	Twist result = new Twist
	
	result.x = twistA.x + twistB.x
	result.y = twistA.y + twistB.y
	result.z = twistA.z + twistB.z
	
	Spawny:Logger:Rotation.addedTwists(twistA, twistB, result)
	
	return result
EndFunction

Twist Function subtractTwists(Twist lefthand, Twist righthand) Global
	if (!lefthand || !righthand)
		Spawny:Logger:Rotation.cannotSubtractTwists(lefthand, righthand)
		return None
	endif
	
	Twist result = new Twist
	
	result.x = lefthand.x - righthand.x
	result.y = lefthand.y - righthand.y
	result.z = lefthand.z - righthand.z
	
	Spawny:Logger:Rotation.subtractedTwists(lefthand, righthand, result)
	
	return result
EndFunction

Twist Function getTwist(ObjectReference targetRef) Global
	Twist data = new Twist
	
	if (targetRef)
		data.x = targetRef.GetAngleX()
		data.y = targetRef.GetAngleY()
		data.z = targetRef.GetAngleZ()
		
		Spawny:Logger:Rotation.gotTwist(targetRef, data)
	else
		Spawny:Logger:Rotation.cannotGetTwist()
	endif
	
	return data
EndFunction

Function applyRotation(ObjectReference akTargetRef, Float xAngle = 0.0, Float yAngle = 0.0, Float zAngle = 0.0) Global
	if (!akTargetRef)
		Spawny:Logger:Rotation.cannotApplyRotation()
		return
	endif
	
	Spawny:Logger:Rotation.applyingRotation(akTargetRef, xAngle, yAngle, zAngle)
	akTargetRef.SetAngle(xAngle, yAngle, zAngle)
EndFunction

Function applyTwist(ObjectReference akTargetRef, Twist data) Global
	if (!akTargetRef || !data)
		Spawny:Logger:Rotation.cannotApplyTwist(akTargetRef, data)
		return
	endif
	
	Spawny:Logger:Rotation.applyingTwist(akTargetRef, data)
	applyRotation(akTargetRef, data.x, data.y, data.z)
EndFunction

Coordinate Function twistCoordinate(Coordinate coordinateData, Twist rotationData) Global
	if (!coordinateData)
		Spawny:Logger:Rotation.cannotRotateCoordinate(coordinateData, rotationData)
		return None
	endif
	
	if (!rotationData)
		Spawny:Logger:Rotation.cannotRotateCoordinate(coordinateData, rotationData)
		return coordinateData
	endif
	
	Coordinate result = new Coordinate
	result.x = coordinateData.x
	result.y = coordinateData.y
	result.z = coordinateData.z
	
	; rotation logic taken from https://stackoverflow.com/questions/14607640/rotating-a-vector-in-3d-space
	; Note this logic does not work well with twists in more than two dimensions, which aren't needed in 3D space regardless
	
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
	
	Spawny:Logger:Rotation.rotatedCoordinate(coordinateData, rotationData, result)
	
	return result
EndFunction
