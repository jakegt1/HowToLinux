#!/bin/bash

RESULT=0

for var in "$@"
do
    RESULT=$(($RESULT + $var))
done

echo -n "$RESULT"