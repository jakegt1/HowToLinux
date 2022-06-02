#!/bin/bash

if [ "$#" -ne "2" ]; then
    exit 1
fi

RESULT="$1$2"

echo -n "$RESULT"