#!/bin/bash

srcdir=.
buildir=build

if [ -d "$buildir" ]; then
    echo "removing directory: $buildir"
    rm -r $buildir
fi

meson $srcdir $buildir --cross-file config/cross_linux.txt
