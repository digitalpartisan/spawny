Scriptname Spawny:Spawner:Paginator extends DynamicTerminal:Paginator Conditional

Spawny:Spawner:Handler Property Handler Auto Const Mandatory

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	Handler.setSpawner(getItem(iItem) as Spawny:Spawner)
	Handler.draw(akTerminalRef)
EndFunction
