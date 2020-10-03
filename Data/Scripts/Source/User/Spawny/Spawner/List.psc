Scriptname Spawny:Spawner:List extends DynamicTerminal:ListWrapper:FormList:Dynamic

Function setChronicleCustomization(Spawny:Spawner:ChronicleCustomization customization)
	setData(None)
	customization && setData(customization.getSpawners())
EndFunction
