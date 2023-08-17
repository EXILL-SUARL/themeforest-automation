#!/usr/bin/env bash

# Generates a HTML file that containers a list of used dependencies and their information.

set -e

function usage {
  echo "usage: $0 <decisions_file> <target_directory>"
}

if [[ -z "$1" || -z "$2" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

if [ ! -f "$1" ]; then
  printf '%s\n' "$1 does not exist.." >&2
  usage
  exit 1;
fi

if [ ! -d "$2" ]; then
  mkdir -p "$2"
fi

license_finder report --decisions-file="$1" -p --enabled-package-managers=npm --format html --quiet --columns=name version authors licenses license_links summary approved description homepage install_path package_manager groups text notice --no-debug > "$2/license_report.html"
