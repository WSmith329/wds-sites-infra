#!/bin/bash
set -e

mkdir -p build

for lambda_dir in lambdas/*; do
    [ -d "$lambda_dir" ] || continue

    name=$(basename "$lambda_dir")
    package_dir="build/$name"

    rm -rf "$package_dir"
    mkdir -p "$package_dir"

    if [ -f "$lambda_dir/requirements.txt" ]; then
        pip install \
            -r "$lambda_dir/requirements.txt" \
            -t "$package_dir"
    fi

    cp -r "$lambda_dir"/* "$package_dir"/

    (
        cd "$package_dir"
        zip -r "../${name}.zip" .
    )
done