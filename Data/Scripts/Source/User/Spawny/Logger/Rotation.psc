Scriptname Spawny:Logger:Rotation Hidden Const DebugOnly

Import Spawny:Utility:Placement
Import Spawny:Utility:Rotation

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Rotation"
	return tags
EndFunction

Bool Function log(String sMessage) Global
	return Loggout.log(Spawny:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(Spawny:Logger.getName(), sMessage, getTags())
EndFunction	

Bool Function error(String sMessage) Global
	return Loggout.error(Spawny:Logger.getName(), sMessage, getTags())
EndFunction

Bool Function cannotAddTwists(Twist twistA, Twist twistB) Global
	return error("Cannot add twists " + twistA + " " + twistB)
EndFunction

Bool Function addedTwists(Twist twistA, Twist twistB, Twist result) Global
	return log("Added twists " + twistA + " + " + twistB + " = " + result)
EndFunction

Bool Function cannotSubtractTwists(Twist lefthand, Twist righthand) Global
	return error("Cannot subtract twists " + lefthand + " " + righthand)
EndFunction

Bool Function subtractedTwists(Twist lefthand, Twist righthand, Twist result) Global
	return log("Subtracted twists " + lefthand + " - " + righthand + " = " + result)
EndFunction

Bool Function cannotGetTwist() Global
	return error("Cannot get rotation of a None reference")
EndFunction

Bool Function gotTwist(ObjectReference akTargetRef, Twist rotation) Global
	return log("Got rotation " + rotation + " of " + akTargetRef)
EndFunction

Bool Function cannotApplyRotation() Global
	return error("Cannot apply rotation to a None reference")
EndFunction

Bool Function applyingRotation(ObjectReference akTargetRef, Float x, Float y, Float z) Global
	return log("Applytion rotation: " + akTargetRef + " " + x + " " + y + " " + z)
EndFunction

Bool Function cannotApplyTwist(ObjectReference akTargetRef, Twist twistData) Global
	return error("Cannot apply twist " + twistData + " to reference " + akTargetRef)
EndFunction

Bool Function applyingTwist(ObjectReference akTargetRef, Twist twistData) Global
	return log("Applying twist " + twistData + " to " + akTargetRef)
EndFunction

Bool Function cannotRotateCoordinate(Coordinate coordinateData, Twist twistData) Global
	return error("Cannot rotate coordinate " + coordinateData + " with rotation " + twistData)
EndFunction

Bool Function rotatedCoordinate(Coordinate coordinateData, Twist twistData, Coordinate resultData) Global
	
EndFunction
