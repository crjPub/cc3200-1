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

function mmm()
{
    local T=$(gettop)

    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree. Try setting TOP."
        return 1
    fi

    if [ $# -gt 2 ]; then
        echo "Too many parameters!"
        mmm_usage
        return 1
    fi

    local START=`PWD= /bin/pwd`
    local MAKEFILE=Makefile

    # The following awk shell script has porting issue between zsh & bash
    # Use a more simiple way with less flexibility to do that
    # Start
    #local DIR=$(echo "$@" | awk -v RS=" " -v ORS=" " '/^[^-].*$/')
    #local OPT=$(echo "$@" | awk -v RS=" " -v ORS=" " '/^-.*$/' | cut -c2-)
    local DIR=$1
    local OPT=$2
    # End

    if [ "x$DIR" = "x." ]; then
        DIR=
    fi

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
        echo Entering $DIR
        cd $DIR
    fi

    make $OPT

    if [ "$DIR" ]; then
        cd $START
        echo Leaving $DIR
    fi
}

function mmm_usage()
{
    echo "Usage:"
    echo "  mmm [path] [option]"
    echo "  - path   - relative path to Makefile (for an App) to be built with"
    echo "  - option - target to make, eg clean, debug, release, etc"
    echo "Example:"
    echo "  mmm Apps/hello clean (* at top folder)"
    echo "  mmm Apps/hello       (* at top folder)"
    echo "  mmm . clean          (* at Apps/hello)"
    echo "  mmm                  (* at Apps/hello)"
}

function mm()
{
    local T=$(gettop)

    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree. Try setting TOP."
        return 1
    fi

    if [ $# -gt 2 ]; then
        echo "Too many parameters!"
        mm_usage
        return 1
    fi

    local START=`PWD= /bin/pwd`
    local MAKEFILE=Makefile

    local MOD=$1
    local OPT=$2

    mm_usage
}

function mm_usage()
{
    echo "Usage:"
    echo "  mm [module] [option]"
    echo "  - module - A collection of Apps, SDK, OS, libs, etc"
    echo "  - option - build command or option, eg clean, debug, release, etc"
    echo "Example:"
    echo "  mm apps clean"
    echo "  mm sdk release"
    echo "  mm libs"
    echo "  mm"
}


