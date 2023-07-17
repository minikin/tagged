import 'package:meta/meta.dart';

/// `Tagged` is a Dart implementation of the Newtype pattern,
/// a pattern used to create a new type from an existing type
/// but with a different name and potentially different behavior.
///
/// The `Tagged` provides a straightforward way to add additional context
/// or "tags" to a value without changing the value itself.
/// It is a handy tool for creating new types
/// and enforcing stronger type checking in Dart applications.
///
/// ```dart
/// typedef UserId = Tagged<User, String>;
/// typedef Email = Tagged<({User user, String email}), String>;
/// typedef Address = Tagged<({User user, String address}), String>;
///
/// class User {
///   final UserId id;
///   final Address address;
///   final Email email;
///   final SubscriptionId? subscriptionId;
///
///  const User(
///     this.subscriptionId, {
///     required this.id,
///     required this.address,
///     required this.email,
///   });
/// }
///
/// typedef SubscriptionId = Tagged<Subscription, String>;
///
/// class Subscription {
///   final SubscriptionId id;
///
///   const Subscription({
///     required this.id,
///   });
/// }
///
///  Subscription getSubscription(SubscriptionId id) =>
///     subscriptions.firstWhere((element) => element.id == id);
/// ````
@immutable
final class Tagged<Tag extends Object, RawValue extends Object>
    implements Comparable<Tagged<Tag, RawValue>> {
  /// The rawValue is the actual value being tagged.
  final RawValue rawValue;

  /// Constructor that creates a new Tagged instance
  /// with the specified rawValue.
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
