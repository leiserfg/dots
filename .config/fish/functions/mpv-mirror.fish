# Defined in - @ line 0
function mpv-mirror --description 'alias mpv-mirror mpv av://v4l2:/dev/video0 -vf lavfi=hflip'
	mpv av://v4l2:/dev/video0 -vf lavfi=hflip $argv;
end
