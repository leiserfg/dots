# Defined in /tmp/fish.tiUT8w/update.fish @ line 2
function update
	yay
    vim  "+au User PackerComplete qall" +PackerSync
    pipx upgrade-all --include-injected > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
