create extension if not exists pgcrypto;

create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  mobile text not null,
  email text not null,
  source text default 'vsl_index',
  created_at timestamptz default now()
);

create table if not exists public.checkout_orders (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid references public.leads(id) on delete set null,
  name text,
  mobile text,
  email text,
  amount integer not null,
  currency text default 'INR',
  razorpay_order_id text unique,
  razorpay_payment_id text,
  razorpay_signature text,
  status text default 'created',
  created_at timestamptz default now(),
  paid_at timestamptz
);

create table if not exists public.razorpay_webhook_events (
  id uuid primary key default gen_random_uuid(),
  event_id text unique,
  event_type text,
  payload jsonb,
  created_at timestamptz default now()
);

alter table public.leads enable row level security;
alter table public.checkout_orders enable row level security;
alter table public.razorpay_webhook_events enable row level security;
