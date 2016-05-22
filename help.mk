#
# Help
#

.PHONY: help
help:
	@echo
	@echo "Common make targets:"
	@echo "----------------------------------------------------------------------------------"
	@echo "droid                    Default target"
	@echo "clean                    Clean target and intermediate feils"
	@echo "docs                     Generate docs from source"
	@echo "libs                     All libraries"
	@echo "help                     You're reading it right now"

.PHONY: out
out:
	@echo "I'm sure you're nice and all, but no thanks."
