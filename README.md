coro-http-luv
=============

[![Build Status](https://travis-ci.org/squeek502/coro-http-luv.svg?branch=master)](https://travis-ci.org/squeek502/coro-http-luv)

`coro-http` from [Lit](https://github.com/luvit/lit) converted to work with plain Lua + [Luv](https://github.com/luvit/luv).

## Requirements

- Lua (>= 5.1 or LuaJIT)
- [Luv](https://github.com/luvit/luv)
- (optional) for HTTPS:
  + [lua-openssl](https://github.com/zhaozg/lua-openssl)
  + (for PUC Lua 5.1 only) [LuaBitOp](https://luarocks.org/modules/luarocks/luabitop)

## Installation

Via [Luarocks](http://luarocks.org/modules/squeek502/coro-http-luv):
```
luarocks install coro-http-luv
```

## Changes from the Lit version

- Everything is now in a `coro-http-luv` module, e.g. `http-codec` is now `require`'d as `coro-http-luv.http-codec`
- `root_ca.dat` in `secure-socket` replaced with `root_ca.lua`, which uses a base64 encoded string for the binary data and returns a decoded version of it
- Bitwise operations in `secure-socket` will use whatever is available (Lua 5.3 operators, 'bit32', or 'bit')
- `require('uv')` replaced with `require('luv')`

## Usage

```lua
local luv = require 'luv'
local http = require 'coro-http-luv'
local unpack = table.unpack or unpack

coroutine.wrap(function()
  local res, data = http.request('GET', 'http://localhost/')

  -- status code
  print(res.code)

  -- print headers
  for i = 1, #res do
    local key, value = unpack(res[i])
    print(key, value)
  end

  -- print response body
  print(data)
end)()

-- start the luv event loop
luv.run()
```
