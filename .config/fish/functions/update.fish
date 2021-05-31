# Defined in /tmp/fish.McFaPv/update.fish @ line 2
function update
	yay
    vim +PackerSync "+au User PackerComplete qall"
    pipx upgrade-all --include-injected > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
