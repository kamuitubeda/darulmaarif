<template>
  <div class="mb-8">
    <div class="flex items-center justify-between mb-4 pr-1">
      <h3 class="font-bold text-gray-800 flex items-center gap-2">
        <UIcon name="i-heroicons-photo" class="w-5 h-5 text-green-600" />
        Galeri Pesantren
      </h3>
      <UButton variant="ghost" color="green" size="xs" trailing-icon="i-heroicons-arrow-right" to="/galeri">Lihat Galeri</UButton>
    </div>
    
    <div v-if="items.length > 0" class="flex overflow-x-auto gap-3 pb-4 snap-x snap-mandatory hide-scrollbar -mx-4 px-4 sm:mx-0 sm:px-0">
      <div 
        v-for="item in activeItems" 
        :key="item.id || item.title" 
        class="flex-shrink-0 w-60 sm:w-72 snap-center rounded-2xl overflow-hidden shadow-sm border border-gray-100 bg-white group cursor-pointer"
      >
        <div class="relative aspect-[4/3] bg-gray-200 overflow-hidden">
          <img :src="item.image_url" :alt="item.title" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-900/80 via-gray-900/10 to-transparent"></div>
          
          <div class="absolute bottom-0 left-0 right-0 p-3 pt-6 pointer-events-none">
            <h4 class="text-sm font-bold text-white leading-snug line-clamp-2 drop-shadow-md">
              {{ item.title }}
            </h4>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="bg-gray-50 rounded-xl p-6 text-center border border-gray-100 border-dashed">
      <UIcon name="i-heroicons-photo" class="w-8 h-8 text-gray-300 mx-auto mb-2" />
      <p class="text-sm text-gray-500 font-medium">Galeri belum tersedia</p>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  items: {
    type: Array,
    default: () => []
    // Expected structure:
    // { id, title, image, is_active }
  }
})

// Filter to ensure only valid items show up
const activeItems = computed(() => {
  return props.items.filter(item => item.is_active !== false)
})
</script>

<style scoped>
/* Hide scrollbar for Chrome, Safari and Opera */
.hide-scrollbar::-webkit-scrollbar {
  display: none;
}
/* Hide scrollbar for IE, Edge and Firefox */
.hide-scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
</style>
