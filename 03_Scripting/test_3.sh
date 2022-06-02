#!/usr/bin/env bats

@test "Concat two strings doesn't support anything other than 2 arguments" {
    ./concat_two_strings.sh onlyone && exit 1
}
