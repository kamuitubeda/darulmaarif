<template>
  <div class="min-h-screen bg-gray-50 flex">
    
    <!-- Sidebar -->
    <aside class="w-64 bg-white border-r border-gray-100 flex flex-col fixed h-full z-30 shadow-sm hidden lg:flex">
      <!-- Brand -->
      <div class="p-5 border-b border-gray-100">
        <div class="flex items-center gap-3">
          <div class="w-9 h-9 bg-green-600 rounded-xl flex items-center justify-center">
            <UIcon name="i-heroicons-academic-cap" class="w-5 h-5 text-white" />
          </div>
          <div>
            <p class="text-sm font-extrabold text-gray-800 leading-tight">Darul Maarif</p>
            <p class="text-[10px] text-green-600 font-bold uppercase tracking-widest">Admin Panel</p>
          </div>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="flex-1 p-4 space-y-1 overflow-y-auto">
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest px-3 mb-2 mt-1">Manajemen Konten</p>
        <NuxtLink v-for="item in navItems" :key="item.path" :to="item.path"
          class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-semibold transition-colors"
          :class="$route.path === item.path ? 'bg-green-50 text-green-700' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-800'"
        >
          <UIcon :name="item.icon" class="w-4 h-4 shrink-0" />
          {{ item.label }}
        </NuxtLink>

        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest px-3 mb-2 mt-6">Administrasi Santri</p>
        <NuxtLink v-for="item in adminNavItems" :key="item.path" :to="item.path"
          class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-semibold transition-colors"
          :class="$route.path.startsWith(item.path) ? 'bg-green-50 text-green-700' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-800'"
        >
          <UIcon :name="item.icon" class="w-4 h-4 shrink-0" />
          {{ item.label }}
        </NuxtLink>
      </nav>

      <!-- User + Logout -->
      <div class="p-4 border-t border-gray-100">
        <div class="flex items-center gap-3 mb-3">
          <div class="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center">
            <UIcon name="i-heroicons-user" class="w-4 h-4 text-green-700" />
          </div>
          <div class="flex-1 min-w-0">
            <p class="text-xs font-bold text-gray-800 truncate">{{ user?.email }}</p>
            <p class="text-[10px] text-gray-400">Administrator</p>
          </div>
        </div>
        <UButton block color="red" variant="soft" size="xs" @click="logout" icon="i-heroicons-arrow-right-on-rectangle">
          Keluar
        </UButton>
      </div>
    </aside>

    <!-- Mobile Header -->
    <div class="lg:hidden fixed top-0 left-0 right-0 h-14 bg-white border-b border-gray-100 z-20 flex items-center justify-between px-4">
      <div class="flex items-center gap-2">
        <div class="w-8 h-8 bg-green-600 rounded-lg flex items-center justify-center">
          <UIcon name="i-heroicons-academic-cap" class="w-4 h-4 text-white" />
        </div>
        <p class="text-sm font-extrabold text-gray-800">Admin Panel</p>
      </div>
      <UButton icon="i-heroicons-bars-3" color="gray" variant="ghost" @click="mobileOpen = !mobileOpen" />
    </div>

    <!-- Mobile Drawer Overlay -->
    <div v-if="mobileOpen" class="lg:hidden fixed inset-0 bg-black/40 z-40" @click="mobileOpen = false"></div>
    <aside v-if="mobileOpen" class="lg:hidden fixed left-0 top-0 bottom-0 w-64 bg-white z-50 flex flex-col shadow-xl">
      <div class="p-4 border-b flex items-center justify-between">
        <p class="font-bold text-gray-800">Menu Admin</p>
        <UButton icon="i-heroicons-x-mark" color="gray" variant="ghost" @click="mobileOpen = false" />
      </div>
      <nav class="flex-1 p-4 space-y-1">
        <NuxtLink v-for="item in navItems" :key="item.path" :to="item.path" @click="mobileOpen = false"
          class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-semibold transition-colors"
          :class="$route.path === item.path ? 'bg-green-50 text-green-700' : 'text-gray-600 hover:bg-gray-50'"
        >
          <UIcon :name="item.icon" class="w-4 h-4" />
          {{ item.label }}
        </NuxtLink>

        <div class="h-px bg-gray-100 my-2"></div>

        <NuxtLink v-for="item in adminNavItems" :key="item.path" :to="item.path" @click="mobileOpen = false"
          class="flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-semibold transition-colors"
          :class="$route.path.startsWith(item.path) ? 'bg-green-50 text-green-700' : 'text-gray-600 hover:bg-gray-50'"
        >
          <UIcon :name="item.icon" class="w-4 h-4" />
          {{ item.label }}
        </NuxtLink>
      </nav>
      <div class="p-4 border-t">
        <UButton block color="red" variant="soft" size="xs" @click="logout" icon="i-heroicons-arrow-right-on-rectangle">Keluar</UButton>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 lg:ml-64 mt-14 lg:mt-0 min-h-screen">
      <div class="p-4 sm:p-6 max-w-5xl mx-auto">
        <slot />
      </div>
    </main>

  </div>
</template>

<script setup>
import { ref } from 'vue'

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const mobileOpen = ref(false)

const navItems = [
  { label: 'Dashboard', path: '/admin', icon: 'i-heroicons-squares-2x2' },
  { label: 'Profil Pesantren', path: '/admin/profil', icon: 'i-heroicons-building-library' },
  { label: 'Agenda', path: '/admin/agenda', icon: 'i-heroicons-calendar-days' },
  { label: 'Pengumuman', path: '/admin/pengumuman', icon: 'i-heroicons-megaphone' },
  { label: 'Galeri', path: '/admin/galeri', icon: 'i-heroicons-photo' },
  { label: 'Program', path: '/admin/program', icon: 'i-heroicons-academic-cap' },
  { label: 'Prestasi', path: '/admin/prestasi', icon: 'i-heroicons-trophy' },
  { label: 'Kontak', path: '/admin/kontak', icon: 'i-heroicons-map-pin' },
]

const adminNavItems = [
  { label: 'Data MTs', path: '/admin/santri/mts', icon: 'i-heroicons-user-group' },
  { label: 'Data MA', path: '/admin/santri/ma', icon: 'i-heroicons-user-group' },
  { label: 'Event Absensi', path: '/admin/absensi/event', icon: 'i-heroicons-clipboard-document-list' },
  { label: 'Sesi & Rekap', path: '/admin/absensi/sesi', icon: 'i-heroicons-check-badge' },
]

const logout = async () => {
  await supabase.auth.signOut()
  navigateTo('/admin/login')
}
</script>
