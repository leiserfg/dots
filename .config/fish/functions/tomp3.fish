function tomp3
	ffmpeg -i $argv[1] -codec:a libmp3lame -qscale:a 2 $argv[2]
end
