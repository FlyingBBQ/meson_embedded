#!/bin/bash

srcdir=.
buildir=build/debug

if [ -d "$buildir" ]; then
    echo "removing directory: $buildir"
    rm -r $buildir
fi

meson $srcdir $buildir --cross-file config/cross_linux.txt --buildtype=debugoptimized && cd $buildir
