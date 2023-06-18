import 'package:tagged/tagged.dart';
import 'package:test/test.dart';

void main() {
  group('Tagged', () {
    test('can be created with a num value', () {
      final tagged = Tagged(42);
      expect(tagged.value, equals(42));
    });

    test('can be created with a String value', () {
      final tagged = Tagged('hello');
      expect(tagged.value, equals('hello'));
    });

    test('throws an error when created with an invalid value', () {
      expect(() => Tagged(true), throwsArgumentError);
    });

    test('can be compared to another Tagged instance', () {
      final tagged1 = Tagged(42);
      final tagged2 = Tagged(42);
      final tagged3 = Tagged(43);

      expect(tagged1.compareTo(tagged2), equals(0));
      expect(tagged1.compareTo(tagged3), equals(-1));
      expect(tagged3.compareTo(tagged1), equals(1));
    });

    test('compareTo returns 0 for equal Tagged instances', () {
      final tagged1 = Tagged('foo');
      final tagged2 = Tagged('foo');
      expect(tagged1.compareTo(tagged2), equals(0));
    });

    test('compareTo returns a negative value for less-than Tagged instances',
        () {
      final tagged1 = Tagged('bar');
      final tagged2 = Tagged('foo');
      expect(tagged1.compareTo(tagged2), lessThan(0));
    });

    test('compareTo returns a positive value for greater-than Tagged instances',
        () {
      final tagged1 = Tagged('foo');
      final tagged2 = Tagged('bar');
      expect(tagged1.compareTo(tagged2), greaterThan(0));
    });

    test('can be serialized to JSON', () {
      final tagged = Tagged(42);
      final json = tagged.toJson();
      expect(json, equals({'value': 42}));
    });

    test('can be deserialized from JSON', () {
      final json = {'value': 42};
      final tagged = Tagged.fromJson(json);
      expect(tagged.value, equals(42));
    });
  });

  test('== returns true for equal Tagged instances', () {
    final tagged1 = Tagged(42);
    final tagged2 = Tagged(42);
    expect(tagged1 == tagged2, isTrue);
  });

  test('== returns false for different Tagged instances', () {
    final tagged1 = Tagged(42);
    final tagged2 = Tagged(43);
    expect(tagged1 == tagged2, isFalse);
  });

  test('== returns false for non-Tagged instances', () {
    final tagged = Tagged(42);
    expect(tagged == 42, isFalse);
  });

  test('hashCode returns the same value for equal Tagged instances', () {
    final tagged1 = Tagged(42);
    final tagged2 = Tagged(42);
    expect(tagged1.hashCode, equals(tagged2.hashCode));
  });

  test('hashCode returns different values for different Tagged instances', () {
    final tagged1 = Tagged(42);
    final tagged2 = Tagged(43);
    expect(tagged1.hashCode, isNot(equals(tagged2.hashCode)));
  });

  test('toString returns the expected value', () {
    final tagged = Tagged(42);
    expect(tagged.toString(), equals('Tagged(value: 42)'));
  });

  test('copyWith returns same instance if value is null', () {
    final tagged = Tagged<int>(42);
    final copy = tagged.copyWith(value: null);
    expect(copy, equals(tagged));
  });

  test('copyWith returns same instance if value is equal', () {
    final tagged = Tagged<int>(42);
    final copy = tagged.copyWith(value: 42);
    expect(copy, equals(tagged));
  });

  test('copyWith returns new instance if value is different', () {
    final tagged = Tagged<int>(42);
    final copy = tagged.copyWith(value: 43);
    expect(copy, isNot(equals(tagged)));
    expect(copy.value, equals(43));
  });

  // test(
  //     'compareTo throws a StateError for Tagged instances with different types',
  //     () {
  //   final tagged1 = Tagged('foo');
  //   final tagged2 = Tagged(1);
  //   expect(() => tagged1.compareTo(tagged2), throwsStateError);
  // });
}
