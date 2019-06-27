# Defined in /tmp/fish.dSDmFc/rmr.fish @ line 2
function rmr --description 'Fast recursive delete'
	rsync --delete --progress -r (mktemp -d)/  $argv
        rmdir $argv #😁just for deleting the folder 
end
