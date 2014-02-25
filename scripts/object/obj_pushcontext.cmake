
macro(obj_pushcontext ctx)
	peek_front("callstack" current_context)
	if(current_context)
		obj_savecontext(${current_context})
	endif()
	push_front("callstack" ${ctx})
	obj_loadcontext(${ctx})
	set(this ${ctx})
endmacro()