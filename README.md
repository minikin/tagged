# Tagged

- [Tagged](#tagged)
  - [Installation](#installation)
  - [Development](#development)
    - [Running Tests](#running-tests)

## Installation

Add `tagged` to your `pubspec.yaml`:

```yaml
dependencies:
  tagged: ^0.1.0
```

Install it:

```sh
dart pub get
```

## Development

### Running Tests

To run all unit tests and collect test coverage data:

```sh
dart pub global activate coverage
dart pub global run coverage:test_with_coverage &&
genhtml coverage/lcov.info -o coverage/ &&
open coverage/index.html
```