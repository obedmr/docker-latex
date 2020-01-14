#!/bin/bash
#
# @name        : tex_compile.sh
# @description : LaTeX -> PDF Compiler Script
# @author      : Obed N Munoz
# @email       : obed.n.munoz@gmail.com
# 
# @usage       : ./tex_compile.sh <TeX_file>


# Get Main TeX File
command=$1

if [ $command = "list-utils" ]; then
    cd /usr/bin
    ls *tex*
else
    shift
    args=$*
    # LaTeX to PDF compilation
    cd /mnt
    $command -interaction=nonstopmode -output-directory=/mnt/aux $args || true
fi
