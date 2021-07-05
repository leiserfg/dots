--[[ require("jit.p").start("10,i1,s,m0,G", "/tmp/output.log")
vim.cmd [[
	au VimLeave * lua require'jit.p'.stop()
]]

-- Entrypoint for my Neovim configuration!
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
require "my.options"
require "my.mapping"
-- require "my.pkgs"

vim.cmd [[ au VimEnter * ++once lua require "my.pkgs"]]
