Scriptname Spawny:Debug:PackagePaginator extends DynamicTerminal:Paginator:Nested:Dynamic:FormArray Conditional

Form[] Function getArray(Int iItemID)
	Chronicle:Package targetPackage = getItem(iItemID) as Chronicle:Package
	if (!targetPackage)
		return None
	endif

	return targetPackage.getCustomizations() as Form[]
EndFunction
