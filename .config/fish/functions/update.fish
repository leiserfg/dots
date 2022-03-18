function update
    yay
    # yay -S aur/neovim-git
    nvim "+lua require 'my.pkgs'"  "+au User PackerComplete qall" +PackerSync
    pipx upgrade-all --include-injected > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
