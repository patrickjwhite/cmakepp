function(obj_istype this result typename)
	obj_gettype(${this} actual)
	if("${actual}" STREQUAL "${typename}")
		return_value(true)
	 else()
	 	return_value(false)
	endif()
endfunction()