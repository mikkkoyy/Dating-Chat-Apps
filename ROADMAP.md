# MinglePH implementation status

This roadmap separates code inherited from the voice-social foundation from MinglePH-specific work. A screen or a repository interface alone does not count as a working backend feature.

## Foundation in this repository

- [x] Flutter client for Android/iOS and inherited web target.
- [x] Appwrite client integration for upstream identity, social data and functions.
- [x] LiveKit client integration for upstream audio rooms and calls.
- [x] Existing friend/pair chat, room chat, stories, activity status and notification modules.
- [x] Existing upstream test suite retained (193 tests).
- [x] MinglePH package/application identifiers and development-only service defaults.
- [x] License and candidate evaluation recorded.
- [x] Phase 1 architecture audit and optional Supabase dating-data foundation prepared; see `docs/` and `supabase/`.

## MinglePH work still required

1. **Backend and identity:** provision the dedicated Supabase project, apply/review the dating schema and RLS, configure private storage, and design an explicit Appwrite-to-Supabase identity transition. Preserve inherited Appwrite/LiveKit features until migration is proven; never reuse upstream credentials.
2. **Dating profile:** add age-appropriate profile fields, photo gallery and interests; validate uploads; allow edit, block, and report actions.
3. **Discovery and matching:** add authorized preferences/filters, pass/like records, unique mutual-match creation, and abuse/rate controls in server functions.
4. **Private messaging:** bind one-to-one conversation access to a mutual match or explicit policy; add real-time delivery, media validation, read state, typing state, and blocking/report enforcement.
5. **Moments/feed:** add posts, comments, follows, moderation and notification behavior with privacy-aware query rules.
6. **Voice rooms:** provision an isolated LiveKit deployment, short-lived server-issued tokens, roles, capacity checks, block/report integration, and operational monitoring.
7. **Wallet and gifts:** design a server-authoritative ledger with idempotent transactions. Add purchase validation through a selected payment provider only after credentials and business rules are supplied. Never mutate balances from the client.
8. **Administration:** add restricted moderator roles, report queues, audit records, and moderation actions.
9. **Release readiness:** replace inherited artwork, links, privacy/legal docs, app-store identifiers, and review account/service configuration; run privacy, security, accessibility, and age-safety reviews.

## Verification status

No Flutter or Dart executable is installed in the current Windows environment, so dependency resolution, code generation, analysis, test execution, and Android/iOS builds could not be run here. Backend services and credentials are also not configured. Do not describe the inherited features as verified against a MinglePH backend until those steps are completed.
