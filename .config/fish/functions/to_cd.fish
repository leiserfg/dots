function to_cd
	ffmpeg -i $argv[1] -pass 1 -f mpeg1video -b 750000 -s ntsc -an -passlogfile log_file $argv[1]".mpeg"

    ffmpeg -i $argv[1] -pass 2 -f mpeg1video -b 750000 -s ntsc -acodec mp2 -ab 128000 -passlogfile log_file $argv[1]".mpeg"
end
