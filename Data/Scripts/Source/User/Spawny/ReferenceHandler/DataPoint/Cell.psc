Scriptname Spawny:ReferenceHandler:DataPoint:Cell extends Spawny:ReferenceHandler:DataPoint

Cell Function getCell()
	return getValue() as Cell
EndFunction

Bool Function isLoaded()
	return getCell().isLoaded()
EndFunction
