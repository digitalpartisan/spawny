Scriptname SpawnyTesting:Spawnable:NodePlacement extends SpawnyTesting:Spawnable

Import Spawny:Utility:Placement

Group SpawnSettings
	Form Property PlaceMe Auto Const Mandatory
	ObjectReference Property TargetReference Auto Const Mandatory
	String[] Property NodeNames Auto Const Mandatory
EndGroup

ObjectReference[] spawnedReferences = None

Function spawnLogic()
	spawnedReferences = new ObjectReference[0]

	Int iCounter = 0
	while (iCounter < NodeNames.Length)
		spawnedReferences.Add(placeAtNode(PlaceMe, TargetReference, NodeNames[iCounter]))
		iCounter += 1
	endWhile
EndFunction

Function despawnLogic()
	if (spawnedReferences)
		Int iCounter = 0
		while (iCounter < spawnedReferences.Length)
			spawnedReferences[iCounter].Disable()
			spawnedReferences[iCounter].Delete()
			iCounter += 1
		endWhile
		
		spawnedReferences = None
	endif
EndFunction
