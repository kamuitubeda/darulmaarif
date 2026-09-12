-- ==============================================================================
-- DATABASE SCHEMA FOR STUDENTS & ATTENDANCE
-- ==============================================================================

-- 1. Tabel Students (Data Induk Santri/Siswa)
CREATE TABLE IF NOT EXISTS public.students (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nis VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(1) CHECK (gender IN ('L', 'P')) NOT NULL,
    level VARCHAR(10) CHECK (level IN ('MTs', 'MA')) NOT NULL,
    class_name VARCHAR(50) NOT NULL,
    dormitory VARCHAR(255), -- Kosongkan untuk siswa reguler/non-pondok
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Mengaktifkan RLS untuk tabel students
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;

-- Kebijakan RLS (Public = Read, Authenticated = All)
CREATE POLICY "Public profiles are viewable by everyone." 
ON public.students FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert/update/delete students" 
ON public.students FOR ALL USING (auth.role() = 'authenticated');

-- ==============================================================================

-- 2. Tabel Attendance Events (Master Event Absensi: Rutin/Insidental)
CREATE TABLE IF NOT EXISTS public.attendance_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Rutin', 'Insidental')) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.attendance_events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can view events" ON public.attendance_events FOR SELECT USING (true);
CREATE POLICY "Auth can manage events" ON public.attendance_events FOR ALL USING (auth.role() = 'authenticated');

-- ==============================================================================

-- 3. Tabel Attendance Sessions (Sesi spesifik dari sebuah event)
CREATE TABLE IF NOT EXISTS public.attendance_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id UUID REFERENCES public.attendance_events(id) ON DELETE CASCADE NOT NULL,
    date DATE NOT NULL,
    target_level VARCHAR(20) NOT NULL, -- 'MTs', 'MA', atau 'Semua'
    target_class VARCHAR(50), -- Opsional, jika spesifik 1 kelas
    created_by UUID REFERENCES auth.users(id), -- User admin yang membuat sesi
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.attendance_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can view sessions" ON public.attendance_sessions FOR SELECT USING (true);
CREATE POLICY "Auth can manage sessions" ON public.attendance_sessions FOR ALL USING (auth.role() = 'authenticated');

-- ==============================================================================

-- 4. Tabel Attendance Records (Rekam Kehadiran per Santri)
CREATE TABLE IF NOT EXISTS public.attendance_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID REFERENCES public.attendance_sessions(id) ON DELETE CASCADE NOT NULL,
    student_id UUID REFERENCES public.students(id) ON DELETE CASCADE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Hadir', 'Izin', 'Sakit', 'Alfa')) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(session_id, student_id) -- Mencegah duplikasi absen di sesi yang sama
);

ALTER TABLE public.attendance_records ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can view records" ON public.attendance_records FOR SELECT USING (true);
CREATE POLICY "Auth can manage records" ON public.attendance_records FOR ALL USING (auth.role() = 'authenticated');

-- ==============================================================================
-- DUMMY DATA UNTUK TEST (Opsional, hapus/comment jika tidak diperlukan)
-- ==============================================================================

-- Dummy Data Master Event
INSERT INTO public.attendance_events (id, name, type, description)
VALUES 
    ('e1111111-1111-1111-1111-111111111111', 'Sholat Dhuha', 'Rutin', 'Sholat Dhuha berjamaah setiap pagi'),
    ('e2222222-2222-2222-2222-222222222222', 'KBM (Kegiatan Belajar Mengajar)', 'Rutin', 'Absensi kehadiran di kelas harian'),
    ('e3333333-3333-3333-3333-333333333333', 'UTS Ganjil 2024', 'Insidental', 'Ujian Tengah Semester')
ON CONFLICT DO NOTHING;
