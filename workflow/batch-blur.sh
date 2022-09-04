#!/usr/bin/env bash

function parse_args
{
  args=()
  while [ "$1" != "" ]; do
      case "$1" in
          -i | --input )               input="$2";             shift;;
      esac
      shift # move to next kv pair
  done
  set -- "${args[@]}"

  # validate required args
  if [[ -z "${input}" ]]; then
      echo "Invalid arguments"
      exit;
  fi
}

function run
{
  parse_args "$@"
  find $input -iregex '.*\.\(jpg\|gif\|ico\|png\|jpeg\|webp\)$' -type f -exec convert -blur 0x20 {} {} \;
}


run "$@";
