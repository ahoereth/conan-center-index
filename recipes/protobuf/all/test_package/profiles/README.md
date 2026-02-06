# Cross-build profiles (macOS → iOS)

Example profiles for building the protobuf test package on **macOS** for **iOS**.

## Usage

From the recipe folder (`recipes/protobuf`), create and test the package for iOS:

```bash
cd recipes/protobuf
conan create all/conanfile.py --name=protobuf --version=5.29.3 \
  --profile:build=all/test_package/profiles/macos_build \
  --profile:host=all/test_package/profiles/ios_host \
  --build=missing
```

Replace `5.29.3` with the version you want to build (e.g. `3.21.12`, `5.29.3`).

## What this does

- **Build profile** (`macos_build`): tools (CMake, protoc) run on your Mac. Protobuf is first built for macOS so `protoc` is available; that binary is then copied into the host package when building protobuf for iOS.
- **Host profile** (`ios_host`): the library and test app are built for iOS (device, `armv8`).

The test package builds an iOS binary and verifies that `protoc` runs correctly (it is executed on the build machine and must produce `addressbook.pb.cc` / `addressbook.pb.h`). The iOS binary is not run when cross-building.

## Tuning

- **Mac arch**: If you use an Intel Mac, set `arch=x86_64` in `macos_build`.
- **Xcode**: Ensure `compiler.version` in both profiles matches your Xcode (e.g. 14, 15). Run `conan profile show default` on macOS to see the detected version.
- **Simulator**: For iOS Simulator use `os.sdk=iphonesimulator` and e.g. `arch=x86_64` or `arch=armv8` in `ios_host`.
