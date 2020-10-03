Scriptname Spawny:Spawner:ChronicleCustomization:Paginator extends DynamicTerminal:Paginator Conditional

Spawny:Spawner:ChronicleCustomization:Handler Property Handler Auto Const Mandatory

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	Handler.setSpawnerCustomization(getItem(iItem) as Spawny:Spawner:ChronicleCustomization)
	Handler.draw(akTerminalRef)
EndFunction
