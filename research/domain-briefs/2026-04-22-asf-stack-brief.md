# ASF Stack Brief — 2026-04-22

Weekly Evidence Loop research on the React + FastAPI + Supabase + Netlify stack backing asf-graphics-app.

## 1. React + FastAPI + Supabase production patterns — 2026

**What's current:**
- Production patterns for FastAPI converge on: structured project layout, centralized error handling (custom exception handlers + ProblemDetails-style responses), request/response logging middleware, JWT validation at every protected route, and containerized deploys with healthchecks.
- Supabase + FastAPI combo remains a dominant pattern: Supabase as managed Postgres + Auth + Storage, FastAPI as the business-logic/orchestration layer. The emerging best practice is using **Supabase for row-level auth and simple CRUD via PostgREST**, and **FastAPI for anything involving multi-table transactions, side effects, or third-party calls**.
- Reliability patterns gaining traction: circuit breakers around Supabase calls, idempotency keys on every write endpoint, graceful degradation (read-replica failover, cached last-known-good on 5xx).

**Common failure modes observed in 2026:**
- Over-fetching via Supabase client SDK (select('*') everywhere) — cited in multiple production postmortems. Best practice is explicit column lists on every `.select()`.
- JWT validation skipped on FastAPI endpoints because "RLS handles it" — but FastAPI bypasses RLS when using the service role key. Every protected route must still verify the user JWT.
- Realtime subscription leaks (subscriptions not unsubscribed on React unmount) — memory/connection growth over time.

**Relevance to ASF:**
- ASF already uses FastAPI for transactional work (invoices, quote generation). Verify every protected route validates JWT independently, not relying on RLS when service role is in use.
- Audit the React client for `select('*')` calls — opportunity for perf win and attack-surface reduction.

