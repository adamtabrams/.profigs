#!/bin/sh

fd -d1 -0 -H --no-ignore-vcs . "$1" | xargs -0 -n1 basename
