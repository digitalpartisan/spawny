Scriptname Spawny:Spawner:Logger Hidden Const DebugOnly

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

Bool Function logWillAdjust(Spawny:Spawner:AdjustmentHandler adjuster, Spawny:Spawner spawner) Global
	return log(adjuster + " will adjust " + spawner)
EndFunction

Bool Function logWillNotAdjust(Spawny:Spawner:AdjustmentHandler adjuster, Spawny:Spawner spawner) Global
	return log(adjuster + " will not adjust " + spawner)
EndFunction

Bool Function logAdjusting(Spawny:Spawner:AdjustmentHandler adjuster, Spawny:Spawner spawner) Global
	return log(adjuster + " is adjusting " + spawner)
EndFunction

Bool Function logAdjustmentFailure(Spawny:Spawner:AdjustmentHandler adjuster, Spawny:Spawner spawner) Global
	return error(adjuster + " failed to adjust " + spawner)
EndFunction
