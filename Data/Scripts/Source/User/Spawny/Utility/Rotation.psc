Scriptname Spawny:Utility:Rotation Hidden Const
{Provides the Twist struct to describe a rotation of an ObjectReference as well as the primitive mathematics required to manipulate Twist values needed for complicated movement and rotation.}

Struct Twist
	Float x = 0.0
	Float y = 0.0
	float z = 0.0
EndStruct

Twist Function buildTwist(Float xAngle = 0.0, Float yAngle = 0.0, Float zAngle = 0.0) Global
	Twist newTwist = new Twist
	newTwist.x = xAngle
	newTwist.y = yAngle
	newTwist.z = zAngle
	
	return newTwist
EndFunction

Twist Function buildZeroTwist() Global
	return buildTwist()
EndFunction

Twist Function copyTwist(Twist values) Global
	if (!values)
		return None
	endif
	
	return buildTwist(values.x, values.y, values.z)
EndFunction

Twist Function getTwist(ObjectReference akTargetRef) Global
	if (!akTargetRef)
		return None
	endif
	
	return buildTwist(akTargetRef.GetAngleX(), akTargetRef.GetAngleY(), akTargetRef.GetAngleZ())
EndFunction

Twist Function addTwists(Twist lefthand, Twist righthand) Global
	return buildTwist(lefthand.x + righthand.x, lefthand.y + righthand.y, lefthand.z + righthand.z)
EndFunction

Twist Function subtractTwists(Twist lefthand, Twist righthand) Global
	return buildTwist(lefthand.x - righthand.x, lefthand.y - righthand.y, lefthand.z - righthand.z)
EndFunction
