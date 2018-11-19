Scriptname Spawny:Simple:Instance:Node extends Spawny:Simple:Instance

Import Spawny:Utility:Placement

PlacementNodeTarget Property MyTarget Auto Const Mandatory
NodePlacementOptions Property MyOptions = None Auto Const

PlacementNodeTarget Function getTargetSetting()
	return MyTarget
EndFunction

Bool Function hasTargetSetting()
	return None != getTargetSetting()
EndFunction

NodePlacementOptions Function getOptionSetting()
	return MyOptions
EndFunction

ObjectReference Function spawnLogic()
	return placeFormTargetNode(getFormSetting(), getTargetSetting(), getOptionSetting())
EndFunction
