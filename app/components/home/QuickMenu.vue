<template>
  <div class="mb-8">
    <div class="grid grid-cols-4 gap-y-6 gap-x-2 bg-white p-4 rounded-xl shadow-sm border border-gray-100">
      <NuxtLink 
        v-for="(item, index) in menuItems" 
        :key="index"
        :to="item.path"
        class="flex flex-col items-center gap-2 cursor-pointer active:scale-95 transition-transform"
      >
        <div :class="`w-12 h-12 rounded-2xl shadow-sm flex items-center justify-center text-white ${item.color} bg-gradient-to-br ${item.gradient}`">
          <UIcon :name="item.icon" class="w-6 h-6" />
        </div>
        <span class="text-[10px] sm:text-xs text-center font-medium text-gray-700 leading-tight">{{ item.label }}</span>
      </NuxtLink>
    </div>
  </div>
</template>

<script setup>
const menuItems = [
  { label: 'Profil', path: '/profil', icon: 'i-heroicons-building-library', color: 'from-blue-500', gradient: 'to-blue-600' },
  { label: 'Agenda', path: '/agenda', icon: 'i-heroicons-calendar-days', color: 'from-emerald-500', gradient: 'to-green-600' },
  { label: 'Informasi', path: '/pengumuman', icon: 'i-heroicons-megaphone', color: 'from-orange-400', gradient: 'to-orange-500' },
  { label: 'Galeri', path: '/galeri', icon: 'i-heroicons-photo', color: 'from-purple-500', gradient: 'to-indigo-600' },
  { label: 'Program', path: '/program', icon: 'i-heroicons-academic-cap', color: 'from-pink-500', gradient: 'to-rose-600' },
  { label: 'Prestasi', path: '/prestasi', icon: 'i-heroicons-trophy', color: 'from-yellow-400', gradient: 'to-yellow-500' },
  { label: 'PSB', path: '/psb', icon: 'i-heroicons-user-plus', color: 'from-cyan-500', gradient: 'to-blue-500' },
  { label: 'Kontak', path: '/kontak', icon: 'i-heroicons-phone', color: 'from-gray-500', gradient: 'to-gray-600' }
]
</script>
