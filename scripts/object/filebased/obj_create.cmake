function(obj_create result)
	random_file(ref "${cutil_temp_dir}/objects/object_{{id}}")
 	file(MAKE_DIRECTORY ${ref})
 	return_value(${ref})
endfunction()