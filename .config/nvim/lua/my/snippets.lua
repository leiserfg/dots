local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d


local function copy(args, a1, a2)
	return args[1]
end

ls.snippets = {
	all = {
    s({trig = "date", wordTrig = true},
        {f(function() os.date() end, {})}
     ),

    s({trig = "date1", wordTrig = true},
        {f(function() t{os.date()} end, {})}
     ),
 }
}
