# Foundation evaluation

Reviewed on 2026-11-26. GitHub repository pages and documentation were inspected; the two local candidate directories were also inspected. GitHub exposed the commit-count/activity signals below but did not expose an exact latest-commit date in the page snapshot, so no exact update dates are inferred. The destination workspace had no root Git repository before this project was created. Floot source export remains unavailable behind its paid upgrade gate.

| Candidate | Stack and available features | Backend / realtime | License and maintenance evidence | Decision |
|---|---|---|---|---|
| [AOSSIE-Org/Resonate](https://github.com/AOSSIE-Org/Resonate) | Flutter; rooms, scheduled rooms, in-room chat/polls, stories, pair chat, friends, voice calls, status and push integration. The local copy has 851 files and 193 tests. | Appwrite auth/database/storage/functions and messaging; LiveKit audio; optional Meilisearch. | Explicit GPL-3.0; GitHub page showed 1,598 commits; local docs include security, onboarding, and contribution guidance. Exact latest commit date was not available in the inspected page. | **Selected.** Best complete Flutter voice-social foundation, already present locally. MinglePH must stay GPL-3.0 unless a separate license grant is obtained. No Resonate backend credentials or production data are reused. |
| [ibhanu/aura](https://github.com/ibhanu/aura) | Flutter dating UI, onboarding, profile editing, discovery/swipes, likes and chat list. | Flutter + Supabase is proposed; its README lists real Supabase integration and real-time chat as areas to contribute, so these are not complete services. | MIT; GitHub page showed one commit and one star; exact latest commit date not available in the inspected page. | Stronger dating UI overlap but too early and missing real backend/chat. |
| [zypherlabs-bit/Weekend](https://github.com/zypherlabs-bit/Weekend) | Flutter/Kotlin Android dating and social discovery; nearby people, matching and chat. | Supabase/Postgres/PostGIS described by its public repo; no LiveKit voice-room base identified. | MIT; GitHub page showed 148 commits and 4 stars; exact latest commit date not available in the inspected page. | Useful dating feature reference, but not the cross-platform voice/chat foundation needed here. |
| [Asresh/nook](https://github.com/Asresh/nook) | Flutter web/iOS/Android voice-room MVP with mute and speaking indicators. | LiveKit and optional Supabase-backed room list/token edge function. | The public README describes the app; latest commit date was not available in the inspected page. The repository has no `LICENSE` file (the direct `LICENSE` path returned 404). | Not reused because its code has no explicit reuse license. |
| Local `Hayaa-main` | Flutter UI/source describes audio rooms, chat, stories, gifts and a wallet. | Firebase, Supabase and a ZEGOCLOUD package are mixed in its pubspec. | No license file was present, and it contains `android/app/google-services.json`. | Not reused or copied: no reuse license and it contains service configuration that should not be published. |

## Selected architecture

Keep the existing Flutter/Riverpod client architecture and its Appwrite + LiveKit integration as one coherent base. Implement dating profiles, discovery/matching, messaging, moments, moderation, and wallet transactions as MinglePH modules with authorization and money-related state enforced server-side in Appwrite functions. Do not add Supabase/PostgreSQL alongside Appwrite without a deliberate migration plan. Replace Meilisearch's upstream example key default with an empty value and leave search disabled until configured.

## Source and license notices

- Upstream: [AOSSIE-Org/Resonate](https://github.com/AOSSIE-Org/Resonate), branch `master` at review time.
- License: GNU GPL v3, retained in [`LICENSE`](LICENSE). This copied and adapted client is therefore distributed under GPL-3.0.
- The original README and upstream privacy policy are retained as `UPSTREAM_README.md` and `UPSTREAM_PRIVACY-POLICY.md` for attribution and historical context. The upstream privacy policy is **not** MinglePH's privacy policy.
- Existing upstream assets, localization, tests, and license notices are retained. MinglePH needs its own icon, privacy terms, moderation policy, and production service configuration before release.
