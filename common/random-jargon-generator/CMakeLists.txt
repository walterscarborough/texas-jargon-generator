# Project and General Cmake Setup
cmake_minimum_required(VERSION 3.15)
project(jargon-generator)

# Compiler Flags
set(CMAKE_CXX_STANDARD 17)

# Conan Setup
if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup()
else ()
    message(WARNING "The file conanbuildinfo.cmake doesn't exist, you have to run conan install first")
endif ()

# Source Files for App
include_directories(src)
file(GLOB SOURCES "src/*.cpp")

# Source Files for Tests
include_directories(test)
file(GLOB TEST_SOURCES "test/*.cpp")

set(NON_MAIN_SOURCES ${SOURCES})
list(REMOVE_ITEM NON_MAIN_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)

add_executable(run-test ${NON_MAIN_SOURCES} ${TEST_SOURCES})
target_link_libraries(run-test ${CONAN_LIBS})