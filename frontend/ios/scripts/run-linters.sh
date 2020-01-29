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

function verify_linters_are_installed() {
  if ! command -v shellcheck >/dev/null; then
    echo "✋ warning: shellcheck not installed; please run 'brew install shellcheck'"
    exit 1
  fi

  if ! command -v mint >/dev/null; then
    echo "✋ warning: mint not installed; please run 'brew install mint'"
    exit 1
  fi
}

function run_bash_linter() {
  shellcheck scripts/*.sh
}

function run_swiftlint() {
  mint run swiftlint
}

function check_swiftformat_warnings() {
  mint run swiftformat swiftformat --lint --verbose .
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nLinters ran successfully 🧹 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_project_ios_directory
  verify_linters_are_installed
  run_bash_linter
  run_swiftlint
  check_swiftformat_warnings
  display_success_message
}

main
