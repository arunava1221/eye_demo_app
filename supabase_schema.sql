-- Run this in Supabase SQL Editor.
-- It stores student profile details, iris analysis sessions, and image files.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  email text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.iris_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  left_eye_path text not null,
  right_eye_path text not null,
  note text,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.iris_sessions enable row level security;

drop policy if exists "Users can read own profile" on public.profiles;
create policy "Users can read own profile"
on public.profiles for select
using (auth.uid() = id);

drop policy if exists "Users can insert own profile" on public.profiles;
create policy "Users can insert own profile"
on public.profiles for insert
with check (auth.uid() = id);

drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can update own profile"
on public.profiles for update
using (auth.uid() = id)
with check (auth.uid() = id);

drop policy if exists "Users can read own sessions" on public.iris_sessions;
create policy "Users can read own sessions"
on public.iris_sessions for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own sessions" on public.iris_sessions;
create policy "Users can insert own sessions"
on public.iris_sessions for insert
with check (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('iris-images', 'iris-images', false)
on conflict (id) do nothing;

drop policy if exists "Users can upload own iris images" on storage.objects;
create policy "Users can upload own iris images"
on storage.objects for insert
with check (
  bucket_id = 'iris-images'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "Users can read own iris images" on storage.objects;
create policy "Users can read own iris images"
on storage.objects for select
using (
  bucket_id = 'iris-images'
  and auth.uid()::text = (storage.foldername(name))[1]
);

drop policy if exists "Users can update own iris images" on storage.objects;
create policy "Users can update own iris images"
on storage.objects for update
using (
  bucket_id = 'iris-images'
  and auth.uid()::text = (storage.foldername(name))[1]
);
