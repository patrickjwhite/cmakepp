function(http_put_test)




  fwrite("myfile.txt" "hello world")
  compress("test.tgz" "myfile.txt")
  http_put("http://httpbin.org/put" --file test.tgz --json)
  ans(res)
  map_tryget(${res} data)
  ans(data)
  fwrite("result.tgz" "${data}")
  ## - does not work because of encoding



  http_put("http://httpbin.org/put" --file myfile.txt --json)
  ans(res)
  assertf("{res.data}" STREQUAL "hello world")



  http_put("http://httpbin.org/put" "{id:'hello world'}" --json)
  ans(res)
  assertf("{res.json.id}" STREQUAL "hello world")

  http_put("http://httpbin.org/put" "{id:'hello world'}" --return-code --show-progress)
  ans(error)
  assert(NOT error)

  http_put("http://httpbin.org/put" "{id:'hello world'}" --return-code)
  ans(error)
  assert("${error}" EQUAL "0")

  http_put("http://httpbin.org/put" "{id:'hello world'}")
  ans(res)
  assert("${res}" MATCHES "hello world")



endfunction()