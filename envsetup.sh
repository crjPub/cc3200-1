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

