local luv = require 'luv'
local http = require 'coro-http-luv'
local unpack = table.unpack or unpack

coroutine.wrap(function()
  local res, data = http.request('GET', 'http://github.com/')
  assert(res and (res.code == 301 or res.code == 200))
  assert(data)

  print(res.code)
  for i = 1, #res do
    local key, value = unpack(res[i])
    print(key, value)
  end
  print(#data)

  local connection = http.getConnection('github.com', 80, false)
  assert(connection)
  connection.socket:close()
end)()

luv.run()
