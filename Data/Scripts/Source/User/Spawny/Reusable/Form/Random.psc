Scriptname Spawny:Reusable:Form:Random extends Spawny:Reusable:Form
{This resuable form script randomly selects a form from the contents of a FormList.}

FormList Property MyForms = None Auto Const Mandatory

Form Function getForm()
	return Jiffy:Utility:FormList.random(MyForms)
EndFunction
