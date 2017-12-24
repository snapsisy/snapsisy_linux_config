#!/bin/bash
for to_be_setup in `find ./ -name "setup*.sh"`; do
	. $to_be_setup
done
. ./list.sh
