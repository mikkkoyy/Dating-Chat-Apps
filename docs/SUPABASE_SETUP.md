# Supabase setup

The repository contains a prepared Supabase client and schema, but no project URL or keys. This change does not connect to a project.

## Create and configure a project

1. Create a dedicated Supabase project for MinglePH and choose its region intentionally.
2. Copy the project URL and **publishable** client key from the project's Connect/API settings. Never use a `service_role`/secret key in Flutter.
3. Keep real values in a local secret manager or untracked local config. `.env.example` lists names only; Flutter does not automatically read that file.
4. Configure the app at run/build time, for example:

   ```powershell
   flutter run `
     --dart-define=SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co `
     --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
   ```

   A local JSON file can also be passed using `--dart-define-from-file`; keep it out of Git. The URL must use HTTPS except for `localhost`/`127.0.0.1` development.

5. Install the Supabase CLI, authenticate, link only the intended MinglePH project, review `supabase/migrations/20261126000100_mingleph_dating_foundation.sql`, and apply with `supabase db push`. Do not push to another backend.
6. Ensure `public.messages` is included in the `supabase_realtime` publication if the project did not have that publication when the migration ran.
7. Keep `profile-photos` and `chat-media` private. Upload profile photos as `<authenticated-user-uuid>/<filename>` and conversation media as `<conversation-uuid>/<authenticated-user-uuid>/<filename>`. Generate short-lived signed URLs only after the corresponding database authorization check.
8. Configure Supabase Auth providers and redirect URLs only when the identity migration is ready. No dating screens call Supabase yet.

## Identity migration prerequisite

The current app authenticates through Appwrite. Appwrite IDs are strings; this schema references UUIDs from `auth.users`. The optional Supabase client does not copy credentials, link accounts, or reuse Appwrite sessions. Before enabling dating access, decide the identity source, design and test account linking/migration, and handle session expiry and account deletion. Never treat a client-supplied ID as proof of identity.

## Local commands

```powershell
flutter pub get
supabase start
supabase db reset
supabase test db
flutter analyze
dart run custom_lint
flutter test
```

No Flutter/Dart executable, local Supabase stack, or credentials were available during this phase, so these commands remain to be run in a configured environment.
