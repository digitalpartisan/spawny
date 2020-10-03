Scriptname Spawny:Spawner:ChronicleCustomization:List extends Chronicle:Package:CustomBehavior:List

Bool Function itemPassesFilter(Int iNumber)
	return getRawDataItem(iNumber) is Spawny:Spawner:ChronicleCustomization
EndFunction
