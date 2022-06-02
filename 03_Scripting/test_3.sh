#!/usr/bin/env bats

@test "Concat two strings doesn't support anything other than 2 arguments" {
    ./concat_two_strings onlyone
    [ "$?" -neq 0 ]
}
