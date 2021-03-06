function(test)

  project_new()
  ans(project)


  call(project.load("pr1"))


  ### save in default location

  ## act
  assign(success = project.save())

  assert(success)
  assert(EXISTS "${test_dir}/pr1/.cps/config.qm")
  assert(EXISTS "${test_dir}/pr1/.cps/package_descriptor.qm")
  fread_data("pr1/.cps/config.qm")
  ans(res)

  assertf({res.config_dir} STREQUAL ".cps")
  assertf({res.dependency_dir} STREQUAL "packages")
  assertf({res.content_dir} STREQUAL ".")
  assertf({res.config_file} STREQUAL ".cps/config.qm")
  assertf({res.package_descriptor_file} STREQUAL ".cps/package_descriptor.qm")


  ### save in custom location

  ## act
  assign(success = project.save("myfile.qm"))

  assert(success)
  assert(EXISTS "${test_dir}/myfile.qm")





endfunction()