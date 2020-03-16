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

function compile_cplusplus() {
  emcc ../../common/random-jargon-generator/src/random_jargon_generator_library.cpp \
    -o random-jargon-generator.js \
    -s EXPORTED_FUNCTIONS="['_generate_phrase']" \
    -s EXTRA_EXPORTED_RUNTIME_METHODS="['cwrap']" \
    -s MODULARIZE=1 -s 'EXPORT_NAME="RandomJargonGeneratorModule"' \
    -std=c++17
}

function main() {
  set_bash_error_handling
  go_to_top_project_directory
  compile_cplusplus
}

main
