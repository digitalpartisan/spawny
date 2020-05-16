Scriptname Spawny:Adjuster extends Quest

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
	
	Spawny:Logger.log(targetRef + " is adjusting")
	
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
	
	if (!references)
		references = new ObjectReference[0]
		coordinates = new Coordinate[0]
		rotations = new Twist[0]
	endif
	
	Spawny:Logger.log(targetRef + " will be adjusted to " + position + " " + angles)
	
	RegisterForRemoteEvent(targetRef, "OnLoad")
	
	references.Add(targetRef)
	coordinates.Add(position)
	rotations.Add(angles)
EndFunction
