Scriptname Spawny:Utility:Modification:AdjustmentHandler extends Quest

Import Spawny:Utility:Movement
Import Spawny:Utility:Rotation
Import Spawny:Utility:Modification

ObjectReference[] references = None
Coordinate[] coordinates = None
Twist[] rotations = None

Function postAdjustment(ObjectReference akTargetRef)
	Spawny:ObjectReference spawnyObject = akTargetRef as Spawny:ObjectReference
	spawnyObject && spawnyObject.spawn()
EndFunction

Event ObjectReference.OnLoad(ObjectReference akSenderRef)
	
EndEvent

Function register(ObjectReference targetRef, Coordinate position, Twist angles)
	
EndFunction

Event OnQuestShutdown()
	GoToState("Shutdown")
EndEvent

Auto State Unstarted
	Event OnQuestInit()
		references = new ObjectReference[0]
		coordinates = new Coordinate[0]
		rotations = new Twist[0]
		GoToState("Running")
	EndEvent
EndState

State Running
	Event ObjectReference.OnLoad(ObjectReference akSenderRef)
		Int iIndex = -1
		if (references && akSenderRef)
			iIndex = references.Find(akSenderRef)
		endif
		if (iIndex < 0)
			return
		endif
		
		ObjectReference targetRef = references[iIndex]
		Coordinate position = coordinates[iIndex]
		Twist angles = rotations[iIndex]
		
		Spawny:Logger.log(targetRef + " is being adjusted")
		
		if ( (!position || setPosition(targetRef, position)) && (!angles || setRotation(targetRef, angles)) )
			references.Remove(iIndex)
			coordinates.Remove(iIndex)
			rotations.Remove(iIndex)
			
			UnregisterForRemoteEvent(targetRef, "OnLoad")
			postAdjustment(targetRef)
		endif
	EndEvent
	
	Function register(ObjectReference targetRef, Coordinate position, Twist angles)
		if (!targetRef || (!position || !angles))
			return
		endif
		
		Spawny:Logger.log(targetRef + " will be adjusted")
		RegisterForRemoteEvent(targetRef, "OnLoad")
		references.Add(targetRef)
		coordinates.Add(position)
		rotations.Add(angles)
	EndFunction
EndState

State Shutdown
	Event OnBeginState(String asOldState)
		Int iCounter = 0
		while (iCounter < references.Length)
			UnregisterForRemoteEvent(references[iCounter], "OnLoad")
			iCounter += 1
		endWhile
	
		references = None
		coordinates = None
		rotations = None
	EndEvent
EndState
