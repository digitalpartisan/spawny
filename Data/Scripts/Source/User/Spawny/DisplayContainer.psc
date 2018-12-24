Scriptname Spawny:DisplayContainer extends ObjectReference

Import Spawny:Utility:Placement

Struct ReferenceNode
	ObjectReference reference = None
	String node = ""
EndStruct

ReferenceNode[] Property ReferenceNodes = None Auto Const Mandatory
Keyword Property BlockWorkshopInteractionKeyword Auto Const Mandatory
Options Property PlacementOptions = None Auto Const

Message Property ActivationMessage Auto Const Mandatory
Int Property RemovalOption = 0 Auto Const

Keyword Property RequiredKeyword = None Auto Const
FormList Property FormListFilter = None Auto Const

Form[] containerContents = None

Bool Function isAllowed(Form akFormValue)
	if (!akFormValue)
		return false
	endif

	if (RequiredKeyword && akFormValue.HasKeyword(RequiredKeyword))
		return true
	endif
	
	if (FormListFilter && FormListFilter.HasForm(akFormValue))
		return true
	endif
	
	return false
EndFunction

Int Function getMaxContents()
	if (ReferenceNodes)
		return ReferenceNodes.Length
	endif
	
	return 0
EndFunction

Int Function getIndexForReference(ObjectReference akTargetRef)
	if (ReferenceNodes)
		return ReferenceNodes.FindStruct("reference", akTargetRef)
	endif
	
	return -1
EndFunction

ReferenceNode Function getReferenceNodeAtIndex(Int iIndex)
	if (ReferenceNodes && iIndex >= 0 && iIndex < ReferenceNodes.Length)
		return ReferenceNodes[iIndex]
	endif

	return None
EndFunction

Function displayReference(ReferenceNode data, Form fFormToDisplay)
	if (!data || "" == data.node || !fFormToDisplay)
		return
	endif
	
	data.reference = placeAtNodeOptions(fFormToDisplay, self, data.node, PlacementOptions, true)
	
	if (!data.reference)
		return
	endif
	
	data.reference.BlockActivation()
	data.reference.SetMotionType(Motion_Keyframed, false)
	data.reference.AddKeyword(BlockWorkshopInteractionKeyword)
	data.reference.SetNoFavorAllowed()
	data.reference.SetPlayerHasTaken()
	RegisterForRemoteEvent(data.reference, "OnActivate")
EndFunction

Function displayReferences()
	Spawny:Logger.log("displaying references")
	Int iCounter = 0
	while (iCounter < containerContents.Length)
		displayReference(getReferenceNodeAtIndex(iCounter), containerContents[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function deleteReference(ReferenceNode data)
	if (data.reference)
		UnregisterForRemoteEvent(data.reference, "OnActivate")
		data.reference.DisableNoWait()
		data.reference.Delete()
		data.reference = None
	endif
EndFunction

Function deleteReferences()
	Spawny:Logger.log("deleting references")
	Int iCounter = 0
	while (iCounter < ReferenceNodes.Length)
		deleteReference(ReferenceNodes[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function refresh()
	deleteReferences()
	displayReferences()
EndFunction

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
	deleteReferences()
EndEvent

Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	if (Game.GetPlayer() != akActionRef)
		return
	endif
	
	Int iReferenceNodeIndex = getIndexForReference(akSender)
	if (0 > iReferenceNodeIndex)
		return
	endif
	
	Int iContentsIndex = containerContents.Find(akSender.GetBaseObject())
	if (0 > iContentsIndex)
		return
	endif
	
	if (RemovalOption != ActivationMessage.Show())
		return
	endif
	
	RemoveItem(containerContents[iContentsIndex], 1, false, akActionRef)
	containerContents.Remove(iContentsIndex)
	deleteReference(getReferenceNodeAtIndex(iReferenceNodeIndex))
EndEvent

Event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if (isAllowed(akBaseItem))
		containerContents.Add(akBaseItem)
	else
		removeItem(akBaseItem, aiItemCount, false, Game.GetPlayer())
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	Int iContentsIndex = containerContents.Find(akBaseItem)
	if (0 > iContentsIndex)
		return
	endif
	
	containerContents.Remove(iContentsIndex)
	deleteReference(getReferenceNodeAtIndex(iContentsIndex))
EndEvent

Auto State Unloaded
	Event OnLoad()
		containerContents = new Form[0]
		GoToState("Ready")
	EndEvent
EndState

State Ready
	Event OnActivate(ObjectReference akActionRef)
		BlockActivation()
		GoToState("Busy")
		AddInventoryEventFilter(None)
		
		if (Game.GetPlayer() == akActionRef)
			deleteReferences()
			Utility.Wait(0.01)
			displayReferences()
		endif
		
		GoToState("Ready")
		BlockActivation(false)
	EndEvent
EndState

State Busy
	
EndState
	