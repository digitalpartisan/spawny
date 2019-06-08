Scriptname Spawny:Reusable:Reference extends Quest Hidden
{This script allows multiple Spawny:Spawner objects to use the same target ObjectReference object.}

ObjectReference Function getReference()
	Spawny:Logger.logBehaviorUndefined(self, "getReference")
	return None
EndFunction
