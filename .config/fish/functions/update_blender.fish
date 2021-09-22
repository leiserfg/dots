function update_blender
    set base https://builder.blender.org
    set download (curl -s $base/download/daily/ |pup '.linux:last-child > a attr{href}' |sed s/.sha256//)
    # set download (curl -s $base/download/experimental/ |pup '.linux > a[href*=cycles] attr{href}' |sed -e "s/.sha256//" -e "1d")
    pushd ~/installed/
    set latest (basename -s .tar.xz $download)
    echo Latest is $latest
    if test -d $latest
        echo $latest "exists"
    else
        curl -s $download|tar -xJf -
        ln -sf $PWD/$latest/blender ~/.local/bin/
        echo "Downloading" $download
    end

    #Clean all but 2 latest
    set all (ls -t|grep "blender-.*-")
    echo "Removing" $all[3..-1]
    rm -rf $all[3..-1]

    string match --regex "blender-(?<blender_version>\d.\d\d?).*" $latest
    cd  $HOME"/.config/blender/"$blender_version"/scripts/addons"
    for addon in (ls)
        cd $addon
        echo "Updating " $addon
        git reset --hard HEAD
        git pull
        git submodule update --init --recursive
        cd ..
    end
    popd
end
