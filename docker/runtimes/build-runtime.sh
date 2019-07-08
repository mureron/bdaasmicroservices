#!/bin/bash
# Downloading dependencies
echo $PWD
$PWD/packages/./DownloadFiles.sh

runtimes=(java  java-optimization-1 java-optimization-2 python spark jupyter)
for directory in "${runtimes[@]}"; do
    (
        cd $directory
        echo $PWD
        ./compileImage.sh
        cd ..
    )
    errorCode=$?
    if [ $errorCode -ne 0 ]; then
	    echo "[INFO] Error creating Image"
	    exit 1
    fi
done