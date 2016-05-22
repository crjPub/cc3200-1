# This is included by the top-level Makefile.
# It sets up standard variables based on the
# current configuration and platform, which
# are not specific to what is being built.

# Only use BUILD_SHELL to wrap around bash.
# DO NOT use other shells such as zsh.
ifdef BUILD_SHELL
SHELL := $(BUILD_SHELL)
else
# Use bash, not whatever shell somebody has installed as /bin/sh
# This is repeated from main.mk, since envsetup.sh runs this file
# directly.
SHELL := /bin/bash
endif

# Utility variables.
empty :=
space := $(empty) $(empty)
comma := ,
# Note that make will eat the newline just before endef.
define newline


endef
# The pound character "#"
define pound
#
endef
# Unfortunately you can't simply define backslash as \ or \\.
backslash := \a
backslash := $(patsubst %a,%,$(backslash))

