function clean_document
	convert $argv[1] -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$argv[2]"
end
