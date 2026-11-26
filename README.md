# MinglePH

MinglePH is a Flutter Android/iOS social dating and voice chat project in active foundation work. This repository starts from [AOSSIE-Org/Resonate](https://github.com/AOSSIE-Org/Resonate), a cross-platform social voice app, and keeps its GNU GPL v3 license. See [FOUNDATION.md](FOUNDATION.md) for the source evaluation, upstream notices, architecture, and the current feature boundary. See [ROADMAP.md](ROADMAP.md) for the implementation sequence.

## Current foundation

The inherited client includes Flutter/Riverpod screens and services for Appwrite authentication and social data, LiveKit audio rooms and calls, room chat, pair chat, friend relationships, stories, notifications, and user activity. It has 193 upstream tests. These inherited modules remain on Appwrite while a separate optional Supabase foundation is prepared for MinglePH dating data. Read [Architecture](docs/ARCHITECTURE.md), [Supabase setup](docs/SUPABASE_SETUP.md), [Database schema](docs/DATABASE_SCHEMA.md), and [Security](docs/SECURITY.md). Appwrite and Supabase identities are not linked yet.

MinglePH-specific dating features (dating profiles, discovery and mutual matching, private dating chat, moments/feed, moderation flows, and a secure virtual economy) are **not implemented yet**. No demo users, fake online states, or fake wallet transactions are included.

## Technology choices

- Flutter / Dart with Riverpod for Android, iOS, and the inherited Flutter web target.
- Appwrite remains active for inherited identity, social data, storage, functions, and push messaging during migration.
- Supabase is prepared for dating-domain PostgreSQL, Realtime, and private profile-photo storage; it remains optional until configured.
- LiveKit for real-time audio rooms and calls.
- Meilisearch remains optional for search.
- Dating data is being prepared in Supabase as a phased addition. Appwrite remains the current authentication authority until identity linking/migration is designed and tested; this phase does not duplicate existing data or silently replace working auth and voice flows.

## Local setup

Install Flutter/Dart, Android SDK for Android, and Xcode/CocoaPods on macOS for iOS. Follow [ONBOARDING.md](ONBOARDING.md) for the inherited Appwrite and LiveKit development services. Supabase setup is documented separately in [docs/SUPABASE_SETUP.md](docs/SUPABASE_SETUP.md). Do not connect to AOSSIE's production project.

Use `.env.example` as a checklist of supported Flutter `--dart-define` names; it intentionally contains names only, not a dotenv file. Set platform-appropriate endpoints (for example, Android Emulator reaches host `localhost` through `10.0.2.2`). Keep actual credentials and signing files out of Git. `MEILISEARCH_API_KEY` defaults to empty and search is disabled unless explicitly configured.

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define=APPWRITE_BASE_DOMAIN=10.0.2.2 --dart-define=APPWRITE_PROJECT_ID=mingleph
```

The Appwrite collections and cloud functions still need to be provisioned for MinglePH before authentication and social services can be exercised. Voice rooms additionally need a LiveKit server and a server-side token function. See [ROADMAP.md](ROADMAP.md).

## License and upstream attribution

This derivative is distributed under the GNU General Public License v3.0. See [LICENSE](LICENSE) and [UPSTREAM.md](UPSTREAM.md). Original Resonate attribution, documentation, and assets are retained; MinglePH branding does not imply endorsement by AOSSIE.
