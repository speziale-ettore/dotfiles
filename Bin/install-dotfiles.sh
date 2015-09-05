#!/bin/bash
######################################################################
# This script creates symlinks from the home directory to all dotfiles
# in ~/Dotfiles
######################################################################

dir=$HOME/Dotfiles                    # dotfiles directory
olddir=$HOME/Tmp/DotfilesOld          # old dotfiles backup directory

# create DotfilesOld in Tmp
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the Dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to DotfilesOld directory, then create
# symlinks from the homedir to any files in the ~/Dotfiles directory specified
# in $files
srcs=`find -L $dir \( -type d -path $dir/.git -o -name '*.swp' \) \
                    -prune -o -type f -print`
for src in $srcs; do
    dst=`echo -n $src | sed s\|^$HOME/Dotfiles\|$HOME\|`
    bck=`echo -n $src | sed s\|^$HOME/Dotfiles\|$olddir\|`

    if [ -f $dst ]; then
         echo "Moving $dst from ~ to $olddir"
         mkdir -p `dirname $bck`
         mv $dst $bck
    fi

    echo "Creating symlink to $src in home directory."
    mkdir -p `dirname $dst`
    ln -s $src $dst
done
