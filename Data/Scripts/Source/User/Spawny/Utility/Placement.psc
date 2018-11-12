Scriptname Spawny:Utility:Placement Hidden Const

Struct FormToPlace
	Form formRecord = None
	InjectTec:Plugin formPlugin = None
	Int formID = 0
EndStruct

Struct PlacementTarget
	ObjectReference targetRef = None
	InjectTec:Plugin targetPlugin = none
	Int targetID = 0
EndStruct

Struct PlacementNodeTarget
	ObjectReference targetRef = None
	InjectTec:Plugin targetPlugin = none
	Int targetID = 0
	String targetNode = ""
EndStruct

Struct PlacementOptions
	Bool forcePersist = false
	Bool initiallyDisabled = false
	Bool deleteWhenAble = false
EndStruct

Struct NodePlacementOptions
	Bool forcePersist = false
	Bool initiallyDisabled = false
	Bool deleteWhenAble = false
	Bool attach = false
EndStruct

Struct Coordinate
	Float x = 0.0
	Float y = 0.0
	Float z = 0.0
EndStruct

Coordinate Function addCoordinates(Coordinate coordinateA, Coordinate coordinateB) Global
	if (!coordinateA || !coordinateB)
		return None
	endif
	
	Coordinate result = new Coordinate
	
	result.x = coordinateA.x + coordinateB.x
	result.y = coordinateA.y + coordinateB.y
	result.z = coordinateA.z + coordinateB.z
	
	return result
EndFunction

Coordinate Function subtractCoordinates(Coordinate lefthand, Coordinate righthand) Global
	if (!lefthand || !righthand)
		return None
	endif
	
	Coordinate result = new Coordinate
	
	result.x = lefthand.x - righthand.x
	result.y = lefthand.y - righthand.y
	result.z = lefthand.z - righthand.z
	
	return result
EndFunction

Coordinate Function getPosition(ObjectReference akTargetRef) Global
	Coordinate position = new Coordinate

	if (!akTargetRef)
		return position
	endif
	
	position.x = akTargetRef.GetPositionX()
	position.y = akTargetRef.GetPositionY()
	position.z = akTargetRef.GetPositionZ()
	
	return position
EndFunction

Form Function loadRemoteForm(InjectTec:Plugin plugin, Int iID) Global
	if (plugin && iID)
		return plugin.lookupForm(iID)
	else
		return None
	endif
EndFunction

Form Function getFormToPlace(FormToPlace data) Global
	if (!data)
		return None
	endif
	
	if (data.formRecord)
		return data.formRecord
	else
		return loadRemoteForm(data.formPlugin, data.formID)
	endif
EndFunction

ObjectReference Function getPlacementTarget(PlacementTarget data) Global
	if (!data)
		return None
	endif
	
	if (data.targetRef)
		return data.targetRef
	else
		return loadRemoteForm(data.targetPlugin, data.targetID) as ObjectReference
	endif
EndFunction

ObjectReference Function getPlacementNodeTarget(PlacementNodeTarget data) Global
	if (!data)
		return None
	endif
	
	if (data.targetRef)
		return data.targetRef
	else
		return loadRemoteForm(data.targetPlugin, data.targetID) as ObjectReference
	endif
EndFunction

Form Function determineForm(Form record) Global
	FormList list = record as FormList
	if (!list)
		return None 
	endif
	
	Int iSize = list.GetSize()
	if (iSize)
		return list.GetAt(Utility.RandomInt(0, iSize - 1))
	else
		return None
	endif
EndFunction

ObjectReference Function placeAt(Form akPlaceMe, ObjectReference akPlaceAt, Bool abForcePersist = false, Bool abInitiallyDisabled = false, Bool abDeleteWhenAble = false) Global
	if (!akPlaceMe || !akPlaceAt)
		return None
	endif
	
	return akPlaceAt.PlaceAtMe(determineForm(akPlaceMe), 1, abForcePersist, abInitiallyDisabled, abDeleteWhenAble)
EndFunction

ObjectReference Function placeFormTarget(FormToPlace placementdata, PlacementTarget targetData, PlacementOptions options = None) Global
	if (!placementData || !targetData)
		return None
	endif
	
	Form placeMe = getFormToPlace(placementData)
	ObjectReference placeAt = getPlacementTarget(targetData)
	
	if (options)
		return placeAt(placeMe, placeAt, options.forcePersist, options.initiallyDisabled, options.deleteWhenAble)
	else
		return placeAt(placeMe, placeAt)
	endif
EndFunction

ObjectReference Function placeAtNode(Form akPlaceMe, ObjectReference akPlaceAt, String asNodeName, Bool abForcePersist = false, Bool abInitiallyDisabled = false, Bool abDeleteWhenAble = false, Bool abAttach = false) Global
	if (!akPlaceMe || !akPlaceAt || !akPlaceAt.HasNode(asNodeName))
		return None
	endif
	
	return akPlaceAt.PlaceAtNode(asNodeName, determineForm(akPlaceMe), 1, abForcePersist, abInitiallyDisabled, abDeleteWhenAble, abAttach)
EndFunction

ObjectReference Function placeFormTargetNode(FormToPlace placementData, PlacementNodeTarget targetData, NodePlacementOptions options) Global
	if (!placementData || !targetData)
		return None
	endif
	
	Form placeMe = getFormToPlace(placementData)
	ObjectReference placeAt = getPlacementNodeTarget(targetData)
	
	if (options)
		return placeAtNode(placeMe, placeAt, targetData.targetNode, options.forcePersist, options.initiallyDisabled, options.deleteWhenAble, options.attach)
	else
		return placeAtNode(placeMe, placeAt, targetData.targetNode)
	endif
EndFunction

Function applyOffset(ObjectReference akTargetRef, Coordinate offsetData) Global
	if (!akTargetRef || !offsetData)
		return
	endif
	
	akTargetRef.MoveTo(akTargetRef, akTargetRef.GetPositionX() + offsetData.x, akTargetRef.GetPositionY() + offsetData.y, akTargetRef.GetPositionZ() + offsetData.z)
EndFunction
