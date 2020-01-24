# Use bash to ensure compatibility in environments
SHELL := bash
# Uses one shell session for entire recipe
.ONESHELL:
# Set strict mode for bash to prevent accidental execution if tasks fail
.SHELLFLAGS := -eu -o pipefail -c
# If a recipe fails delete the target to remove clutter
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
# Uses '>' instead of 'TAB' for prefixes to avoid annoying whitespace issues
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

# ======= End preamble =========

.PHONY: all clean build dev test
BUNDLE_PREFIX=public/build
BUNDLES=bundle.js
ROOT_CONTENT=index.html

$(BUNDLE_PREFIX)/%: $(shell find src -type f)
> npm run build

all: build

build: node_modules public/build/bundle.js

dev: node_modules
> npm run dev

clean:
> rm -rf public/build node_modules

node_modules: package.json package-lock.json
> npm install
> touch node_modules
