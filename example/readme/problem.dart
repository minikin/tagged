class User {
  final String id;
  final String name;
  final String email;
  final String? subscriptionId;

  const User(
    this.subscriptionId, {
    required this.id,
    required this.name,
    required this.email,
  });
}

final user = const User(
  null,
  id: '1',
  name: 'John',
  email: 'email@email.com',
);

class Subscription {
  final String id;

  const Subscription({
    required this.id,
  });
}

final subscriptions = <Subscription>[];

Subscription getSubscription(String id) =>
    subscriptions.firstWhere((element) => element.id == id);

final subscription = getSubscription(user.id);
