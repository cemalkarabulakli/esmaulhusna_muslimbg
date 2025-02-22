# Publishing Guide

This document describes how to publish new versions of the `esmaulhusna_muslimbg` package to pub.dev.

## Release Process

1. Update the version in `pubspec.yaml` following semantic versioning:
   - MAJOR version for incompatible API changes
   - MINOR version for backwards-compatible functionality additions
   - PATCH version for backwards-compatible bug fixes

2. Update `CHANGELOG.md` with the changes in the new version.

3. Run the following checks locally:
   ```bash
   flutter pub get
   dart format --output=none --set-exit-if-changed .
   dart analyze
   flutter test
   ```

4. Commit all changes:
   ```bash
   git add .
   git commit -m "Release version x.y.z"
   ```

5. Create and push a tag:
   ```bash
   git tag vx.y.z
   git push origin vx.y.z
   ```

6. The GitHub Action will automatically:
   - Run all tests and checks
   - Publish to pub.dev if all checks pass

## Version Tag Format

Tags must follow the format `vX.Y.Z` where:
- X = major version
- Y = minor version
- Z = patch version

Examples:
- `v1.0.0`
- `v1.2.3`
- `v2.0.0-beta.1`

## Troubleshooting

If the automated publishing fails:
1. Check the GitHub Actions logs
2. Verify all tests pass locally
3. Ensure the version hasn't been published before
4. Verify the pubspec.yaml is valid 