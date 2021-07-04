local ls = require "luasnip"
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d
math.randomseed(os.time())
local function uuid()
  local random = math.random
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  local out
  local function subs(c)
    local v = (((c == "x") and random(0, 15)) or random(8, 11))
    return string.format("%x", v)
  end
  out = template:gsub("[xy]", subs)
  return out
end
local function copy(args, a1, a2)
  return args[1]
end
local LOREM_IPSUM =
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
local function sf(trig, body, regTrig)
  return s({ regTrig = regTrig, trig = trig, wordTrig = true }, { f(body, {}), i(0) })
end
local function replace_each(replacer)
  local function wrapper(args)
    local len = #(args[1])[1]
    return { replacer:rep(len) }
  end
  return wrapper
end
local function emmet(arg1)
  local content = (arg1)[1][1]
  return sn(nil, { t { "asdf", content, "asdf" } })
end
local function _1_()
  return { os.date "%Y-%m-%d" }
end
local function _2_()
  return { uuid() }
end
local function _3_(args)
  local amount = tonumber(args[1].captures[1])
  if amount == nil then
    return { LOREM_IPSUM }
  else
    return { LOREM_IPSUM:sub(1, (amount + 1)) }
  end
end
ls.snippets = {
  all = {
    sf("date", _1_),
    sf("uuid", _2_),
    sf("lorem(%d*)", _3_, true),
    s({ trig = "bbox", wordTrig = true }, {
      t { "╔" },
      f(replace_each "═", { 1 }),
      t { "╗", "║" },
      i(1, { "content" }),
      t { "║", "╚" },
      f(replace_each "═", { 1 }),
      t { "╝" },
      i(0),
    }),
    s({ trig = "sbox", wordTrig = true }, {
      t { "*" },
      f(replace_each "-", { 1 }),
      t { "*", "|" },
      i(1, { "content" }),
      t { "|", "*" },
      f(replace_each "-", { 1 }),
      t { "*" },
      i(0),
    }),
  },
  direnv = {
    s({ trig = "lay", wordTrig = true }, { t { "layout " }, i(1, { "python" }), i(0) }),
  },
}
require("luasnip/loaders/from_vscode").lazy_load()
