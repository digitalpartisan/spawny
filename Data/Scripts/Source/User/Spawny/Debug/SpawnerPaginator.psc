Scriptname Spawny:Debug:SpawnerPaginator extends DynamicTerminal:Paginator Conditional

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	Spawny:Spawner spawner = getItem(iItem) as Spawny:Spawner
	spawner && spawner.goTo()
EndFunction
