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

function start_server() {
  emrun --no_browser --port 8080 index.html
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  start_server
}

main
