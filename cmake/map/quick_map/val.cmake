function(val)
  # appends the values to the current_map[current_key]
  stack_peek(ref:quick_map_map_stack)
  ans(current_map)
  stack_peek(ref:quick_map_key_stack)
  ans(current_key)
  map_append("${current_map}" "${current_key}" "${ARGN}")
endfunction()