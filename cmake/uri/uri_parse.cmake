## parses an uri
## input can be any path or uri
## whitespaces in segments are allowed if string is delimited by double or single quotes(non standard behaviour)
##{
#  scheme,
#  net_root: # is // if the uri is a net uri
#  authority: # is the authority part if uri has a net_root
#  abs_root: # is / if the uri is a absolute path
#  segments: # an array of uri segments (folder)
#  file: # the last segment 
#  file_name: # the last segment without extension 
#  extension: # extension of file 
#  rest: # the ret of the input string which is not part of the uri
#  query: # the query part of the uri 
#  fragment # fragment part of uri
# }
##
##
##
function(uri_parse str)
  set(flags ${ARGN})

  list_extract_labelled_value(flags --into-existing)
  ans(res)

  list_extract_flag(flags --notnull)
  ans(notnull)
  if(notnull)
    set(notnull --notnull)
  else()
    set(notnull)
  endif()


  regex_uri()



  # set input data for uri
  if(NOT res)
    map_new()
    ans(res)
  endif()


  map_set(${res} input "${str}")


  ## normalize input of uri
  uri_normalize_input("${res}" ${flags})
  map_get("${res}" uri)
  ans(str)

  # scheme
  string_take_regex(str "${scheme_regex}:")
  ans(scheme)

  if(NOT "${scheme}_"  STREQUAL _)
    string_slice("${scheme}" 0 -2)
    ans(scheme)
  endif()

  # scheme specic part is rest of uri
  set(scheme_specific_part "${str}")


  # net_path
  string_take_regex(str "${net_root_regex}")
  ans(net_path)

  # authority
  set(authority)
  if(net_path)
    string_take_regex(str "${authority_regex}")
    ans(authority)
  endif()

  string_take_regex(str "${path_char_regex}+")
  ans(path)

  string_take_regex(str "${query_regex}")
  ans(query)
  if(query)
    string_slice("${query}" 1 -1)
    ans(query)
  endif()



  if(net_path)
    set(net_path "${authority}${path}")
  endif()

  string_take_regex(str "${fragment_regex}")
  ans(fragment)
  if(fragment)
    string_slice("${fragment}" 1 -1)
    ans(fragment)
  endif()


  map_capture(${res}
    
    scheme 
    scheme_specific_part
    net_path
    authority 
    path      
    query 
    fragment 

    ${notnull}
  )



  # extended parse
  uri_parse_scheme(${res})
  uri_parse_authority(${res})
  uri_parse_path(${res})
  uri_parse_file(${res})
  uri_parse_query(${res})      



  return_ref(res)

endfunction()