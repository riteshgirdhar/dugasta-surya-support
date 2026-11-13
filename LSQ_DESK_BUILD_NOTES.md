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
## 13 Nov 2026
- Added playbook **Lead Requirement** plus required **Types of lead required** checkboxes: Client Lead, Agent Lead, Agency Lead, Meta Paid Ads, Google Ads, Data / Pool, Other.
- Mailto subject now starts with `[LSQ Support]` so tickets still show in Surya's Gmail watch.
- Supabase RPCs (`lsq_ticket_create` / `lsq_ticket_status`) and table `lsq_support_tickets` are still not applied — tickets stay device-local until the reporter emails Surya. No `/admin.html` yet; queue is the Gmail inbox + Sheet `1hf682L5Guzoqbc9eR3vVgQus0iy0B-8gzzRdlDurP4Y` (mirror not wired).
