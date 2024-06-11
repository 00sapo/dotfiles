#!/bin/sh
injson="$(cat)"
if [ -n "$injson" ]; then
	# something has been added/changed
	task sync
fi
