<template>
  <div class="pb-10">

    <!-- Profile Header Card (App-like feel) -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <div class="absolute -bottom-5 -left-10 w-32 h-32 bg-emerald-300/30 rounded-full blur-xl pointer-events-none"></div>
      <UIcon name="i-heroicons-squares-2x2" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />

      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-academic-cap" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Darul Maarif</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Portal Informasi Pesantren</p>
        </div>
      </div>
    </div>

    <!-- Main Navigation Grid -->
    <h3 class="font-bold text-gray-700 text-xs uppercase tracking-widest mb-3 px-1">Navigasi Utama</h3>
    <div class="mb-8">
      <MenuGrid :items="menuItems" />
    </div>

    <!-- Settings Section -->
    <h3 class="font-bold text-gray-700 text-xs uppercase tracking-widest mb-3 px-1">Pengaturan</h3>
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden divide-y divide-gray-50">
      <div class="flex items-center gap-4 p-4 group active:bg-gray-50 cursor-pointer transition-colors">
        <div class="w-10 h-10 rounded-xl bg-gray-100 flex items-center justify-center shrink-0 group-hover:bg-gray-200 transition-colors">
          <UIcon name="i-heroicons-user-circle" class="w-5 h-5 text-gray-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Profil Saya</div>
          <div class="text-xs text-gray-400">Lihat & ubah data akun</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300" />
      </div>

      <div class="flex items-center gap-4 p-4 group active:bg-gray-50 cursor-pointer transition-colors">
        <div class="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center shrink-0 group-hover:bg-blue-100 transition-colors">
          <UIcon name="i-heroicons-bell" class="w-5 h-5 text-blue-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Notifikasi</div>
          <div class="text-xs text-gray-400">Atur preferensi pemberitahuan</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300" />
      </div>

      <div class="flex items-center gap-4 p-4 group active:bg-gray-50 cursor-pointer transition-colors">
        <div class="w-10 h-10 rounded-xl bg-amber-50 flex items-center justify-center shrink-0 group-hover:bg-amber-100 transition-colors">
          <UIcon name="i-heroicons-shield-check" class="w-5 h-5 text-amber-600" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-gray-800">Privasi & Keamanan</div>
          <div class="text-xs text-gray-400">Kelola keamanan akun</div>
        </div>
        <UIcon name="i-heroicons-chevron-right" class="w-4 h-4 text-gray-300" />
      </div>

      <div class="flex items-center gap-4 p-4 group active:bg-red-50 cursor-pointer transition-colors">
        <div class="w-10 h-10 rounded-xl bg-red-50 flex items-center justify-center shrink-0 group-hover:bg-red-100 transition-colors">
          <UIcon name="i-heroicons-arrow-right-on-rectangle" class="w-5 h-5 text-red-500" />
        </div>
        <div class="flex-1">
          <div class="text-sm font-bold text-red-600">Keluar Sistem</div>
          <div class="text-xs text-gray-400">Logout dari portal ini</div>
        </div>
      </div>
    </div>

    <!-- App Info Footer -->
    <p class="text-center text-[11px] text-gray-400 mt-8 font-medium">Portal Pesantren Darul Maarif · v1.0.0</p>

  </div>
</template>

<script setup>
definePageMeta({ title: 'Menu Utama - Darul Maarif' })

const menuItems = [
  { label: 'Profil\nPesantren', path: '/profil', icon: 'i-heroicons-building-library', color: 'from-blue-500', gradient: 'to-blue-600' },
  { label: 'Agenda', path: '/agenda', icon: 'i-heroicons-calendar-days', color: 'from-emerald-500', gradient: 'to-green-600' },
  { label: 'Pengumuman', path: '/pengumuman', icon: 'i-heroicons-megaphone', color: 'from-orange-400', gradient: 'to-orange-500' },
  { label: 'Galeri', path: '/galeri', icon: 'i-heroicons-photo', color: 'from-purple-500', gradient: 'to-indigo-600' },
  { label: 'Program', path: '/program', icon: 'i-heroicons-academic-cap', color: 'from-pink-500', gradient: 'to-rose-600' },
  { label: 'Prestasi', path: '/prestasi', icon: 'i-heroicons-trophy', color: 'from-yellow-400', gradient: 'to-yellow-500' },
  { label: 'PSB', path: '/psb', icon: 'i-heroicons-user-plus', color: 'from-cyan-500', gradient: 'to-blue-500' },
  { label: 'Kontak', path: '/kontak', icon: 'i-heroicons-phone', color: 'from-gray-500', gradient: 'to-gray-600' }
]
</script>
