# Manipulating Data with Flutter

Flutter application to understand data persistence: shared preferences, file system and database.

### Preferences Plugin

- [Shared preferences plugin](https://pub.dev/packages/shared_preferences) - Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.). Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.

### File System Android e IOS

- [path_provider](https://pub.dev/packages/path_provider) - A Flutter plugin for finding commonly used locations on the filesystem. Supports iOS, Android, Linux and MacOS. Not all methods are supported on all platforms.

- [Read and write files](https://flutter.dev/docs/cookbook/persistence/reading-writing-files) - In some cases, you need to read and write files to disk. For example, you may need to persist data across app launches, or download data from the internet and save it for later offline use.

### Widget Dismissible

- [Dismissible](https://flutter.dev/docs/cookbook/gestures/dismissible) - The “swipe to dismiss” pattern is common in many mobile apps. For example, when writing an email app, you might want to allow a user to swipe away email messages to delete them from a list.

### Database

- [Sqflite](https://pub.dev/packages/sqflite) - SQLite plugin for Flutter. Supports iOS, Android and MacOS.

### Date Formatting

- [Intl](https://pub.dev/packages/intl) - Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

- [DateTime class](https://api.dart.dev/stable/2.12.4/dart-core/DateTime-class.html) - Create a DateTime object by using one of the constructors or by parsing a correctly 
formatted string, which complies with a subset of ISO 8601.

- [DateFormat class](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html) - It allows the user to choose from a set of standard date time formats as well as specify a customized pattern under certain locales. Date elements that vary across locales include month name, week name, field order, etc. We also allow the user to use any customized pattern to parse or format date-time strings under certain locales. Date elements that vary across locales include month name, weekname, field, order, etc.

## License

MIT

