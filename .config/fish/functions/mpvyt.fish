# Defined in /tmp/fish.vOHBJs/mpvyt.fish @ line 2
function mpvyt --wraps='mpv --ytdl-format=bestaudio ytdl://ytsearch:' --description 'alias mpvyt mpv --ytdl-format=bestaudio ytdl://ytsearch:'
  mpv   --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$argv";
end
