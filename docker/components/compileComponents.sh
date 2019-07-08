#!/bin/bash
for directory in */ ; do
    cd $directory
    echo "[INFO] Compiling component $directory"
    ./startImage.sh
    cd ..
done