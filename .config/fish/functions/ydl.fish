# Defined in /tmp/fish.ck7dtW/ydl.fish @ line 2
function ydl
	youtube-dl -f "bestvideo[height<=480][ext=webm]+bestaudio/[height <=? 480]" --write-sub --write-auto-sub --sub-lang en,es    $argv;
end
