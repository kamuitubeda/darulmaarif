<template>
  <div class="pb-10">
    <!-- Compact Header -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-trophy" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-trophy" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Prestasi Santri</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Capaian & penghargaan kebanggaan pondok.</p>
        </div>
      </div>
    </div>

    <div class="flex flex-col gap-4">
      <div v-for="(item, index) in achievements" :key="index" class="bg-white p-4 rounded-2xl shadow-sm border border-gray-100 flex gap-4 items-center">
        <div class="w-14 h-14 rounded-full bg-gradient-to-br from-yellow-100 to-yellow-200 flex items-center justify-center shrink-0 border border-yellow-300">
          <UIcon name="i-heroicons-trophy" class="w-7 h-7 text-yellow-600" />
        </div>
        <div>
          <span class="text-[10px] sm:text-xs font-bold text-yellow-600 uppercase tracking-widest bg-yellow-50 px-2 py-0.5 rounded">{{ item.level }}</span>
          <h3 class="font-bold text-gray-800 text-sm mt-1 mb-0.5 leading-snug">{{ item.title }}</h3>
          <p class="text-xs text-gray-500">{{ item.name }} - {{ item.year }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  title: 'Prestasi - Darul Maarif'
})

const achievements = [
  { level: 'Nasional', title: 'Juara 1 Musabaqah Hifdzil Quran 30 Juz', name: 'Ahmad Faiz', year: '2024' },
  { level: 'Provinsi', title: 'Medali Emas Olimpiade Sains Nasional (Matematika)', name: 'Budi Santoso', year: '2023' },
  { level: 'Kabupaten', title: 'Juara Umum Lomba Pidato Bahasa Arab', name: 'Tim Pidato MA', year: '2023' },
  { level: 'Nasional', title: 'Top 10 Lomba Kaligrafi Kontemporer', name: 'Zaidan Rizqi', year: '2023' },
  { level: 'Provinsi', title: 'Juara 2 Pencak Silat Tapak Suci', name: 'Usman Ali', year: '2022' }
]
</script>
