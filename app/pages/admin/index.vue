<template>
  <div>
    <div class="mb-6">
      <h1 class="text-2xl font-extrabold text-gray-800">Dashboard</h1>
      <p class="text-sm text-gray-500 mt-1">Selamat datang, {{ user?.email }}</p>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-8">
      <div v-for="stat in stats" :key="stat.label" class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-9 h-9 rounded-xl flex items-center justify-center" :class="stat.bg">
            <UIcon :name="stat.icon" class="w-5 h-5" :class="stat.color" />
          </div>
        </div>
        <div class="text-2xl font-extrabold text-gray-800">{{ stat.count ?? '—' }}</div>
        <div class="text-xs text-gray-500 font-medium mt-0.5">{{ stat.label }}</div>
      </div>
    </div>

    <!-- Quick Links -->
    <h2 class="font-bold text-gray-700 text-sm mb-3">Akses Cepat</h2>
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-3">
      <NuxtLink v-for="item in quickLinks" :key="item.path" :to="item.path"
        class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100 flex flex-col items-center gap-2 group hover:border-green-200 hover:shadow-md transition-all"
      >
        <div class="w-10 h-10 rounded-xl flex items-center justify-center bg-gray-50 group-hover:bg-green-50 transition-colors">
          <UIcon :name="item.icon" class="w-5 h-5 text-gray-500 group-hover:text-green-600 transition-colors" />
        </div>
        <span class="text-xs font-bold text-gray-600 group-hover:text-green-700 text-center leading-tight">{{ item.label }}</span>
      </NuxtLink>
    </div>
  </div>
</template>

<script setup>
definePageMeta({ layout: 'admin', middleware: 'auth' })

const user = useSupabaseUser()
const supabase = useSupabaseClient()

// Fetch counts
const counts = ref({})
onMounted(async () => {
  const tables = ['agendas', 'announcements', 'gallery', 'achievements', 'programs']
  for (const t of tables) {
    const { count } = await supabase.from(t).select('*', { count: 'exact', head: true })
    counts.value[t] = count ?? 0
  }
})

const stats = computed(() => [
  { label: 'Agenda', count: counts.value['agendas'], icon: 'i-heroicons-calendar-days', color: 'text-emerald-600', bg: 'bg-emerald-50' },
  { label: 'Pengumuman', count: counts.value['announcements'], icon: 'i-heroicons-megaphone', color: 'text-orange-600', bg: 'bg-orange-50' },
  { label: 'Galeri', count: counts.value['gallery'], icon: 'i-heroicons-photo', color: 'text-purple-600', bg: 'bg-purple-50' },
  { label: 'Prestasi', count: counts.value['achievements'], icon: 'i-heroicons-trophy', color: 'text-yellow-600', bg: 'bg-yellow-50' },
])

const quickLinks = [
  { label: 'Kelola Agenda', path: '/admin/agenda', icon: 'i-heroicons-calendar-days' },
  { label: 'Pengumuman', path: '/admin/pengumuman', icon: 'i-heroicons-megaphone' },
  { label: 'Galeri', path: '/admin/galeri', icon: 'i-heroicons-photo' },
  { label: 'Program', path: '/admin/program', icon: 'i-heroicons-academic-cap' },
  { label: 'Prestasi', path: '/admin/prestasi', icon: 'i-heroicons-trophy' },
  { label: 'Profil', path: '/admin/profil', icon: 'i-heroicons-building-library' },
  { label: 'Kontak', path: '/admin/kontak', icon: 'i-heroicons-map-pin' },
  { label: 'Lihat Portal', path: '/', icon: 'i-heroicons-arrow-top-right-on-square' },
]
</script>
