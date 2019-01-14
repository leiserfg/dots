function fish_title
	echo " ⌁ "(uname -n)" ⌁ "(whoami)" @ "(basename $PWD)(test -n "$HOSTNAME"; and echo " ⌁ $HOSTNAME"; or echo "")
end
