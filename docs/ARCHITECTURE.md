# MinglePH architecture audit

## Current client

The app is Flutter for Android/iOS, using feature-first MVVM, Riverpod providers/notifiers, Freezed models, and `go_router`. Features are under `lib/features/<feature>/` with view, viewmodel, model, and data layers. Shared providers/services live under `lib/core`, shared UI/models under `lib/shared`, and navigation under `lib/routes`. Generated Dart files are build_runner output and must not be hand-edited.

`lib/routes/app_router.dart` composes feature route lists and centralizes authentication redirects and feature flags. Current route groups cover splash/landing/login/signup/OTP/password recovery; onboarding/profile editing/account deletion; the tab shell/home/notifications; rooms/room chat; settings/preferences; themes/interests; friend pairing/pair chat/friend calls; and stories/live chapters. Dating discovery, mutual-match inbox, dating conversation, and moderation queue routes are not present.

## Existing backend and capabilities

- **Appwrite** currently handles sign-in/session state (`AuthRepository`), user profiles/social records, storage, server functions, and Realtime subscriptions. Rooms, room chat, pair chat, friend requests/calls, stories, notifications, interests, activity, and achievements use the inherited Appwrite service layer.
- **LiveKit** with `flutter_webrtc` handles room and friend-call audio. Room tokens and privileged room operations are obtained from Appwrite Functions; the client does not mint its own LiveKit credentials.
- **Meilisearch** is optional and disabled by default.
- Dating discovery, dating matches, and dating-private conversations do not exist at baseline. Friend/pair chat and room chat are not dating matches or substitutes for their authorization model.
- No Supabase project credentials, remote database, tables, or migrations existed at baseline.

## Supabase boundary

Supabase is prepared for new dating-domain data: PostgreSQL schema/migrations, RLS, Realtime for dating messages, and private profile-photo storage. Optional client initialization does not replace Appwrite sign-in. Appwrite IDs are strings while Supabase Auth uses UUIDs, so account linking/migration is required before authenticated dating requests can work.

Match creation and direct conversation/member provisioning are not writable by mobile clients. A future trusted Edge Function or equivalent server operation must verify reciprocal likes and block status and create match/conversation rows atomically. Wallet/payment state must also remain server-authoritative. No UI or existing Appwrite/LiveKit flow is changed in Phase 1.

## Dependencies and migration

The app's dependencies are in `pubspec.yaml`/`pubspec.lock`: Flutter/Dart SDK, Appwrite 28.0.x (pinned to the current server response format), Riverpod 3 / generator 4, `go_router`, Freezed, LiveKit, WebRTC, storage/platform plugins, and test/codegen/lint tools. Phase 1 adds stable `supabase_flutter` 2.18.3 (minimum Dart 3.9; app minimum is Dart 3.10). The lockfile must be resolved with Flutter installed. A current `flutter pub outdated` report could not be obtained in this environment, so no additional packages are called outdated or upgraded. SQL lives in `supabase/migrations/`. Review and apply only to a dedicated MinglePH Supabase project. See [setup](SUPABASE_SETUP.md), [schema](DATABASE_SCHEMA.md), and [security](SECURITY.md).
