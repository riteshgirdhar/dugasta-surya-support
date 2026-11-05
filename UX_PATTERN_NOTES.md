# LSQ Desk — UX Pattern Notes (aligned to Option E)
**Product:** LSQ Desk (Option E in `BEST_SOLUTION_BRIEF.md`)  
**Audience:** skeptical ops lead  
**Contract:** guided playbooks → structured RCA → **real Supabase ticket + ID + status** → optional booking → status page  
**Do not contradict:** ticket IDs (`LSQ-####`), status lifecycle, 6 playbooks, Sheet mirror, free/busy booking linked to ticket.

**Visual system:** **Console Dark** (defined in BEST_SOLUTION_BRIEF §7 — Linear / Vercel / Raycast lineage). This file expands UX patterns only; tokens below match the brief exactly.

---

## 1. Why mailto-chat feels unfinished

Current GH Pages page is a messenger shell that ends in `mailto:` + Calendar template. Ops reads that as theater:

| Promise | Reality | Ops rejection |
|---|---|---|
| Chat / Assist | Fake linear Q&A in bubbles | No agent, no persistence |
| “Email RCA” | Opens mail client | No ticket, no queue, no metrics |
| Screenshot = Drive URL | No upload / paste | Evidence missing → Slack ping |
| Booking | Calendar template tab | Slot not held; orphan invites |
| Status pill | Cosmetic | No SLA, no ownership |
| No ticket ID | Close tab, zero receipt | “Did it land?” culture |

**One-liner:** Pretty chat that dumps into email is a contact form with worse UX than Zendesk. Option E replaces it with the Vercel / Intercom Tickets / Pylon contract: **intake → record → ID → status → optional human**.

---

## 2. Patterns from research (mapped to Option E)

### Intercom Messenger
- **Spaces:** Home / Messages / **Tickets** — tickets are first-class, not buried in chat.
- Tickets space appears only after a customer has submitted ≥1 ticket (never an empty Tickets void).
- Recent tickets card (max 3) on Home when status changes or a ticket is created.
- Badge on Tickets space for create + **status update** (not every message).
- Spotlight Smart Suggestions: 3 rotating chips in composer — chip-led start.
- Dark theme supported; brand color + semantic system.
- **Borrow:** chip home, ticket receipt + status badges, recent-ticket affordance after first submit.  
- **Reject:** cute Fin mascot / illustrated Intercom marketing chrome.

### Plain.com
- Structured custom / contact forms: dropdown + text + textarea; on submit → assignee / label / **priority** / thread fields.
- Headless portal: your UI, their API — threads with timeline of submitted values.
- Design DNA: Linear restraint, single accent, no cute support illustrations (marketing is light; product can be dark).
- **Borrow:** structured intake that arrives ready to action; auto severity/priority from impact; timeline entry of form values.  
- **Align:** RCA form is a form card (not endless bubbles), with playbook answers pre-filling fields.

### Pylon Customer Portal
- Issues list with status / filters; ticket detail with status, last message, ownership.
- Ticket forms from portal; new ticket immediately visible.
- Real-time visibility cuts “any updates?” follow-ups.
- Customer-facing status labels (map internal → external).
- **Borrow:** `/t/:code` status page; status honesty; reopen / add-info.  
- **Phase 2 note:** WhatsApp/Slack as a channel into the **same** Supabase ticket (brief Option D) — do not fork UX.

### Linear / Vercel dark UI
- Near-black canvas, hairline borders, Inter, dense calm chrome, issue IDs (`LIN-123` / Vercel case numbers).
- Vercel Support Center: AI/chat → editable case form → **Submit Case → ticket number + case list + status + attachments**.
- Linear Customer Requests / Asks: structured capture, triage from context, statuses.
- **Borrow:** `LSQ-0142` mono ID, keyboard-fast chips, surface ladder, scarce accent (`#5B8CFF`), status timeline.

### Cross-cutting UI details to ship
| Pattern | Implementation in LSQ Desk |
|---|---|
| Layout density | Single column ≤720px mobile-first; desktop max ~800px; sticky bottom primary CTA |
| Empty state | Home: “What’s broken in LSQ?” + **6 playbook chips** + Something else + SLA strip |
| Suggestion chips | Issue chips on Home; hide after pick; playbook yes/no as chips |
| Progress | Playbook stepper (2–4 steps) → RCA form progress → ticket lifecycle timeline |
| Severity | Impact chips (just me / my team / everyone) → auto P1/P2/P3 |
| Screenshot drop zone | Paste + drag/drop + camera; thumbnails; size/type validation |
| Ticket ID feedback | Confirmation card: copyable `LSQ-####`, SLA, status link, email sent |
| Dedupe | “Same lead 2h ago — LSQ-0139. Add yourself?” before create |
| Booking | Only after ticket exists; slots show IST + Dubai; event linked to ticket |

---

## 3. Ten non-negotiable UX features

1. **Real Supabase ticket** — Edge Fn `create-ticket`; never mailto as primary path.
2. **Copyable ticket ID receipt** — `LSQ-####` on-screen + email to reporter + Surya; Sheet mirror.
3. **Playbook-first deflection** — 6 JSON playbooks with Fixed it / Still broken before RCA.
4. **Home suggestion chips** — 6 issue chips + Something else; SLA strip truthful.
5. **Visible progress** — playbook stepper → RCA steps → status timeline (New → … → Fixed).
6. **Screenshot paste/drop zone** — Ctrl+V / drag / camera; storage URLs on ticket.
7. **Severity from impact** — just me / my team / everyone → P3 / P2 / P1; severity pill on receipt.
8. **Duplicate check** — same lead / recent ticket → join existing instead of new.
9. **Optional booking only after ticket** — free/busy slots; Calendar event **linked to ticket code**.
10. **Status page `/t/:code`** — lifecycle + root cause / fix notes; email on every status change; reopen / add-info.

