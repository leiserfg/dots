function rmr
	rsync --delete --progress -r (mktemp -d)/  $argv
end
