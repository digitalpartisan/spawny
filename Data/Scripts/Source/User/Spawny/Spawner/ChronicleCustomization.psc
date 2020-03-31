Scriptname Spawny:Spawner:ChronicleCustomization extends Chronicle:Package:CustomBehavior:QuestList
{Used to allow a Chronicle package to start spawners upon the package being installed.
Also starts any and all spawners upon a game load event to allow for additional spawners to be installed during a mod upgrade.
Shuts down spawners when the package is uninstalled.
Ditto for a list of listeners.}

FormList Property Spawners Auto Const Mandatory
{A list of Spawny:Spawner records for this package's behavior to handle.}
FormList Property Listeners = None Auto Const
{A list of Spawny:ReferenceHandler:Listener records for this package's behavior to handle.}

Function handle(Bool bStart = true)
	handleQuestList(Spawners, bStart)
	handleQuestList(Listeners, bStart)
EndFunction
