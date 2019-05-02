# Disable make builtin rules and variables
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

# Paths to helper scripts.
PYTHON := python
RJ2 := scripts/rj2.py
GEN_TARGETS := scripts/gen_targets.py

STAGING := staging
TEMPLATES := templates

# Compute full list of config files we can build from templates present in the templates dir.
CONFIG_FILES := $(shell $(PYTHON) $(GEN_TARGETS) --rule "$(STAGING)/%:	$(TEMPLATES)/%.j2" --root .)

# The default target builds the full list of config files.
all:	$(CONFIG_FILES)
.PHONY: all

# To build a config file, render the corresponding template file with respect to the env.yaml context.
$(STAGING)/%:	$(RJ2) env.yaml $(TEMPLATES)/%.j2
	$(PYTHON) $< --out $@ --ctx $(word 2,$^) $(word 3,$^)

clean:
	rm -rf $(STAGING)
.PHONY:	clean
