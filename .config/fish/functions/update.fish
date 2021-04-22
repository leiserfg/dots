# Defined in /tmp/fish.L6sTwK/update.fish @ line 2
function update
	yay
    vim +PackerCompile +PackerSync  +qall > /dev/null
    pipx upgrade-all --include-injected > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
