<template>
  <div class="mb-8">
    <div class="flex items-center justify-between mb-4">
      <h3 class="font-bold text-gray-800 flex items-center gap-2">
        <UIcon name="i-heroicons-calendar" class="w-5 h-5 text-green-600" />
        Agenda Pekan Ini
      </h3>
      <UButton variant="ghost" color="green" size="xs" trailing-icon="i-heroicons-arrow-right" to="/agenda">Lihat Semua</UButton>
    </div>
    
    <div v-if="items.length > 0" class="space-y-3">
      <NuxtLink 
        v-for="item in activeItems" 
        :key="item.id || item.title" 
        :to="item.link || '/agenda'"
        class="bg-white rounded-xl p-3 shadow-sm border border-gray-100 flex gap-4 active:scale-[0.98] transition-all duration-200 hover:shadow-md cursor-pointer group tap-highlight-transparent"
      >
        <!-- Date Badge -->
        <div class="bg-green-50 rounded-lg p-2 text-center min-w-[55px] border border-green-100 flex flex-col justify-center transition-colors group-hover:bg-green-100 group-hover:border-green-200">
          <span class="text-xs sm:text-sm text-green-600 font-extrabold uppercase leading-none mb-1">{{ item.date_day }}</span>
          <span class="text-[10px] text-green-700 font-semibold tracking-wide uppercase">{{ item.date_month }}</span>
        </div>
        
        <!-- Agenda details -->
        <div class="flex-1 flex flex-col justify-center">
          <h4 class="text-sm font-bold text-gray-800 leading-snug mb-1 group-hover:text-green-700 transition-colors">
            {{ item.title }}
          </h4>
          
          <p v-if="item.description" class="text-xs text-gray-500 line-clamp-1 mb-1.5 leading-snug">
            {{ item.description }}
          </p>

          <div class="flex flex-wrap gap-x-3 gap-y-1 mt-auto">
            <span v-if="item.time" class="text-[10px] sm:text-xs text-gray-500 flex items-center gap-1 font-medium bg-gray-50 px-1.5 py-0.5 rounded-md">
              <UIcon name="i-heroicons-clock" class="w-3 h-3 text-gray-400" />
              {{ item.time }}
            </span>
            <span v-if="item.location" class="text-[10px] sm:text-xs text-gray-500 flex items-center gap-1 font-medium bg-gray-50 px-1.5 py-0.5 rounded-md line-clamp-1">
              <UIcon name="i-heroicons-map-pin" class="w-3 h-3 text-gray-400" />
              {{ item.location }}
            </span>
          </div>
        </div>
      </NuxtLink>
    </div>
    
    <div v-else class="bg-gray-50 rounded-xl p-6 text-center border border-gray-100 border-dashed">
      <UIcon name="i-heroicons-calendar-days" class="w-8 h-8 text-gray-300 mx-auto mb-2" />
      <p class="text-sm text-gray-500 font-medium">Belum ada agenda terdekat</p>
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
    // { id, title, description, date_day, date_month, time, location, link, is_active }
  }
})

// Optional active filter to ensure only valid agendas show up
const activeItems = computed(() => {
  return props.items.filter(item => item.is_active !== false)
})
</script>

<style scoped>
.tap-highlight-transparent {
  -webkit-tap-highlight-color: transparent;
}
</style>
