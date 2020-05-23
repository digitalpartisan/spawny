Scriptname Spawny:Utility:Placement Hidden Const
{Contains all basic and vital spawning behavior as well as options to customize the placement of the form record at its target.
Reference the parameters of the various methods herein to determine which is best suited to your purpose.}

Struct Options
	Bool forcePersist = false
	Bool initiallyDisabled = false
	Bool deleteWhenAble = false
	String nodeName = ""
	Bool attach = false
	Int amount = 1
EndStruct

Options Function copyOptions(Options duplicateMe) Global
	Options copy = new Options
	
	if (duplicateMe)
		copy.forcePersist = duplicateMe.forcePersist
		copy.initiallyDisabled = duplicateMe.initiallyDisabled
		copy.deleteWhenAble = duplicateMe.deleteWhenAble
		copy.nodeName = duplicateMe.nodeName
		copy.attach = duplicateMe.attach
		copy.amount = duplicateMe.amount
	endif
	
	return copy
EndFunction

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

ObjectReference Function placeBasic(Form placeMe, ObjectReference atMe, Bool bForcePersist = false, Bool bInitiallyDisabled = false, Bool bDeleteWhenAble = false, Int iAmount = 1) Global
	if (!placeMe || !atMe)
		Spawny:Logger:Placement.logCannotPlace(placeMe, atMe)
		return None
	endif
	
	ObjectReference result = atMe.PlaceAtMe(interpretForm(placeMe), iAmount, bForcePersist, bInitiallyDisabled, bDeleteWhenAble)
	Spawny:Logger:Placement.logPlacing(placeMe, atMe, bForcePersist, bInitiallyDisabled, bDeleteWhenAble, result)
	
	return result
EndFunction

ObjectReference Function placeNode(Form placeMe, ObjectReference atMe, String nodeName, Bool bAttach = false, Bool bForcePersist = false, Bool bInitiallyDisabled = false, Bool bDeleteWhenAble = false, Int iAmount = 1) Global
	if (!placeMe || !atMe)
		Spawny:Logger:Placement.logCannotPlace(placeMe, atMe)
		return None
	endif
	
	if ("" == nodeName || !atMe.HasNode(nodeName))
		Spawny:Logger:Placement.logReferenceDoesNotHaveNode(atMe, nodeName)
		return None
	endif
	
	ObjectReference result = atMe.PlaceAtNode(nodeName, interpretForm(placeMe), iAmount, bForcePersist, bInitiallyDisabled, bDeleteWhenAble, bAttach)
	Spawny:Logger:Placement.logPlacingAtNode(placeMe, atMe, nodeName, bForcePersist, bInitiallyDisabled, bDeleteWhenAble, bAttach, result)
	return result
EndFunction

ObjectReference Function placeGranular(Form placeMe, ObjectReference atMe, String nodeName = "", Bool bAttach = false, Bool bForcePersist = false, Bool bInitiallyDisabled = false, Bool bDeleteWhenAble = false, Int iAmount = 1) Global
	if ("" != nodeName)
		return placeNode(placeMe, atMe, nodeName, bAttach, bForcePersist, bInitiallyDisabled, bDeleteWhenAble, iAmount)
	else
		return placeBasic(placeMe, atMe, bForcePersist, bInitiallyDisabled, bDeleteWhenAble, iAmount)
	endif
EndFunction

ObjectReference Function place(Form placeMe, ObjectReference atMe, Options optionData = None) Global
	if (optionData)
		return placeGranular(placeMe, atMe, optionData.nodeName, optionData.attach, optionData.forcePersist, optionData.initiallyDisabled, optionData.deleteWhenAble, optionData.amount)
	else
		return placeGranular(placeMe, atMe)
	endif
EndFunction
