Scriptname Spawny:ReferenceHandler:DataPoint:Cell extends Spawny:ReferenceHandler:DataPoint

Cell Property MyCell Auto Const

Bool Function hasValue()
	return (MyCell || parent.hasValue())
EndFunction

Cell Function getCell()
	if (MyCell)
		return MyCell
	else
		return getValue() as Cell
	endif
EndFunction

Bool Function isLoaded()
	return getCell().isLoaded()
EndFunction
