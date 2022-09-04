#!/usr/bin/env bash

function parse_args
{
  args=()
  while [ "$1" != "" ]; do
      case "$1" in
          -i | --input )               input="$2";             shift;;
          -s | --output )       output="$2";     shift;;
      esac
      shift # move to next kv pair
  done
  set -- "${args[@]}"

  # validate required args
  if [[ -z "${input}" || -z "${output}" ]]; then
      echo "Invalid arguments"
      exit;
  fi
}

function run
{
  parse_args "$@"
  pandoc -t beamer -o $output $input
}


run "$@";
