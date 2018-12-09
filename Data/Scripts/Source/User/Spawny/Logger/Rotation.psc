Scriptname Spawny:Logger:Rotation Hidden Const DebugOnly

Import Spawny:Utility:Placement
Import Spawny:Utility:Movement
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
