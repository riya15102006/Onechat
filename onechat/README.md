# OneChat

One Hour. One Chance. One Real Connection.

## Prerequisites
- Flutter 3.22+
- Dart 3.3+
- Firebase project (Android & iOS apps created)

## Setup
1. Install Flutter SDK and set PATH.
2. Create Firebase project, add Android and iOS apps, enable Auth providers (Phone, Google).
3. Run FlutterFire to generate config:
   - `dart pub global activate flutterfire_cli`
   - `flutterfire configure` (select this project)
   - This will overwrite `lib/firebase_options.dart` with real values.
4. Install dependencies:
   - `flutter pub get`
5. Run the app:
   - `flutter run`

## Structure
- `lib/main.dart`: App entry, Firebase init
- `lib/app.dart`: Theme + Router
- `lib/core/*`: Theme, router, utils
- `lib/features/*`: Feature-first screens and logic

More docs coming as features are implemented.