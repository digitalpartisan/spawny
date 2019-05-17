Scriptname Spawny:Reusable:Form:Dynamic extends Spawny:Reusable:Form

Form fMyForm = None

Form Function getForm()
	return fMyForm
EndFunction

Bool Function hasForm()
	return None != getForm()
EndFunction

Function setForm(Form afNewValue)
	fMyForm = afNewValue
EndFunction

Function clearForm()
	setForm(None)
EndFunction
