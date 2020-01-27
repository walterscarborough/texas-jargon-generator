#!/usr/bin/env bash

function set_bash_error_handling() {
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail
}

function go_to_project_root_directory() {
    local -r script_dir=$(dirname "${BASH_SOURCE[0]}")

    cd "$script_dir/.."
}

function run_bash_linter() {
    shellcheck scripts/*.sh
}

function run_swift_linter() {
    mint run swiftlint
}

function display_success_message() {
    local -r green_color_code='\033[1;32m'
    local -r default_color_code='\033[00m'
    echo -e "${green_color_code}\\nLinters ran successfully 🧹 ${default_color_code} \\n"
}

function main() {
    set_bash_error_handling
    go_to_project_root_directory
    run_bash_linter
    run_swift_linter
    display_success_message
}

main