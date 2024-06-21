#!/bin/sh
twdensity
if test $? -ne 0; then
	echo "Failed to update density"
	exit 1
fi
echo "Density updated"
