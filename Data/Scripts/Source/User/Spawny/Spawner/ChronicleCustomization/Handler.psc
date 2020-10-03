Scriptname Spawny:Spawner:ChronicleCustomization:Handler extends Chronicle:Package:CustomBehavior:Handler Conditional

Spawny:Spawner:Paginator Property SpawnerPaginator Auto Const
{Optional paginator used by the terminal displaying this handler when it needs to paginate the spawners from its custom behavior.}
Spawny:Spawner:List Property SpawnerList Auto Const
{Optional list for paginating the spawners in this customization.}

Function setSpawnerCustomization(Spawny:Spawner:ChronicleCustomization newValue)
	setBehavior(newValue)
EndFunction

Spawny:Spawner:ChronicleCustomization Function getSpawnerCustomization()
	return getBehavior() as Spawny:Spawner:ChronicleCustomization
EndFunction

Spawny:Spawner:Paginator Function getSpawnerPaginator()
	return SpawnerPaginator
EndFunction

Spawny:Spawner:List Function getSpawnerList()
	if (!isValid() || !SpawnerList)
		return None
	endif

	SpawnerList.setChronicleCustomization(getSpawnerCustomization())
	return SpawnerList
EndFunction

Function paginateSpawners(ObjectReference akTerminalRef)
	DynamicTerminal:Paginator paginator = getSpawnerPaginator()
	DynamicTerminal:ListWrapper list = getSpawnerList()

	if (!paginator || !list)
		return
	endif

	paginator.init(akTerminalRef, list)
EndFunction
