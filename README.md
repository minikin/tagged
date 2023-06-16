# Tagged

- [Tagged](#tagged)
  - [Installation](#installation)
  - [Running Tests](#running-tests)

## Installation

Add `tagged` to your `pubspec.yaml`:

```yaml
dependencies:
  tagged:
```

Install it:

```sh
dart pub get
```

## Running Tests

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```