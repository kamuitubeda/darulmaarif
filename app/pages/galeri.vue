<template>
  <div class="pb-6">
    <!-- Compact Header -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-photo" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-photo" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Galeri Kegiatan</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Foto dan dokumentasi pesantren.</p>
        </div>
      </div>
    </div>
    <!-- Categories Tab -->
    <div class="flex gap-2 overflow-x-auto pb-4 hide-scrollbar mb-2">
      <UButton 
        v-for="cat in categories" 
        :key="cat"
        @click="activeCategory = cat"
        :color="activeCategory === cat ? 'green' : 'gray'" 
        :variant="activeCategory === cat ? 'solid' : 'soft'" 
        size="sm" 
        class="rounded-full px-4 transition-all duration-300"
      >
        {{ cat }}
      </UButton>
    </div>
    
    <!-- Gallery Grid -->
    <div class="grid grid-cols-2 gap-3" v-auto-animate>
      <div 
        v-for="(item, index) in filteredGallery" 
        :key="index" 
        class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden group cursor-pointer"
      >
        <div class="aspect-[4/3] relative overflow-hidden bg-gray-200">
          <img :src="item.image_url" :alt="item.title" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" loading="lazy" />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-900/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
        </div>
        <div class="p-2.5">
          <h4 class="text-[11px] sm:text-xs font-bold text-gray-700 line-clamp-2 leading-tight">
            {{ item.title }}
          </h4>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

definePageMeta({
  title: 'Galeri - Darul Maarif'
})

const supabase = useSupabaseClient()

const { data: dbGalleryItems, pending } = await useAsyncData('public-gallery', () =>
  supabase.from('gallery').select('*').eq('is_active', true).order('created_at', { ascending: false }).then(r => r.data ?? [])
)

const categories = computed(() => {
  const cats = new Set((dbGalleryItems.value || []).map(i => i.category))
  return ['Semua', ...Array.from(cats)]
})
const activeCategory = ref('Semua')

const filteredGallery = computed(() => {
  if (activeCategory.value === 'Semua') return dbGalleryItems.value || [];
  return (dbGalleryItems.value || []).filter(item => item.category === activeCategory.value);
})
</script>

<style scoped>
.hide-scrollbar::-webkit-scrollbar {
  display: none;
}
.hide-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
