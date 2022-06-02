#!/usr/bin/env bats

@test "Concat two strings can concat two strings" {
    result="$(./concat_two_strings.sh foo bar)"
    [ "$result" = "foobar" ]
}

@test "Add can add two" {
    result="$(./add.sh 2 6)"
    [ "$result" -eq 8 ]
}
