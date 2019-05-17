Scriptname Spawny:ReferenceHandler:DataPoint:Cell extends Spawny:ReferenceHandler:DataPoint

Cell Function getCell()
	return getValue() as Cell
EndFunction

Bool Function isLoaded()
	if (!hasValue())
		return false
	endif
	
	return getCell().IsLoaded()
EndFunction
