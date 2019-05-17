Scriptname Spawny:Reusable:Form:Random extends Spawny:Reusable:Form

FormList Property MyForms = None Auto Const Mandatory

Form Function getForm()
	if (!MyForms || 0 == MyForms.GetSize())
		return None
	endif
	
	return MyForms.GetAt(Utility.RandomInt(0, MyForms.GetSize() - 1))
EndFunction
