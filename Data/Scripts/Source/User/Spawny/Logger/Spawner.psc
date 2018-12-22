Scriptname Spawny:Logger:Spawner Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[0]
	tags.Add("Spawner")
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

Bool Function logStartup(Spawny:Spawner spawner) Global
	return log("Spawner " + spawner + " is starting up")
EndFunction

Bool Function logShutdown(Spawny:Spawner spawner) Global
	return log("Spawner " + spawner + " is shutting down")
EndFunction

Bool Function logSpawning(Spawny:Spawner spawner) Global
	return log("Spawner " + spawner + " is spawning")
EndFunction
