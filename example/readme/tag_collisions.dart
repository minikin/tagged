import 'package:tagged/tagged.dart';

typedef UserId = Tagged<User, String>;

// sealed class EmailTag {}

//typedef Email = Tagged<EmailTag, String>;

typedef Email = Tagged<({User user, String email}), String>;

class User {
  final UserId id;
  final String name;
  final Email email;
  final SubscriptionId? subscriptionId;

  const User(
    this.subscriptionId, {
    required this.id,
    required this.name,
    required this.email,
  });
}

final user = const User(
  null,
  id: UserId('1'),
  name: 'John',
  email: Email('email@email.com'),
);

typedef SubscriptionId = Tagged<Subscription, String>;

class Subscription {
  final SubscriptionId id;

  const Subscription({
    required this.id,
  });
}

void sendWelcomeEmail(String userAddress) {}
