function ftpdw
	set -l port 2121
    if test $argv[1]
        set port $argv[1]
    end
    ip a | grep 'wlp6s0' | sed -e "s/\/.*/:$port/" -e 's- *inet -ftp://-' | read -l server
    echo "serving on $server"
    echo $server | xclip -sel clip
    python -m pyftpdlib --port $port -w
end
