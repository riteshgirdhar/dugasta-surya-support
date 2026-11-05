# LSQ Desk build notes — overnight 6 Nov 2026

## Status
- UI (Console Dark Desk): local ready — playbooks, RCA, status page, booking.
- Backend: waiting on Supabase connector auth to apply `supabase_lsq_desk.sql` (RPCs `lsq_ticket_create` / `lsq_ticket_status`).
- Until then: createTicket falls back to device-only + mailto (honestly labelled).
- `tickets.json` is empty `{}` — do not store PII on GH Pages.

## After Supabase allow
1. Apply supabase_lsq_desk.sql
2. Smoke-test create + status
3. Deploy index.html, style.css, desk.js, t.html, availability.json, tickets.json
4. Wire SMTP email in Edge Function (follow-up)
