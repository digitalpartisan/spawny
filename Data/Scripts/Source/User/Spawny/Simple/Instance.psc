Scriptname Spawny:Simple:Instance extends Spawny:Simple Hidden

Import Spawny:Utility:Placement
Import Spawny:Utility:Rotation

FormToPlace Property MyForm Auto Const Mandatory
Coordinate Property MyOffset = None Auto Const
Twist Property MyRotation = None Auto Const

ObjectReference spawnedForm = None

Function clearSpawnedForm()
	if (spawnedForm)
		spawnedForm.Disable()
		spawnedForm.Delete()
		spawnedForm = None
	endif
EndFunction

ObjectReference Function getSpawnedForm()
	return spawnedForm
EndFunction

Bool Function hasSpawned()
	return None != getSpawnedForm()
EndFunction

FormToPlace Function getFormSetting()
	return MyForm
EndFunction

Bool Function hasFormSetting()
	return None != getFormSetting()
EndFunction

Coordinate Function getOffset()
	return MyOffset
EndFunction

Bool Function hasOffset()
	return None != getOffset()
EndFunction

Twist Function getRotation()
	return MyRotation
EndFunction

Bool Function hasRotation()
	return None != getRotation()
EndFunction

Bool Function hasTargetSetting()
	return false
EndFunction

Bool Function canSpawn()
	return hasFormSetting() && hasTargetSetting() && !hasSpawned()
EndFunction

Function setSpawnedForm(ObjectReference akNewValue)
	spawnedForm = akNewValue
EndFunction

ObjectReference Function spawnLogic()
	return None
EndFunction

Function offsetLogic()
	if (hasSpawned() && hasOffset())
		applyOffset(getSpawnedForm(), getOffset())
	endif
EndFunction

Function rotationLogic()
	if (hasSpawned() && hasRotation())
		applyTwist(getSpawnedForm(), getRotation())
	endif
EndFunction

Function spawn()
	if (canSpawn())
		setSpawnedForm(spawnLogic())
		offsetLogic()
		rotationLogic()
	endif
EndFunction

Function despawn()
	if (spawnedForm)
		spawnedForm.Disable()
		spawnedForm.Delete()
		spawnedForm = None
	endif
EndFunction
