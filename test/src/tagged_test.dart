import 'package:tagged/tagged.dart';
import 'package:test/test.dart';

void main() {
  group('Tagged', () {
    test(
        '''copyWith returns a new Tagged instance with the same type and a different value''',
        () {
      final tagged1 = const Tagged<int, int>(42);
      final tagged2 = tagged1.copyWith(rawValue: 24);
      expect(tagged1.rawValue, equals(42));
      expect(tagged2.rawValue, equals(24));
      expect(tagged1.runtimeType, equals(tagged2.runtimeType));
    });

    test(
        '''copyWith returns a new Tagged instance with the same type and updated value''',
        () {
      final tagged1 = const Tagged<int, int>(42);
      final tagged2 = tagged1.copyWith(rawValue: 24);
      expect(tagged1.runtimeType, equals(tagged2.runtimeType));
      expect(tagged2.rawValue, equals(24));
    });

    test('copyWith returns a new instance with the specified rawValue', () {
      final tagged1 = const Tagged<int, int>(42);
      final tagged2 = tagged1.copyWith(rawValue: null);
      expect(tagged2.rawValue, equals(42));
    });

    test(
        '''map returns a new Tagged instance with the same type and a mapped value''',
        () {
      final tagged1 = const Tagged<int, String>('42');
      final tagged2 = tagged1.map<String>((value) => value.toString());

      expect(tagged1.runtimeType, equals(tagged2.runtimeType));
      expect(tagged2.rawValue, equals('42'));
    });

    test('toJson returns a Map with the rawValue field', () {
      final tagged = const Tagged<int, int>(42);
      final json = tagged.toJson();
      expect(json, equals({'rawValue': 42}));
    });

    test('fromJson returns a new Tagged instance with the rawValue field', () {
      final json = {'rawValue': 42};
      final tagged = Tagged<int, int>.fromJson(json);
      expect(tagged.rawValue, equals(42));
    });

    test('hashCode returns the hashCode of the rawValue field', () {
      final tagged = const Tagged<int, int>(42);
      expect(tagged.hashCode, equals(42.hashCode));
    });

    test('== returns true if the rawValue fields are equal', () {
      final tagged1 = const Tagged<int, int>(42);
      final tagged2 = const Tagged<int, int>(42);
      final tagged3 = const Tagged<int, int>(24);
      expect(tagged1 == tagged2, isTrue);
      expect(tagged1 == tagged3, isFalse);
    });

    test('toString returns the expected string representation', () {
      final tagged = const Tagged<int, int>(42);
      expect(tagged.toString(), equals('Tagged(rawValue: 42)'));
    });

    test(
        'compareTo returns the expected value when comparing comparable values',
        () {
      final tagged1 = const Tagged<int, int>(42);
      final tagged2 = const Tagged<int, int>(24);
      final result = tagged1.compareTo(tagged2);
      expect(result, equals(1));
    });
  });
}
