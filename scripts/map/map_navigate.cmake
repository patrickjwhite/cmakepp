#navigates a map structure
# use . and [] operators to select next element in map
# e.g.  map_navigate(<map_ref> res "propa.propb[3].probc[3][4].propd")
function(map_navigate map result path)

	string(REGEX MATCHALL  "(\\[([0-9][0-9]*)\\])|(\\.[a-zA-Z0-9][a-zA-Z0-9]*)" parts ".${path}")

	set(current ${map})
	foreach(part ${parts})
		string(REGEX MATCH "[a-zA-Z0-9][a-zA-Z0-9]*" index "${part}")
		string(SUBSTRING "${part}" 0 1 index_type)
		if(index_type STREQUAL ".")
			map_get(${current} current "${index}")
		elseif(index_type STREQUAL "[")
			ref_get(lst ${current})
			list(GET lst ${index} keyOrValue)
			map_tryget(${current} current ${keyOrValue})
			if(NOT current)
				set(current ${keyOrValue})
			endif()
		endif()
		if(NOT current)
			return_value(NOTFOUND)
		endif()
	endforeach()
	return_value("${current}")
endfunction()