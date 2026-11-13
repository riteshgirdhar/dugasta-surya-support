-- LSQ Desk v1 — paste into Supabase SQL editor (project wnfmouleaanhloyoodvb). Safe: new objects only.
create sequence if not exists lsq_ticket_seq start 1;
create table if not exists lsq_support_tickets(
  id bigserial primary key,
  code text unique not null default ('LSQ-'||lpad(nextval('lsq_ticket_seq')::text,4,'0')),
  created_at timestamptz default now(), updated_at timestamptz default now(),
  status text not null default 'Open' check (status in ('Open','Investigating','Waiting on reporter','Fixed','Closed')),
  severity text default 'P3', playbook text, reporter_name text, reporter_email text,
  team text, lead_ref text, summary text, expected text, tried text, screenshot_url text,
  surya_note text, meta jsonb default '{}'::jsonb);
alter table lsq_support_tickets enable row level security;  -- no direct anon access; RPCs only
create or replace function lsq_ticket_create(p jsonb) returns jsonb language plpgsql security definer set search_path=public as $$
declare r lsq_support_tickets;
begin
  if coalesce(p->>'reporter_email','') !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$' or length(coalesce(p->>'summary',''))<10 then
    raise exception 'invalid ticket'; end if;
  insert into lsq_support_tickets(severity,playbook,reporter_name,reporter_email,team,lead_ref,summary,expected,tried,screenshot_url,meta)
  values (left(p->>'severity',4),left(p->>'playbook',40),left(p->>'reporter_name',120),left(p->>'reporter_email',200),left(p->>'team',60),
          left(p->>'lead_ref',200),left(p->>'summary',4000),left(p->>'expected',2000),left(p->>'tried',2000),left(p->>'screenshot_url',500),
          jsonb_build_object('ua',left(p->>'ua',300),'lead_types',nullif(left(coalesce(p->>'lead_types',''),300),''))) returning * into r;
  return jsonb_build_object('code',r.code,'status',r.status,'created_at',r.created_at);
end $$;
create or replace function lsq_ticket_status(p_code text) returns jsonb language sql security definer set search_path=public as $$
  select jsonb_build_object('code',code,'status',status,'severity',severity,'playbook',playbook,'created_at',created_at,
    'updated_at',updated_at,'summary',left(summary,280),'surya_note',surya_note,'lead_types',meta->>'lead_types')
  from lsq_support_tickets where code=upper(p_code) $$;
revoke all on function lsq_ticket_create(jsonb), lsq_ticket_status(text) from public;
grant execute on function lsq_ticket_create(jsonb), lsq_ticket_status(text) to anon, authenticated;
