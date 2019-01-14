function togif
	set -l palette "/tmp/palette.png"

set -l filters "fps=15,scale=-1:-1:flags=lanczos"

ffmpeg -v warning -i $argv[1] -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $argv[1] -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $argv[2]
end
