Scriptname Spawny:Reusable:Form extends Quest Hidden
{Scripts of this type are used to access a Form record in a number of ways such that multiple Spawny:Spawner objects may use the same record easily.
Reference the child scripts for implementation details and possible use cases.}

Form Function getForm()
	Spawny:Logger.logBehaviorUndefined(self, "getForm")
	return None
EndFunction
