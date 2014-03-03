macro(peek_back ref result)
   get_property(lst GLOBAL PROPERTY ${ref})
   if(NOT lst)
   	set(result NOTFOUND)
   endif()


   list(LENGTH lst len)
   if(${len} LESS 1)
   	set(result NOTFOUND)
   else()
   math(EXPR len "${len} - 1")
   list(GET lst ${len} ${result})
   #debug_message("peeking front ${result}")
   endif()
endmacro()