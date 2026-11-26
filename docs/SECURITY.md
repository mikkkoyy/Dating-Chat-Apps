# Security review

The migration enables RLS on every application table, revokes broad `anon`/`authenticated` grants, then adds least-privilege grants. No secret key is embedded in Flutter configuration. Supabase is optional and Appwrite auth remains unchanged.

## Policy summary

- Profiles and profile photos are visible to signed-in users except across a block relationship; users write only their own rows. Exact birth date is stored in an own-only table.
- The interest catalogue is authenticated-read-only; users maintain only their own interests.
- Likes are visible only to sender/receiver, can be inserted only by sender, and reject blocked/self targets. Match rows are participant-readable but not client-insertable.
- Conversations, members, and messages are member-only. Message inserts require `sender_id = auth.uid()` and membership; blocks disable conversation/message access. Clients can update only `read_at` for messages they did not send.
- Users can read/manage only their own outgoing block list. A reported user cannot read a report; reports are reporter-readable and moderation status is not client-writable.
- `profile-photos` is private. Object paths are uploader-scoped; viewing another user's image is denied across block relationships.
- Match/conversation provisioning, moderation decisions, and wallet/payment changes require trusted server logic. Wallet operations are outside this migration.

## Review notes and remaining verification

RLS helpers are in the non-exposed `private` schema, use `SECURITY DEFINER` with an empty `search_path`, and are executable only by `authenticated`. They bind access checks to `auth.uid()` and schema-qualify referenced objects. The public timestamp trigger is not a privileged API operation and clients cannot execute it directly.

This is a migration-level review, not a live penetration test. Apply to a disposable Supabase project and test at least two authenticated users (owner, unrelated user, blocked user, member, and non-member) before production. Verify storage policy and Realtime RLS behavior on the deployed Supabase version; add rate limits and server-side abuse controls before enabling discovery/reporting.
