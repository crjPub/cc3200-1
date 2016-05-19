#******************************************************************************
#
# Makefile
#
#*****************************************************************************

#
# Current directory
#
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(CURDIR:%/=%))

#
# The base directory for SDK
#
SDK_ROOT=../../SDK/CC3200

#
# Include the common make definitions.
#
include ${SDK_ROOT}/tools/gcc_scripts/makedefs

#
# Where to find source files that do not live in this directory.
#
VPATH=.
VPATH+=../common

#
# Where to find header files that do not live in the source directory.
#
IPATH=.
IPATH+=../..
IPATH+=${SDK_ROOT}/inc
IPATH+=${SDK_ROOT}/driverlib
IPATH+=../common

#
# The default rule, which causes the driver library to be built.
#
all: ${OBJDIR} ${BINDIR}
all: ${BINDIR}/${CURRENT_DIR}.axf

#
# The rule to clean out all the build products.
#
clean:
	@rm -rf ${OBJDIR} ${wildcard *~}
	@rm -rf ${BINDIR} ${wildcard *~}


#
# The rule to create the target directories.
#
${OBJDIR}:
	@mkdir -p ${OBJDIR}

${BINDIR}:
	@mkdir -p ${BINDIR}

#
# Rules for building the target
#
${BINDIR}/${CURRENT_DIR}.axf: ${OBJDIR}/main.o
${BINDIR}/${CURRENT_DIR}.axf: ${OBJDIR}/pinmux.o
${BINDIR}/${CURRENT_DIR}.axf: ${OBJDIR}/gpio_if.o
${BINDIR}/${CURRENT_DIR}.axf: ${OBJDIR}/startup_${COMPILER}.o
${BINDIR}/${CURRENT_DIR}.axf: ${SDK_ROOT}/driverlib/${COMPILER}/${BINDIR}/libdriver.a

SCATTERgcc_${CURRENT_DIR} = linker.ld
ENTRY_${CURRENT_DIR} = ResetISR

#
# Include the automatically generated dependency files.
#
ifneq (${MAKECMDGOALS}, clean)
-include ${wildcard ${OBJDIR}/*.d} __dummy__
endif
