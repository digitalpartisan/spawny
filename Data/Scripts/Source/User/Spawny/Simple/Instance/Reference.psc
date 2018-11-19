Scriptname Spawny:Simple:Instance:Reference extends Spawny:Simple:Instance

Import Spawny:Utility:Placement

PlacementTarget Property MyTarget Auto Const Mandatory
PlacementOptions Property MyOptions = None Auto Const

PlacementTarget Function getTargetSetting()
	return MyTarget
EndFunction

Bool Function hasTargetSetting()
	return None != getTargetSetting()
EndFunction

PlacementOptions Function getOptionSetting()
	return MyOptions
EndFunction

ObjectReference Function spawnLogic()
	return placeFormTarget(getFormSetting(), getTargetSetting(), getOptionSetting())
EndFunction
