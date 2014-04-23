
function(map_clone_shallow original)
  map_isvalid("${original}" ismap)
  if(ismap)
    map_new()
    ans(result)
    map_keys("${original}" keys)
    foreach(key ${keys})
      map_get("${original}" value ${key})
      map_set("${result}" ${key} ${value})
    endforeach()
    return(${result})
  endif()

  ref_isvalid("${original}")
  ans(isref)
  if(isref)
    ref_get(${original})
    ans(res)
    ref_gettype(${original})
    ans(type)
    ref_new(${type})
    ans(result)
    ref_set(${result} ${res})
    return(${result})
  endif()

  # everythign else is a value type and can be returned
  return_ref(original)

endfunction()