function tovp9 --argument source out
	ffmpeg -y -i $source -c:v libvpx-vp9 -pass 1 -b:v 0 -crf 33 -threads 8 -speed 4 -tile-columns 6 -frame-parallel 1 -an -f webm /dev/null


    ffmpeg -y -i $source -c:v libvpx-vp9 -pass 2 -b:v 0 -crf 33 -threads 8 -speed 2 -tile-columns 6 -frame-parallel 1 {$out}.webm
end
