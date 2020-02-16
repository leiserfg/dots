# Defined in /tmp/fish.a06wY7/update_blender.fish @ line 2
function update_blender
	set base https://builder.blender.org
    set download (curl -s $base/download/ |pup '.linux:last-child > a attr{href}')
    pushd ~/installed/
    set latest (basename -s .tar.xz $download)
    echo Latest is $latest
    if test -d $latest
        echo $latest "exists"
    else
        curl -s $base$download|tar -xJf -
        ln -sf $PWD/$latest/blender ~/.local/bin/
        echo "Downloading" $download
    end
    
    #Clean all but 2 latest
    set all (ls -t|grep "blender-....-")
    echo "Removing" $all[3..-1]
    rm -rf $all[3..-1]
    cd  $HOME"/.config/blender/"(string match --regex '\d.\d\d' $latest)"/scripts/addons"
    for addon in (ls)
        cd $addon
        echo "Updating " $addon
        git reset --hard HEAD
        git pull
        cd ..
    end
    popd
end
