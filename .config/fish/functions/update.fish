# Defined in /tmp/fish.JOIMqk/update.fish @ line 2
function update
	yay
    vim +PackerCompile +PackerSync  +qall > /dev/null
    pipx upgrade-all --include-deps > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
