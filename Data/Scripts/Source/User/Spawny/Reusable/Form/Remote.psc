Scriptname Spawny:Reusable:Form:Remote extends Spawny:Reusable:Form Const

Import Spawny:Utility:Remote

FormData Property MyForm Auto Const Mandatory

Form Function getSetting()
	if (!MyForm)
		return None
	endif
	
	if (!MyForm.record)
		populateForm(MyForm)
	endif
	
	return MyForm.record
EndFunction
