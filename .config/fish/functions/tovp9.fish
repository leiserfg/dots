# Defined in /tmp/fish.FI3j7k/tovp9.fish @ line 2
function tovp9 --argument source out
	ffmpeg -y -i $source -c:v libvpx-vp9 -pass 1 -b:v 0 -crf 30 -threads 8 -row-mt 1 -an -f webm /dev/null
    ffmpeg -y -i $source -pass 2 -c:a libopus  -c:v libvpx-vp9   -b:v 0 -crf 30 -threads 8 -row-mt 1    {$out}.webm
end
