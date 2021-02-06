# Defined in /tmp/fish.rHhVY0/mediafire_links.fish @ line 2
function mediafire_links --argument shared
    for hash in (echo $shared|cut -f 5 -d /|tr , \n)
        curl -s https://www.mediafire.com/file/$hash/fake_filename/file|pup "a#downloadButton" attr{href} 2> /dev/null
    end
end
