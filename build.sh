#!/bin/bash

buildir=build

if [ -d "$buildir" ]; then
    echo "removing directory: $buildir"
    rm -r $buildir
fi

meson $buildir --cross-file config/cross_linux.txt --buildtype debug
