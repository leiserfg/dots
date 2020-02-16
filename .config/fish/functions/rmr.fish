# Defined in /tmp/fish.fsq2hh/rmr.fish @ line 2
function rmr --description 'Fast recursive delete'
	rsync --delete  -r (mktemp -d)/  $argv
        rmdir $argv #😁just for deleting the folder 
end
