<template>
  <div class="pb-10">

    <!-- Compact Header —  konsisten dengan halaman lain -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-megaphone" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-megaphone" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Pusat Informasi</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Berita & pengumuman resmi pesantren.</p>
        </div>
      </div>
    </div>

    <!-- Loading -->
    <div v-if="pending" class="py-16 flex flex-col items-center gap-3">
      <UIcon name="i-heroicons-arrow-path" class="w-8 h-8 text-green-500 animate-spin" />
      <p class="text-sm text-gray-400 font-medium">Memuat pengumuman...</p>
    </div>

    <!-- Article Cards List -->
    <div v-else-if="announcements && announcements.length > 0" class="flex flex-col gap-5">
      <article
        v-for="item in announcements"
        :key="item._path"
        class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden group transition-all duration-300 hover:shadow-md hover:border-green-100 cursor-pointer"
        @click="navigateTo(item._path)"
      >
        <!-- Cover Image - full width on top -->
        <div v-if="item.image" class="w-full h-44 bg-gray-200 overflow-hidden relative">
          <img :src="item.image" :alt="item.title" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" />
          <div class="absolute inset-0 bg-gradient-to-t from-black/30 to-transparent"></div>
          <!-- Category badge on image -->
          <span class="absolute top-3 left-3 text-[10px] font-bold uppercase tracking-widest px-2.5 py-1 rounded-full bg-white/90 backdrop-blur-sm shadow-sm"
            :class="getCategoryTextColor(item.category)">
            {{ item.category }}
          </span>
        </div>
        <!-- Fallback no-image placeholder -->
        <div v-else class="w-full h-24 flex items-center justify-center bg-gradient-to-br from-green-50 to-emerald-50 border-b border-green-100 relative">
          <UIcon name="i-heroicons-building-library" class="w-10 h-10 text-green-300" />
          <span class="absolute top-3 left-3 text-[10px] font-bold uppercase tracking-widest px-2.5 py-1 rounded-full bg-white shadow-sm" :class="getCategoryTextColor(item.category)">
            {{ item.category }}
          </span>
        </div>

        <!-- Card Body -->
        <div class="p-4">
          <!-- Date -->
          <div class="flex items-center gap-1.5 text-[11px] font-semibold text-gray-400 mb-2">
            <UIcon name="i-heroicons-calendar-days" class="w-3.5 h-3.5 text-green-400" />
            <span>{{ formatDate(item.date) }}</span>
          </div>
          <!-- Title -->
          <h2 class="font-extrabold text-gray-800 text-base leading-snug mb-2 line-clamp-2 group-hover:text-green-700 transition-colors duration-200">
            {{ item.title }}
          </h2>
          <!-- Summary -->
          <p v-if="item.summary" class="text-xs text-gray-500 leading-relaxed line-clamp-2 mb-4">
            {{ item.summary }}
          </p>
          <!-- Read More CTA -->
          <div class="flex items-center justify-between pt-3 border-t border-gray-50">
            <span class="text-xs font-bold text-green-600 group-hover:text-green-800 transition-colors flex items-center gap-1">
              Baca selengkapnya
              <UIcon name="i-heroicons-arrow-right" class="w-3.5 h-3.5 transition-transform duration-300 group-hover:translate-x-1" />
            </span>
          </div>
        </div>
      </article>
    </div>

    <!-- Empty State -->
    <div v-else class="py-16 bg-gray-50 rounded-2xl flex flex-col items-center justify-center border border-dashed border-gray-200">
      <UIcon name="i-heroicons-inbox" class="w-14 h-14 text-gray-200 mb-3" />
      <p class="text-gray-400 font-semibold text-sm">Belum ada pengumuman tersedia.</p>
    </div>

  </div>
</template>

<script setup>
import { computed } from 'vue'

definePageMeta({ title: 'Pengumuman - Darul Maarif' })

const { data: announcements, pending } = await useAsyncData('announcements-list', () =>
  queryContent('/pengumuman')
    .sort({ date: -1 })
    .find()
)

const formatDate = (dateStr) => {
  if (!dateStr) return ''
  return new Intl.DateTimeFormat('id-ID', { year: 'numeric', month: 'long', day: 'numeric' }).format(new Date(dateStr))
}

const getCategoryTextColor = (cat) => {
  const map = {
    'Penerimaan': 'text-green-700',
    'Akademik': 'text-blue-700',
    'Prestasi': 'text-yellow-700',
    'Kegiatan': 'text-purple-700',
  }
  return map[cat] || 'text-gray-600'
}
</script>
