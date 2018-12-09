Scriptname Spawny:Reusable:Reference:Remote extends Spawny:Reusable:Reference Const

Import Spawny:Utility:Remote

ObjectReferenceData Property MyReference Auto Const Mandatory

ObjectReference Function getSetting()
	if (!MyReference)
		return None
	endif
	
	if (!MyReference.reference)
		populateObjectReference(MyReference)
	endif
	
	return MyReference.reference
EndFunction
