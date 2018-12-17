Scriptname Spawny:RemoteReferenceHandler:Reusable extends Spawny:RemoteReferenceHandler

Import Spawny:Utility:Placement

Spawny:Reusable:Form Property FormValue Auto Const Mandatory
Spawny:Modifier Property Modifier = None Auto Const

Function spawn()
	ObjectReference newRef = place(FormValue.getSetting(), getReference())
	
	if (!newRef)
		Spawny:Logger.log(self + " did not spawn")
	endif
	
	if (newRef && Modifier)
		Modifier.apply(newRef)
	endif
EndFunction
