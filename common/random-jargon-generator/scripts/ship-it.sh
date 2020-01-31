#!/usr/bin/env bash

function set_bash_error_handling() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function go_to_project_cplusplus_directory() {
  local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

  cd "$script_dir/.."
}

function run_linters() {
  ./scripts/run-linters.sh
}

function run_tests() {
  ./scripts/run-tests.sh
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nrandom-jargon-generator Ship-it ran successfully 📚 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_project_cplusplus_directory
  run_linters
  run_tests
  display_success_message
}

main
