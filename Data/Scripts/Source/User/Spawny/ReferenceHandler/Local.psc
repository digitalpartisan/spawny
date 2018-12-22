Scriptname Spawny:ReferenceHandler:Local extends Spawny:ReferenceHandler

ObjectReference Property TargetReference Auto Const Mandatory

Function onBeginObserving(String asOldState)
	if (TargetReference)
		setReference(TargetReference)
		goToReady()
	else
		goToDormant()
	endif
EndFunction
