/// A generic class that represents a value with a tag a `new type`.
/// The tag is a type parameter that can be used to distinguish between different types of values.
/// The rawValue is the actual value being tagged.
final class Tagged<Tag extends Object, RawValue extends Object>
    implements Comparable<Tagged<Tag, RawValue>> {
  final RawValue rawValue;

  /// Constructor that creates a new Tagged instance with the specified rawValue.
  const Tagged(this.rawValue);

  /// Returns a new Tagged instance with the specified rawValue.
  /// If rawValue is null, the current rawValue is used.
  Tagged<Tag, RawValue> copyWith({
    RawValue? rawValue,
  }) {
    return Tagged<Tag, RawValue>(
      rawValue ?? this.rawValue,
    );
  }

  /// Returns a string representation of the Tagged instance.
  @override
  String toString() => 'Tagged(rawValue: $rawValue)';

  /// Returns true if the specified object is equal to this Tagged instance.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tagged<Tag, RawValue> && other.rawValue == rawValue;
  }

  /// Returns a hash code for this Tagged instance.
  @override
  int get hashCode => rawValue.hashCode;

  /// Compares this Tagged instance to another Tagged instance.
  /// Returns a negative integer, zero, or a positive integer
  /// as this Tagged instance is less than, equal to, or greater than
  /// the specified Tagged instance.
  @override
  int compareTo(Tagged<Tag, RawValue> other) {
    return (rawValue as Comparable).compareTo(other.rawValue as Comparable);
  }

  /// Creates a new Tagged instance from a JSON map.
  factory Tagged.fromJson(Map<String, dynamic> json) {
    final rawValue = json['rawValue'] as RawValue;
    return Tagged<Tag, RawValue>(rawValue);
  }

  /// Converts this Tagged instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'rawValue': rawValue,
    };
  }

  /// Returns a new Tagged instance with the same tag and a new rawValue.
  /// The new rawValue is created by applying the specified mapper function
  /// to the current rawValue.
  Tagged<Tag, NewValue> map<NewValue extends Object>(
      NewValue Function(RawValue) mapper) {
    return Tagged<Tag, NewValue>(mapper(rawValue));
  }
}
