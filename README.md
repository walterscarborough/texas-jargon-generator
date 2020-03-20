# Texas Jargon Generator

This is an experimental project for exploring cross platform application development strategies.

It currently uses a C++ library to share business logic between iOS, Android, and a webapp.

It has some interesting highlights that may serve as a useful reference for other teams:

* Uses the same shared library in all clients
    * shows how to import C++ into an iOS project as Objective C++
    * shows how to import C++ into an Android project via JNI
    * shows how to import C++ into a webapp via JavaScript/WebAssembly
* The C++ library is tested with gtest and linted by clang-tidy
* The iOS app is divided into modular components (frameworks) following [App Continuum](https://www.appcontinuum.io) conventions
* Includes a complete set of shell scripts to automate common tasks such as installing dependencies, linting (Bash, C++, and Swift), and running tests

## General Setup

### Setup and Installing Dependencies

```bash
./scripts/install-dependencies.sh
```

Please note that the emscripten configuration for the `web` frontend can be a bit confusing. Please refer to homebrew instructions at the end of the emscripten installation to set the `BINARYEN` path correctly in your home directory.

### Running Tests

```bash
./scripts/run-linters-and-tests.sh
```

### Pushing Changes To This Repository

```bash
./scripts/ship-it.sh
```

## Building Apps

### Building the iOS Client

Open up `frontends/ios/xcode/TexasJargonGenerator.xcodeproj` in xcode and build from there.

### Building the Android Client

Open up `frontends/android` in Android Studio and build from there.

### Building the Web Client

```bash
# Go to the web directory
cd frontends/web

# Run the build script
./scripts/build.sh

# Start the emscripten web server
./scripts/start-server.sh

# View localhost:8080 in your browser
```
