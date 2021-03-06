## uncompresses the file specified into the current pwd()
function(uncompress file)
  mime_type("${file}")
  ans(types)

  if("${types}" MATCHES "application/x-gzip")
    directory_ensure_exists(".")  
    path_qualify(file)
    tar(xzf "${file}" ${ARGN})
    return_ans()
  else()
    message(FATAL_ERROR "unsupported compression: '${types}'")
  endif()
endfunction()





