Scriptname Spawny:Reusable:Form:Remote extends Spawny:Reusable:Form

Import Spawny:Utility:Remote

FormData Property MyForm Auto Const Mandatory

Form Function getSetting()
	if (!MyForm)
		return None
	endif
	
	if (!MyForm.record)
		populateForm(MyForm)
		Game.GetPlayer().AddItem(MyForm.record)
	endif
	
	return MyForm.record
EndFunction
