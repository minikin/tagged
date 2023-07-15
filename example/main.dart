import 'package:tagged/tagged.dart';

void main() {
  final user = const User(
    id: UserId('1'),
    name: 'John',
    email: Email('email@mail.com'),
  );

  final item = const ShopItem(
    id: ItemId('1'),
    price: 10,
  );

  // 🛑 The argument type 'Tagged<ShopItem, String>' can't be assigned
  // to the parameter type 'Tagged<User, String>'.
  // processUserData(item.id);

  print({
    'user': user.id.rawValue,
    'item': item.id.rawValue,
  });
}

void processUserData(UserId id) {
  print(id);
}

typedef UserId = Tagged<User, String>;

sealed class EmailTag {}

typedef Email = Tagged<EmailTag, String>;

final class User {
  final UserId id;
  final String name;
  final Email email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });
}

typedef ItemId = Tagged<ShopItem, String>;

final class ShopItem {
  final ItemId id;
  final double price;

  const ShopItem({
    required this.id,
    required this.price,
  });
}
