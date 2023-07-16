# Tagged

A Newtype Pattern, a Safe & Type-Restricted Wrapper for Dart

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct.svg)](https://vshymanskyy.github.io/StandWithUkraine)

<p align="center">
    <a href="https://github.com/minikin/tagged/actions">
    <img src="https://github.com/minikin/tagged/actions/workflows/build.yaml/badge.svg" alt="CI Status" />
  </a>

  <a href="https://codecov.io/gh/minikin/tagged" >
  <img src="https://codecov.io/gh/minikin/tagged/branch/main/graph/badge.svg?token=n4qmrtvshr"/>
  </a>

   <a href="https://github.com/minikin/tagged/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="Tagged is released under the MIT license." />
  </a>

  <a href="https://github.com/minikin/tagged/blob/main/CODE_OF_CONDUCT.md">
    <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs welcome!" />
  </a>
</p>

- [Tagged](#tagged)
  - [Motivation](#motivation)
  - [The problem](#the-problem)
  - [The solution](#the-solution)
    - [Handling Tag Collisions](#handling-tag-collisions)
    - [Accessing Raw Values](#accessing-raw-values)
  - [Installation](#installation)
  - [FAQ](#faq)
  - [Support](#support)
  - [License](#license)

> Inspired by [Pointfreeco's Tagged Swift Package](https://github.com/pointfreeco/swift-tagged) and functional programming.

## Motivation

Frequently, we find ourselves dealing with data types that are overly broad or encompass more values than required for our particular field.
At times, we may need to distinguish between two values that appear equivalent at the type level.

An email address, for instance, is merely a String, yet it needs to have certain limitations on its usage.
Similarly, while a `User` `id` can be represented using an `String`, it should be distinguishable from a `Subscription` id that also uses an `String` as its base.

The `Tagged` pub comes in handy in averting severe runtime errors during the compile time by effortlessly encapsulating fundamental types within more distinct contexts.

## The problem

Dart has a robust and versatile type system, but it's still common to model most data like this:

```dart
class User{
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


class Subscription {
  final String id;

  const Subscription({
    required this.id,
  });
}
```

We are utilizing the same data type for both user and subscription IDs in our model. However, it is crucial to note that our application logic should not consider these values as interchangeable. To illustrate, let's consider a scenario where we need to create a function to retrieve a subscription:

```dart
Subscription getSubscription(String id) =>
    subscriptions.firstWhere((element) => element.id == id);
```

This type of code is extremely common, but it can lead to significant runtime bugs and security vulnerabilities. Although it may compile, run, and appear reasonable at first glance, it is essential to be aware of the potential risks it poses.

```dart
final subscription = getSubscription(user.id);
```

This code is prone to _failure_ when attempting to locate a user's subscription. Even worse, if there is an overlap between user IDs and subscription IDs, it will _incorrectly_ display subscriptions to the wrong users. This can lead to severe consequences, including the _exposure of sensitive_ information such as billing details.

## The solution

Using the `Tagged` allows us to succinctly differentiate between types.

```dart
typedef UserId = Tagged<User, String>;

class User {
  final UserId id;
  final String name;
  final String email;
  final SubscriptionId? subscriptionId;

  const User(
    this.subscriptionId, {
    required this.id,
    required this.name,
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
```

In this scenario, we have utilized the container type as a means to uniquely tag each `ID`, thereby implementing the Tagged approach. By incorporating a generic tag parameter within the container type, we can differentiate between user and subscription IDs effectively. This enables us to maintain distinct types and ensures that our code accurately handles each `ID`, mitigating the risk of errors and bolstering security by safeguarding sensitive information like billing details.

We can now update `getSubscription` to take a `SubscriptionId` where it previously took any `String`.

```dart
Subscription getSubscription(SubscriptionId id) =>
    subscriptions.firstWhere((element) => element.id == id);
```

This further enhances the reliability and correctness of our code, reducing the risk of runtime errors and ensuring that the appropriate ID is used in the intended context.

```dart
final subscription = getSubscription(user.id);
```

> ❌ The argument type 'Tagged<User, String>' can't be assigned to the parameter type 'Tagged<Subscription, String>'.

`Tagged` has prevented critical bugs at compile time, improving code stability and reliability.

### Handling Tag Collisions

Another bug remains unresolved within the types we've defined. We have implemented a function with the following signature:

```dart
void sendEmail(String userAddress) {}
```

It lacks proper input validation and accepts __any__ string, which poses a potential issue.

```dart
sendEmail(user.address)
```

Although the code compiles and runs, there is a critical flaw in its logic. The variable user.address is mistakenly assumed to refer to the user's email address, when in fact, it points to their billing address. As a result, the emails intended for users are not being sent. Additionally, if the function is called with invalid data, it may lead to server churn and crashes, exacerbating the issue further. This issue must be addressed to ensure that users receive the appropriate communications and to prevent potential disruptions to the server.

Let's try to fix the issue with Tagged:

```dart
typedef UserId = Tagged<User, String>;

typedef Email = Tagged<User, String>;

typedef Address = Tagged<User, String>;

class User {
  final UserId id;
  final String address;
  final Email email;
  final SubscriptionId? subscriptionId;

  const User(
    this.subscriptionId, {
    required this.id,
    required this.address,
    required this.email,
  });
}
```

However, we shouldn't reuse `Tagged<User, String>` for `Email` and  `Address` because the compiler would treat `UserId`, `Email` and `Address` as the same type!

```dart
typedef UserId = Tagged<User, String>;

abstract class EmailTag {}
typedef Email = Tagged<EmailTag, String>;

abstract class AddressTag {}
typedef Address = Tagged<AddressTag, String>;

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
```

Now we can update `sendEmail` to take an `Email` where it previously took any `String`.

```dart
void sendEmail(Email email) {}
```

```dart
sendEmail(user.address)
```

> ❌ The argument type 'Tagged<AddressTag, String>' can't be assigned to the parameter type 'Tagged<EmailTag, String>'.

We've now distinguished `Email` and `Address` at the cost of an extra line per type, but things are documented very explicitly.

Tuple labels in the type system can differentiate seemingly equivalent tuple types, allowing us to save an additional line of code.

```dart
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
```

Add text:

```dart
final user = const User(
  null,
  id: UserId('1'),
  address: Address('address'),
  email: Address('email@email.com'), 
);
```
> ❌ The argument type 'Tagged<({String address, User user}), String>' can't be assigned to the parameter type 'Tagged<({String email, User user}), String>'.

### Accessing Raw Values

Tagged expose its raw values, _via_ a `rawValue` property:

``` dart
final id = user.id.rawValue; // String
```

## Installation

Add `tagged` to your `pubspec.yaml`:

```yaml
dependencies:
  tagged: ^0.1.0
```

Install it:

```sh
dart pub get
```

## FAQ

  - **Why not use a Typedefs?**

    [Typedefs](https://dart.dev/language/typedefs)  are just that: aliases. A type alias can be used interchangeably with the original type and offers no additional safety or guarantees.

## Support

Post issues and feature requests on the GitHub [issue tracker](https://github.com/minikin/tagged/issues).

## License

The source code is distributed under the MIT license.
See the [LICENSE](https://github.com/minikin/tagged/blob/main/LICENSE) file for more info.
