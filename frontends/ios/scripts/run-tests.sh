#!/usr/bin/env bash

declare WIREMOCK_PID=""

function set_bash_error_handling() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function set_bash_exit_handling() {
  trap cleanup EXIT
}

function go_to_project_ios_directory() {
  local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

  cd "$script_dir/../../../"
}

function start_wiremock_if_not_running() {
  if [[ ! $(lsof -i :8080) ]]; then
    echo "Wiremock not running - starting now"
    pushd contracts
      java -jar wiremock-standalone.jar --root-dir . &
      WIREMOCK_PID=$!

      sleep 1
    popd
  fi
}

function run_tests() {
  pushd frontends/ios
    xcodebuild clean test \
      -project TexasJargonGenerator.xcodeproj \
      -scheme TexasJargonGenerator \
      -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.3' \
      | xcpretty
  popd
}

function cleanup() {

  local -r exit_code=$?

  function stop_wiremock_if_started_by_test_suite() {
    if [[ -n "$WIREMOCK_PID" ]]; then
      echo "Wiremock running - stopping now"
      kill "$WIREMOCK_PID"
    fi
  }

  function display_success_message() {
    local -r green_color_code='\033[1;32m'
    local -r default_color_code='\033[00m'
    echo -e "${green_color_code}\\nFormatters ran successfully 🧼 ${default_color_code} \\n"
  }

  stop_wiremock_if_started_by_test_suite

  if [[ exit_code -eq 0 ]]; then
    display_success_message
  fi
}

function main() {
  set_bash_error_handling
  set_bash_exit_handling
  go_to_project_ios_directory
  start_wiremock_if_not_running
  run_tests
}

main
