#!/bin/bash

#******************************************************************************
#
# Setup variables which are used in build
# Source this script before make
# $ source envsetup.sh
#
#*****************************************************************************

echo Set environment for CC3200 build...

OS=$(uname -s)
export OS

ROOT_PATH=$(pwd)
export ROOT_PATH

SDK_PATH=$(pwd)/SDK/CC3200
export SDK_PATH

OUT_DIR=out
export OUT_DIR
OBJ_DIR=obj
export OBJ_DIR
BIN_DIR=exe
export BIN_DIR

TOP=.

function gettop
{
    local TOPFILE=envsetup.sh
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ] ; then
        # The following circumlocution ensures we remove symlinks from TOP.
        (cd $TOP; PWD= /bin/pwd)
    else
        if [ -f $TOPFILE ] ; then
            # The following circumlocution (repeated below as well) ensures
            # that we record the true directory name and not one that is
            # faked up with symlink names.
            PWD= /bin/pwd
        else
            local HERE=$PWD
            T=
            while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
                \cd ..
                T=`PWD= /bin/pwd -P`
            done
            \cd $HERE
            if [ -f "$T/$TOPFILE" ]; then
                echo $T
            fi
        fi
    fi
}

function findmakefile()
{
    TOPFILE=envsetup.sh
    local HERE=$PWD
    T=
    while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
        T=`PWD= /bin/pwd`
        if [ -f "$T/Makefile" ]; then
            echo $T/Makefile
            \cd $HERE
            return
        fi
        \cd ..
    done
    \cd $HERE
}

function mmm()
{
    local T=$(gettop)

    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree. Try setting TOP."
        return 1
    fi

    local DIR=$1
    local ARGS=$2
    local START=`PWD= /bin/pwd`
    local MAKEFILE=Makefile

    if [ "$DIR" ]; then
        DIR=`echo $DIR | sed -e 's/:.*//' -e 's:/$::'`
        MAKEFILE=$DIR/Makefile
    fi

    if [ ! -f $MAKEFILE ]; then
        if [ -d $DIR ]; then
            echo "No Makefile in $DIR."
        else
            echo "Couldn't locate the directory $DIR"
        fi
        return 1
    fi


    if [ "$DIR" ]; then
        cd $DIR
    fi

    make $ARGS

    cd $START
}


