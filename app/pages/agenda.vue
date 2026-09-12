<template>
  <div class="pb-10 -mx-4 sm:mx-0 px-4 sm:px-0">
    
    <!-- Compact Header — konsisten dengan halaman lain -->
    <div class="bg-gradient-to-br from-green-500 to-emerald-700 p-5 rounded-[2.5rem] shadow-lg mb-6 relative overflow-hidden isolate -mx-4 sm:mx-0">
      <div class="absolute -top-8 -right-8 w-32 h-32 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
      <UIcon name="i-heroicons-calendar-days" class="absolute -right-4 -bottom-4 w-28 h-28 text-white/10 rotate-12 pointer-events-none" />
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-14 h-14 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center border border-white/30 shadow-inner shrink-0">
          <UIcon name="i-heroicons-calendar-days" class="w-7 h-7 text-white" />
        </div>
        <div>
          <h1 class="text-xl font-extrabold text-white tracking-tight leading-tight">Agenda Kegiatan</h1>
          <p class="text-green-100 text-xs font-medium mt-0.5">Kalender akademik & kajian ponpes.</p>
        </div>
      </div>
    </div>

    <!-- Horizontal Month Filters -->
    <div class="flex gap-2 overflow-x-auto pb-4 hide-scrollbar mb-4 -mx-4 px-4 sm:mx-0 sm:px-0 snap-x">
      <UButton 
        v-for="month in months" 
        :key="month"
        @click="activeMonth = month"
        :color="activeMonth === month ? 'green' : 'gray'" 
        :variant="activeMonth === month ? 'solid' : 'soft'" 
        size="sm" 
        class="rounded-xl px-5 py-2 font-bold snap-start shadow-sm transition-all duration-300 transform active:scale-95"
      >
        {{ month }}
      </UButton>
    </div>
    
    <!-- Timeline List -->
    <div class="relative mt-4">
      <div class="absolute left-6 top-4 bottom-0 w-0.5 bg-gradient-to-b from-green-200 via-green-100 to-transparent"></div>
      
      <div class="space-y-6">
        <div v-for="(item, index) in filteredAgendas" :key="index" class="relative pl-16 group">
          <!-- Timeline Date Badge -->
          <div class="absolute left-0 top-1 w-12 h-14 bg-white rounded-xl shadow-sm border border-gray-100 flex flex-col items-center justify-center overflow-hidden z-10 transition-transform duration-300 group-hover:scale-105">
            <span class="text-[10px] font-bold text-white bg-green-500 w-full text-center py-0.5 uppercase tracking-widest">{{ item.month }}</span>
            <span class="text-lg font-extrabold text-gray-800 leading-none mt-1">{{ item.date_day }}</span>
          </div>
          
          <!-- Event Content Card -->
          <div class="bg-white p-4 sm:p-5 rounded-2xl shadow-sm border border-gray-100 transition-all duration-300 hover:shadow-md hover:border-green-100 cursor-pointer">
            <div class="flex justify-between items-start gap-2 mb-2">
              <h3 class="font-bold text-gray-800 text-sm sm:text-base leading-snug">{{ item.title }}</h3>
              <UBadge :color="getCategoryColor(item.category)" variant="soft" size="xs" class="capitalize shrink-0 border">{{ item.category }}</UBadge>
            </div>
            
            <p class="text-xs text-gray-500 mb-3 leading-relaxed">{{ item.description }}</p>
            
            <div class="flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4 text-xs font-semibold text-gray-600 bg-gray-50 border border-gray-100 rounded-xl p-2.5">
              <div class="flex items-center gap-1.5">
                <UIcon name="i-heroicons-clock" class="w-4 h-4 text-emerald-500 shrink-0" />
                <span>{{ item.time }}</span>
              </div>
              <div class="hidden sm:block w-1 h-1 bg-gray-300 rounded-full"></div>
              <div class="flex items-center gap-1.5">
                <UIcon name="i-heroicons-map-pin" class="w-4 h-4 text-emerald-500 shrink-0" />
                <span class="truncate">{{ item.location }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Empty State -->
      <div v-if="filteredAgendas.length === 0" class="py-12 text-center text-gray-500">
        <UIcon name="i-heroicons-calendar" class="w-12 h-12 text-gray-200 mx-auto mb-3" />
        <p class="font-medium text-sm">Belum ada agenda di bulan ini.</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

definePageMeta({ title: 'Daftar Agenda - Darul Maarif' })

const supabase = useSupabaseClient()

const { data: dbAgendas, pending } = await useAsyncData('public-agendas', () =>
  supabase.from('agendas').select('*').eq('is_active', true).order('date', { ascending: true }).then(r => r.data ?? [])
)

const agendas = computed(() => {
  return (dbAgendas.value || []).map(item => {
    const d = new Date(item.date)
    return {
      ...item,
      date_day: new Intl.DateTimeFormat('id-ID', { day: '2-digit' }).format(d),
      month: new Intl.DateTimeFormat('id-ID', { month: 'short' }).format(d),
      full_month: new Intl.DateTimeFormat('id-ID', { month: 'long' }).format(d)
    }
  })
})

const months = computed(() => {
  const m = new Set(agendas.value.map(a => a.full_month))
  return ['Semua', ...Array.from(m)]
})

const activeMonth = ref('Semua')

const filteredAgendas = computed(() => {
  if (activeMonth.value === 'Semua') return agendas.value
  return agendas.value.filter(item => item.full_month === activeMonth.value)
})

const getCategoryColor = (cat) => {
  const map = {
    'Akademik': 'blue',
    'Ekstrakurikuler': 'yellow',
    'Kajian': 'emerald',
    'Acara': 'violet'
  }
  return map[cat] || 'gray'
}
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
