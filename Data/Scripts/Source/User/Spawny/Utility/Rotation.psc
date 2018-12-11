Scriptname Spawny:Utility:Rotation Hidden Const

Import Spawny:Utility:Movement
Import Math

Struct Twist
	Float x = 0.0
	Float y = 0.0
	float z = 0.0
EndStruct

Twist Function buildTwist(Float xAngle = 0.0, Float yAngle = 0.0, Float zANgle = 0.0) Global
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

Twist Function add(Twist lefthand, Twist righthand) Global
	return buildTwist(lefthand.x + righthand.x, lefthand.y + righthand.y, lefthand.z + righthand.z)
EndFunction

Twist Function subtract(Twist lefthand, Twist righthand) Global
	return buildTwist(lefthand.x - righthand.x, lefthand.y - righthand.y, lefthand.z - righthand.z)
EndFunction

Function rotate(ObjectReference akTargetRef, Twist rotation, Bool bAbsolute = true) Global
	if (!akTargetRef || !rotation)
		return
	endif
	
	Twist twistToApply = copyTwist(rotation)
	if (!bAbsolute)
		twistToApply = add(getTwist(akTargetRef), rotation)
	endif
	
	akTargetRef.SetAngle(twistToApply.x, twistToApply.y, twistToApply.z)
EndFunction

Function resetRotation(ObjectReference akTargetRef) Global
	rotate(akTargetRef, buildZeroTwist())
EndFunction
