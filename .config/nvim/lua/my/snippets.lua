local ls = require'luasnip'
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
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    local out = template:gsub('[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return out
end

local function copy(args, a1, a2)
	return args[1]
end

local LOREM_IPSUM = "Lorem ipsum dolor sit amet, "..
"consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. "..
"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. "..
"Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "..
"Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. "

local function sf(trig, body, regTrig)
    return s({trig = trig, wordTrig=true, regTrig=regTrig},
        {f(body, {}), i(0)}
     )
end

local function replace_each(replacer)
    return function(args)
        local len = #args[1][1]
        return {replacer:rep(len)}
    end
end

ls.snippets = {
 all = {
    sf("date", function() return {os.date("%Y-%m-%d")} end),
    sf("uuid", function() return {uuid()} end),
    sf('lorem(%d*)', function(args) 
        local amount = tonumber(args[1].captures[1])
        if amount == nil then 
            return {LOREM_IPSUM} 
        else
           return {LOREM_IPSUM:sub(1, amount+1)}
        end
    end, true),
s({trig = "bbox", wordTrig=true},
    {
        t{"╔"}, f(replace_each("═"), {1}), t{"╗", "║"},
        i(1, {"content"}),  t{"║", "╚"},
        f(replace_each("═"), {1}),
        t{"╝"},
        i(0)}
 ),

s({trig = "sbox", wordTrig=true},
    {
        t{"*"}, f(replace_each("-"), {1}), t{"*", "|"},
        i(1, {"content"}),  t{"|", "*"},
        f(replace_each("-"), {1}),
        t{"*"},
        i(0)}
 ),
 ls.parser.parse_snippet({trig="if", wordTrig=true}, "if ${1:expression}:\n\t${2:pass}"),
 },
}
require('luasnip/loaders/from_vscode').load()

