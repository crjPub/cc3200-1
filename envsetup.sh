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
    if [ "$T" ]; then
        local MAKEFILE=
        local ARGS=
        local DIR TO_CHOP
        local GET_INSTALL_PATH=
        local DASH_ARGS=$(echo "$@" | awk -v RS=" " -v ORS=" " '/^-.*$/')
        local DIRS=$(echo "$@" | awk -v RS=" " -v ORS=" " '/^[^-].*$/')
        for DIR in $DIRS ; do
            DIR=`echo $DIR | sed -e 's/:.*//' -e 's:/$::'`
            if [ -f $DIR/Android.mk ]; then
                local TO_CHOP=`(\cd -P -- $T && pwd -P) | wc -c | tr -d ' '`
                local TO_CHOP=`expr $TO_CHOP + 1`
                local START=`PWD= /bin/pwd`
                local MFILE=`echo $START | cut -c${TO_CHOP}-`
                if [ "$MFILE" = "" ] ; then
                    MFILE=$DIR/Makefile
                else
                    MFILE=$MFILE/$DIR/Makefile
                fi
                MAKEFILE="$MAKEFILE $MFILE"
            else
                case $DIR in
                    showcommands | *=*) ARGS="$ARGS $DIR";;
                    GET-INSTALL-PATH) GET_INSTALL_PATH=$DIR;;
                    *)  if [ -d $DIR ]; then
                            echo "No Makefile in $DIR.";
                        else
                            echo "Couldn't locate the directory $DIR";
                        fi
                    return 1;;
                esac
            fi
        done
        if [ -n "$GET_INSTALL_PATH" ]; then
            ARGS=$GET_INSTALL_PATH
        fi
        ONE_SHOT_MAKEFILE="$MAKEFILE" make -C $T -f build/core/main.mk $DASH_ARGS $ARGS
    else
        echo "Couldn't locate the top of the tree. Try setting TOP."
    return 1
fi
}