---

## 4. Recommended IA (matches Option E wireflow ≤90s)

```
Home
  • “What’s broken in LSQ?”
  • 6 playbook chips + Something else
  • Status strip: Surya online · avg first reply …
        ↓
Playbook (self-serve)
  • 2–4 check steps (yes/no)
  • Fixed it → log deflection → done
  • Still broken → continue
        ↓
RCA form (pre-filled from playbook)
  • Name + team (localStorage)
  • Lead ID/phone (multi), when, impact → severity
  • Expected vs actual
  • Screenshot drop zone
  • Duplicate check gate
        ↓
Ticket created (confirmation)
  • LSQ-#### + copy
  • SLA promise + email confirmation
  • Link to status page
        ↓
Optional book 15 min
  • Next free slots (IST + Dubai columns)
  • Event linked to ticket
        ↓
Status page /t/:code
  • Timeline: New → Triaged → Investigating → Waiting → Fixed → Closed / Duplicate
  • Root cause & fix notes (Surya)
  • Add info / reopen
```

**Aligns with brief lifecycle:** New → Triaged → Investigating → Waiting on reporter → Fixed → Closed (48h) / Duplicate.

---

## 5. Component list (Console Dark)

**Shell:** page canvas, optional home-only top gradient glow, surface cards, hairline borders  
**Header:** LSQ Desk wordmark, SLA / availability strip  
**Home:** issue chip grid (6 + other), optional `/` command bar to search playbooks  
**Playbook:** stepper, yes/no chips, Fixed it / Still broken  
**RCA:** form card, inline validation, impact → severity pill, multi lead-ID chips, screenshot dropzone + thumbnails  
**Dedupe:** alert card with existing ticket code + Add yourself  
**Confirmation:** mono ticket code, copy button, SLA line, status link, toast  
**Booking:** slot picker (two TZ columns), confirm linked to ticket  
**Status:** timeline, status badge, root-cause / fix notes, add-info composer  
**System:** toast, skeletons, sticky mobile CTA (44px targets)

---

## 6. Anti-patterns (ops will reject)

| Avoid | Why |
|---|---|
| Fake 3D mascot / Agency character hero | Toys, not a CRM desk |
| Grok / external AI redirect | Loses context + brand |
| Classic form-only wall | High abandon; no deflection |
| Apple light / iOS clone | Wrong family for B2B LSQ ops |
| Mailto as Send | No system of record |
| Calendar template as “booked” | Slot not reserved |
| Endless bubble interrogation | Use hybrid: chips + form card |
| Competing ambient orbs | One subtle home glow max (brief) |
| Free-text “urgency” | Use impact → P1/P2/P3 |
| Screenshot = paste Drive link only | Real upload/paste required |
| Booking before ticket | Breaks Option E order |
| Lime-as-primary CTA (old “Noir Signal” draft) | **Superseded** — Console Dark uses cobalt `#5B8CFF` |

---

## 7. Visual system — **Console Dark** (canonical)

Source of truth: `BEST_SOLUTION_BRIEF.md` §7. Do not invent a second system.

### Name
**Console Dark**

### Hex palette (exact)
| Token | Hex | Use |
|---|---|---|
| `bg` | `#0B0D12` | page |
| `surface` | `#12151C` | cards |
| `surface-2` | `#1A1E27` | inputs, hover |
| `border` | `#262B36` | 1px hairlines |
| `text` | `#E7E9EE` | primary |
| `text-muted` | `#8B93A7` | secondary |
| `accent` | `#5B8CFF` | primary buttons, focus ring |
| `success` | `#3FCF8E` | Fixed |
| `warning` | `#F5B544` | P2 / waiting |
| `danger` | `#F2555A` | P1 |

### Type
- **Inter** UI: 14/20 base, 24/32 titles, weight 600 headings  
- **JetBrains Mono** for ticket codes & lead IDs  
- Radius: **10px** cards / **8px** inputs; **4-pt** spacing grid  
- One subtle top gradient glow **only on home**

### Motion rules
1. 150–200ms standard; ease `cubic-bezier(0.2, 0.8, 0.2, 1)`  
2. Chip / step enter: fade + 6px rise; stagger ≤40ms  
3. No bounce, no mascot loops; honor `prefers-reduced-motion`  
4. Progress bars determinate for upload; indeterminate only while Edge Fn pending  
5. Focus: 2px accent ring (`#5B8CFF`); never strip outlines  
6. Home glow static or ≤0.2 opacity drift; nowhere else

### Accent scarcity
Cobalt for primary CTA + focus. Success/warning/danger only for status & severity. No second brand color fight.

---

## 8. Ops-lead pitch (aligned)

> Ship **LSQ Desk (Option E)** in **Console Dark**: Home chips → 6 playbooks → RCA with paste screenshots → **Supabase ticket `LSQ-####`** + Sheet + email → optional 15-min only after the ticket exists → `/t/:code` status. That is Intercom Tickets + Vercel Support Center + Pylon visibility on our stack. Mailto chat is retired.

---

## 9. Source map

- Intercom Messenger Tickets space + Spotlight Smart Suggestions + dark theme  
- Plain structured forms / headless portal / Linear-restraint support UX  
- Pylon portal Issues + status visibility + ticket forms  
- Linear issue IDs/states + Customer Requests / Asks  
- Vercel Support Center (case form → number → status → attachments)  
- Raycast density (command bar `/`, near-black ladder) — borrowed sparingly  
- Canonical product decision: `BEST_SOLUTION_BRIEF.md` Option E + Console Dark

---

*Aligned overnight UX track. Supersedes earlier “Noir Signal” naming — use **Console Dark** only.*
