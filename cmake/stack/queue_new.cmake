
  function(queue_new)
    ref_new(queue)
    ans(queue)
    map_set_hidden(${queue} front 0)
    map_set_hidden(${queue} back 0)
    return(${queue})
  endfunction()