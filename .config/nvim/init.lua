--[[ require("jit.p").start("10,i1,s,m0,G", "/tmp/output.log")
vim.cmd [[
	au VimLeave * lua require'jit.p'.stop()
]]

require "my.options"
require "my.mapping"

vim.cmd [[ au VimEnter * ++once lua require "my.pkgs"]]
