local function ensure(pkg)
    local pkg_name = pkg:match'[^/]*$'
    local base = vim.fn.stdpath('data')..'/site/pack/packer/start/'
    local pkg_path = base .. pkg_name
    if vim.fn.empty(vim.fn.glob(pkg_path)) > 0 then
        vim.pretty_print(("Installing %s to %s"):format(pkg, pkg_path))
        vim.fn.system({'git', 'clone', "--depth", "1", 'https://github.com/' .. pkg, pkg_path})
        vim.cmd('packadd ' .. pkg_name)
    end
end

ensure("wbthomason/packer.nvim")
ensure("rktjmp/hotpot.nvim")

require "hotpot"
require "my.init"


