Scriptname Spawny:Modifier:Ownership extends Quest

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property Plugin Auto Const
Bool Property NoCrime = false Auto Const

Group ActorSettings
	Bool Property Player = false Auto Const
	Actor Property ActorOwner = None Auto Const
	DigitSet Property ActorDigits = None Auto Const
EndGroup

Group ActorBaseSettings
	ActorBase Property ActorBaseOwner = None Auto Const
	DigitSet Property ActorBaseDigits = None Auto Const
EndGroup

Group FactionSettings
	Faction Property FactionOwner = None Auto Const
	DigitSet Property FactionDigits = None Auto Const
EndGroup

Actor actorForm = None
ActorBase actorBaseForm = None
Faction factionForm = None

Actor Function getActorForm()
	return actorForm
EndFunction

ActorBase Function getActorBaseForm()
	return actorBaseForm
EndFunction

Faction Function getFactionForm()
	return factionForm
EndFunction

Function setActorForm(Actor newValue)
	actorForm = newValue
EndFunction

Function setActorBaseForm(ActorBase newValue)
	actorBaseForm = newValue
EndFunction

Function setFactionForm(Faction newValue)
	factionForm = newValue
EndFunction

Actor Function loadActorForm()
	if (Player)
		return Game.GetPlayer()
	endif
	
	if (ActorOwner)
		return ActorOwner
	endif
	
	if (Plugin && ActorDigits)
		return Plugin.lookupWithDigits(ActorDigits) as Actor
	endif
	
	return None
EndFunction

ActorBase Function loadActorBaseForm()
	if (ActorBaseOwner)
		return ActorBaseOwner
	endif
	
	if (Plugin && ActorBaseDigits)
		return Plugin.lookupWithDigits(ActorBaseDigits) as ActorBase
	endif
	
	return None
EndFunction

Faction Function loadFactionForm()
	if (FactionOwner)
		return FactionOwner
	endif
	
	if (Plugin && FactionDigits)
		return Plugin.lookupWithDigits(FactionDigits) as Faction
	endif
	
	return None
EndFunction

Function loadForms()
	setActorForm(loadActorForm())
	setActorBaseForm(loadActorBaseForm())
	setFactionForm(loadFactionForm())
EndFunction

Function checkState()
	if (getActorForm() || getActorBaseForm() || getFactionForm())
		return
	endif
	
	loadForms()
EndFunction

Function apply(ObjectReference akTargetRef)
	if (!akTargetRef)
		return
	endif
	
	checkState()
	
	Actor actorRefValue = getActorForm()
	if (actorRefValue)
		akTargetRef.SetActorRefOwner(actorRefValue, NoCrime)
	endif
	
	ActorBase actorBaseValue = getActorBaseForm()
	if (actorBaseValue)
		akTargetRef.SetActorOwner(actorBaseValue, NoCrime)
	endif
	
	Faction factionValue = getFactionForm()
	if (factionValue)
		akTargetRef.SetFactionOwner(factionValue, NoCrime)
	endif
EndFunction
