-- Profiling
--require("jit.p").start("10,i1,s,m0,G", "/tmp/output.log")
--vim.cmd [[
--	au VimLeave * lua require'jit.p'.stop()
--]]


local function ensure(pkg)
    local pkg_name = pkg:match'[^/]*$'
    local pkg_path = vim.fn.stdpath('data')..'/site/pack/packer/start/' .. pkg_name
    if vim.fn.empty(vim.fn.glob(pkg_path)) > 0 then
        vim.print(("Installing %s to %s"):format(pkg, pkg_path))
        vim.fn.system({'git', 'clone', 'https://github.com/' .. pkg, pkg_path})
    end
end

ensure("wbthomason/packer.nvim")
ensure("rktjmp/hotpot.nvim")

require "hotpot"
require "my.init"

