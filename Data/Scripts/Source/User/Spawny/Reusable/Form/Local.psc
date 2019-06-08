Scriptname Spawny:Reusable:Form:Local extends Spawny:Reusable:Form
{This reusable form script is a very simple, static, local (i.e. is contained within the mod in question or one of its required master plugins) property value.}

Form Property MyForm Auto Const Mandatory

Form Function getForm()
	return MyForm
EndFunction
