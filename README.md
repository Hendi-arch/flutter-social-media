# Flutter Social Media

Flutter social media using the [DummyAPI IO](https://dummyapi.io/).

## Related Tutorials

- [Flutter App Architecture: The Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)

## Supported Features

- [x] Home feature (Users and Posts)
- [x] Profile feature
- [x] Posts by profile feature

## Ongoing Development

- [ ] Like/unlike on post
- [ ] Posts by like
- [ ] Posts by tags
- [ ] Filtered posts

## App Architecture

The app is composed by two main layers.

### Data Layer

The data layer contains a single feature repository that is used to fetch data from the [DummyAPI IO](https://dummyapi.io/).

The data is then parsed (using JsonSerializable) and returned using **type-safe** entity classes.

For more info about this, read this tutorial:

- [Flutter App Architecture: The Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)

### Presentation Layer

This layer holds all the widgets, along with their notifier.

Widgets do not communicate directly with the repository.

Instead, they watch some notifiers that extend the `ChangeNotifier` class (using Provider).

This allows to map the data from the layer above to `BaseEntity<T>` objects that can be mapped to the appropriate UI states (data, loading, error).

**Note**: to use the API you'll need to register an account and obtain your own API key. This can be set via `--dart-define` or inside `lib/app/app_secret.dart`.
