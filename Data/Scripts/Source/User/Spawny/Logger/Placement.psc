Scriptname Spawny:Logger:Placement Hidden Const DebugOnly

Import Spawny:Utility:Placement

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Placement"
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

Bool Function cannotAddCoordinates(Coordinate coordinateA, Coordinate coordinateB) Global
	return error("Cannot add coordinates: " + coordinateA + " " + coordinateB)
EndFunction

Bool Function addedCoordinates(Coordinate coordinateA, Coordinate coordinateB, Coordinate result) Global
	return log("Added coordinates: " + coordinateA + " + " + coordinateB + " = " + result)
EndFunction

Bool Function cannotSubtractCoordinates(Coordinate lefthand, Coordinate righthand) Global
	return error("Cannot subtract coordinates: " + lefthand + " " + righthand)
EndFunction

Bool Function subtractedCoordinates(Coordinate lefthand, Coordinate righthand, Coordinate result) Global
	return log("Subtracted coordinates: " + lefthand + " - " + righthand + " = " + result)
EndFunction

Bool Function cannotGetPosition() Global
	return error("Cannot get position of null object reference")
EndFunction

Bool Function gotPosition(ObjectReference akTargetRef, Coordinate position) Global
	return log("Position of " + akTargetRef + " is " + position)
EndFunction

Bool Function cannotPlaceAt(Form afFormToPlace, ObjectReference akPlacementTarget) Global
	return error("Cannot place " + afFormToPlace + " at " + akPlacementTarget)
EndFunction

Bool Function placingAt(Form afFormToPlace, ObjectReference akPlacementTarget, Bool abForcePersist, Bool abInitiallyDisabled, Bool abDeleteWhenAble) Global
	return log("Placing " + afFormToPlace + " at " + akPlacementTarget + " with force persist: " + abForcePersist + " initially disabled: " + abInitiallyDisabled + " delete when able: " + abDeleteWhenAble)
EndFunction

Bool Function cannotPlaceAtNode(Form afFormToPlace, ObjectReference akPlacementTarget, String asNodeName) Global
	return error("Cannot place " + afFormToPlace + " at " + akPlacementTarget + " on node " + asNodeName)
EndFunction

Bool Function placingAtNode(Form afFormToPlace, ObjectReference akPlacementTarget, String asNodeName, Bool abForcePersist, Bool abInitiallyDisabled, Bool abDeleteWhenAble, Bool abAttach) Global
	return log("Placing " + afFormToPlace + " at " + akPlacementTarget + " on node " + asNodeName + " with force persist: " + abForcePersist + " initially disabled: " + abInitiallyDisabled + " delete when able: " + abDeleteWhenAble + " attach: " + abAttach)
EndFunction

Bool Function cannotPlaceFormTarget(FormToPlace placementData, PlacementTarget targetData) Global
	return error("Cannot place " + placementData + " at " + targetData)
EndFunction

Bool Function placingFormTarget(FormToPlace placementData, PlacementTarget targetData, PlacementOptions options) Global
	return log("Placing " + placementData + " at " + targetData + " with options " + options)
EndFunction

Bool Function cannotPlaceFormTargetNode(FormToPlace placementData, PlacementNodeTarget targetData) Global
	return error("Cannot place " + placementData + " at " + targetData)
EndFunction

Bool Function placingFormTargetNode(FormToPlace placementData, PlacementNodeTarget targetData, NodePlacementOptions options) Global
	return log("Placing " + placementData + " at " + targetData + " with options " + options)
EndFunction

Bool Function cannotApplyOffset(ObjectReference akTargetRef, Coordinate movement) Global
	return error("Cannot apply offset " + movement + " to reference " + akTargetRef)
EndFunction

Bool Function applyingOffset(ObjectReference akTargetRef, Coordinate movement) Global
	return log("Applying offset " + movement + " to reference " + akTargetRef)
EndFunction
