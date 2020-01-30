#!/usr/bin/env bash

declare WIREMOCK_VERSION=2.25.1

function set_bash_error_handling() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
  set -x
}

function go_to_top_project_directory() {
  local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

  cd "$script_dir/.."
}

function download_wiremock_if_not_available() {
  pushd contracts
    if [[ ! -f wiremock-standalone.jar ]]; then
        curl -o "wiremock-standalone.jar" "https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar"
    fi
  popd
}

function start_wiremock() {
  pushd contracts
    java -jar wiremock-standalone.jar --root-dir .
  popd
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  download_wiremock_if_not_available
  start_wiremock
}

main
