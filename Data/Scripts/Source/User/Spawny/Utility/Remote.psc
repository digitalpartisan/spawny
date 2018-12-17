Scriptname Spawny:Utility:Remote Hidden Const

Struct FormData
	Form record = None
	InjectTec:Plugin plugin = None
	Int id = 0
EndStruct

Struct ObjectReferenceData
	ObjectReference reference = None
	InjectTec:Plugin plugin = None
	Int id = 0
EndStruct

Form Function load(InjectTec:Plugin plugin, Int iID) Global
	if (!plugin || !iID)
	Debug.MessageBox("busted")
		return None
	endif

	return plugin.lookupForm(iID)
EndFunction

ObjectReference Function loadReference(InjectTec:Plugin plugin, Int iID) Global
	Form loaded = load(plugin, iID)
	if (!loaded)
		Debug.MessageBox("did not load form " + iID)
	endif
	return loaded as ObjectReference
EndFunction

Function populateForm(FormData data) Global
	if (!data)
		return None
	endif
	
	data.record = load(data.plugin, data.id)
EndFunction

Function populateObjectReference(ObjectReferenceData data) Global
	if (!data)
		return None
	endif
	
	data.reference = loadReference(data.plugin, data.id)
EndFunction
