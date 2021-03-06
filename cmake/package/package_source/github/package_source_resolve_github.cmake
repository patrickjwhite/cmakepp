    function(github_get_file user repo ref path)
        set(raw_uri "https://raw.githubusercontent.com/")
        set(path_uri "${raw_uri}/${user}/${repo}/${ref}/${path}" )
        http_get("${path_uri}" ${ARGN})
        return_ans()
    endfunction()

  ## package_source_resolve_github() -> <package handle> {}
  ##
  ## resolves the specifie package uri 
  ## and if uniquely identifies a package 
  ## returns its pacakge descriptor
  function(package_source_resolve_github uri)  
    uri("${uri}")
    ans(uri)

    package_source_query_github("${uri}" --package-handle)
    ans(package_handle)

    list(LENGTH package_handle count)
    if(NOT "${count}" EQUAL 1)
        error("could not result {uri.uri} to a unique package")
        return()
    endif() 

    assign(package_uri = package_handle.uri)
    uri("${package_uri}")
    ans(package_uri)
    assign(hash = package_uri.params.hash)
    if(NOT hash)
        error("package uri is not unique. requires a hash param: {uri.uri}")
        return()
    endif()

    assign(user = package_uri.normalized_segments[0])
    assign(repo = package_uri.normalized_segments[1])
    assign(ref_type = package_uri.normalized_segments[2])
    assign(ref_name = package_uri.normalized_segments[3])


    ## get the repository descriptor
    github_api("repos/${user}/${repo}" --json)
    ans(repo_descriptor)
    if(NOT repo_descriptor)
        error("could not resolve repository descriptor")
        return()
    endif()



    ## try to get the package descriptor remotely
    github_get_file("${user}" "${repo}" "${hash}" "package.cmake" --silent-fail)
    ans(content)
    json_deserialize("${content}")
    ans(package_descriptor)


    ## map default values on the packge descriptor 
    ## using the information from repo_descriptor
    assign(default_description = repo_descriptor.description)

    map_defaults("${package_descriptor}" "{
      id:$repo,
      version:'0.0.0',
      description:$default_description
    }")
    ans(package_descriptor)
    
    ## response
    map_set(${package_handle} package_descriptor "${package_descriptor}")
    map_set(${package_handle} github_descriptor "${repo_descriptor}")

    return_ref(package_handle)
  endfunction()