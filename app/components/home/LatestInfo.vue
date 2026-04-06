<template>
  <div class="mb-8">
    <div class="flex items-center justify-between mb-4">
      <h3 class="font-bold text-gray-800 flex items-center gap-2">
        <UIcon name="i-heroicons-newspaper" class="w-5 h-5 text-green-600" />
        Info Terbaru
      </h3>
      <UButton variant="ghost" color="green" size="xs" trailing-icon="i-heroicons-arrow-right" to="/pengumuman">Semua</UButton>
    </div>
    
    <div class="space-y-4">
      <div v-for="i in 3" :key="i" class="bg-white rounded-xl overflow-hidden shadow-sm border border-gray-100 flex flex-col active:scale-[0.98] transition-transform cursor-pointer">
        <!-- Optional Image Thumbnail -->
        <div class="h-32 w-full bg-gray-100 bg-cover bg-center" :style="`background-image: url('https://picsum.photos/seed/info${i}/400/200')`"></div>
        <div class="p-3">
          <div class="flex items-center justify-between mb-1.5">
            <span class="text-[10px] uppercase font-bold text-green-600 tracking-wider">Artikel</span>
            <span class="text-[10px] text-gray-400">12 Agu 2024</span>
          </div>
          <h4 class="text-sm font-bold text-gray-800 leading-snug line-clamp-2">
            Pendaftaran Santri Baru Gelombang 2 Resmi Dibuka Hari Ini
          </h4>
        </div>
      </div>
    </div>
  </div>
</template>
