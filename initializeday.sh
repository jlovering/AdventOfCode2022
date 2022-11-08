#!/bin/bash

day=$1

mkdir calendar/$day
cp -r template/* calendar/$day

sed -i '' "s/day = \"template\"/day = \"$day\"/" calendar/$day/spec/part1_spec.cr
sed -i '' "s/day = \"template\"/day = \"$day\"/" calendar/$day/spec/part2_spec.cr