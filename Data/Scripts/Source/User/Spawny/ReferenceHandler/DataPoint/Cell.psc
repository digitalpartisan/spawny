Scriptname Spawny:ReferenceHandler:DataPoint:Cell extends Spawny:ReferenceHandler:DataPoint

Cell Property MyCell Auto Const
String Property MyCellName Auto Const
{This is a fallback mechanism to allow the player character to programmatically center on a cell if the intended reference has not yet been spawned.}

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
	return hasValue() && getCell().isLoaded()
EndFunction

String Function getCellName()
	return MyCellName
EndFunction

Function centerOn()
	String cellName = getCellName()
	cellName && "" != cellName && Debug.CenterOnCell(cellName)
EndFunction
