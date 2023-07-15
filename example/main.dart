import 'package:tagged/tagged.dart';

void main() {
  final user = User(
    UserId('1'),
    'John',
    Email('email@mail.com'),
  );
  final item = ShopItem(ItemId('1'), 10);

  // processUnUser(item.id);
}

void processUnUser(UserId id) {
  print(id);
}

typedef UserId = Tagged<User, String>;

sealed class EmailTag {}

typedef Email = Tagged<EmailTag, String>;

final class User {
  final UserId id;
  final String name;
  final Email email;

  const User(this.id, this.name, this.email);
}

typedef ItemId = Tagged<ShopItem, String>;

final class ShopItem {
  final ItemId id;
  final double price;

  const ShopItem(this.id, this.price);
}
