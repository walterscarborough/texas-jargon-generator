#!/usr/bin/env bash

function set_bash_error_handling() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function go_to_project_ios_directory() {
  local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

  cd "$script_dir/.."
}

function run_bash_linter() {
  shellcheck scripts/*.sh
}

function run_swiftlint() {
  pushd xcode
    mint run swiftlint
  popd
}

function check_swiftformat_warnings() {
  pushd xcode
    mint run swiftformat swiftformat --lint --verbose .
  popd
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nLinters ran successfully 🧹 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_project_ios_directory
  run_bash_linter
  run_swiftlint
  check_swiftformat_warnings
  display_success_message
}

main
