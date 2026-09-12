-- =============================================
-- DARUL MAARIF PESANTREN PORTAL - SUPABASE SCHEMA
-- Jalankan semua query ini di Supabase SQL Editor
-- =============================================

-- 1. AGENDAS
create table public.agendas (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  date date not null,
  time text,
  location text,
  category text default 'Umum',
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 2. PROGRAMS
create table public.programs (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  icon text default 'i-heroicons-academic-cap',
  color text default 'bg-green-500',
  levels text[] default array['MTs/SMP', 'MA/SMA'],
  sort_order int default 0,
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 3. ACHIEVEMENTS (PRESTASI)
create table public.achievements (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  name text not null,
  level text not null,
  year text not null,
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 4. GALLERY
create table public.gallery (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  image_url text not null,
  category text default 'Umum',
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 5. ANNOUNCEMENTS (PENGUMUMAN)
create table public.announcements (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  summary text,
  content text,
  category text default 'Pengumuman',
  image_url text,
  date date default current_date,
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 6. CONTACTS (single row)
create table public.contacts (
  id int primary key default 1,
  phone text,
  whatsapp text,
  email text,
  instagram text,
  address text,
  map_embed_url text,
  hours jsonb default '[]'::jsonb,
  updated_at timestamptz default now()
);
insert into public.contacts (id, phone, whatsapp, email, instagram, address)
values (1, '(022) 1234-567', '6281234567890', 'info@darulmaarif.sch.id', '@darulmaarif.official', 'Jl. Pendidikan No. 123, Sukamaju, Jawa Barat 40123')
on conflict (id) do nothing;

-- 7. SITE PROFILE (single row)
create table public.site_profile (
  id int primary key default 1,
  kyai_name text default 'K.H. Ahmad Dahlan, Lc., M.A.',
  kyai_title text default 'Mudirul Ma''had',
  kyai_photo_url text,
  history text,
  vision text,
  mission text,
  updated_at timestamptz default now()
);
insert into public.site_profile (id, kyai_name, history, vision, mission)
values (1,
  'K.H. Ahmad Dahlan, Lc., M.A.',
  'Pondok Pesantren Darul Maarif didirikan pada tahun 1990 dengan niat murni untuk mencetak generasi muslim yang tafaqquh fiddin (paham agama) serta memiliki kompetensi global.',
  'Menjadi pusat pendidikan Islam unggulan yang melahirkan generasi Rabbani.',
  'Menyelenggarakan pendidikan Islam komprehensif, berkualitas dan berdaya saing.'
) on conflict (id) do nothing;

-- =============================================
-- RLS (Row Level Security) — aktifkan jika perlu
-- Untuk publik read: enable RLS + policy select for anon
-- =============================================
alter table public.agendas enable row level security;
alter table public.programs enable row level security;
alter table public.achievements enable row level security;
alter table public.gallery enable row level security;
alter table public.announcements enable row level security;
alter table public.contacts enable row level security;
alter table public.site_profile enable row level security;

-- Izinkan semua orang membaca (public read)
create policy "Public read agendas" on public.agendas for select using (true);
create policy "Public read programs" on public.programs for select using (true);
create policy "Public read achievements" on public.achievements for select using (true);
create policy "Public read gallery" on public.gallery for select using (true);
create policy "Public read announcements" on public.announcements for select using (true);
create policy "Public read contacts" on public.contacts for select using (true);
create policy "Public read site_profile" on public.site_profile for select using (true);

-- Hanya authenticated user (admin) yang bisa insert/update/delete
create policy "Admin write agendas" on public.agendas for all using (auth.role() = 'authenticated');
create policy "Admin write programs" on public.programs for all using (auth.role() = 'authenticated');
create policy "Admin write achievements" on public.achievements for all using (auth.role() = 'authenticated');
create policy "Admin write gallery" on public.gallery for all using (auth.role() = 'authenticated');
create policy "Admin write announcements" on public.announcements for all using (auth.role() = 'authenticated');
create policy "Admin write contacts" on public.contacts for all using (auth.role() = 'authenticated');
create policy "Admin write site_profile" on public.site_profile for all using (auth.role() = 'authenticated');
