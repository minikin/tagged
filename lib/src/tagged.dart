final class Tagged<Tag extends Object, RawValue extends Object>
    implements Comparable<Tagged<Tag, RawValue>> {
  final RawValue rawValue;

  const Tagged(this.rawValue);

  Tagged<Tag, RawValue> copyWith({
    RawValue? rawValue,
  }) {
    return Tagged<Tag, RawValue>(
      rawValue ?? this.rawValue,
    );
  }

  @override
  String toString() => 'Tagged(rawValue: $rawValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tagged<Tag, RawValue> && other.rawValue == rawValue;
  }

  @override
  int get hashCode => rawValue.hashCode;

  @override
  int compareTo(Tagged<Tag, RawValue> other) {
    return (rawValue as Comparable).compareTo(other.rawValue as Comparable);
  }

  factory Tagged.fromJson(Map<String, dynamic> json) {
    final rawValue = json['rawValue'] as RawValue;
    return Tagged<Tag, RawValue>(rawValue);
  }

  Map<String, dynamic> toJson() {
    return {
      'rawValue': rawValue,
    };
  }

  Tagged<Tag, NewValue> map<NewValue extends Object>(
      NewValue Function(RawValue) mapper) {
    final newValue = mapper(rawValue);
    return Tagged<Tag, NewValue>(newValue);
  }
}
