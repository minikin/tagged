typedef Validator<T> = void Function(T value);

class Tagged<T> {
  final T _value;

  T get value => _value;

  factory Tagged(T value, [Validator<T>? validator]) {
    (validator ?? (T value) {})(value);
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
  String toString() => 'Tagged(_value: $_value)';
}
