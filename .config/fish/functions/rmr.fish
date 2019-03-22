# Defined in /tmp/fish.WKmjEi/rmr.fish @ line 2
function rmr --description 'Fast recursive delete'
	rsync --delete --progress -r (mktemp -d)/  $argv
        rm -r $argv #😁just for deleting the folder 
end
