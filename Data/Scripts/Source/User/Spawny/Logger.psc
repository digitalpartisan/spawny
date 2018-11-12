Scriptname Spawny:Logger Hidden Const DebugOnly

String Function getName() Global
	return "Spawny"
EndFunction

Bool Function log(String sMessage, String[] tags = None) Global
	return Loggout.log(getName(), sMessage, tags)
EndFunction

Bool Function warn(String sMessage, String[] tags = None) Global
	return Loggout.warn(getName(), sMessage, tags)
EndFunction

Bool Function error(String sMessage, String[] tags = None) Global
	return Loggout.error(getName(), sMessage, tags)
EndFunction

Bool Function logBehaviorUndefined(ScriptObject scriptRef, String sName) Global
	return error("Behavior " + sName + " undefined on " + scriptRef)
EndFunction
