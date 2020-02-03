# Texas Jargon Generator

This is a test driven sample project for learning, experimenting, and lots of fun scripting automation.
It currently is an iOS app, but will hopefully expand in the future to include Android and a webapp.

It has some features that may serve as a useful reference for other teams:

* the iOS app is divided into components (frameworks) following App Continuum conventions
* the iOS app uses a portable C++ library for generating random jargon that is fully tested with gtest and linted by clang
* a complete set of shell scripts to automate common tasks such as installing dependencies, linting (Bash, C++, and Swift), and running tests

## Setup and Installing Dependencies

```bash
./scripts/install-dependencies.sh
```

## Running Tests

```bash
./scripts/run-linters-and-tests.sh
```

## Ship-It

```bash
./scripts/ship-it.sh
```
