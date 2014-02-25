function(obj_getownkeys this result)
  file(GLOB prop_refs "${this}/*")
  foreach(prop_ref ${prop_refs})
  	get_filename_component(key ${prop_ref} NAME_WE)
  	set(keys ${keys} ${key})
  endforeach()
  debug_message("${this} has following keys: ${keys}")

  return_value(${keys})
endfunction()