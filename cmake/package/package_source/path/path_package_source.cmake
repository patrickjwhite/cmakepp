
  function(path_package_source)
    obj("{
      source_name:'file',
      pull:'package_source_pull_path',
      query:'package_source_query_path',
      resolve:'package_source_resolve_path'
    }")
    return_ans()
  endfunction()
