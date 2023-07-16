// ignore_for_file: unused_element, unused_local_variable

import 'package:tagged/tagged.dart';

void main() {
  final subscription = const Subscription(id: SubscriptionId('1'));

  final user = User(
    subscription.id,
    id: const UserId('1'),
    address: const Address('address'),
    email: const Email('email@email.com'),
  );

  final subscriptions = <Subscription>[];

  Subscription getSubscription(SubscriptionId id) =>
      subscriptions.firstWhere((element) => element.id == id);

  // ❌ The argument type 'Tagged<User, String>' can't be assigned
  // to the parameter type 'Tagged<Subscription, String>'.
  // final subscription = getSubscription(user.id);

  void sendEmail(Email email) {}

  // ❌ The argument type 'Tagged<({String address, User user}), String>'
  // can't be assigned to the parameter type
  //'Tagged<({String email, User user}), String>'.
  // sendEmail(user.address);
}

typedef UserId = Tagged<User, String>;
typedef Email = Tagged<({User user, String email}), String>;
typedef Address = Tagged<({User user, String address}), String>;

class User {
  final UserId id;
  final Address address;
  final Email email;
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
