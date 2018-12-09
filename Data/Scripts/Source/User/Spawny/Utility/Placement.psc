Scriptname Spawny:Utility:Placement Hidden Const

Struct Options
	Bool forcePersist = false
	Bool initiallyDisabled = false
	Bool deleteWhenAble = false
EndStruct

Form Function interpretForm(Form record) Global
	FormList list = record as FormList
	if (!list)
		return record
	endif
	
	Int iSize = list.GetSize()
	if (iSize)
		return list.GetAt(Utility.RandomInt(0, iSize - 1))
	else
		return None
	endif
EndFunction

ObjectReference Function place(Form aFormToPlace, ObjectReference akTargetRef, Bool abForcePersist = false, Bool abInitiallyDisabled = false, Bool abDeleteWhenAble = false) Global
	if (!aFormToPlace || !akTargetRef)
		return None
	endif
	
	return akTargetRef.PlaceAtMe(interpretForm(aFormToPlace), 1, abForcePersist, abInitiallyDisabled, abDeleteWhenAble)
EndFunction

ObjectReference Function placeOptions(Form aFormToPlace, ObjectReference akTargetRef, Options optionData) Global
	if (optionData)
		return place(aFormToPlace, akTargetRef, optionData.forcePersist, optionData.initiallyDisabled, optionData.deleteWhenAble)
	else
		return place(aFormToPlace, akTargetRef)
	endif
EndFunction

ObjectReference Function placeAtNode(Form aFormToPlace, ObjectReference akTargetRef, String asNodeName, Bool abAttach = false, Bool abForcePersist = false, Bool abInitiallyDisabled = false, Bool abDeleteWhenAble = false) Global
	if (!aFormToPlace || !akTargetRef)
		return None
	endif
	
	if (akTargetRef.HasNode(asNodeName))
		return akTargetRef.PlaceAtNode(asNodeName, interpretForm(aFormToPlace), 1, abForcePersist, abInitiallyDisabled, abDeleteWhenAble, abAttach)
	else
		return place(aFormToPlace, akTargetRef, abForcePersist, abInitiallyDisabled, abDeleteWhenAble)
	endif
EndFunction

ObjectReference Function placeAtNodeOptions(Form aFormToPlace, ObjectReference akTargetRef, String asNodeName, Options optionData, Bool abAttach = false) Global
	if (optionData)
		return placeAtNode(aFormToPlace, akTargetRef, asNodeName, abAttach, optionData.forcePersist, optionData.initiallyDisabled, optionData.deleteWhenAble)
	else
		return placeAtNode(aFormToPlace, akTargetRef, asNodeName, abAttach)
	endif
EndFunction
