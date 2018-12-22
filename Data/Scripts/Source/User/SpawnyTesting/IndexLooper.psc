Scriptname SpawnyTesting:IndexLooper Hidden Const

Int Function getNextIndex(Int iCurrentIndex, Int iListSize) Global
	Int iNextIndex = iCurrentIndex + 1
	if (iNextIndex >= iListSize)
		iNextIndex = 0
	endif
	
	return iNextIndex
EndFunction
