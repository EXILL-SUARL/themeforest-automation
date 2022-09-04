#!/usr/bin/env bash

function parse_args
{
  # positional args
  args=()

  # named args
  while [ "$1" != "" ]; do
      case "$1" in
          -i | --input )               input="$2";             shift;;
          -s | --output )       output="$2";     shift;;
          * )                           args+=("$1")             # if no match, add it to the positional args
      esac
      shift # move to next kv pair
  done

  # restore positional args
  set -- "${args[@]}"

  # set positionals to vars
  positional_1="${args[0]}"
  positional_2="${args[1]}"

  # validate required args
  if [[ -z "${input}" || -z "${output}" ]]; then
      echo "Invalid arguments"
      exit;
  fi

  # set defaults
  if [[ -z "$yet_more_args" ]]; then
      yet_more_args="a default value";
  fi
}

function run
{
  parse_args "$@"
  pandoc -t beamer -o $output $input
}


run "$@";
