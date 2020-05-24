Scriptname Spawny:ObjectReference:Logger Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[0]
	tags.Add("ObjectReference")
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

Bool Function logInitialized(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been initialized")
EndFunction

Bool Function logLoaded(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been loaded")
EndFunction

Bool Function logUnloaded(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been unloaded")
EndFunction

Bool Function logEnabled(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been enabled")
EndFunction

Bool Function logDisabled(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been disabled")
EndFunction

Bool Function logDeleted(Spawny:ObjectReference akObject) Global
	return log(akObject + " has been deleted")
EndFunction

Bool Function logContainerChanged(Spawny:ObjectReference akObject, Spawny:ObjectReference:ChildPlacement childObject) Global
	return log(akObject + " observed a container change on child " + childObject.name)
EndFunction

Bool Function logSpawning(Spawny:ObjectReference akObject) Global
	return log(akObject + " is spawning")
EndFunction

Bool Function logDespawning(Spawny:ObjectReference akObject) Global
	return log(akObject + " is despawning")
EndFunction

Bool Function logFailureToSpawn(Spawny:ObjectReference akObject, Spawny:ObjectReference:ChildPlacement failedPlacement) Global
	return error(akObject + " failed to spawn " + failedPlacement)
EndFunction
