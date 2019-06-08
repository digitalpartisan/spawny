Scriptname Spawny:Reusable:Form:Dynamic extends Spawny:Reusable:Form
{This particular Spawny:Reusable:Form allows its value to be set at will by a calling entity.
This is useful for situations where multiple Spawny:Spawner objects need to spawn the same form where said form may change from time to time.}

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
