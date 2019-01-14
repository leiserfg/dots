function urldecode
    echo -e (echo $url | sed 's % \\\\x g')
end
