import 'package:tagged/tagged.dart';

typedef UserId = Tagged<User, String>;

// abstract class EmailTag {}

// typedef Email = Tagged<EmailTag, String>;

// abstract class AddressTag {}

// typedef Address = Tagged<AddressTag, String>;

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

final user = const User(
  null,
  id: UserId('1'),
  address: Address('address'),
  email: Email('email@email.com'),
);

typedef SubscriptionId = Tagged<Subscription, String>;

class Subscription {
  final SubscriptionId id;

  const Subscription({
    required this.id,
  });
}

void sendEmail(Email email) {}

// final _ = sendEmail(user.address);

// void sendEmail(String userAddress) {}

// final _ = sendEmail(user.address);
