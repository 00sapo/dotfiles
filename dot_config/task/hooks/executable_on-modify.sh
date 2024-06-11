#!/bin/sh
task sync
# return the stdin to the stdout (i.e. don't change anything), but only the second line
# (i.e. the modified task)
tail -n 1 /dev/stdin
