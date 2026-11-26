# MinglePH

MinglePH is a Flutter Android/iOS social dating and voice chat project in active foundation work. This repository starts from [AOSSIE-Org/Resonate](https://github.com/AOSSIE-Org/Resonate), a cross-platform social voice app, and keeps its GNU GPL v3 license. See [FOUNDATION.md](FOUNDATION.md) for the source evaluation, upstream notices, architecture, and the current feature boundary. See [ROADMAP.md](ROADMAP.md) for the implementation sequence.

## Current foundation

The inherited client includes Flutter/Riverpod screens and services for Appwrite authentication and social data, LiveKit audio rooms and calls, room chat, pair chat, friend relationships, stories, notifications, and user activity. It has 193 upstream tests. These inherited modules still require a separately configured MinglePH backend; they are not evidence that MinglePH's dating or coin flows are complete.

MinglePH-specific dating features (dating profiles, discovery and mutual matching, private dating chat, moments/feed, moderation flows, and a secure virtual economy) are **not implemented yet**. No demo users, fake online states, or fake wallet transactions are included.

## Technology choices

- Flutter / Dart with Riverpod for Android, iOS, and the inherited Flutter web target.
- Appwrite for identity, database, storage, functions, and push messaging.
- LiveKit for real-time audio rooms and calls.
- Meilisearch remains optional for search.
- PostgreSQL/Supabase is not added: the chosen base already has a substantial Appwrite backend integration, so adding a competing backend would split the architecture.

## Local setup

Install Flutter/Dart, Android SDK for Android, and Xcode/CocoaPods on macOS for iOS. Follow [ONBOARDING.md](ONBOARDING.md) for the Appwrite and LiveKit development services. That upstream guide describes Resonate's backend setup; create and configure a separate MinglePH Appwrite project and matching collections/functions before using this client with real accounts. Do not connect to AOSSIE's production project.

Copy the variable names in `.env.example` into your local configuration and pass values with Flutter `--dart-define` arguments. Keep actual credentials and signing files out of Git. `MEILISEARCH_API_KEY` defaults to empty and search is disabled unless explicitly configured.

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define=APPWRITE_BASE_DOMAIN=localhost --dart-define=APPWRITE_PROJECT_ID=mingleph
```

The Appwrite collections and cloud functions still need to be provisioned for MinglePH before authentication and social services can be exercised. Voice rooms additionally need a LiveKit server and a server-side token function. See [ROADMAP.md](ROADMAP.md).

## License and upstream attribution

This derivative is distributed under the GNU General Public License v3.0. See [LICENSE](LICENSE) and [UPSTREAM.md](UPSTREAM.md). Original Resonate attribution, documentation, and assets are retained; MinglePH branding does not imply endorsement by AOSSIE.
