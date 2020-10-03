Scriptname Spawny:Debug:CustomizationPaginator extends DynamicTerminal:Paginator:Nested:Dynamic Conditional

Spawny:Spawner:List Property SpawnerList Auto Const Mandatory

DynamicTerminal:ListWrapper Function getListWrapper(Int iItemID)
	Spawny:Spawner:ChronicleCustomization customization = getItem(iItemID) as Spawny:Spawner:ChronicleCustomization
	customization && SpawnerList.setChronicleCustomization(customization)
	return SpawnerList
EndFunction
