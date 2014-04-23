# parses a structured list given the structure map
# returning a map which contains all the parsed values
function(structured_list_parse structure_map)
  map_new()
  ans(result)
  set(args ${ARGN})
  map_keys(${structure_map} keys)
  set(cutoffs)

  set(descriptors)
  foreach(key ${keys})
    map_tryget(${structure_map} current "${key}")
    if(current)
      value_descriptor_parse(${key} ${current})
      ans(current_descriptor)

      list(APPEND descriptors ${current_descriptor})
      map_tryget(${current_descriptor} labels "labels")
      list(APPEND cutoffs ${labels})        
    endif()
  endforeach()

  set(errors)
  foreach(current_descriptor ${descriptors})
    map_import(${current_descriptor})
    list(REMOVE_ITEM cutoffs ${labels})

    list_find_first(args ${cutoffs})
    ans(first_cutoff)
    list_slice(args 0 ${first_cutoff})
    ans(args_to_search)
    list_slice(args ${first_cutoff} -1)
    ans(args)
    map_import(${current_descriptor})
    list_parse_descriptor(${current_descriptor} ERROR error UNUSED_ARGS unused ${args_to_search} )
    ans(current_result)
    set(args ${unused} ${args} )
    if(error)
      list(APPEND errors ${id})
    endif()
    map_navigate_set("result.${id}" ${current_result})
  endforeach()

  return(${result})
endfunction()