#!/usr/bin/env bash

function set_bash_error_handling() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function go_to_top_project_directory() {
  local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

  cd "$script_dir/.."
}

function clean() {
  rm random-jargon-generator.js random-jargon-generator.wasm
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  clean
}

main
