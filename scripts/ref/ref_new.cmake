function(ref_new ref )
	while(true)
		make_guid(id)
		get_property(prop GLOBAL PROPERTY "ref:global:${id}")
		if(NOT prop)
			set(${ref} "ref:global:type:${id}" PARENT_SCOPE)
			return()
		endif()
	endwhile()
endfunction()