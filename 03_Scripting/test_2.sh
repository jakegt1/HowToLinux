#!/usr/bin/env bats

@test "Add can add two" {
    result="$(./add.sh 2 6)"
    [ "$result" -eq 8 ]
}

@test "Add can add many" {
    result="$(./add.sh 3 4 7)"
    [ "$result" -eq 14 ]
}

