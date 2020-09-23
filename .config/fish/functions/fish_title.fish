# Defined in /tmp/fish.YwCHQ1/fish_title.fish @ line 2
function fish_title
	echo (whoami)"@"(uname -n) (prompt_pwd)
end
