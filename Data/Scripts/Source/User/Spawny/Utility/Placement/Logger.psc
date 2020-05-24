Scriptname Spawny:Utility:Placement:Logger Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[0]
	tags.Add("Placement")
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

Bool Function logCannotPlace(Form afFormToPlace, ObjectReference akTargetRef) Global
	return log("Cannot place " + afFormToPlace + " at " + akTargetRef)
EndFunction

Bool Function logReferenceDoesNotHaveNode(ObjectReference akTargetRef, String asNodeName) Global
	return log("Reference " + akTargetRef + " does not have node " + asNodeName)
EndFunction

Bool Function logPlacing(Form afFormToPlace, ObjectReference akTargetRef, Bool abForcePersist, Bool abInitiallyDisabled, Bool abDeleteWhenAble, ObjectReference akResultRef) Global
	return log("Placing " + afFormToPlace + " at " + akTargetRef + " with force persist " + abForcePersist + " initially disabled " + abInitiallyDisabled + " delete when able " + abDeleteWhenAble + " with result " + akResultRef)
EndFunction

Bool Function logPlacingAtNode(Form afFormToPlace, ObjectReference akTargetRef, String asNodeName, Bool abForcePersist, Bool abInitiallyDisabled, Bool abDeleteWhenAble, Bool abAttach, ObjectReference akResultRef) Global
	return log("Placing " + afFormToPlace + " at " + akTargetRef + " node " + asNodeName + " with force persist " + abForcePersist + " initially disabled " + abInitiallyDisabled + " delete when able " + abDeleteWhenAble + " attach " + abAttach + " with result " + akResultRef)
EndFunction
