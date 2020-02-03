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

function install_missing_brew_dependencies() {
  if [[ -f /usr/local/bin/clang-tidy ]]; then
    unlink /usr/local/bin/clang-tidy
  fi

  if [[ -f /usr/local/bin/clang-format ]]; then
    unlink /usr/local/bin/clang-format
  fi

  brew install conan llvm

  ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
  ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
}

function install_missing_conan_dependencies() {
  conan install . -s build_type=Debug --install-folder=cmake-build-debug
  conan install . -s build_type=Release --install-folder=cmake-build-release
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nCommon dependencies installed successfully 💾 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_project_cplusplus_directory
  install_missing_brew_dependencies
  install_missing_conan_dependencies
  display_success_message
}

main
