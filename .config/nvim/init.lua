local basepath = vim.fn.stdpath "data" .. "/lazy/"

-- Blazingly fast
collectgarbage "stop"
jit.off()

-- collectgarbage("isrunning")
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    jit.on()
    collectgarbage "restart"
  end,
  once = true,
})

local function ensure(pkg)
  local pkg_name = pkg:match "[^/]*$"
  local pkg_path = basepath .. pkg_name
  if vim.fn.empty(vim.fn.glob(pkg_path)) > 0 then
    vim.pretty_print(("Installing %s to %s"):format(pkg, pkg_path))
    vim.fn.system { "git", "clone", "https://github.com/" .. pkg, pkg_path }
    -- vim.cmd('packadd ' .. pkg_name)
  end
  vim.opt.rtp:prepend(pkg_path)
end

-- ensure("wbthomason/packer.nvim")
-- ensure("rktjmp/hotpot.nvim")

-- require "hotpot"
ensure "folke/lazy.nvim"
require "my.init"
