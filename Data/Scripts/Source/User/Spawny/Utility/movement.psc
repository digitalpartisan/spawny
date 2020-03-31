Scriptname Spawny:Utility:Movement Hidden Const
{Provides the Coordinate struct used to denote and alter ObjectReference positions as well as the logic in methods needed to manipulate Coordinate values in basic ways required to support more complicated calculations.}

Struct Coordinate
	Float x = 0.0
	Float y = 0.0
	Float z = 0.0
EndStruct

Coordinate Function buildCoordinate(Float xValue = 0.0, Float yValue = 0.0, Float zValue = 0.0) Global
	Coordinate newCoordinate = new Coordinate
	newCoordinate.x = xValue
	newCoordinate.y = yValue
	newCoordinate.z = zValue
	
	return newCoordinate
EndFunction

Coordinate Function buildZeroCoordinate() Global
	return buildCoordinate()
EndFunction

Coordinate Function copyCoordinate(Coordinate values) Global
	if (!values)
		return None
	endif
	
	return buildCoordinate(values.x, values.y, values.z)
EndFunction

Coordinate Function getPosition(ObjectReference akTargetRef) Global
	if (!akTargetRef)
		return None
	endif
	
	return buildCoordinate(akTargetRef.GetPositionX(), akTargetRef.GetPositionY(), akTargetRef.GetPositionZ())
EndFunction

Coordinate Function addCoordinates(Coordinate lefthand, Coordinate righthand) Global
	if (!leftHand || !rightHand)
		return None
	endif
	
	return buildCoordinate(lefthand.x + righthand.x, lefthand.y + righthand.y, lefthand.z + righthand.z)
EndFunction

Coordinate Function subtractCoordinates(Coordinate lefthand, Coordinate righthand) Global
	if (!lefthand || !righthand)
		return None
	endif
	
	return buildCoordinate(lefthand.x - righthand.x, lefthand.y - righthand.y, lefthand.z - righthand.z)
EndFunction
