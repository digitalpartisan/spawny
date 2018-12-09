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
		return None
	endif

	return plugin.lookupForm(iID)
EndFunction

ObjectReference Function loadReference(InjectTec:Plugin plugin, Int iID) Global
	return load(plugin, iID) as ObjectReference
EndFunction

Form Function populateForm(FormData data) Global
	if (!data)
		return None
	endif
	
	data.record = load(data.plugin, data.id)
	return data.record
EndFunction

ObjectReference Function populateObjectReference(ObjectReferenceData data) Global
	if (!data)
		return None
	endif
	
	data.reference = loadReference(data.plugin, data.id)
	return data.reference
EndFunction
