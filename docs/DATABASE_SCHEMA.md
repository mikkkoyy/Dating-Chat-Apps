# Dating database schema

Migration: `supabase/migrations/20261126000100_mingleph_dating_foundation.sql`.

| Table | Purpose and constraints |
|---|---|
| `profiles` | Discoverable card fields; UUID identity FK; case-insensitive unique username; bounded text. `location` is city/region only. |
| `profile_private` | Own-only date of birth with adult-age and sanity checks; separated to keep exact DOB out of discovery queries. |
| `profile_photos` | Private object paths and display ordering, owner-scoped and unique. |
| `interests`, `user_interests` | Shared catalogue and per-user join rows. |
| `likes` | Unique directed pair, no self-like; a client can create its own like but cannot assert a match. |
| `matches` | Canonically sorted UUID pair; client-readable by participants, never client-writable. |
| `conversations`, `conversation_members` | Member-scoped private conversations; direct creation is reserved for trusted server code. |
| `messages` | Conversation/sender FKs, payload constraints, member access and read-receipt-only updates. |
| `user_blocks` | Directed block relationship, no self-block, owner-managed. |
| `user_reports` | Reporter-only read access; client can submit but cannot change moderation status. |

All user references point to Supabase Auth UUIDs. Timestamps use UTC `timestamptz`; selected `updated_at` fields are trigger-maintained. Indexes cover usernames, photo order, reverse interest lookup, received likes, match membership, conversation membership, message chronology, and report review queues.

The private `profile-photos` and `chat-media` storage buckets have object policies. Profile paths are `<user-uuid>/<filename>`; chat paths are `<conversation-uuid>/<sender-uuid>/<filename>` and require active, unblocked membership.

The requested `birth_date` and `photo_url` fields are adapted for privacy: exact birth date is in the self-only `profile_private` table, and photos store private object paths rather than permanent public URLs. Signed URLs should be short-lived. No sample users or interest catalogue entries are seeded.

Matches and conversation membership have no authenticated write grants or write policies. A trusted, atomic Edge Function/server operation must verify reciprocal likes, eligibility, and block status before creating them. Never grant the mobile client a service-role key.
