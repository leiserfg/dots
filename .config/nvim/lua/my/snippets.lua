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
 )
 }
}



-- LOAD ALL THE SNIPPETS
local Path = require'plenary.path'.Path

local function json_decode(data)
  local status, result = pcall(vim.fn.json_decode, data)
  if status then
    return result
  else
    return nil, result
  end
end


local function load_sniped_file(lang, snippet_set_path)
    if not snippet_set_path.exist() then return end
    local lang_snips = ls.snippets[lang] or {}

    local snippet_set_data = json_decode(snippet_set_path.read())
    for name, parts in ipair(snippet_set_data) do 
        -- TODO parse snippet only works with sitrings
        -- parts.body is a list, this will fail
        lang_snips.insert(ls.parser.parse_snippet({trig=parts.prefix, name=name, wordTrig=true}, parts.body))
    end
    ls.snippets[lang] = lang_snips
end
local function load_snippet_folder(root)
    local package = root / 'package.json'
    if not package.exist() then return end
    local package_data = json_decode(package.read())
    if not (package_data and package.contribute and package_data.contribute.snippets)  then return end

    for _, snippet_entry in ipairs(package_data.contribute.snippets) do
        load_snippet_file(snippet_entry.language, root/snippet_entry.path)
    end
end

--[[ for path in vim.o.runtimepath:gmatch('([^,]+)') do
    load_snippet_folder(Path(path))
end ]]

