-- Lua-version-agnostic bit module (only includes the functions secure-socket cares about)
local bit = (function()
  if _VERSION >= "Lua 5.3" then
    return assert(load([[return {
      band = function(a, b) return a & b end,
      rshift = function(a, b) return a >> b end,
      lshift = function(a, b) return a << b end,
      bor = function(a, b) return a | b end,
    }]]))()
  end

  local hasBit32, bit32 = pcall(require, "bit32")
  if hasBit32 then return bit32 end

  local hasBit, bitop = pcall(require, "bit")
  if hasBit then return bitop end
end)()

if not bit then
  error("no bit library available (looked for Lua 5.3 operators, 'bit32', 'bit')")
end

return bit
