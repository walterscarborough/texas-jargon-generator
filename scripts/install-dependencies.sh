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

function install_common_dependencies() {
  ./common/random-jargon-generator/scripts/install-dependencies.sh
}

function install_ios_dependencies() {
  ./frontends/ios/scripts/install-dependencies.sh
}

function install_wiremock() {
  pushd contracts
    if [[ ! -f wiremock-standalone.jar ]]; then
        local -r wiremock_version=2.25.1
        curl -o "wiremock-standalone.jar" "https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${wiremock_version}/wiremock-standalone-${wiremock_version}.jar"
    fi
  popd
}

function display_success_message() {
  local -r green_color_code='\033[1;32m'
  local -r default_color_code='\033[00m'
  echo -e "${green_color_code}\\nAll dependencies installed successfully 💾 ${default_color_code} \\n"
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  install_common_dependencies
  install_ios_dependencies
  install_wiremock
  display_success_message
}

main
