# Defined in /tmp/fish.PTHjqP/telegif.fish @ line 1
function telegif --argument input output

ffmpeg $input -framerate 25 -c:v libx264 -crf 23  -profile:v baseline -level 3.0 -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an $output.mp4
end