**Sources:**
- [How to Build Production-Ready FastAPI Applications (oneuptime.com, 2026-01-26)](https://oneuptime.com/blog/post/2026-01-26-fastapi-production-ready/view)
- [Building a Supabase and FastAPI Project (Medium)](https://medium.com/@abhik12295/building-a-supabase-and-fastapi-project-a-modern-backend-stack-52030ca54ddf)
- [Supabase reliability patterns skill (mcp.directory)](https://mcp.directory/skills/supabase-reliability-patterns)

---

## 2. Supabase RLS best practices and 2026 changes

**Headline updates:**
- Supabase published expanded official docs on RLS performance practices, codifying what the community discovered in 2024-2025.
- The major performance wins all trace to two patterns:
  1. **Index every column referenced by a policy** — not just PKs. Missing indexes on `user_id`-style columns can cause 100×+ slowdowns on large tables.
  2. **Wrap function calls inside `(SELECT ...)` subqueries** to trigger PostgreSQL initPlan caching. Example: `team_id = ANY(ARRAY(SELECT user_teams()))` instead of `team_id = ANY(user_teams())`. This hoists the function call out of the per-row evaluation loop.
- Growing 2026 pattern: using **JWT claims** (auth.jwt()->>'role', custom claims) directly in policies instead of joining to a profiles table. Simpler policies, faster execution — but requires discipline on claim refresh.
- Hybrid architectures are now mainstream: RLS for data isolation at the row level, FastAPI for complex authorization logic (e.g., "editor can update unless invoice is locked"). Don't try to express everything in RLS.

**Gotchas / performance traps:**
- RLS impact is worst on queries that scan every row (LIMIT/OFFSET/ORDER BY). Policies fire per-row. Indexing the filter columns is mandatory, not optional.
- Explicit filters in the query that duplicate the policy condition help PostgreSQL choose better plans. Don't assume RLS alone will optimize.

**Relevance to ASF:**
- Verify every column used in ASF policies has an index. Likely candidates: `user_id`, `organization_id`, `project_id`.
- Audit policies for bare function calls; rewrite with `(SELECT ...)` wrapper pattern.
- **Possible contradiction with current ASF learnings:** if any learning says "RLS alone is enough for authorization," that should be qualified — RLS handles isolation, not fine-grained business authz.

**Sources:**
- [Supabase Docs: RLS Performance and Best Practices](https://supabase.com/docs/guides/troubleshooting/rls-performance-and-best-practices-Z5Jjwv)
- [Supabase RLS Best Practices: Production Patterns (Makerkit)](https://makerkit.dev/blog/tutorials/supabase-rls-best-practices)
- [Supabase Features: Row Level Security](https://supabase.com/features/row-level-security)
- [GitHub Discussion #14576 — RLS Performance](https://github.com/orgs/supabase/discussions/14576)

---

## 3. PostgREST behavior changes / gotchas

**Breaking / notable changes:**
- PostgREST dropped support for **PostgreSQL 12 (EOL)**. Supabase projects on very old Postgres versions will be forced to upgrade.
- PostgREST moved to MAJOR.PATCH two-part versioning from v14.0 onward. Only even MAJOR versions are releases; odd-numbered MAJORs are dev-only. Don't pin to odd versions.

**Active 2026 gotcha — HIGH impact for ASF:**
- **PGRST204 schema cache bug** (tracked at supabase/supabase#42183): PostgREST schema cache does not reliably refresh when new columns are added to existing tables or when new tables are created. Documented refresh methods (`NOTIFY pgrst, 'reload schema'`) are reported not to clear the stale state in affected deployments. Symptom: PGRST204 errors referencing columns that exist in the database.
- **This maps directly to the 2026-04-14 CRITICAL alert** (migrations 026-028 broke employee permissions, root cause unidentified). Worth investigating whether the stale schema cache is a contributing factor.
- Workarounds reported by the community: full project restart/pause-unpause, explicit `SELECT pg_notify('pgrst','reload schema')` followed by a brief wait, and in worst cases force-refreshing by toggling a trivial schema change.

**Relevance to ASF:**
- Prioritize testing the schema cache reload path in the next ASF migration session. If PGRST204 reproduces, add it to the migration runbook and the proposal queue.

**Sources:**
- [PostgREST Releases (GitHub)](https://github.com/PostgREST/postgrest/releases)
- [PostgREST CHANGELOG](https://github.com/PostgREST/postgrest/blob/main/CHANGELOG.md)
- [supabase/supabase#42183 — PGRST204 schema cache](https://github.com/supabase/supabase/issues/42183)

---

## 4. Netlify deployment patterns for React + FastAPI

**Headline 2026 update:**
- **Netlify Functions now ship with native Python runtime** (matured in 2025, standard in 2026). FastAPI can be deployed directly as Netlify Functions without a Docker intermediary. Each file under `netlify/functions/` becomes a separate serverless endpoint backed by AWS Lambda under the hood.
- **Durable Functions (2026)** — new Netlify primitive for long-running tasks that would otherwise hit the 10s/30s Lambda timeout. Chunks long tasks into steps with persistent state between steps. Relevant for ASF if any report-generation or bulk-invoice operation runs close to the timeout.

**Deployment pattern (current best practice):**
- React app deploys as static assets to Netlify CDN.
- FastAPI deploys as Netlify Functions (Python runtime) under `netlify/functions/`.
- Netlify rewrites `/api/*` → the function handler. Single deploy, single domain, no CORS.
- Environment variables managed in Netlify UI or via `netlify.toml` with secrets in Netlify's encrypted env.

**Gotchas:**
- Cold starts are still real; first request after idle can be 1-3s on Python runtime.
- Lambda sandbox restrictions apply (no persistent filesystem writes outside `/tmp`, 512MB by default, 15-min hard ceiling even with Durable Functions).
- Some Python libraries with C extensions still need the container build path — pure-Python FastAPI + Supabase client is fine on the native runtime.

**Relevance to ASF:**
- If ASF is still using a non-Netlify path for the FastAPI backend (e.g., separate Railway/Fly.io deploy), consolidating to Netlify Functions is now a real option. Worth a follow-up evaluation once the CRITICAL migration issue is resolved.
- Durable Functions worth knowing if any ASF flow (PDF generation, bulk import) approaches the timeout.

**Sources:**
- [Netlify Functions overview](https://www.netlify.com/platform/core/functions/)
- [Netlify Functions Python: Serverless Mobile Backends 2026](https://johal.in/netlify-functions-python-serverless-mobile-backends-2026/)
- [Netlify Docs: Functions overview](https://docs.netlify.com/build/functions/overview/)

---

## Summary — findings that may contradict current ASF learnings

1. **PGRST204 schema cache bug** is a plausible contributing factor to the 2026-04-14 CRITICAL alert (migrations 026-028 broke employee permissions). If ASF learnings currently attribute the failure to a policy or migration bug without mentioning schema cache staleness, that's a gap. → **Flagging as HIGH for alerts.md and writing a proposal.**
2. **RLS policy function-wrapping pattern** (wrap in `(SELECT ...)` for initPlan caching) — verify ASF policies use this. If not, easy perf win.
3. **Netlify native Python runtime** — if ASF learnings still describe FastAPI deploy as requiring a separate container host, that's outdated. Consolidation to Netlify Functions is now viable.

No other contradictions with current learnings surfaced in this pass.
