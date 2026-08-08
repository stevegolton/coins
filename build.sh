#!/usr/bin/env bash
set -euo pipefail

mkdir -p out

openscad -o out/coin5.stl coin5.scad &
openscad -o out/coin10.stl coin10.scad &
openscad -o out/coin25.stl coin25.scad &
wait

echo "Done."
