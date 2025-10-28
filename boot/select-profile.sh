#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <profile>" >&2
  exit 1
fi

profile="$1"
script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
profile_dir="$script_dir/profiles/$profile"

if [[ ! -d "$profile_dir" ]]; then
  echo "Unknown profile '$profile'. Available profiles:" >&2
  ls "$script_dir/profiles" >&2
  exit 1
fi

files=(
  "bpi-r4-boot.txt"
  "bpi-r4-u-boot-frag.config"
  "bpi-r4-uboot.env.txt"
)

for name in "${files[@]}"; do
  target="profiles/$profile/$name"
  if [[ ! -f "$script_dir/$target" ]]; then
    echo "Profile '$profile' is missing $name" >&2
    exit 1
  fi
  ln -sfn "$target" "$script_dir/$name"
  echo "Linked $name -> $target"
done
