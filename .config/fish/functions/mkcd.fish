# Defined in /tmp/fish.zbOgFy/mkcd.fish @ line 2
function mkcd --description 'alias mkcd=mkdir'
	mkdir -p $argv[1]
        cd $argv[1]
end
