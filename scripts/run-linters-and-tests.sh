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

function run_random_jargon_generator_ship_it() {
  ./common/random-jargon-generator/scripts/ship-it.sh
}

function run_ios_ship_it() {
  ./frontends/ios/scripts/ship-it.sh
}

function run_top_level_bash_linter() {
    shellcheck scripts/*.sh
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nAll tests ran successfully 🧪 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  run_top_level_bash_linter
  run_random_jargon_generator_ship_it
  run_ios_ship_it
  display_success_message
}

main
