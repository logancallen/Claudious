# Supabase — Platform-Specific Learnings
<!-- Auto-maintained. Keep under 200 lines. Archive stale entries at bottom. -->

## Active Learnings

### 2026-04-17 — Supabase — auth.*() functions need (select ...) wrap for perf

**Severity:** HIGH
**Context:** Every auth.uid() and auth.role() call in an RLS policy's USING or WITH CHECK clause is evaluated per-row by default. At scale this is a 10x+ overhead. Wrapping as `(select auth.FN())` makes it a scalar subquery that Postgres caches per-query.
**Learning:** Standard Supabase RLS performance pattern. Applies to auth.uid(), auth.role(), auth.jwt(), auth.email(), and any function call that's stable within a query. Advisor warning: `auth_rls_initplan`. Mechanical rewrite is safe (zero semantic change). Generate migrations from pg_policies introspection, not regex on SQL source — safer against comment lines and quoted strings.
**Applies to:** Any Supabase project with RLS policies calling auth.*() functions directly.

### 2026-04-17 — Supabase — Tighten auth.role()='authenticated' when platform is staff-only

**Severity:** HIGH
**Context:** ASF Graphics had 5 RLS SELECT policies predicated on `auth.role() = 'authenticated'` — any logged-in user could read. Platform has no non-staff authenticated users, so the loose predicate was defense gap without user-visible purpose. Migration 042 tightened to role-EXISTS predicate matching migration 040's graphics-staff pattern.
**Learning:** When a platform's user population is homogeneous (all staff, all customers, etc.), `auth.role() = 'authenticated'` is a false gate. Tighten to an EXISTS predicate against profiles.role. Zero user-visible change if every current user matches the tighter predicate. Defense in depth against future auth misconfiguration or service-role leaks.
**Applies to:** Any Supabase project with a homogeneous authenticated population. Not applicable when the platform serves genuine public-auth users alongside staff.
