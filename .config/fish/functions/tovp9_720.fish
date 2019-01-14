function tovp9_720 --argument source
	set -l out (echo $source | sed -E 's/\.[^.]+$/.webm/')
    ffmpeg -y -i $source -c:v libvpx-vp9 -pass 1 -vf 'scale=-1:min(720\,ih)' -b:v 0 -crf 40 -threads 8 -speed 4 -tile-columns 6 -frame-parallel 1 -an -f webm /dev/null
    ffmpeg -y -i $source -c:v libvpx-vp9 -pass 2 -vf 'scale=-1:min(720\,ih)' -b:v 0 -crf 40 -threads 8 -speed 2 -tile-columns 6 -frame-parallel 1 -f webm $out
end
