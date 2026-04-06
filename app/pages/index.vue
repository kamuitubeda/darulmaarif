<template>
  <div class="pb-4">
    <!-- 1. Hero slider for important announcements -->
    <HomeHeroSlider :slides="mockSlides" />

    <!-- 2. Quick menu grid (8 items) -->
    <HomeQuickMenu />

    <!-- 3. Weekly agenda preview -->
    <HomeAgendaPreview :items="mockAgendas" />

    <!-- 4. Latest information / announcements preview -->
    <HomeAnnouncementPreview />

    <!-- 5. Latest gallery preview -->
    <HomeGalleryPreview :items="mockGalleries" />

    <!-- 6. Call-to-action section for PSB registration -->
    <HomePSBCallToAction />
  </div>
</template>

<script setup>
// Using auto-imported components from ~/components/home/*
definePageMeta({
  title: 'Beranda - Darul Maarif'
})

// Mock data representing CMS input
const mockSlides = [
  {
    title: 'Penerimaan Santri Baru Tahun Ajaran 2024/2025 Telah Dibuka',
    description: 'Mari bergabung bersama kami membentuk generasi Qur\'ani yang berakhlak mulia. Pendaftaran gelombang pertama dibuka hingga akhir bulan.',
    image: 'https://picsum.photos/seed/pesantren1/600/300',
    link: '/psb',
    order: 1,
    is_active: true
  },
  {
    title: 'Kajian Rutin Ahad Pagi Bersama K.H. Ahmad Dahlan',
    description: 'Terbuka untuk umum, diselenggarakan setiap hari Ahad pagi bertempat di Masjid Raya Darul Maarif.',
    image: 'https://picsum.photos/seed/kajian/600/300',
    link: '/agenda',
    order: 2,
    is_active: true
  },
  {
    title: 'Peresmian Gedung Asrama Putri Darul Maarif',
    description: 'Alhamdulillah, acara peresmian berlangsung khidmat dengan dihadiri oleh berbagai tokoh masyarakat.',
    image: 'https://picsum.photos/seed/gedung/600/300',
    link: '/pengumuman',
    order: 3,
    is_active: true
  },
  {
    title: 'Draft Slide',
    description: 'Bukan untuk dipublish.',
    image: 'https://picsum.photos/seed/draft/600/300',
    link: '#',
    order: 4,
    is_active: false // this should not appear
  }
]

// Mock data for weekly agendas
const mockAgendas = [
  {
    id: 1,
    title: 'Kajian Tafsir Jalalain Rutin Malam Jumat',
    description: 'Kajian rutin mingguan terbuka untuk santri dan masyarakat sekitar',
    date_day: '14',
    date_month: 'Agu',
    time: '19:30 - Selesai',
    location: 'Masjid Raya Darul Maarif',
    link: '/agenda/1',
    is_active: true
  },
  {
    id: 2,
    title: 'Kerja Bakti Akbar Persiapan Tahun Ajaran Baru',
    description: 'Wajib diikuti oleh seluruh santri mukim kelas 2 dan 3 asrama.',
    date_day: '16',
    date_month: 'Agu',
    time: '07:00 - 10:00',
    location: 'Lingkungan Pesantren',
    link: '/agenda/2',
    is_active: true
  },
  {
    id: 3,
    title: 'Pertemuan Rutin Wali Santri Angkatan 2023',
    description: 'Penyampaian laporan perkembangan akademik dan tahfidz kwartal pertama.',
    date_day: '18',
    date_month: 'Agu',
    time: '09:00 - 11:30',
    location: 'Aula Utama Lt.2',
    link: '/agenda/3',
    is_active: true
  }
]

// Mock data for CMS Galleries
const mockGalleries = [
  {
    id: 1,
    title: 'Kegiatan Ekstrakurikuler Memanah Santri Putra',
    image: 'https://picsum.photos/seed/galeri1/400/300',
    is_active: true
  },
  {
    id: 2,
    title: 'Kunjungan Studi Banding ke Universitas Al-Azhar',
    image: 'https://picsum.photos/seed/galeri2/400/300',
    is_active: true
  },
  {
    id: 3,
    title: 'Suasana Hafalan Quran Ba\'da Subuh',
    image: 'https://picsum.photos/seed/galeri3/400/300',
    is_active: true
  },
  {
    id: 4,
    title: 'Panen Raya Kebun Hidroponik Pesantren',
    image: 'https://picsum.photos/seed/galeri4/400/300',
    is_active: true
  }
]
</script>
