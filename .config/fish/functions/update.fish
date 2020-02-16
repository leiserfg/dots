# Defined in /tmp/fish.egDrmS/update.fish @ line 2
function update
	yay
    vim +PlugUpdate  +qall > /dev/null
    pipx upgrade-all --include-deps > /dev/null  2>/dev/null
    rustup update > /dev/null 
end
