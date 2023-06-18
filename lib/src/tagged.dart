typedef Validator<T> = void Function(T value);

class Tagged<T extends Object> implements Comparable<Tagged<T>> {
  final T _value;

  T get value => _value;

  factory Tagged(T value) {
    if (value is! String && value is! num) {
      throw ArgumentError('Value must be of type String or num');
    }

    return Tagged._(value);
  }

  Tagged._(this._value);

  Map<String, dynamic> toJson() {
    return {'value': _value};
  }

  factory Tagged.fromJson(Map<String, dynamic> json) {
    return Tagged<T>(json['value']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Tagged && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'Tagged(value: $_value)';

  @override
  int compareTo(Tagged<T> other) {
    if (_value is num && other._value is num) {
      return (_value as num).compareTo(other._value as num);
    } else if (_value is String && other._value is String) {
      return (_value as String).compareTo(other._value as String);
    } else {
      throw StateError('Cannot compare values of different types');
    }
  }
}
