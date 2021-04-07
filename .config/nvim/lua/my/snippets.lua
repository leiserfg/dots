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

local function sf(trig, body, regexTrig) 
   local wordTrig = true
    if regexTrig then
        wordTrig = false
    else
        wordTrig = true
        regexTrig = false
    end

    return s({trig = trig, wordTrig = true},
        {f(body, {}), i(0)}
     )
end

ls.snippets = {
	all = {
    sf("date", function() return {os.date("%Y-%m-%d")} end),
    sf("uuid", function() return {uuid()} end),
 }
}
