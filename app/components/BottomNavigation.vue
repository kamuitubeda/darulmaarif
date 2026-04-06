<template>
  <nav class="fixed bottom-0 left-0 right-0 z-50 flex justify-center w-full pointer-events-none pb-safe">
    <div class="w-full max-w-md bg-white border-t border-gray-200 shadow-[0_-10px_15px_-3px_rgba(0,0,0,0.05)] px-2 h-[68px] flex items-center justify-around pointer-events-auto rounded-t-3xl sm:rounded-none">
      <NuxtLink
        v-for="item in navItems"
        :key="item.path"
        :to="item.path"
        class="relative flex flex-col items-center justify-center w-16 h-full gap-1 text-gray-500 hover:text-gray-900 transition-colors duration-200 tap-highlight-transparent group"
        active-class="text-green-600 font-bold is-active"
      >
        <!-- Active indicator dot -->
        <div class="absolute top-1 w-1 h-1 rounded-full bg-green-600 opacity-0 transition-opacity duration-200 indicator"></div>
        
        <div class="relative flex items-center justify-center p-1 mt-1">
          <!-- Active state gets a filled icon style via group/is-active classes or we just use scale -->
          <UIcon :name="item.icon" class="w-6 h-6 transition-transform duration-200 icon-element" />
          
          <div v-if="item.badge" class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full border-2 border-white"></div>
        </div>
        <span class="text-[10px] leading-tight tracking-tight">{{ item.name }}</span>
      </NuxtLink>
    </div>
  </nav>
</template>

<script setup>
const navItems = [
  { name: 'Home', path: '/', icon: 'i-heroicons-home' },
  { name: 'Pengumuman', path: '/pengumuman', icon: 'i-heroicons-megaphone', badge: true },
  { name: 'Agenda', path: '/agenda', icon: 'i-heroicons-calendar-days' },
  { name: 'Kontak', path: '/kontak', icon: 'i-heroicons-phone' },
  { name: 'Menu', path: '/menu', icon: 'i-heroicons-bars-3' },
]
</script>

<style scoped>
/* Handle safe area for modern mobile devices (e.g., iPhone Home Indicator) */
.pb-safe {
  padding-bottom: env(safe-area-inset-bottom);
}

/* Prevent native tap highlight color on mobile */
.tap-highlight-transparent {
  -webkit-tap-highlight-color: transparent;
}

/* Custom active state animation */
.is-active .indicator {
  opacity: 1;
}
.is-active .icon-element {
  transform: translateY(-2px);
}
</style>
