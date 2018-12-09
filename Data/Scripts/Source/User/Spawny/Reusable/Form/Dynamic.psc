Scriptname Spawny:Reusable:Form:Dynamic extends Spawny:Reusable:Form

Form fMyForm = None

Bool Function hasForm()
	return None != getSetting()
EndFunction

Function set(Form afNewValue)
	fMyForm = afNewValue
EndFunction

Function clear()
	set(None)
EndFunction

Form Function getSetting()
	return fMyForm
EndFunction
