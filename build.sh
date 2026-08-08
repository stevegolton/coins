#!/usr/bin/env bash
set -euo pipefail

mkdir -p out

for file in coin5.scad coin10.scad coin25.scad; do
  echo "Converting $file..."
  openscad -o "out/${file%.scad}.stl" "$file"
done

echo "Done."
