## returns true if there exists an element
## for which the predicate holds
function(list_any __list_any_lst __list_any_predicate)
  function_import("${__list_any_predicate}" as __list_any_predicate REDEFINE)
  foreach(item ${${__list_any_lst}})
    __list_any_predicate("${item}")
    ans(__list_any_predicate_holds)
    if(__list_any_predicate_holds)
      return(true)
    endif()
  endforeach()
  return(false)
endfunction()


