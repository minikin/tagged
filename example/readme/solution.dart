import 'package:tagged/tagged.dart';

typedef UserId = Tagged<User, String>;

class User {
  final UserId id;
  final String address;
  final String email;
  final SubscriptionId? subscriptionId;

  const User(
    this.subscriptionId, {
    required this.id,
    required this.address,
    required this.email,
  });
}

typedef SubscriptionId = Tagged<Subscription, String>;

class Subscription {
  final SubscriptionId id;

  const Subscription({
    required this.id,
  });
}

final user = const User(
  null,
  id: UserId('1'),
  address: 'address',
  email: 'email@email.com',
);

final subscriptions = <Subscription>[];

Subscription getSubscription(SubscriptionId id) =>
    subscriptions.firstWhere((element) => element.id == id);

// final subscription = getSubscription(user.id);

// final id = user.id.rawValue;
