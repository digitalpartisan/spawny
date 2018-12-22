Scriptname Spawny:Logger:Modification Hidden Const DebugOnly

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation

String[] Function getTags() Global
	String[] tags = new String[0]
	tags.Add("Modification")
	return tags
EndFunction

Bool Function log(String asMessage) Global
	return Spawny:Logger.log(asMessage, getTags())
EndFunction

Bool Function warn(String asMessage) Global
	return Spawny:Logger.warn(asMessage, getTags())
EndFunction

Bool Function error(String asMessage) Global
	return Spawny:Logger.error(asMessage, getTags())
EndFunction

Bool Function logCannotOffset(ObjectReference akTargetRef, Coordinate offset) Global
	return log("Cannot offset " + akTargetRef + " by " + offset)
EndFunction

Bool Function logOffset(ObjectReference akTargetRef, Coordinate offset, Bool bRelative, Coordinate actualOffset) Global
	return log("Offsetting " + akTargetRef + " by " + offset + " with relative " + bRelative + " and actual offset " + actualOffset)
EndFunction

Bool Function logCannotResetPosition(ObjectReference akTargetRef) Global
	return log("Cannot reset position on " + akTargetRef)
EndFunction

Bool Function logResetPosition(ObjectReference akTargetRef) Global
	return log("Resetting position on " + akTargetRef)
EndFunction

Bool Function logCannotRotate(ObjectReference akTargetRef, Twist angles) Global
	return log("Cannot rotate " + akTargetRef + " by " + angles)
EndFunction

Bool Function logRotate(ObjectReference akTargetRef, Twist angles, Bool bRelative, Twist actualAngles) Global
	return log("Rotating " + akTargetRef + " by " + angles + " with relative " + bRelative + " with actual angles " + actualAngles)
EndFunction

Bool Function logCannotResetRotation(ObjectReference akTargetRef) Global
	return log("Cannot reset rotation on " + akTargetRef)
EndFunction

Bool Function logResetRotation(ObjectReference akTargetRef) Global
	return log("Resetting rotation on " + akTargetRef)
EndFunction

Bool Function logCannotRotateCoordinate(Coordinate position, Twist angles) Global
	return log("Cannot rotate coordinate " + position + " by " + angles)
EndFunction

Bool Function logRotateCoordinate(Coordinate position, Twist angles, Coordinate newPosition) Global
	return log("Rotated coordinate " + position + " by " + angles + " to " + newPosition)
EndFunction

Bool Function logCannotToggleStatic(ObjectReference akTargetRef) Global
	return log("Cannot toggle static on " + akTargetRef)
EndFunction

Bool Function logMakeStatic(ObjectReference akTargetRef) Global
	return log("Making " + akTargetRef + " static")
EndFunction

Bool Function logUnmakeStatic(ObjectReference akTargetRef) Global
	return log("Un-making " + akTargetRef + " static")
EndFunction

Bool Function logModifierCannotApply(Spawny:Modifier modifier, ObjectReference akTargetRef) Global
	return log("Modifier " + modifier + " cannot apply to " + akTargetRef)
EndFunction

Bool Function logModifierApply(Spawny:Modifier modifier, ObjectReference akTargetRef) Global
	return log("Modifier " + modifier + " applying to " + akTargetRef)
EndFunction
