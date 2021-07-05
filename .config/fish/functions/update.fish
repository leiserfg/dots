# Defined in /tmp/fish.B12A3G/update.fish @ line 2
function update
    yay
    nvim "+lua require 'my.pkgs'"  "+au User PackerComplete qall" +PackerSync
    pipx upgrade-all --include-injected > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
