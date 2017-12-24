#!/bin/bash

check() {
. ./bin/checks
}

config() {
. ./bin/configs
}

install() {
	. bin/layers
	for layer in $Layers; do
		. ./layers/$layer/install.sh
	done
}

check
config
install
